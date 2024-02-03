class Category {
  String? id;
  String? collectionId;
  String? color;
  String? thumbnail;
  String? title;
  String? icon;

  Category(this.id, this.collectionId, this.color, this.thumbnail, this.title,
      this.icon);

  factory Category.withJson(Map<String, dynamic> jsonMapObject) {
    return Category(
      jsonMapObject["id"],
      jsonMapObject["collectionId"],
      jsonMapObject["color"],
      "https://startflutter.ir/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["thumbnail"]}",
      jsonMapObject["title"],
      "https://startflutter.ir/api/files/${jsonMapObject["collectionId"]}/${jsonMapObject["id"]}/${jsonMapObject["icon"]}",
    );
  }
}
