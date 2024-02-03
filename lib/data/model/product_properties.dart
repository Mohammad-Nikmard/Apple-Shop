class ProductProperties {
  String? collectionId;
  String? id;
  String? productId;
  String? value;
  String? title;

  ProductProperties(
      this.collectionId, this.id, this.productId, this.value, this.title);

  factory ProductProperties.withJson(Map<String, dynamic> jsonMapObject) {
    return ProductProperties(
      jsonMapObject["collectionId"],
      jsonMapObject["id"],
      jsonMapObject["product_id"],
      jsonMapObject["value"],
      jsonMapObject["title"],
    );
  }
}
