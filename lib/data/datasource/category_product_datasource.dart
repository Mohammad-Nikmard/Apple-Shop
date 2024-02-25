import 'package:apple_shop/data/model/product.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class ICategroyProductDatasource {
  Future<List<Product>> getProducts(String productId);
}

class CategoryProductRemoteDatasource extends ICategroyProductDatasource {
  final Dio _dio;

  CategoryProductRemoteDatasource(this._dio);
  @override
  Future<List<Product>> getProducts(String productId) async {
    try {
      if (productId == "qnbj8d6b9lzzpn8") {
        var response = await _dio.get(
          "collections/products/records",
        );
        return response.data["items"]
            .map<Product>((jsonMapObject) => Product.wihJson(jsonMapObject))
            .toList();
      } else {
        Map<String, String> qparams = {
          'filter': 'category = "$productId"',
        };
        var response = await _dio.get("collections/products/records",
            queryParameters: qparams);
        return response.data["items"]
            .map<Product>((jsonMapObject) => Product.wihJson(jsonMapObject))
            .toList();
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 2);
    }
  }
}
