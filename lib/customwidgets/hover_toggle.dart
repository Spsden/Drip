import 'package:flutter/material.dart';

class HoverToggle extends StatefulWidget {
  final Widget child;
  final Widget onHoverWidget;
  final Size size;
  final HoverMode hoverMode;

  const HoverToggle(
      {Key? key, required this.child, required this.onHoverWidget, required this.size,
        required this.hoverMode
      })
      : super(key: key);

  @override
  State<HoverToggle> createState() => _HoverToggleState();
}

class _HoverToggleState extends State<HoverToggle> with MaterialStateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: widget.size,
      child: MouseRegion(
          cursor: isHovered ? SystemMouseCursors.click : MouseCursor.defer,
          onEnter: (_) => setMaterialState(MaterialState.hovered, true),
          onExit: (_) => setMaterialState(MaterialState.hovered, true),
          child: widget.hoverMode == HoverMode.replace
              ? _buildReplaceableChildren()
              : _buildChildrenStack()


      ),
    );
  }

  Widget _buildChildrenStack() {
    Widget child = isHovered
        ? Opacity(opacity: 0.2, child: widget.child)
        : widget.child;
    return Stack(
      children: <Widget>[
        child,
        if (isHovered) widget.onHoverWidget,
      ],
    );
  }

  Widget _buildReplaceableChildren() {
    return
      isHovered ? widget.onHoverWidget : widget.child;
  }
}

enum HoverMode { replace, overlay }
