// ignore_for_file: camel_case_types, library_private_types_in_public_api, avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'package:treatlab_new/helper/defines.dart';
import 'package:treatlab_new/pages/dish_view.dart';
import 'package:treatlab_new/pages/ingredient_view.dart';
import 'package:treatlab_new/pages/inventory_view.dart';
import 'package:treatlab_new/pages/order_view.dart';
import 'package:treatlab_new/pages/report_view.dart';
import 'package:treatlab_new/pages/signin_view.dart';
import 'package:treatlab_new/pages/signup_view.dart';
import 'package:treatlab_new/widgets/logo_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext content) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TreatLab',
        initialRoute: '/',
        routes: {
          '/': (context) => const splash_screen(),
          '/login': (context) => const SigninView(),
          '/signup': (context) => const SignupView(),
          '/dishes': (context) => const DishView(),
          '/orders': (context) => const OrderView(),
          '/report': (context) => const ReportView(),
          '/inventory': (context) => const InventoryView(),
          '/ingredients': (context) => const IngredientView(),
        },
      );
}

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});
  @override
  _splash_screenState createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1))
        .then((value) => Navigator.of(context).pushReplacementNamed('/login'));

    return Scaffold(
      backgroundColor: AppColor.primary.color,
      body: const Center(child: LogoWidget()),
    );
  }
}
