import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/data/datasource/product_datasource.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IProductRepository {
  Future<Either<String, List<Product>>> getProducts();
  Future<Either<String, List<Product>>> getBestSellerProducts();
  Future<Either<String, List<Product>>> getHotestProducts();
}

class ProductRemoteRepository extends IProductRepository {
  final IProductDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Product>>> getProducts() async {
    try {
      var response = await _datasource.getProducts();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, List<Product>>> getBestSellerProducts() async {
    try {
      var response = await _datasource.getBestSellerProducts();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, List<Product>>> getHotestProducts() async {
    try {
      var response = await _datasource.getHotestProducts();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }
}
