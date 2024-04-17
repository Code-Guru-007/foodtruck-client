import 'package:flutter/material.dart';
import 'package:treatlab_new/helper/defines.dart';
import 'package:treatlab_new/layouts/dish_layout.dart';
import 'package:treatlab_new/layouts/main_layout.dart';

class DishView extends StatelessWidget {
  const DishView({super.key});

  @override
  Widget build(BuildContext context) => const MainLayout(
        page: Pages.dish,
        child: DishLayout(page: Pages.dish),
      );
}
