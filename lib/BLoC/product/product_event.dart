import 'package:apple_shop/data/model/product.dart';

abstract class ProductEvent {}

class ProductDataRequestEvent extends ProductEvent {
  String productId;
  String categoryId;

  ProductDataRequestEvent(this.productId, this.categoryId);
}

class AddToBasketEvent extends ProductEvent {
  Product productItem;

  AddToBasketEvent(this.productItem);
}

class CommentPostingEvent extends ProductEvent {
  String text;
  String productId;

  CommentPostingEvent(this.text, this.productId);
}
