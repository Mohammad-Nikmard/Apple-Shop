import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IProductDatasource {
  Future<List<Product>> getProducts();
  Future<List<Product>> getBestSellerProducts();
  Future<List<Product>> getHotestProducts();
}

class ProductRemoteDatasource extends IProductDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<Product>> getProducts() async {
    try {
      var response = await _dio.get("collections/products/records");
      return response.data["items"]
          .map<Product>((jsonMapObject) => Product.wihJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 2);
    }
  }

  @override
  Future<List<Product>> getBestSellerProducts() async {
    Map<String, String> qparams = {
      'filter': 'popularity = "Best Seller"',
    };
    try {
      var response = await _dio.get("collections/products/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<Product>((jsonMapObject) => Product.wihJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 2);
    }
  }

  @override
  Future<List<Product>> getHotestProducts() async {
    Map<String, String> qparams = {'filter': 'popularity = "Hotest"'};

    try {
      var response = await _dio.get("collections/products/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<Product>((jsonMapObject) => Product.wihJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 2);
    }
  }
}
