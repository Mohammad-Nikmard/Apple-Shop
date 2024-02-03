import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/data/datasource/banner_datasource.dart';
import 'package:apple_shop/data/model/banner.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IBannerRepository {
  Future<Either<String, List<BannerModel>>> getBanners();
}

class BannerRemoteRpository extends IBannerRepository {
  final IBannerDatasource _datasource = locator.get();
  @override
  Future<Either<String, List<BannerModel>>> getBanners() async {
    try {
      var response = await _datasource.getBanners();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }
}
