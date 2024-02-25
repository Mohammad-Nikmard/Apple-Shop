import 'package:apple_shop/BLoC/basket/basket_bloc.dart';
import 'package:apple_shop/data/datasource/authentication_datasource.dart';
import 'package:apple_shop/data/datasource/banner_datasource.dart';
import 'package:apple_shop/data/datasource/basket_datasource.dart';
import 'package:apple_shop/data/datasource/category_product_datasource.dart';
import 'package:apple_shop/data/datasource/cateogry_datasource.dart';
import 'package:apple_shop/data/datasource/comment_datasource.dart';
import 'package:apple_shop/data/datasource/product_datasource.dart';
import 'package:apple_shop/data/datasource/product_detail_datasource.dart';
import 'package:apple_shop/data/repository/authnetication_repository.dart';
import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/data/repository/basket_repository.dart';
import 'package:apple_shop/data/repository/category_product_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/comments_repository.dart';
import 'package:apple_shop/data/repository/product_detail_repository.dart';
import 'package:apple_shop/data/repository/product_repository.dart';
import 'package:apple_shop/util/auth_manager.dart';
import 'package:apple_shop/util/dio_handler.dart';
import 'package:apple_shop/util/payment_handler.dart';
import 'package:apple_shop/util/url_handler.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zarinpal/zarinpal.dart';

var locator = GetIt.instance;

Future<void> initServiceLocator() async {
  await getComponents();

  getDatasources();

  getRepositores();

  getBlocs();
}

Future<void> getComponents() async {
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  locator.registerSingleton<Dio>(DioHandler.dioWithHeader());

  locator.registerSingleton<PaymentRequest>(PaymentRequest());
  locator.registerSingleton<URLHandler>(Launcher());
  locator.registerSingleton<PaymentHandler>(
      ZarinpalPayment(locator.get(), locator.get()));
}

void getDatasources() {
  locator.registerSingleton<ICategoryDataSource>(
      CategoryRemoteDataSource(locator.get()));
  locator.registerSingleton<IBannerDatasource>(
      BannerRemoteDataSource(locator.get()));
  locator.registerSingleton<IProductDatasource>(
      ProductRemoteDatasource(locator.get()));
  locator.registerSingleton<IProductDetailDatasource>(
      ProductDetailRemoteDatasource(locator.get()));
  locator.registerSingleton<ICategroyProductDatasource>(
      CategoryProductRemoteDatasource(locator.get()));
  locator.registerSingleton<IBasketDatasource>(BasketDatabase());
  locator
      .registerSingleton<IAuthenticationDatasource>(AuthenticationDatasource());
  locator.registerSingleton<ICommentDatasource>(
      CommentsRemoteDatasource(locator.get(), AuthManager.readId()));
}

void getRepositores() {
  locator.registerSingleton<ICategoryRepository>(
      CategoryRemoteRepository(locator.get()));
  locator.registerSingleton<IBannerRepository>(
      BannerRemoteRpository(locator.get()));
  locator.registerSingleton<IProductRepository>(
      ProductRemoteRepository(locator.get()));
  locator.registerSingleton<IProductDetailRepository>(
      ProductDetailRemoteRepository(locator.get()));
  locator.registerSingleton<ICategoryProductRepository>(
      CategoryProductRemoteRepository(locator.get()));
  locator.registerSingleton<IBasketRepository>(
      BasketDatabaseRepository(locator.get()));
  locator.registerSingleton<IAuthenticationRepository>(
      AuthenticationRepository(locator.get()));
  locator.registerSingleton<ICommentRepository>(
      CommentsRemoteRepository(locator.get()));
}

void getBlocs() {
  locator
      .registerSingleton<BasketBloc>(BasketBloc(locator.get(), locator.get()));
}
