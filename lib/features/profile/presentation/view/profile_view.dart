import 'dart:io'; // Import File class
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  File? _profilePic;
  final Map<String, String> _user = {
    'firstName': 'Abhilekh',
    'lastName': 'Yonjan',
    'email': 'abielkhyonjan@gmail.com',
    'profilePic': '' // Use an empty string or URL for the default picture
  };

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profilePic = File(pickedFile.path);
      });
      // TODO: Upload image to server and update _user profilePic
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Profile Picture Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Updated logo with AssetImage
              const Image(
                image: AssetImage('assets/icons/Venue.png'),
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 4,
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                constraints: const BoxConstraints(maxWidth: 700),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: _showImageSourceDialog,
                          child: CircleAvatar(
                            radius: 90,
                            backgroundImage: _profilePic != null
                                ? FileImage(_profilePic!)
                                : const AssetImage('assets/images/default-avatar.png') as ImageProvider,
                            backgroundColor: Colors.grey[200],
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    const Text(
                      'User Details',
                      style: TextStyle(fontSize: 28, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'First Name: ${_user['firstName']}',
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    Text(
                      'Last Name: ${_user['lastName']}',
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                    Text(
                      'Email: ${_user['email']}',
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
