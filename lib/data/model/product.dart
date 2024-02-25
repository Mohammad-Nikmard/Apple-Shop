import 'package:apple_shop/constants/string_constatns.dart';

class Product {
  String? category;
  String? id;
  String? collectionId;
  String? description;
  int? discountPrice;
  String? name;
  String? popularity;
  int? price;
  int? quantity;
  String? thumbnail;
  num? discountPercentage;

  Product(
    this.category,
    this.id,
    this.collectionId,
    this.description,
    this.discountPrice,
    this.name,
    this.popularity,
    this.price,
    this.quantity,
    this.thumbnail,
  ) {
    discountPercentage = ((price! - discountPrice!) / price!) * 100;
  }

  factory Product.wihJson(Map<String, dynamic> jsonMapObject) {
    return Product(
      jsonMapObject["category"],
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["description"],
      jsonMapObject["discount_price"],
      jsonMapObject["name"],
      jsonMapObject["popularity"],
      jsonMapObject["price"],
      jsonMapObject["quantity"],
      "${StringConstants.baseURL}/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["thumbnail"]}",
    );
  }
}
