// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      userId: json['userId'] as String,
      bookingDate: json['bookingDate'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$BookingToJson(Booking instance) => <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'userId': instance.userId,
      'bookingDate': instance.bookingDate,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
