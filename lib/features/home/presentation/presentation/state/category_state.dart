import '../../domain/entity/venue_card_entity.dart';

class CategoryState {
  final bool isLoading;
  final String? error;
  final List<VenueCardEntity> categories;
  final bool hasReachedMax;
  final int page;

  CategoryState({
    required this.isLoading,
    this.error,
    required this.categories,
    required this.page,
    required this.hasReachedMax,
  });

  factory CategoryState.initial() {
    return CategoryState(
      isLoading: false,
      error: null,
      categories: [],
      hasReachedMax: false,
      page: 0,
    );
  }

  CategoryState copyWith({
    bool? isLoading,
    String? error,
    int? page,
    List<VenueCardEntity>? categories,
    bool? hasReachedMax,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
      page: page ?? this.page,
      categories: categories ?? this.categories,
    );
  }

  @override
  String toString() =>
      'CategoryState(isLoading: $isLoading, error: $error, categories: $categories, hasReachedMax: $hasReachedMax, page: $page)';
}
