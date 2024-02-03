import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/data/model/category.dart';
import 'package:apple_shop/data/model/gallery.dart';
import 'package:apple_shop/data/model/product_properties.dart';
import 'package:apple_shop/data/model/product_variant.dart';
import 'package:apple_shop/data/model/variant_type.dart';
import 'package:apple_shop/data/model/variants.dart';
import 'package:apple_shop/util/api_exception.dart';
import 'package:dio/dio.dart';

abstract class IProductDetailDatasource {
  Future<List<GalleryImages>> getImages(String productId);
  Future<Category> getCategory(String categoryId);
  Future<List<VariantType>> getVariantTypes();
  Future<List<Variants>> getVariants(String productId);
  Future<List<ProductVariant>> getProductVariants(String productId);
  Future<List<ProductProperties>> getProperties(String productId);
}

class ProductDetailRemoteDatasource extends IProductDetailDatasource {
  final Dio _dio = locator.get();
  @override
  Future<List<GalleryImages>> getImages(String productId) async {
    Map<String, String> qparams = {
      'filter': 'product_id = "$productId"',
    };
    try {
      var response = await _dio.get("collections/gallery/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<GalleryImages>(
              (jsonMapObject) => GalleryImages.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 3);
    }
  }

  @override
  Future<Category> getCategory(String categoryId) async {
    Map<String, String> qparams = {
      'filter': 'id = "$categoryId"',
    };
    try {
      var response = await _dio.get("/collections/category/records",
          queryParameters: qparams);
      return Category.withJson(response.data["items"][0]);
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 0);
    }
  }

  @override
  Future<List<VariantType>> getVariantTypes() async {
    try {
      var response = await _dio.get("collections/variants_type/records");
      return response.data["items"]
          .map<VariantType>(
              (jsonMapObject) => VariantType.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 4);
    }
  }

  @override
  Future<List<Variants>> getVariants(String productId) async {
    Map<String, String> qparams = {'filter': 'product_id = "$productId"'};
    try {
      var response = await _dio.get("collections/variants/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<Variants>((jsonMapObject) => VariantType.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 5);
    }
  }

  @override
  Future<List<ProductVariant>> getProductVariants(String productId) async {
    var variantsType = await getVariantTypes();
    var variants = await getVariants(productId);

    List<ProductVariant> productVariantList = [];

    for (var variantTypeElement in variantsType) {
      var test = variants
          .where((variantsElement) =>
              variantsElement.typeId == variantTypeElement.type)
          .toList();

      productVariantList.add(ProductVariant(variantTypeElement, test));
    }

    return productVariantList;
  }

  @override
  Future<List<ProductProperties>> getProperties(String productId) async {
    Map<String, String> qparams = {'filter': 'product_id = "$productId"'};
    try {
      var response = await _dio.get("collections/properties/records",
          queryParameters: qparams);
      return response.data["items"]
          .map<ProductProperties>(
              (jsonMapObject) => ProductProperties.withJson(jsonMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data["message"], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException("$ex", 9);
    }
  }
}
