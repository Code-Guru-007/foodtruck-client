import 'package:flutter/material.dart';

class ExpansionWidget extends StatefulWidget {
  final String title;
  final Icon trailingIcon;
  final List<Widget> children;
  final VoidCallback onTrailingActionStarted;
  const ExpansionWidget(
      {super.key,
      required this.title,
      required this.trailingIcon,
      required this.onTrailingActionStarted,
      // this.onTrailingActionEnded,
      required this.children});
  @override
  State<ExpansionWidget> createState() => _ExpansionWidgetState();
}

class _ExpansionWidgetState extends State<ExpansionWidget> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
          )),
      leading: AnimatedRotation(
        turns: isExpanded ? .5 : 0,
        duration: const Duration(milliseconds: 200),
        child: const Icon(Icons.expand_less_outlined, size: 20),
      ),
      trailing: InkWell(
        onTap: widget.onTrailingActionStarted,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          alignment: Alignment.center,
          width: 45,
          height: 45,
          child: widget.trailingIcon,
        ),
      ),
      shape: const Border.fromBorderSide(
          BorderSide(color: Colors.transparent, width: 0)),
      iconColor: Colors.black,
      textColor: Colors.black,
      expandedAlignment: Alignment.topLeft,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 24),
      initiallyExpanded: true,
      onExpansionChanged: (value) {
        setState(() {
          isExpanded = value;
        });
      },
      children: widget.children,
    );
  }
}
