import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/gallery.dart';
import 'package:apple_shop/data/model/product_properties.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:dartz/dartz.dart';

abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProdcutLoadingState extends ProductState {}

class ProductResponseState extends ProductState {
  Either<String, List<GalleryImages>> imagesList;
  Either<String, Category> categoryItem;
  Either<String, List<ProductVariant>> productVariantList;
  Either<String, List<ProductProperties>> getProperties;

  ProductResponseState(this.imagesList, this.categoryItem,
      this.productVariantList, this.getProperties);
}
