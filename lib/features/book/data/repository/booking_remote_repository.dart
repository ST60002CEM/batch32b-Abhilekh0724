// import '../../domain/entity/booking_entity.dart';
// import '../../domain/repository/booking_repository.dart';
// import '../data_source/remote/booking_remote_datasource.dart';
// import '../model/booking_model.dart';
//
// class RemoteBookingRepository implements BookingRepository {
//   final RemoteBookingDataSource remoteBookingDataSource;
//
//   RemoteBookingRepository(this.remoteBookingDataSource);
//
//   @override
//   Future<Booking> getBookingById(String id) async {
//     final bookingDTO = await remoteBookingDataSource.fetchBooking(id);
//     return BookingModel.fromDTO(bookingDTO);
//   }
//
//   @override
//   Future<List<Booking>> getAllBookings() async {
//     final bookingDTOs = await remoteBookingDataSource.fetchAllBookings();
//     return bookingDTOs.map((dto) => BookingModel.fromDTO(dto)).toList();
//   }
//
//   @override
//   Future<void> createBooking(Booking booking) async {
//     // Casting Booking to BookingModel before calling toDTO
//     await remoteBookingDataSource.createBooking((booking as BookingModel).toDTO());
//   }
// }
