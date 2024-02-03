import 'package:apple_shop/BLoC/authentication/authentication_bloc.dart';
import 'package:apple_shop/BLoC/authentication/authentication_event.dart';
import 'package:apple_shop/BLoC/authentication/authentication_state.dart';
import 'package:apple_shop/DI/service_locator.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/ui/dashboard_screen.dart';
import 'package:apple_shop/ui/first_screen.dart';
import 'package:apple_shop/widgets/bloc_error_message.dart';
import 'package:apple_shop/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(locator.get()),
      child: const MainBody(),
    );
  }
}

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -165,
            left: -100,
            child: Container(
              height: 350,
              width: 350,
              decoration: const BoxDecoration(
                color: ShopColors.blueColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const _Header(),
          Positioned(
            right: 20,
            top: 90,
            child: JustTheTooltip(
              tailBaseWidth: 10,
              elevation: 8.0,
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              backgroundColor: ShopColors.blueColor,
              isModal: true,
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "نام کاربری و رمز عبور خود را",
                      style: TextStyle(
                        fontFamily: "SB",
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "وارد کنید تا وارد حساب خود شوید",
                      style: TextStyle(
                        fontFamily: "SB",
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: ShopColors.greyColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Image.asset("images/icon_information.png"),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            right: -50,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.45,
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
              height: MediaQuery.of(context).size.height / 1.6,
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
              height: MediaQuery.of(context).size.height / 1.8,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Text(
                    "نام کاربری",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "SB",
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      controller: _usernameController,
                      style: const TextStyle(
                        fontFamily: "SB",
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        fillColor: const Color(0xff1A2A4D),
                        filled: true,
                        hintText: "اینجا بنویسید...",
                        hintStyle: TextStyle(
                          fontFamily: "SB",
                          fontSize: 16,
                          color: ShopColors.greyColor.withOpacity(0.4),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          borderSide: BorderSide(
                            style: BorderStyle.none,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          borderSide: BorderSide(
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Text(
                    "رمز عبور",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "SB",
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xff1A2A4D),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              controller: _passwordController,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textDirection: TextDirection.rtl,
                              decoration: InputDecoration(
                                hintText: "اینجا بنویسید...",
                                hintStyle: TextStyle(
                                  fontFamily: "SB",
                                  fontSize: 16,
                                  color: ShopColors.greyColor.withOpacity(0.4),
                                ),
                                fillColor: const Color(0xff1A2A4D),
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide(
                                    style: BorderStyle.none,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  borderSide: BorderSide(
                                    style: BorderStyle.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    if (state is AuthenticationInitState) {
                      if (_usernameController.text == "" &&
                          _passwordController.text == "") {
                        return Center(
                          child: Container(
                            height: 55,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "ورود",
                                style: TextStyle(
                                  fontFamily: "SB",
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else if (_usernameController.text != "" &&
                          _passwordController.text != "") {
                        return Center(
                          child: ElevatedButton(
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
                              context.read<AuthenticationBloc>().add(
                                    AuthenticationLoginEvent(
                                      _usernameController.text,
                                      _passwordController.text,
                                    ),
                                  );
                            },
                            child: Text(
                              "ورود",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        );
                      }
                    } else if (state is AuthenticationLoadingState) {
                      return const LoadingAnimation(
                        color: Colors.white,
                      );
                    } else if (state is AuthenticationLoginResponseState) {
                      return state.loginMessage.fold(
                        (exceptionMessage) {
                          return Center(
                            child: ElevatedButton(
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
                                context.read<AuthenticationBloc>().add(
                                      AuthenticationLoginEvent(
                                        _usernameController.text,
                                        _passwordController.text,
                                      ),
                                    );
                              },
                              child: Text(
                                "ورود",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          );
                        },
                        (loginResponse) {
                          return Column(
                            children: [
                              Center(
                                child: ElevatedButton(
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
                                    context.read<AuthenticationBloc>().add(
                                          AuthenticationLoginEvent(
                                            _usernameController.text,
                                            _passwordController.text,
                                          ),
                                        );
                                  },
                                  child: Text(
                                    "ورود",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    return const BlocErrorMessage();
                  },
                  listener: ((context, state) {
                    if (state is AuthenticationLoginResponseState) {
                      _usernameController.text = "";
                      _passwordController.text = "";

                      return state.loginMessage.fold(
                        (message) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: SnackBarMessage(item: message),
                              duration: const Duration(seconds: 5),
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                            ),
                          );
                        },
                        (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DashBoardScreen(),
                            ),
                          );
                        },
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 45, left: 20),
          child: GestureDetector(
            onTap: () {
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
            child: const Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 22.5,
                ),
                SizedBox(width: 7),
                Text(
                  "برگشت",
                  style: TextStyle(
                    fontFamily: "SM",
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 50),
          child: Text(
            "ورود",
            style: TextStyle(
              fontFamily: "SB",
              fontSize: 38,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class SnackBarMessage extends StatelessWidget {
  const SnackBarMessage({super.key, required this.item});
  final String? item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 75,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            color: ShopColors.blueColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                spreadRadius: -10,
                blurRadius: 25,
                color: Colors.black,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: Center(
                        child: Lottie.asset(
                          "assets/Animation - 1706705888529.json",
                          repeat: true,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item ?? "خطا",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
