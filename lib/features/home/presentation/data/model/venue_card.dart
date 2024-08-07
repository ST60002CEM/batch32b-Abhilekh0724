import 'package:json_annotation/json_annotation.dart';

part 'venue_card.g.dart';

@JsonSerializable()
class VenueCard {
  @JsonKey(name: '_id')
  final String id;
  final double? price;
  final String? name;
  final String? info;
  final String? photo;

  VenueCard({
    required this.id,
    this.price,
    this.name,
    this.info,
    this.photo,
  });

  factory VenueCard.fromJson(Map<String, dynamic> json) => _$VenueCardFromJson(json);

  Map<String, dynamic> toJson() => _$VenueCardToJson(this);
}
