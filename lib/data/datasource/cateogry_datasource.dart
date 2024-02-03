import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class ICategoryDataSource {
  Future<List<Category>> getCategories();
}

class CategoryRemoteDataSource extends ICategoryDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<Category>> getCategories() async {
    try {
      var response = await _dio.get("collections/category/records");
      return response.data["items"]
          .map<Category>((jsonMapObject) => Category.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 0);
    }
  }
}
