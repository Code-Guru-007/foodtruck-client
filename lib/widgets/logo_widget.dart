import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'The Holy\nFoodTruck',
          style: TextStyle(
              color: Color(0xFFD6BD96),
              fontSize: 24,
              fontWeight: FontWeight.w400,
              shadows: <Shadow>[
                Shadow(
                    color: Color(0xFF333333),
                    offset: Offset(-1, 3),
                    blurRadius: 3)
              ]),
        ),
        SizedBox(height: 3),
        SizedBox(
          width: 150,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "by TREAT LAB",
                style: TextStyle(
                  color: Color(0xFFD6BD96),
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                ),
              ),
              Text(
                "\u24C7",
                style: TextStyle(
                  color: Color(0xFFD6BD96),
                  fontSize: 12,
                  fontWeight: FontWeight.w200,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
