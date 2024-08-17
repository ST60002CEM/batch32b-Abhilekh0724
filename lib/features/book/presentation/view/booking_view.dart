import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/booking_view_model.dart';

class BookingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch bookings without requiring userId as the token is used for authentication
    return ChangeNotifierProvider(
      create: (_) => BookingViewModel()..fetchBookingsByUser(),
      child: Scaffold(
        body: Consumer<BookingViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (viewModel.errorMessage.isNotEmpty) {
              return Center(child: Text('Error: ${viewModel.errorMessage}'));
            }

            if (viewModel.bookings.isEmpty) {
              return Center(child: Text('No bookings found'));
            }

            return ListView.builder(
              itemCount: viewModel.bookings.length,
              itemBuilder: (context, index) {
                final booking = viewModel.bookings[index];
                return ListTile(
                  title: Text('Category: ${booking.categoryId}'),
                  subtitle: Text('Date: ${booking.bookingDate}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
