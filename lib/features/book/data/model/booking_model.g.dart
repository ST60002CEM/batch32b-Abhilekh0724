// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Booking _$BookingFromJson(Map<String, dynamic> json) => Booking(
      id: json['id'] as String,
      categoryId:
          CategoryId.fromJson(json['categoryId'] as Map<String, dynamic>),
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

CategoryId _$CategoryIdFromJson(Map<String, dynamic> json) => CategoryId(
      id: json['id'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      name: json['name'] as String? ?? '',
      info: json['info'] as String? ?? '',
      photo: json['photo'] as String? ?? '',
    );

Map<String, dynamic> _$CategoryIdToJson(CategoryId instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'name': instance.name,
      'info': instance.info,
      'photo': instance.photo,
    };
