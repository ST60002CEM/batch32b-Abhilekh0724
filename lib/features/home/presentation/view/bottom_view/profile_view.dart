// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../../../app/constants/api_endpoint.dart';
// import '../../viewmodel/profile_viewmodel.dart';
//
//
// class ProfileView extends ConsumerStatefulWidget {
//   const ProfileView({super.key});
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
// }
//
// class _ProfileViewState extends ConsumerState<ProfileView> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final currentUser = ref.watch(profileViewModelProvider);
//
//     if (currentUser.isLoading) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     } else {
//       return SizedBox.expand(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 300,
//               width: 300,
//               child: Image.network(
//                   '${ApiEndpoints.imageUrl}${currentUser.authEntity!}'),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "First Name : ${currentUser.authEntity?.fname ?? ""}",
//               style: const TextStyle(
//                 fontSize: 30,
//               ),
//             )
//           ],
//         ),
//       );
//     }
//   }
// }
//
// // class ProfileView extends ConsumerWidget {
// //   const ProfileView({super.key});
//
// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final authState = ref.watch(authViewModelProvider);
//
// //     return const SizedBox.expand(
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Text('Profile View'),
// //         ],
// //       ),
// //     );
// //   }
// // }
// // class ProfileView extends StatefulWidget {
// //   const ProfileView({super.key});
//
// //   @override
// //   State<ProfileView> createState() => _ProfileViewState();
// // }
//
// // class _ProfileViewState extends State<ProfileView> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Profile'),
// //       ),
// //       body: const Center(
// //         child: Text('Profile View'),
// //       ),
// //     );
// //   }
// // }
