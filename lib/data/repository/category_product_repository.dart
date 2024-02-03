import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/data/datasource/category_product_datasource.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICategoryProductRepository {
  Future<Either<String, List<Product>>> getProducts(String productId);
}

class CategoryProductRemoteRepository extends ICategoryProductRepository {
  final ICategroyProductDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<Product>>> getProducts(String productId) async {
    try {
      var response = await _datasource.getProducts(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }
}
