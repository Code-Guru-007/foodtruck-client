import 'package:flutter/material.dart';
import 'package:treatlab_new/helper/defines.dart';
import 'package:treatlab_new/layouts/ingredient_layout.dart';
import 'package:treatlab_new/layouts/main_layout.dart';

class IngredientView extends StatelessWidget {
  const IngredientView({super.key});

  @override
  Widget build(BuildContext context) => const MainLayout(
        page: Pages.ingredient,
        child: IngredientLayout(
          page: Pages.ingredient,
        ),
      );
}
