import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {

  double containerHeight = 100;
  double containerWidth = double.infinity;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerHeight,
      height: containerHeight,
      child: RaisedButton(
        child: Text('Click here'),
        onPressed: () {
          setState(() {
            containerHeight = containerHeight == 150 ? 250 : 150;
            containerWidth = containerWidth == 150 ? 250 : 150;
          });


        },
      ),
    );
  }
}
