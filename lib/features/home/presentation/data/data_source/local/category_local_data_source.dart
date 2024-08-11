import 'package:dartz/dartz.dart';
import '../../../domain/entity/venue_card_entity.dart';

abstract class CategoryLocalDataSource {
  Future<List<VenueCardEntity>> getCategories();
  Future<void> saveCategories(List<VenueCardEntity> categories);


}
