abstract class FilterProductEvent {}

class FilterProductDataRequestEvent extends FilterProductEvent {
  String productId;

  FilterProductDataRequestEvent(this.productId);
}
