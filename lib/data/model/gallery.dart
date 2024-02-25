import 'package:apple_shop/constants/string_constatns.dart';

class GalleryImages {
  String? id;
  String? collectionId;
  String? productId;
  String? image;

  GalleryImages(this.id, this.collectionId, this.productId, this.image);

  factory GalleryImages.withJson(Map<String, dynamic> jsonMapObject) {
    return GalleryImages(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["product_id"],
      "${StringConstants.baseURL}/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["image"]}",
    );
  }
}
