import 'package:apple_shop/constants/string_constatns.dart';
import 'package:apple_shop/util/auth_manager.dart';
import 'package:dio/dio.dart';

class DioHandler {
  static Dio dioWithHeader() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: StringConstants.baseURL,
        headers: {
          "Content-Type": "application-json",
          "Authorization": "Bearer ${AuthManager.readToken()}",
        },
      ),
    );

    return dio;
  }

  static Dio dioWithoutHeader() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: StringConstants.baseURL,
      ),
    );

    return dio;
  }
}
