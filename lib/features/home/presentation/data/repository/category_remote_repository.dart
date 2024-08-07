import 'package:dartz/dartz.dart';
import '../../../../../core/failure/failure.dart';
import '../../domain/entity/venue_card_entity.dart';
import '../../domain/repository/category_repository.dart';
import '../data_source/remote/category_remote_data_source.dart';
import '../model/venue_card.dart';

class CategoryRemoteRepository implements ICategoryRepository {
  final CategoryRemoteDataSource _remoteDataSource;

  CategoryRemoteRepository(this._remoteDataSource);

  @override
  Future<Either<Failure, List<VenueCardEntity>>> getAllCategories() async {
    try {
      final dto = await _remoteDataSource.getCategories();
      final entities = dto.categories?.map((card) => VenueCardEntity(
        id: card.id,
        price: card.price??00,
        name: card.name ?? 'Unknown',
        info: card.info ?? 'No information',
        photo: card.photo ?? 'No photo available',
      )).toList() ?? [];
      return Right(entities);
    } catch (e) {
      print('Remote Repository Exception: $e');
      return Left(Failure(error: 'Failed to fetch categories from server'));
    }
  }

  @override
  Future<Either<Failure, void>> saveCategories(List<VenueCardEntity> categories) {
    return Future.error('Remote saving is not implemented');
  }
}
