class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://192.168.1.70:5500/api/";

  // ====================== Auth Routes ======================
  static const String login = "user/login";
  static const String register = "user/create";
  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String currentUser = "auth/getMe";

  // ====================== Profile Routes ======================
  static const String profile = "profile/";
  static const String uploadProfilePic = "profile/uploadProfilePic";

  // ====================== Admin Routes ======================
  static const String createCategory = "admin/create";
  static const String getAllCategories = "admin/get";
  static const String updateCategory = "admin/update/";
  static const String deleteCategory = "admin/delete/";
  static const String searchCategory = "admin/search";
  static const String getCategoryById = "admin/get/";

  // ====================== Review Routes ======================
  static const String review = "review/reviews";
  static const String getReviewsByCategory = "review/reviews/";

  // ====================== Book Routes ======================
  static const String book = "book/book";
  static const String getBookingsByCategory = "book/category/";
  static const String getBookingsByUser = "book/bookeduser";
}
