import 'package:url_launcher/url_launcher.dart';

abstract class URLHandler {
  Future<void> launchUrlforPayment(String? link);
}

class Launcher extends URLHandler {
  @override
  Future<void> launchUrlforPayment(String? link) async {
    await launchUrl(
      Uri.parse(link ?? ""),
      mode: LaunchMode.externalApplication,
    );
  }
}
