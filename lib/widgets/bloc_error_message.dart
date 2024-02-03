import 'package:flutter/material.dart';

class BlocErrorMessage extends StatelessWidget {
  const BlocErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "خطا در دریافت اطلاعات",
        style: TextStyle(
          fontFamily: "SB",
          fontSize: 25,
        ),
      ),
    );
  }
}
