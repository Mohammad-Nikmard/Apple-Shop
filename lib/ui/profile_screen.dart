import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/ui/first_screen.dart';
import 'package:apple_shop/util/auth_manager.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShopColors.greyBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const _AppBar(),
            const SizedBox(height: 7),
            Text(
              "محمد نیک مرد",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 5),
            Text(
              "09377964183",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ProfileItemChip(
                          header: "علاقمندی ها",
                          image: "icon_heart_setting.png"),
                      ProfileItemChip(
                          header: "آدرس ها",
                          image: "icon_location_setting.png"),
                      ProfileItemChip(
                          header: "سفارشات اخیر",
                          image: "icon_card_setting.png"),
                      ProfileItemChip(
                          header: "تنظیمات", image: "icon_setting.png"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ProfileItemChip(
                          header: "بلاگ", image: "icon_blog_setting.png"),
                      ProfileItemChip(
                          header: "اطلاعیه", image: "icon_bell_setting.png"),
                      ProfileItemChip(
                          header: "تخفیف ها", image: "icon_offs_setting.png"),
                      ProfileItemChip(
                          header: "نقد و نظرات",
                          image: "icon_comments_setting.png"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ProfileItemChip(
                          header: "پشتیبانی", image: "icon_phone_setting.png"),
                      ProfileItemChip(
                          header: "سفارش در حال انجام",
                          image: "icon_queue_setting.png"),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(120.0, 50.0),
                backgroundColor: ShopColors.blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: () {
                AuthManager.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FirstScreen(),
                  ),
                );
              },
              child: const Text(
                "خروج از حساب کاربری",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "SB",
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            Text(
              "اپل شاپ",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 5),
            Text(
              "v-1.0.00",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 5),
            Text(
              "t.me/M_theSicko",
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class ProfileItemChip extends StatelessWidget {
  const ProfileItemChip({super.key, required this.header, required this.image});
  final String header;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: const ShapeDecoration(
            color: ShopColors.blueColor,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(45),
              ),
            ),
            shadows: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 25,
                color: ShopColors.blueColor,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: SizedBox(
            height: 26,
            width: 26,
            child: Center(
              child: Image.asset("images/$image"),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          header,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: "SB",
          ),
        ),
      ],
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 46,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("images/icon_apple_blue.png"),
              Text(
                "حساب کاربری",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
