import 'package:apple_shop/BLoC/product/product_event.dart';
import 'package:apple_shop/BLoC/product/product_state.dart';
import 'package:apple_shop/data/model/basket_card.dart';
import 'package:apple_shop/data/repository/basket_repository.dart';
import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _detailRepository;
  final IBasketRepository _basketRepository;

  ProductBloc(this._detailRepository, this._basketRepository)
      : super(ProductInitState()) {
    on<ProductDataRequestEvent>(
      (event, emit) async {
        emit(ProdcutLoadingState());
        var imagesList = await _detailRepository.getImages(event.productId);
        var categoryItem =
            await _detailRepository.getCategory(event.categoryId);

        var productVariantList =
            await _detailRepository.getProductVariants(event.productId);

        var properties = await _detailRepository.getProperties(event.productId);

        emit(ProductResponseState(
            imagesList, categoryItem, productVariantList, properties));
      },
    );

    on<AddToBasketEvent>(
      (event, emit) async {
        var card = BasketCard(
          event.productItem.name!,
          event.productItem.price!,
          event.productItem.discountPrice!,
          event.productItem.discountPercentage!,
          event.productItem.thumbnail!,
        );
        await _basketRepository.addItem(card);
      },
    );
  }
}
