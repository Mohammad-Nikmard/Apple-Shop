import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeResponseState extends HomeState {
  Either<String, List<BannerModel>> bannerList;
  Either<String, List<Category>> categoryList;
  Either<String, List<Product>> productList;
  Either<String, List<Product>> bestSellerProductList;
  Either<String, List<Product>> hotestproductList;

  HomeResponseState(this.bannerList, this.categoryList, this.productList,
      this.bestSellerProductList, this.hotestproductList);
}
