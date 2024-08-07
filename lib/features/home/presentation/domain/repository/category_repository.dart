import 'package:dartz/dartz.dart';
import '../../../../../core/failure/failure.dart';
import '../entity/venue_card_entity.dart';

abstract class ICategoryRepository {
  Future<Either<Failure, List<VenueCardEntity>>> getAllCategories();
  Future<Either<Failure, void>> saveCategories(List<VenueCardEntity> categories);
}
