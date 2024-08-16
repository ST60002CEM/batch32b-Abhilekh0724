// import '../entity/booking_entity.dart';
// import '../repository/booking_repository.dart';
//
// class CreateBookingUseCase {
//   final BookingRepository bookingRepository;
//
//   CreateBookingUseCase(this.bookingRepository);
//
//   Future<void> call(Booking booking) async {
//     return await bookingRepository.createBooking(booking);
//   }
// }
//
// class GetBookingByIdUseCase {
//   final BookingRepository bookingRepository;
//
//   GetBookingByIdUseCase(this.bookingRepository);
//
//   Future<Booking> call(String id) async {
//     return await bookingRepository.getBookingById(id);
//   }
// }
//
// class GetAllBookingsUseCase {
//   final BookingRepository bookingRepository;
//
//   GetAllBookingsUseCase(this.bookingRepository);
//
//   Future<List<Booking>> call() async {
//     return await bookingRepository.getAllBookings();
//   }
// }
