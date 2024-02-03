import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/data/datasource/product_detail_datasource.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/gallery.dart';
import 'package:apple_shop/data/model/product_properties.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<GalleryImages>>> getImages(String productId);
  Future<Either<String, Category>> getCategory(String categoryId);
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId);
  Future<Either<String, List<ProductProperties>>> getProperties(
      String productId);
}

class ProductDetailRemoteRepository extends IProductDetailRepository {
  final IProductDetailDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<GalleryImages>>> getImages(
      String productId) async {
    try {
      var response = await _datasource.getImages(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, Category>> getCategory(String categoryId) async {
    try {
      var response = await _datasource.getCategory(categoryId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, List<ProductVariant>>> getProductVariants(
      String productId) async {
    try {
      var response = await _datasource.getProductVariants(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, List<ProductProperties>>> getProperties(
      String productId) async {
    try {
      var response = await _datasource.getProperties(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }
}
