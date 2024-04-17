import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Pages { login, signup, order, dish, ingredient, inventory, report }

enum AppColor { primary, pinky, darky, woody, linky, border }

extension PagesExtension on Pages {
  String get title {
    switch (this) {
      case Pages.login:
        return "Login";
      case Pages.signup:
        return "Signup";
      case Pages.order:
        return "Orders";
      case Pages.dish:
        return "Dishes";
      case Pages.ingredient:
        return "Ingredients";
      case Pages.inventory:
        return "Inventory";
      case Pages.report:
        return "Report";
    }
  }
}

extension AppColorExtension on AppColor {
  Color get color {
    switch (this) {
      case AppColor.primary:
        return const Color(0xFFA52947);
      case AppColor.pinky:
        return const Color(0xFFFFA4EE);
      case AppColor.darky:
        return const Color(0xFF77182F);
      case AppColor.woody:
        return const Color(0xFFD6BD96);
      case AppColor.linky:
        return const Color(0xFF1B75D0);
      case AppColor.border:
        return const Color(0xFF959595);
    }
  }
}

typedef VoidCallbackWithString = void Function(String s);

class MenuItem {
  final String title;
  final String route;
  final String icon;

  const MenuItem(
      {required this.title, required this.route, required this.icon});
}

const List<MenuItem> menuItems = [
  MenuItem(
    title: "Orders",
    route: "/orders",
    icon: "assets/icons/utensils-solid.png",
  ),
  MenuItem(
    title: "Dishes",
    route: "/dishes",
    icon: "assets/icons/burger-solid.png",
  ),
  MenuItem(
    title: "Ingredients",
    route: "/ingredients",
    icon: "assets/icons/wheat-awn-solid.png",
  ),
  MenuItem(
    title: "Inventory",
    route: "/inventory",
    icon: "assets/icons/cubes-stacked-solid.png",
  ),
  MenuItem(
    title: "Report",
    route: "/report",
    icon: "assets/icons/chart-line-solid.png",
  ),
];

List<T> map<T>(List<dynamic> list, T Function(dynamic) convert) {
  List<T> result = [];
  for (var item in list) {
    result.add(convert(item));
  }
  return result;
}

String getTypeText(dynamic type) {
  if (type is List) {
    return type.join(', '); // Join multiple types into a single string
  } else if (type is String) {
    return type; // Single type as string
  } else {
    return 'Unknown'; // Handle unknown or unexpected type
  }
}

String formatTimestamp(String timestampString) {
  if (timestampString.isEmpty) {
    return ''; // or any default value you prefer
  }

  try {
    DateTime dateTime = DateTime.parse(timestampString);
    String formattedDate = DateFormat.yMMMMd().format(dateTime);
    return formattedDate;
  } catch (e) {
    return '';
  }
}
