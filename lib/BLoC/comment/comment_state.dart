import 'package:apple_shop/data/model/comments.dart';
import 'package:dartz/dartz.dart';

abstract class CommentState {}

class CommentsInitState extends CommentState {}

class CommentsLoadingState extends CommentState {}

class CommentsResponseState extends CommentState {
  Either<String, List<Comments>> getComments;

  CommentsResponseState(this.getComments);
}
