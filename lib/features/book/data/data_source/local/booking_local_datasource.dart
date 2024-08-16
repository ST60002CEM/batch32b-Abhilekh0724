// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
//
// import '../../dto/booking_dto.dart';
//
// class LocalBookingDataSource {
//   final SharedPreferences sharedPreferences;
//   static const String BOOKINGS_KEY = 'BOOKINGS_KEY';
//
//   LocalBookingDataSource(this.sharedPreferences);
//
//   Future<void> saveBooking(BookingDTO booking) async {
//     final bookings = await getBookings();
//     bookings.add(booking);
//     final bookingsJson = bookings.map((e) => e.toJson()).toList();
//     sharedPreferences.setString(BOOKINGS_KEY, jsonEncode(bookingsJson));
//   }
//
//   Future<List<BookingDTO>> getBookings() async {
//     final jsonString = sharedPreferences.getString(BOOKINGS_KEY);
//     if (jsonString != null) {
//       final List<dynamic> jsonData = jsonDecode(jsonString);
//       return jsonData.map((e) => BookingDTO.fromJson(e)).toList();
//     }
//     return [];
//   }
//
//   Future<void> clearBookings() async {
//     await sharedPreferences.remove(BOOKINGS_KEY);
//   }
// }
