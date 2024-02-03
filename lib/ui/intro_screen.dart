import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/ui/dashboard_screen.dart';
import 'package:apple_shop/ui/first_screen.dart';
import 'package:apple_shop/util/auth_manager.dart';
import 'package:flutter/material.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  void initState() {
    super.initState();
    if (AuthManager.readToken().isEmpty) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  const FirstScreen()),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
      );
    } else if (AuthManager.readToken().isNotEmpty) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  const DashBoardScreen()),
              transitionDuration: const Duration(milliseconds: 500),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF58AEE8),
            ShopColors.blueColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        color: ShopColors.blueColor,
        image: DecorationImage(
          image: AssetImage("images/Star Pattern.png"),
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: _MainContent(),
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  const _MainContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.only(top: 45),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: 280,
                  width: 280,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("images/apple_logo.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.only(top: 60, right: 38),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "اوج هیجان",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "SB",
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "با خرید محصولات",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "SB",
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "!اپل",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "SB",
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: const BoxDecoration(
                      color: Color(0xFF253DEE), shape: BoxShape.circle),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset("images/icon_right_arrow_cricle.png"),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "From",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF86A4F7),
                  fontFamily: "GB",
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "MohammadNikmard",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.9),
                  fontFamily: "GB",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
