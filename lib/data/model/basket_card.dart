import 'package:hive/hive.dart';

part 'basket_card.g.dart';

@HiveType(typeId: 0)
class BasketCard {
  @HiveField(0)
  String title;

  @HiveField(1)
  int price;

  @HiveField(2)
  int discountPrice;

  @HiveField(3)
  num percentageAmount;

  @HiveField(5)
  String thumbnail;

  BasketCard(this.title, this.price, this.discountPrice, this.percentageAmount,
      this.thumbnail);
}
