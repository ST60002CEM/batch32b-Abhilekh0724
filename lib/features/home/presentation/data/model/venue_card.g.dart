// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_card.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueCard _$VenueCardFromJson(Map<String, dynamic> json) => VenueCard(
      id: json['_id'] as String,
      price: (json['price'] as num?)?.toDouble(),
      name: json['name'] as String?,
      info: json['info'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$VenueCardToJson(VenueCard instance) => <String, dynamic>{
      '_id': instance.id,
      'price': instance.price,
      'name': instance.name,
      'info': instance.info,
      'photo': instance.photo,
    };
