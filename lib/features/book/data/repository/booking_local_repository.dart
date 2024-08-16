// import '../../domain/entity/booking_entity.dart';
// import '../../domain/repository/booking_repository.dart';
// import '../data_source/local/booking_local_datasource.dart';
// import '../model/booking_model.dart';
//
// class LocalBookingRepository implements BookingRepository {
//   final LocalBookingDataSource localBookingDataSource;
//
//   LocalBookingRepository(this.localBookingDataSource);
//
//   @override
//   Future<Booking> getBookingById(String id) async {
//     final bookings = await localBookingDataSource.getBookings();
//     final bookingDTO = bookings.firstWhere((booking) => booking.id == id);
//     return BookingModel.fromDTO(bookingDTO);
//   }
//
//   @override
//   Future<List<Booking>> getAllBookings() async {
//     final bookings = await localBookingDataSource.getBookings();
//     return bookings.map((bookingDTO) => BookingModel.fromDTO(bookingDTO)).toList();
//   }
//
//   @override
//   Future<void> createBooking(Booking booking) async {
//     final bookingDTO = booking.toDTO(); // Convert Booking to BookingDTO
//     await localBookingDataSource.saveBooking(bookingDTO); // Save BookingDTO
//   }
// }
