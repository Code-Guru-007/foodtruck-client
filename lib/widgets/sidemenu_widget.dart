import 'package:flutter/material.dart';

import 'package:treatlab_new/helper/defines.dart';

class SidemenuWidget extends StatelessWidget {
  final Pages page;
  const SidemenuWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(color: AppColor.primary.color),
      width: 55,
      child: Column(children: [
        Container(
            width: 55,
            height: 55,
            padding: const EdgeInsets.all(15),
            child: Image.asset("assets/stars.png")),
        const Expanded(child: Text("")),
        Center(
          child: Column(
              children: map(
                  menuItems,
                  (menuItem) => Container(
                      width: 55,
                      height: 55,
                      padding: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          color: (menuItem.title == page.title)
                              ? AppColor.darky.color
                              : AppColor.primary.color),
                      child: InkWell(
                          onTap: () => {
                                Navigator.of(context)
                                    .pushReplacementNamed(menuItem.route)
                              },
                          child: Column(
                            children: [
                              Image.asset(menuItem.icon,
                                  width: 26, height: 26, fit: BoxFit.contain),
                              Text(menuItem.title,
                                  style: TextStyle(
                                    color: AppColor.woody.color,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w200,
                                  ))
                            ],
                          ))))),
        ),
        const SizedBox(height: 110),
        const Expanded(child: Text("")),
      ]));
}
