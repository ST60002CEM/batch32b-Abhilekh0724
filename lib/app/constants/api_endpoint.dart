class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://192.168.1.68/api/";
  static const String baseUrl = "http://10.0.2.2:5500/api/";
  //static const String baseUrl = "http://192.168.4.4:3000/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "user/login";
  static const String register = "user/create";
  static const String homepage = "user/get";
  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String uploadImage = "auth/uploadImage";
  static const String currentUser = "auth/getMe";
  static const String getAllUser = "auth/getAllUsers";
  static const String updateUser = "auth/updateUser/";
  static const String deleteUser = "auth/deleteUser/";
}
