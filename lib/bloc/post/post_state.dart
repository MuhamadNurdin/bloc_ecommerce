abstract class PostState {}

class CategoriesLoading extends PostState {}

class CategoriesLoaded extends PostState {
  final List<String> categories;

  CategoriesLoaded(this.categories);
}

class CategoriesError extends PostState {
  final String message;

  CategoriesError(this.message);
}
