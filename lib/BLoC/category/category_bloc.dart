import 'package:apple_shop/BLoC/category/category_event.dart';
import 'package:apple_shop/BLoC/category/category_state.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository _categoryRepository;

  CategoryBloc(this._categoryRepository) : super(CategoryInitState()) {
    on<CategoryDataRequestEvent>(
      (event, emit) async {
        emit(CategoryLoadingState());
        var getCategories = await _categoryRepository.geteCategories();
        emit(CategoryResponseState(getCategories));
      },
    );
  }
}
