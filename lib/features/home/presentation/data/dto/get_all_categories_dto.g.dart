// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_categories_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCategoriesDTO _$GetAllCategoriesDTOFromJson(Map<String, dynamic> json) =>
    GetAllCategoriesDTO(
      success: json['success'] as bool,
      message: json['message'] as String,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => VenueCard.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCategoriesDTOToJson(
        GetAllCategoriesDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'categories': instance.categories,
    };
