import 'package:apple_shop/util/api_exception.dart';
import 'package:apple_shop/util/auth_manager.dart';
import 'package:apple_shop/util/dio_handler.dart';
import 'package:dio/dio.dart';

abstract class IAuthenticationDatasource {
  Future<void> register(
      String username, String password, String passwordConfirm);
  Future<String> login(String username, String password);
}

class AuthenticationDatasource extends IAuthenticationDatasource {
  final Dio _dio = DioHandler.dioWithoutHeader();
  @override
  Future<void> register(
      String username, String password, String passwordConfirm) async {
    try {
      var response = await _dio.post(
        "collections/users/records",
        data: {
          "username": username,
          "password": password,
          "passwordConfirm": passwordConfirm,
          "name": username,
        },
      );

      if (response.statusCode == 200) {
        login(username, password);
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode,
          response: ex.response);
    } catch (ex) {
      throw ApiException("$ex", 6);
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      var response = await _dio.post(
        "collections/users/auth-with-password",
        data: {
          'identity': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        var token = response.data["token"];
        var id = response.data["record"]["id"];
        AuthManager.saveToken(token);
        AuthManager.saveId(id);
        return token;
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode,
          response: ex.response);
    } catch (ex) {
      throw ApiException("$ex", 7);
    }
    return "";
  }
}
