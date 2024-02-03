import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/data/datasource/authentication_datasource.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthenticationRepository {
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm);

  Future<Either<String, String>> login(String username, String password);
}

class AuthenticationRepository extends IAuthenticationRepository {
  final IAuthenticationDatasource _datasource = locator.get();
  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _datasource.register(username, password, passwordConfirm);
      return right("ثبت نام شما موفقیت آمیز بود");
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      var response = await _datasource.login(username, password);
      if (response.isNotEmpty) {
        return right("شما وارد اکانت شدید");
      } else {
        return left("خطا در ورود به حساب کاربری");
      }
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }
}
