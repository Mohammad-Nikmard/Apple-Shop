import 'package:apple_shop/data/model/basket_card.dart';

abstract class BasketState {}

class BasketInitState extends BasketState {}

class BasketLoadingState extends BasketState {}

class BasketResponseState extends BasketState {
  List<BasketCard> cardItems;
  int finalPrice;

  BasketResponseState(this.cardItems, this.finalPrice);
}
