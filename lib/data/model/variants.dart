class Variants {
  String? collectionId;
  String? id;
  String? name;
  int? priceChange;
  String? productId;
  String? typeId;
  String? value;

  Variants(this.collectionId, this.id, this.name, this.priceChange,
      this.productId, this.typeId, this.value);

  factory Variants.withJson(Map<String, dynamic> jsonMapObject) {
    return Variants(
      jsonMapObject["collectionId"],
      jsonMapObject["id"],
      jsonMapObject["name"],
      jsonMapObject["price_change"],
      jsonMapObject["product_id"],
      jsonMapObject["type_id"],
      jsonMapObject["value"],
    );
  }
}
