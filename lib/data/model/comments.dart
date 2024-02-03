class Comments {
  String? collectionId;
  String? id;
  String? productId;
  String? text;
  String? userId;
  String? userAvatar;
  String? name;

  Comments(this.collectionId, this.id, this.productId, this.text, this.userId,
      this.userAvatar, this.name);

  factory Comments.withJson(Map<String, dynamic> jsonMapObject) {
    return Comments(
      jsonMapObject["collectionId"],
      jsonMapObject["id"],
      jsonMapObject["product_id"],
      jsonMapObject["text"],
      jsonMapObject["user_id"],
      "https://startflutter.ir/api/files/${jsonMapObject["expand"]["user_id"]["collectionId"]}/${jsonMapObject["expand"]["user_id"]["id"]}/${jsonMapObject["expand"]["user_id"]["avatar"]}",
      jsonMapObject["expand"]["user_id"]["name"],
    );
  }
}
