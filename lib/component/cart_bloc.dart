import 'package:flutter_bloc/flutter_bloc.dart';

class CartState {
  final List<String> selectedCategories;

  CartState({required this.selectedCategories});
}

class CartEvent {}

class AddCategoryEvent extends CartEvent {
  final String category;

  AddCategoryEvent(this.category);
}

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(selectedCategories: []));

  @override
  // ignore: override_on_non_overriding_member
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is AddCategoryEvent) {
      final updatedCategories = List<String>.from(state.selectedCategories);
      if (!updatedCategories.contains(event.category)) {
        updatedCategories.add(event.category);
      }
      yield CartState(selectedCategories: updatedCategories);
    }
  }
}
