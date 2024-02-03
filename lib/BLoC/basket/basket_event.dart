abstract class BasketEvent {}

class ShowBasketItemsEvent extends BasketEvent {}

class DeleteItemsEvent extends BasketEvent {
  int index;

  DeleteItemsEvent(this.index);
}

class PaymentRequestEvent extends BasketEvent {}
