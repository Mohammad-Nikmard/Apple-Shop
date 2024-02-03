import 'package:apple_shop/data/model/product.dart';
import 'package:dartz/dartz.dart';

abstract class FilterProductState {}

class FilterProductInitState extends FilterProductState {}

class FitlerProductLoadingState extends FilterProductState {}

class FilterProductResponseState extends FilterProductState {
  Either<String, List<Product>> productList;

  FilterProductResponseState(this.productList);
}
