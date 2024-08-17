import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart'; // Ensure this file is generated

@JsonSerializable()
class Booking {
  final String id;
  final CategoryId categoryId; // Assuming CategoryId is another model
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

  factory Booking.fromJson(Map<String, dynamic> json) {
    // Safely handle null values
    return Booking(
      id: json['_id'] ?? '', // Default to empty string if null
      categoryId: json['categoryId'] != null ? CategoryId.fromJson(json['categoryId']) : CategoryId(),
      userId: json['userId'] ?? '', // Default to empty string if null
      bookingDate: json['bookingDate'] ?? '',
      status: json['status'] ?? '', // Default to empty string if null
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => _$BookingToJson(this);
}

@JsonSerializable()
class CategoryId {
  final String id;
  final double price;
  final String name;
  final String info;
  final String photo;

  CategoryId({
    this.id = '', // Default to empty string if null
    this.price = 0.0,
    this.name = '',
    this.info = '',
    this.photo = '',
  });

  factory CategoryId.fromJson(Map<String, dynamic> json) => _$CategoryIdFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryIdToJson(this);
}
