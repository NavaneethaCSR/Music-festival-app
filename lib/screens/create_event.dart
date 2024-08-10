// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:beat_bash/screens/customer_input_format.dart';
import 'package:beat_bash/screens/customer_headtext.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Eventscreen extends StatefulWidget {
  const Eventscreen({Key? key});

  @override
  State<Eventscreen> createState() => EventscreenState();
}

class FilePickerResult {
  final List<PlatformFile> files;

  FilePickerResult({required this.files});
}

class EventscreenState extends State<Eventscreen> {
  final logger = Logger();

  FilePickerResult? _filePickerResult;
  DateTime? date = DateTime.now();
  bool _isInPersonEvent = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _guestController = TextEditingController();
  final TextEditingController _sponsersController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        setState(() {
          _dateTimeController.text = selectedDateTime.toString();
        });
      }
    }
  }

  void openImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileSize = await file.length(); // Asynchronously get the file size

      final platformFile = PlatformFile(
        name: pickedFile.name,
        size: fileSize,
        path: pickedFile.path,
      );

      setState(() {
        _filePickerResult = FilePickerResult(files: [platformFile]);

        imageFile =
            File(pickedFile.path); // Assign the picked file to imageFile
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const CustomHeadText(text: "Create Event"),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  if (kIsWeb) {
                    pickImageForWeb(context);
                  } else {
                    openImagePicker();
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .3,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 85, 19, 126),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _filePickerResult != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(_filePickerResult!.files.first.path!),
                            fit: BoxFit.fill,
                          ),
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo_outlined,
                              size: 42,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Add Event Image",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              CustomInputForm(
                controller: _nameController,
                icon: Icons.event_outlined,
                label: "Event Name",
                hint: "Add Event Name",
              ),
              const SizedBox(
                height: 8,
              ),
              CustomInputForm(
                maxLines: 4,
                controller: _descController,
                icon: Icons.description_outlined,
                label: "Description",
                hint: "Add Description",
              ),
              const SizedBox(
                height: 8,
              ),
              CustomInputForm(
                controller: _locationController,
                icon: Icons.location_on_outlined,
                label: "Location",
                hint: "Enter Location of Event",
              ),
              const SizedBox(
                height: 8,
              ),
              CustomInputForm(
                controller: _dateTimeController,
                icon: Icons.date_range_outlined,
                label: "Date& Time",
                hint: "Pickup Date& Time ",
                readOnly: true,
                onTap: () => _selectDateTime(context),
              ),
              const SizedBox(
                height: 8,
              ),
              CustomInputForm(
                controller: _guestController,
                icon: Icons.people_outlined,
                label: "Guests",
                hint: "Enter list of guests",
              ),
              const SizedBox(
                height: 8,
              ),
              CustomInputForm(
                controller: _sponsersController,
                icon: Icons.attach_money_outlined,
                label: "Sponsors",
                hint: "Enter Sponsors",
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Text(
                    "In Person Event",
                    style: TextStyle(
                      color: Color.fromARGB(255, 85, 19, 126),
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Switch(
                    activeColor: const Color.fromARGB(255, 85, 19, 126),
                    focusColor: const Color.fromARGB(255, 85, 19, 126),
                    value: _isInPersonEvent,
                    onChanged: (value) {
                      setState(() {
                        _isInPersonEvent = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: MaterialButton(
                  color: const Color.fromARGB(255, 85, 19, 126),
                  onPressed: () async {
                    if (_nameController.text.isEmpty ||
                        _descController.text.isEmpty ||
                        _locationController.text.isEmpty ||
                        _dateTimeController.text.isEmpty ||
                        _sponsersController.text.isEmpty ||
                        _guestController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Event Name, Description, Location, Date & Time, Sponsors, Guests are required.",
                          ),
                        ),
                      );
                    } else {
                      String? imageUrl;
                      if (kIsWeb) {
                        // Handle image upload for web
                        // imageUrl = await uploadImageWeb();
                      } else {
                        // Handle image upload for other platforms (Android)
                        imageUrl = await uploadEventImage();
                      }
                      if (imageUrl != null) {
                        try {
                          // Create event data
                          Map<String, dynamic> eventData = {
                            'name': _nameController.text,
                            'description': _descController.text,
                            'imageUrl': imageUrl,
                            'location': _locationController.text,
                            'dateTime': _dateTimeController.text,
                            'guests': _guestController.text,
                            'sponsors': _sponsersController.text,
                            // Add other fields as needed
                          };

                          // Add event data to Firestore
                          await FirebaseFirestore.instance
                              .collection('EVENTS')
                              .add(eventData);

                          // Show success message
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Event Created !!"),
                              ),
                            );
                          }

                          // Navigate back
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Error creating event: $e"),
                            ),
                          );
                        }
                      } else {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Error uploading image"),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: const Text(
                    "Create New Event",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  File? imageFile;

  String? uploadEventImage() {
    try {
      if (_filePickerResult != null &&
          _filePickerResult!.files.isNotEmpty &&
          _filePickerResult!.files.first.path != null &&
          _filePickerResult!.files.first.path!.isNotEmpty) {
        PlatformFile file = _filePickerResult!.files.first;

        final Reference storageRef = FirebaseStorage.instance.ref().child(
            'EVENTSS/${DateTime.now().millisecondsSinceEpoch}_${file.name}');

        // Upload the file directly to Firebase Storage
        UploadTask uploadTask = storageRef.putFile(File(file.path!));

        // Wait for the upload to complete
        uploadTask.whenComplete(() async {
          try {
            String imageUrl = await storageRef.getDownloadURL();
            // Handle the download URL as needed
            return imageUrl;
          } catch (e) {
            logger.e('Error getting download URL: $e');
          }
        });
      } else {
        logger.i("No file selected");
      }
    } catch (e) {
      logger.e('Error uploading file to Firebase Storage: $e');
    }
    return null;
  }

  void pickImageForWeb(BuildContext context) {}
}
