// // booking_repository.dart
// import '../../../../core/networking/local/api_service.dart';
// import '../entity/booking_entity.dart';
//
// class BookingRepository {
//   Future<List<Booking>> getBookingsByUser(String userId) async {
//     final response = await ApiService.getBookingsByUser(userId);
//     return response.map((bookingJson) => Booking.fromJson(bookingJson)).toList();
//   }
// }
