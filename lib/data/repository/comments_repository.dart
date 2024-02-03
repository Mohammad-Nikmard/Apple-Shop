import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/data/datasource/comment_datasource.dart';
import 'package:apple_shop/data/model/comments.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dartz/dartz.dart';

abstract class ICommentRepository {
  Future<Either<String, List<Comments>>> getComments(String productId);
  Future<Either<String, String>> postComment(String text, String productId);
}

class CommentsRemoteRepository extends ICommentRepository {
  final ICommentDatasource _datasource = locator.get();

  @override
  Future<Either<String, List<Comments>>> getComments(String productId) async {
    try {
      var response = await _datasource.getComments(productId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }

  @override
  Future<Either<String, String>> postComment(
      String text, String productId) async {
    try {
      await _datasource.postComment(text, productId);
      return right("کامنت شما با موفقیت ثبت شد");
    } on ApiException catch (ex) {
      return left(ex.message!);
    }
  }
}
