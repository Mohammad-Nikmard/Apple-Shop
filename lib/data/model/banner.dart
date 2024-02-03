class BannerModel {
  String? collectionId;
  String? id;
  String? categoryId;
  String? thumbnail;

  BannerModel(this.collectionId, this.id, this.categoryId, this.thumbnail);

  factory BannerModel.withJson(Map<String, dynamic> jsonMapObject) {
    return BannerModel(
      jsonMapObject["collectionId"],
      jsonMapObject["id"],
      jsonMapObject["categoryId"],
      "https://startflutter.ir/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["thumbnail"]}",
    );
  }
}
