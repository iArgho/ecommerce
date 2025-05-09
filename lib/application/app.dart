import 'package:eCommerce/application/theme/app_color.dart';
import 'package:eCommerce/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class eCommerce extends StatelessWidget {
  const eCommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: MaterialColor(
          AppColor.primaryColor.value,
          AppColor().color,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
