// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import '../../dto/booking_dto.dart';
//
// class RemoteBookingDataSource {
//   final String baseUrl;
//
//   RemoteBookingDataSource(this.baseUrl);
//
//   Future<BookingDTO> fetchBooking(String id) async {
//     final response = await http.get(Uri.parse('$baseUrl/bookings/$id'));
//
//     if (response.statusCode == 200) {
//       final jsonResponse = json.decode(response.body);
//       return BookingDTO.fromJson(jsonResponse);
//     } else {
//       throw Exception('Failed to load booking');
//     }
//   }
//
//   Future<List<BookingDTO>> fetchAllBookings() async {
//     final response = await http.get(Uri.parse('$baseUrl/bookings'));
//
//     if (response.statusCode == 200) {
//       final jsonResponse = json.decode(response.body) as List;
//       return jsonResponse.map((e) => BookingDTO.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load bookings');
//     }
//   }
//
//   Future<void> createBooking(BookingDTO booking) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/bookings'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(booking.toJson()),
//     );
//
//     if (response.statusCode != 201) {
//       throw Exception('Failed to create booking');
//     }
//   }
// }
