class VariantType {
  String? name;
  String? title;
  String? type;
  VariantTypesEnum? typeEnum;
  String? collectionId;
  String? id;

  VariantType(this.name, this.title, this.type, this.typeEnum,
      this.collectionId, this.id);

  factory VariantType.withJson(Map<String, dynamic> jsonMapObject) {
    return VariantType(
      jsonMapObject["name"],
      jsonMapObject["title"],
      jsonMapObject["type"],
      types(jsonMapObject["type"]),
      jsonMapObject["collectionId"],
      jsonMapObject["id"],
    );
  }
}

VariantTypesEnum types(String type) {
  switch (type) {
    case "Color":
      return VariantTypesEnum.color;

    case "Storage":
      return VariantTypesEnum.storage;

    case "Vlotage":
      return VariantTypesEnum.volatge;

    default:
      return VariantTypesEnum.none;
  }
}

enum VariantTypesEnum {
  color,
  storage,
  volatge,
  none,
}
