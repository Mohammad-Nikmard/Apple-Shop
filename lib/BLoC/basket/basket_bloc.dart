import 'package:apple_shop/BLoC/basket/basket_event.dart';
import 'package:apple_shop/BLoC/basket/basket_state.dart';
import 'package:apple_shop/data/repository/basket_repository.dart';
import 'package:apple_shop/util/payment_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final IBasketRepository _basketRepository;
  final PaymentHandler _paymentHandler;
  BasketBloc(this._basketRepository, this._paymentHandler)
      : super(BasketInitState()) {
    on<ShowBasketItemsEvent>(
      (event, emit) async {
        emit(BasketLoadingState());
        var cardItems = await _basketRepository.getCards();
        var price = await _basketRepository.finalPrice();
        emit(BasketResponseState(cardItems, price));
      },
    );
    on<DeleteItemsEvent>(
      (event, emit) async {
        await _basketRepository.deleteitem(event.index);
        emit(BasketLoadingState());
        var cardItems = await _basketRepository.getCards();
        var price = await _basketRepository.finalPrice();
        emit(BasketResponseState(cardItems, price));
      },
    );

    on<PaymentRequestEvent>(
      (event, emit) async {
        var price = await _basketRepository.finalPrice();
        await _paymentHandler.initPayment(price);

        await _paymentHandler.launchPaymnet();

        await _paymentHandler.verficationPayment();
      },
    );
  }
}
