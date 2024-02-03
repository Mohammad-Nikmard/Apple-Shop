abstract class CommentEvent {}

class CommentInitativeEvent extends CommentEvent {
  String productId;

  CommentInitativeEvent(this.productId);
}

class PostNewCommentEvent extends CommentEvent {
  String comment;
  String productId;

  PostNewCommentEvent(this.comment, this.productId);
}
