class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const String baseUrl = "http://192.168.1.70:5500/api/";

  // ====================== Auth Routes ======================
  static const String login = "${baseUrl}user/login";
  static const String register = "${baseUrl}user/create";
  static const String imageUrl = "${baseUrl}uploads/";
  static const String currentUser = "${baseUrl}auth/getMe";

  // ====================== Profile Routes ======================
  static const String profile = "${baseUrl}profile/";
  static const String uploadProfilePic = "${baseUrl}profile/uploadProfilePic";

  // ====================== Admin Routes ======================
  static const String createCategory = "${baseUrl}admin/create";
  static const String getAllCategories = "${baseUrl}admin/get";
  static const String updateCategory = "${baseUrl}admin/update/";
  static const String deleteCategory = "${baseUrl}admin/delete/";
  static const String searchCategory = "${baseUrl}admin/search";
  static const String getCategoryById = "${baseUrl}admin/get/";

  // ====================== Review Routes ======================
  static const String review = "${baseUrl}review/reviews";
  static const String getReviewsByCategory = "${baseUrl}review/reviews/";

  // ====================== Book Routes ======================
  static const String book = "${baseUrl}book/book";
  static const String getBookingsByCategory = "${baseUrl}book/category/";
  static const String getBookingsByUser = "${baseUrl}book/bookeduser";
  static const String cancelBooking = "${baseUrl}book/cancel/";
  static const String deleteBooking = "${baseUrl}book/delete/";
  static const String getAllBookings = "${baseUrl}book/all"; // Admin only
}
