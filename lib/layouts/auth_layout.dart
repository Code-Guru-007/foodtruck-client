import 'package:flutter/material.dart';

import 'package:treatlab_new/helper/defines.dart';
import 'package:treatlab_new/widgets/logo_widget.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;
  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.only(left: 50, top: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset('assets/cloud.png',
                              width: 100, height: 30),
                          Image.asset('assets/stars.png',
                              width: 30, height: 50),
                          const SizedBox(width: 30),
                          const LogoWidget()
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Image.asset('assets/truck-front.jpg',
                          alignment: Alignment.topLeft,
                          width: double.infinity,
                          fit: BoxFit.cover))
                ],
              )),
          Container(
              width: 420,
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: child)
        ],
      ),
      backgroundColor: AppColor.primary.color,
    );
  }
}
