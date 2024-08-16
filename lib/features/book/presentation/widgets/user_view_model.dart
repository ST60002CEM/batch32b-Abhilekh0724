// import 'package:provider/provider.dart';
// import 'package:provider/single_child_widget.dart';
// import '../../../../core/networking/local/api_service.dart';
// import '../../domain/repository/booking_repository.dart';
// import '../viewmodel/booking_view_model.dart';
//
// final List<SingleChildWidget> providers = [
//   Provider<ApiService>(
//     create: (_) => ApiService(),
//   ),
//   Provider<BookingRepository>(
//     create: (context) => BookingRepository(context.read<ApiService>()),
//   ),
//   ChangeNotifierProvider<BookingViewModel>(
//     create: (context) => BookingViewModel(context.read<BookingRepository>()),
//   ),
// ];
