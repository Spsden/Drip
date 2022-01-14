import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'package:mibe/widgets/explorepage.dart';
import 'package:mibe/widgets/searchwidget.dart';

class RightSide extends StatefulWidget {
  const RightSide({Key? key}) : super(key: key);

  @override
  _RightSideState createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.red.shade800, Colors.black])),
      child: Column(
        children: [
          TopBar(
            controller: _controller,
          ),
          Expanded(child: YouTubeHomeScreen())
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final TextEditingController controller;
  const TopBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: WindowTitleBarBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: MoveWindow()),
            SearchWidget(
              onSubmitted: (_query) {
                // Navigator.push(
                //   context,
                //   PageRouteBuilder(
                //     opaque: false,
                //     pageBuilder: (_, __, ___) => YouTubeSearchPage(
                //       query: _query,
                //     ),
                //   ),
                // );
                // controller.text = '';
              },
              textcontroller: controller,
            ),
            Expanded(child: MoveWindow()),
            Row(
              children: [
                MinimizeWindowButton(),
                MaximizeWindowButton(),
                CloseWindowButton()
              ],
            )
          ],
        ),
      ),
    );
  }
}
