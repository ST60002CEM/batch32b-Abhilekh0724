// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../profile_provider.dart';
// import '../widgets/profile_picture_provider.dart'; // Adjust the import as necessary
//
// class ProfileView extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final profileAsyncValue = ref.watch(profileProvider);
//     final profilePictureAsyncValue = ref.watch(profilePictureProvider);
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Profile')),
//       body: profileAsyncValue.when(
//         data: (user) {
//           final profilePic = user['profilePic'] ?? '';
//           final firstName = user['firstName'] ?? '';
//           final lastName = user['lastName'] ?? '';
//           final email = user['email'] ?? '';
//
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 SizedBox(height: 20),
//                 CircleAvatar(
//                   radius: 100,
//                   backgroundImage: profilePic.isNotEmpty
//                       ? NetworkImage('http://192.168.1.70:5500$profilePic')
//                       : AssetImage('assets/images/default-avatar.png') as ImageProvider,
//                 ),
//                 SizedBox(height: 20),
//                 Text('First Name: $firstName', style: TextStyle(fontSize: 20)),
//                 Text('Last Name: $lastName', style: TextStyle(fontSize: 20)),
//                 Text('Email: $email', style: TextStyle(fontSize: 20)),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () async {
//                     final picker = ImagePicker();
//                     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//                     if (pickedFile != null) {
//                       final file = File(pickedFile.path);
//                       await ref.read(profilePictureProvider.future);
//                     }
//                   },
//                   child: Text('Upload Profile Picture'),
//                 ),
//               ],
//             ),
//           );
//         },
//         loading: () => Center(child: CircularProgressIndicator()),
//         error: (error, stackTrace) => Center(child: Text('Error: $error')),
//       ),
//     );
//   }
// }
