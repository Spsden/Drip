import 'package:flutter/material.dart';
class HoverToggle extends StatefulWidget {
  final Widget child;
  final Widget onHoverWidget;
  final Widget size;
  const HoverToggle({Key? key, required this.child, required this.onHoverWidget, required this.size}) : super(key: key);

  @override
  State<HoverToggle> createState() => _HoverToggleState();
}

class _HoverToggleState extends State<HoverToggle> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
