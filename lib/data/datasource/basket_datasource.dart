import 'package:apple_shop/data/model/basket_card.dart';
import 'package:hive_flutter/adapters.dart';

abstract class IBasketDatasource {
  Future<void> addItem(BasketCard card);
  Future<List<BasketCard>> getCards();
  Future<void> deleteitem(int index);
  Future<int> finalPrice();
}

class BasketDatabase extends IBasketDatasource {
  var box = Hive.box<BasketCard>("basketCard");

  @override
  Future<void> addItem(BasketCard card) async {
    await box.add(card);
  }

  @override
  Future<List<BasketCard>> getCards() async {
    return box.values.toList();
  }

  @override
  Future<void> deleteitem(int index) async {
    await box.deleteAt(index);
  }

  @override
  Future<int> finalPrice() async {
    var basketList = box.values.toList();

    var finalPrice = basketList.fold(
        0, (previousValue, element) => previousValue + element.discountPrice);

    return finalPrice;
  }
}
