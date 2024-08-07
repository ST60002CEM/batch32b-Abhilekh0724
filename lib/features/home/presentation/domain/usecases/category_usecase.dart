import 'package:dartz/dartz.dart';
import '../../../../../core/failure/failure.dart';
import '../entity/venue_card_entity.dart';
import '../repository/category_repository.dart';

class CategoryUseCase {
  final ICategoryRepository _remoteRepository;
  final ICategoryRepository _localRepository;

  CategoryUseCase(this._remoteRepository, this._localRepository);

  Future<Either<Failure, List<VenueCardEntity>>> getAllCategories() async {
    final localResult = await _localRepository.getAllCategories();

    return localResult.fold(
          (failure) async {
        final remoteResult = await _remoteRepository.getAllCategories();
        return remoteResult.fold(
              (remoteFailure) => Left(remoteFailure),
              (categories) async {
            await _localRepository.saveCategories(categories);
            return Right(categories);
          },
        );
      },
          (categories) => Right(categories),
    );
  }
}
