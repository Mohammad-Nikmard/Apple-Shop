import 'package:apple_shop/BLoC/home/home_event.dart';
import 'package:apple_shop/BLoC/home/home_state.dart';
import 'package:apple_shop/data/repository/banner_repository.dart';
import 'package:apple_shop/data/repository/category_repository.dart';
import 'package:apple_shop/data/repository/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository;
  final ICategoryRepository _categoryRepository;
  final IProductRepository _procutRepository;
  HomeBloc(
      this._bannerRepository, this._categoryRepository, this._procutRepository)
      : super(HomeInitState()) {
    on<HomeDataRequestEvent>(
      (event, emit) async {
        emit(HomeLoadingState());
        var bannerList = await _bannerRepository.getBanners();
        var categoryList = await _categoryRepository.geteCategories();
        var productList = await _procutRepository.getProducts();
        var bestSellerProductList =
            await _procutRepository.getBestSellerProducts();
        var hotestProductList = await _procutRepository.getHotestProducts();
        emit(HomeResponseState(bannerList, categoryList, productList,
            bestSellerProductList, hotestProductList));
      },
    );
  }
}
