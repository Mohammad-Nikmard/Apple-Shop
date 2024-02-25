import 'package:apple_shop/constants/string_constatns.dart';

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
      "${StringConstants.baseURL}/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["thumbnail"]}",
    );
  }
}
