import 'package:equatable/equatable.dart';

class VenueCardEntity extends Equatable {
  final String id;
  final double price;
  final String name;
  final String info;
  final String photo;

  const VenueCardEntity({
    required this.id,
    required this.price,
    required this.name,
    required this.info,
    required this.photo,
  });

  @override
  List<Object?> get props => [id, price, name, info, photo];
}
