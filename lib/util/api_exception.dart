import 'package:dio/dio.dart';

class ApiException implements Exception {
  String? message;
  int? errorCode;
  Response? response;

  ApiException(this.message, this.errorCode, {this.response}) {
    if (errorCode != 400) {
      return;
    } else if (message == "Failed to authenticate.") {
      message = ".نام کاربری یا رمز عبور اشتباه است";
    }
    if (message == "Failed to create record.") {
      if (response?.data["data"]["username"] != null) {
        if (response?.data["data"]["username"]["message"] ==
            "The username is invalid or already in use.") {
          message = ".نام کاربری قبلا گرفته شده است";
        }
      }
    }
  }
}


// 0 errorCode = Category
// 1 errorCode = banners
// 2 erorCode = products
// 3 errorColde = galletImages
// 4 errorCode = variantTypes
// 5 errorCode = varaints
// 6 errorCode = register
// 7 errorCode = login
// 8 errorCode = comments
// 9 errorCode = productProperties