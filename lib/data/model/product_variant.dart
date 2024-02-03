import 'package:apple_shop/data/model/variant_type.dart';
import 'package:apple_shop/data/model/variants.dart';

class ProductVariant {
  VariantType variantType;
  List<Variants> variantsList;

  ProductVariant(this.variantType, this.variantsList);
}
