import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/ui/login_screen.dart';
import 'package:apple_shop/ui/register_screen.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  height: 200,
                  width: 230,
                  child: Center(
                    child: Image.asset("images/avatar_apple.png"),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "اپل شاپ",
                    style: TextStyle(
                      fontFamily: "SB",
                      fontSize: 30,
                      color: ShopColors.blueColor,
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "لذت خرید با هیجان",
                    style: TextStyle(
                      fontFamily: "SM",
                      fontSize: 16,
                      color: ShopColors.blueColor,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: -50,
              left: -50,
              right: -50,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.7,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ShopColors.greyColor.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      MediaQuery.of(context).size.width,
                    ),
                    topRight: Radius.circular(
                      MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              left: -50,
              right: -50,
              child: Container(
                height: MediaQuery.of(context).size.height / 2.2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ShopColors.greyColor.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      MediaQuery.of(context).size.width,
                    ),
                    topRight: Radius.circular(
                      MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              left: -50,
              right: -50,
              child: Container(
                height: MediaQuery.of(context).size.height / 2.9,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ShopColors.darkBlueColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      MediaQuery.of(context).size.width,
                    ),
                    topRight: Radius.circular(
                      MediaQuery.of(context).size.width,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 55),
                        backgroundColor: ShopColors.blueColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                ((context, animation, secondaryAnimation) =>
                                    const LoginScreen()),
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "ورود",
                        style: TextStyle(
                          fontFamily: "SB",
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(150, 55),
                        side: const BorderSide(
                          color: ShopColors.blueColor,
                          width: 3,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                ((context, animation, secondaryAnimation) =>
                                    const RegisterScreen()),
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: const Text(
                        "ثبت نام",
                        style: TextStyle(
                          fontFamily: "SB",
                          fontSize: 18,
                          color: ShopColors.blueColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
