import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/data/model/comments.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:apple_shop/util/auth_manager.dart';
import 'package:dio/dio.dart';

abstract class ICommentDatasource {
  Future<List<Comments>> getComments(String productId);
  Future<void> postComment(String text, String productId);
}

class CommentsRemoteDatasource extends ICommentDatasource {
  final Dio _dio = locator.get();
  String? userId = AuthManager.readId();
  @override
  Future<List<Comments>> getComments(String productId) async {
    Map<String, dynamic> qparams = {
      'filter': 'product_id = "$productId"',
      'perPage': 50,
      'expand': 'user_id',
    };
    try {
      var response = await _dio.get("collections/comment/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<Comments>((jsonMapObject) => Comments.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 8);
    }
  }

  @override
  Future<void> postComment(String text, String productId) async {
    try {
      await _dio.post(
        "collections/comment/records",
        data: {
          'text': text,
          'user_id': userId,
          'product_id': productId,
        },
      );
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 8);
    }
  }
}
