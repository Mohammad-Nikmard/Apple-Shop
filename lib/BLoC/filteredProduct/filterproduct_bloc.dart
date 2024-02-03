import 'package:apple_shop/BLoC/filteredProduct/filter_product_event.dart';
import 'package:apple_shop/BLoC/filteredProduct/filterproduct_state.dart';
import 'package:apple_shop/data/repository/category_product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterProductBloc extends Bloc<FilterProductEvent, FilterProductState> {
  final ICategoryProductRepository _categoryProductRepository;
  FilterProductBloc(this._categoryProductRepository)
      : super(FilterProductInitState()) {
    on<FilterProductDataRequestEvent>(
      (event, emit) async {
        emit(FitlerProductLoadingState());
        var response =
            await _categoryProductRepository.getProducts(event.productId);
        emit(FilterProductResponseState(response));
      },
    );
  }
}
