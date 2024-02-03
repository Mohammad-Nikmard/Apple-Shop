import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IBannerDatasource {
  Future<List<BannerModel>> getBanners();
}

class BannerRemoteDataSource extends IBannerDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<BannerModel>> getBanners() async {
    try {
      var response = await _dio.get("collections/banner/records");
      return response.data["items"]
          .map<BannerModel>(
              (jsonMapObject) => BannerModel.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 1);
    }
  }
}
