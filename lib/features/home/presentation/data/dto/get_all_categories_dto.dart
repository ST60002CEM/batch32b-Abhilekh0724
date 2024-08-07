import 'package:json_annotation/json_annotation.dart';
import '../model/venue_card.dart';

part 'get_all_categories_dto.g.dart';

@JsonSerializable()
class GetAllCategoriesDTO {
  final bool success;
  final String message;
  final List<VenueCard> categories;

  GetAllCategoriesDTO({
    required this.success,
    required this.message,
    required this.categories,
  });

  factory GetAllCategoriesDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllCategoriesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCategoriesDTOToJson(this);
}
