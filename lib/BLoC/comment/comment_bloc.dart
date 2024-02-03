import 'package:apple_shop/BLoC/comment/comment_event.dart';
import 'package:apple_shop/BLoC/comment/comment_state.dart';
import 'package:apple_shop/data/repository/comments_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final ICommentRepository _commentRepository;
  CommentBloc(this._commentRepository) : super(CommentsInitState()) {
    on<CommentInitativeEvent>(
      (event, emit) async {
        emit(CommentsLoadingState());
        var comments = await _commentRepository.getComments(event.productId);
        emit(CommentsResponseState(comments));
      },
    );

    on<PostNewCommentEvent>(
      (event, emit) async {
        _commentRepository.postComment(event.comment, event.productId);
        emit(CommentsLoadingState());
        var comments = await _commentRepository.getComments(event.productId);
        emit(CommentsResponseState(comments));
      },
    );
  }
}
