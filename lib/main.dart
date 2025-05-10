import 'package:eCommerce/application/app.dart';
import 'package:eCommerce/data/controller/WishlistController.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(WishlistController());
  runApp(const eCommerce());
}
