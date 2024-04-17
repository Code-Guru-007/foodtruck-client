import 'package:flutter/material.dart';
import 'package:treatlab_new/helper/defines.dart';
import 'package:treatlab_new/widgets/sidemenu_widget.dart';
import 'package:treatlab_new/widgets/topbar_widget.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final Pages page;

  const MainLayout({
    super.key,
    required this.child,
    required this.page,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Row(
          children: [
            SidemenuWidget(page: page),
            SizedBox(
              width: MediaQuery.of(context).size.width - 55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBarWidget(page: page),
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      );
}
