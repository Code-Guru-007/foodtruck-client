import 'package:flutter/material.dart';
import 'package:treatlab_new/helper/defines.dart';
import 'package:treatlab_new/layouts/inventory_layout.dart';
import 'package:treatlab_new/layouts/main_layout.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({super.key});

  @override
  Widget build(BuildContext context) => const MainLayout(
        page: Pages.inventory,
        child: InventoryLayout(
          page: Pages.inventory,
        ),
      );
}
