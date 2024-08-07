import 'package:dartz/dartz.dart';
import '../../../../../core/failure/failure.dart';
import '../../domain/entity/venue_card_entity.dart';
import '../../domain/repository/category_repository.dart';
import '../data_source/local/category_local_data_source.dart';

class CategoryLocalRepository implements ICategoryRepository {
  final CategoryLocalDataSource _localDataSource;

  CategoryLocalRepository(this._localDataSource);

  @override
  Future<Either<Failure, List<VenueCardEntity>>> getAllCategories() async {
    try {
      final categories = await _localDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      print('Local Repository Exception: $e');
      return Left(Failure(error: 'Failed to fetch categories from local storage'));
    }
  }

  @override
  Future<Either<Failure, void>> saveCategories(List<VenueCardEntity> categories) async {
    try {
      await _localDataSource.saveCategories(categories);
      return Right(null);
    } catch (e) {
      print('Local Repository Save Exception: $e');
      return Left(Failure(error: 'Failed to save categories to local storage'));
    }
  }
}
