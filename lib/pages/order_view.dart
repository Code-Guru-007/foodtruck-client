import 'package:flutter/material.dart';
import 'package:treatlab_new/helper/defines.dart';
import 'package:treatlab_new/layouts/order_layout.dart';
import 'package:treatlab_new/layouts/main_layout.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) => const MainLayout(
        page: Pages.order,
        child: OrderLayout(page: Pages.dish),
      );
}
