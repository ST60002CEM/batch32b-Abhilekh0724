// booking_entity.dart
class Booking {
  final String categoryId;
  final String userId;
  final DateTime bookingDate;
  final String status;
  final DateTime createdAt;

  Booking({
    required this.categoryId,
    required this.userId,
    required this.bookingDate,
    required this.status,
    required this.createdAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      categoryId: json['categoryId'],
      userId: json['userId'],
      bookingDate: DateTime.parse(json['bookingDate']),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'userId': userId,
      'bookingDate': bookingDate.toIso8601String(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
