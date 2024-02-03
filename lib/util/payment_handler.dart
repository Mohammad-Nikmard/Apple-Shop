import 'package:apple_shop/util/extensions/string_extension.dart';
import 'package:apple_shop/util/url_handler.dart';
import 'package:uni_links/uni_links.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPayment(num amount);
  Future<void> launchPaymnet();
  Future<void> verficationPayment();
}

class ZarinpalPayment extends PaymentHandler {
  final PaymentRequest _paymentRequest;
  final URLHandler _urlHandler;

  String? authority;
  String? status;

  ZarinpalPayment(this._paymentRequest, this._urlHandler);

  @override
  Future<void> initPayment(num amount) async {
    _paymentRequest.setIsSandBox(false);
    _paymentRequest.setAmount(amount);
    _paymentRequest.setDescription("this is a test");
    _paymentRequest.setMerchantID("d645fba8-1b29-11ea-be59-000c295eb8fc");
    _paymentRequest.setCallbackURL("mohammadNik://shoptest");

    linkStream.listen(
      (deepLink) {
        if (deepLink!.toLowerCase().contains("authority")) {
          authority = deepLink.extractValueFromQuery("Authority")!;
          status = deepLink.extractValueFromQuery("Status")!;
        }
      },
    );
  }

  @override
  Future<void> launchPaymnet() async {
    ZarinPal().startPayment(
      _paymentRequest,
      (status, paymentGatewayUri) async {
        if (status == 100) {
          _urlHandler.launchUrlforPayment(paymentGatewayUri!);
        }
      },
    );
  }

  @override
  Future<void> verficationPayment() async {
    ZarinPal().verificationPayment(
      status!,
      authority!,
      _paymentRequest,
      (isPaymentSuccess, refID, paymentRequest) {
        if (isPaymentSuccess) {
          print(refID);
        } else {}
      },
    );
  }
}
