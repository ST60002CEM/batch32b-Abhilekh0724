// class ProfileDto {
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String? profilePic;
//
//   ProfileDto({
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     this.profilePic,
//   });
//
//   factory ProfileDto.fromJson(Map<String, dynamic> json) {
//     return ProfileDto(
//       firstName: json['firstName'],
//       lastName: json['lastName'],
//       email: json['email'],
//       profilePic: json['profilePic'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'firstName': firstName,
//       'lastName': lastName,
//       'email': email,
//       'profilePic': profilePic,
//     };
//   }
// }
