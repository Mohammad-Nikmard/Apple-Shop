import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/data/datasource/cateogry_datasource.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<Category>>> geteCategories();
}

class CategoryRemoteRepository extends ICategoryRepository {
  final ICategoryDataSource _dataSource = locator.get();
  @override
  Future<Either<String, List<Category>>> geteCategories() async {
    try {
      var response = await _dataSource.getCategories();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }
}
