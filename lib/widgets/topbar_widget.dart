import 'package:flutter/material.dart';
import 'package:treatlab_new/helper/defines.dart';

class TopBarWidget extends StatelessWidget {
  final Pages page;
  const TopBarWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    var rightCorner = (page.index == Pages.dish.index ||
            page.index == Pages.ingredient.index)
        ? [
            InkWell(
                onTap: () {},
                splashColor: Colors.transparent,
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
                highlightColor: Colors.transparent,
                child: Row(children: [
                  Image.asset("assets/anonymous.png", width: 55, height: 55),
                  const Text("administrator")
                ]))
          ]
        : [
            InkWell(
                onTap: () {},
                splashColor: Colors.transparent,
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
                highlightColor: Colors.transparent,
                child: Row(children: [
                  Image.asset("assets/anonymous.png", width: 55, height: 55),
                  const Text("administrator")
                ]))
          ];

    return Container(
        width: double.infinity,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 2, color: AppColor.primary.color),
        )),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(page.title,
              style: const TextStyle(
                  fontFamily: "Times New Roman",
                  fontSize: 28,
                  fontWeight: FontWeight.w500)),
          Row(children: rightCorner)
        ]));
  }
}
