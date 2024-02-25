import 'package:apple_shop/data/datasource/basket_datasource.dart';
import 'package:apple_shop/data/model/basket_card.dart';

abstract class IBasketRepository {
  Future<void> addItem(BasketCard card);
  Future<List<BasketCard>> getCards();
  Future<void> deleteitem(int index);
  Future<int> finalPrice();
}

class BasketDatabaseRepository extends IBasketRepository {
  final IBasketDatasource _datasource;

  BasketDatabaseRepository(this._datasource);
  @override
  Future<void> addItem(BasketCard card) async {
    await _datasource.addItem(card);
  }

  @override
  Future<List<BasketCard>> getCards() async {
    return await _datasource.getCards();
  }

  @override
  Future<void> deleteitem(int index) async {
    await _datasource.deleteitem(index);
  }

  @override
  Future<int> finalPrice() async {
    return await _datasource.finalPrice();
  }
}
