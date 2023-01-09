
import 'package:flutter/material.dart';

class HoveredCard extends StatefulWidget {
  const HoveredCard({
    super.key,
    required this.child,
    this.clickable = true,
    this.aspectRatio = const AspectRatio(aspectRatio: 4/5.4),
  });

  final Widget child;
  final bool clickable;
  final AspectRatio aspectRatio ;


  @override
  State<HoveredCard> createState() => _HoveredCardState();
}

class _HoveredCardState extends State<HoveredCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(_hovered ? 20 : 8);
    const animationCurve = Curves.easeInOut;
    return MouseRegion(
      onEnter: (_) {
        if (!widget.clickable) return;
        setState(() {
          _hovered = true;
        });
      },
      onExit: (_) {
        if (!widget.clickable) return;
        setState(() {
          _hovered = false;
        });
      },
      cursor: widget.clickable
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      child: AnimatedContainer(
       height: 200,
        width: 180,


        margin: const EdgeInsets.only(right: 15),
        duration: kThemeAnimationDuration,
        curve: animationCurve,
        decoration: BoxDecoration(


          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 1,
          ),
          borderRadius: borderRadius,
        ),
        foregroundDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(
            _hovered ? 0.12 : 0,
          ),
          borderRadius: borderRadius,
        ),
        child: TweenAnimationBuilder<BorderRadius>(
          duration: kThemeAnimationDuration,
          curve: animationCurve,
          tween: Tween(begin: BorderRadius.zero, end: borderRadius),
          builder: (context, borderRadius, child) => ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: borderRadius,
            child: child,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}