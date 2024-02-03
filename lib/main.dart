import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/data/model/basket_card.dart';
import 'package:apple_shop/ui/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  //Sharepref
  WidgetsFlutterBinding.ensureInitialized();

  //Hive
  await Hive.initFlutter();
  Hive.registerAdapter(BasketCardAdapter());
  await Hive.openBox<BasketCard>("basketCard");

  //GetIt
  await initServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontFamily: "SB",
            fontSize: 16,
            color: ShopColors.blueColor,
          ),
          bodyMedium: TextStyle(
            fontFamily: "SB",
            fontSize: 16,
          ),
          bodyLarge: TextStyle(
            fontFamily: "SB",
            fontSize: 20,
          ),
          bodySmall: TextStyle(
            fontFamily: "SB",
            fontSize: 12,
            color: Colors.black,
          ),
          labelSmall: TextStyle(
            fontFamily: "SB",
            fontSize: 10,
            color: ShopColors.greyColor,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const IntroductionScreen(),
    );
  }
}
