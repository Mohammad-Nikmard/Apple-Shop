import 'dart:ui';
import 'package:apple_shop/BLoC/basket/basket_bloc.dart';
import 'package:apple_shop/BLoC/category/category_bloc.dart';
import 'package:apple_shop/BLoC/category/category_event.dart';
import 'package:apple_shop/BLoC/home/home_bloc.dart';
import 'package:apple_shop/BLoC/home/home_event.dart';
import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/ui/basket_screen.dart';
import 'package:apple_shop/ui/category_screen.dart';
import 'package:apple_shop/ui/home_screen.dart';
import 'package:apple_shop/ui/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _currentState = 3;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: Scaffold(
        bottomNavigationBar: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: SizedBox(
              height: 65,
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentState,
                unselectedItemColor: Colors.black,
                selectedLabelStyle:
                    const TextStyle(fontFamily: "SB", fontSize: 10),
                unselectedLabelStyle:
                    const TextStyle(fontFamily: "SB", fontSize: 10),
                selectedItemColor: ShopColors.blueColor,
                onTap: (index) {
                  setState(() {
                    _currentState = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Image.asset(
                        "images/icon_profile.png",
                        height: 26,
                        width: 26,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: -15,
                              blurRadius: 25,
                              color: ShopColors.blueColor,
                              offset: Offset(0, 15),
                            ),
                          ],
                        ),
                        child: Image.asset("images/icon_profile_active.png"),
                      ),
                    ),
                    label: "حساب کاربری",
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Image.asset(
                        "images/icon_basket.png",
                        height: 26,
                        width: 26,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: -15,
                              blurRadius: 25,
                              color: ShopColors.blueColor,
                              offset: Offset(0, 15),
                            ),
                          ],
                        ),
                        child: Image.asset("images/icon_basket_active.png"),
                      ),
                    ),
                    label: "سبد خرید",
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Image.asset(
                        "images/icon_category.png",
                        height: 26,
                        width: 26,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: -15,
                              blurRadius: 25,
                              color: ShopColors.blueColor,
                              offset: Offset(0, 15),
                            ),
                          ],
                        ),
                        child: Image.asset("images/icon_category_active.png"),
                      ),
                    ),
                    label: "دسته بندی",
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Image.asset(
                        "images/icon_home.png",
                        height: 26,
                        width: 26,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: -15,
                              blurRadius: 25,
                              color: ShopColors.blueColor,
                              offset: Offset(0, 15),
                            ),
                          ],
                        ),
                        child: Image.asset("images/icon_home_active.png"),
                      ),
                    ),
                    label: "خانه",
                  ),
                ],
              ),
            ),
          ),
        ),
        body: IndexedStack(
          index: _currentState,
          children: [
            const ProfileScreen(),
            BlocProvider(
              create: (context) => locator.get<BasketBloc>(),
              child: const BasketScreen(),
            ),
            BlocProvider(
              create: (context) {
                var bloc = CategoryBloc(
                  locator.get(),
                );
                bloc.add(CategoryDataRequestEvent());
                return bloc;
              },
              child: const CategoryScreen(),
            ),
            BlocProvider(
              create: (context) {
                var bloc = HomeBloc(
                  locator.get(),
                  locator.get(),
                  locator.get(),
                );
                bloc.add(HomeDataRequestEvent());
                return bloc;
              },
              child: const HomeScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool exitApp = await showDialog(
      context: context,
      builder: ((context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: const Text(
              "خروج از برنامه",
              style: TextStyle(
                color: ShopColors.blueColor,
                fontFamily: "SB",
                fontSize: 18,
              ),
            ),
            content: const Text(
              "از برنامه خارج میشوید؟",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "SB",
                fontSize: 18,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "خیر",
                  style: TextStyle(
                    color: ShopColors.blueColor,
                    fontFamily: "SB",
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  "بله",
                  style: TextStyle(
                    color: ShopColors.redColor,
                    fontFamily: "SB",
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
    return exitApp;
  }
}
