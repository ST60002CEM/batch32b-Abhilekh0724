import 'package:flutter/material.dart';
import '../../../../core/networking/local/api_service.dart';
import '../../data/model/booking_model.dart';

class BookingViewModel extends ChangeNotifier {
  List<Booking> _bookings = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Booking> get bookings => _bookings;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchBookingsByUser(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _bookings = await ApiService.getBookingsByUser(userId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
