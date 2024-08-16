import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart'; // Ensure this file is generated

@JsonSerializable()
class Booking {
  final String id;
  final String categoryId;
  final String userId;
  final String bookingDate;
  final String status;
  final String createdAt;

  Booking({
    required this.id,
    required this.categoryId,
    required this.userId,
    required this.bookingDate,
    required this.status,
    required this.createdAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
