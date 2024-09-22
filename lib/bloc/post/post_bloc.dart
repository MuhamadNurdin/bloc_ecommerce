import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_google/services/api_service.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final ApiService apiService;

  PostBloc(this.apiService) : super(CategoriesLoading()) {
    on<FetchCategories>(_onFetchCategories);
  }

  Future<void> _onFetchCategories(FetchCategories event, Emitter<PostState> emit) async {
    try {
      emit(CategoriesLoading());
      final categories = await apiService.fetchCategories();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError('Failed to load categories'));
    }
  }
}
