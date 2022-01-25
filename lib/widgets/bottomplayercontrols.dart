import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';

class PlayerControls extends StatefulWidget {
  const PlayerControls({Key? key}) : super(key: key);

  @override
  _PlayerControlsState createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  double _sliderval = 20;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              //width: 300,
              child: Row(
            children: [
              Image(image: AssetImage('assets/cover.jpg')),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hum Badi Door- Sonu Nigam',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      'Robi Tasr',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
          fluent.Center(
            child: Container(
              width: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.shuffle),
                    iconSize: 20,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(fluent.FluentIcons.previous),
                    iconSize: 25,
                    onPressed: () {},
                  ),
                  Stack(
                    children: [
                      fluent.Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(
                            //valueColor: Colors.red,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      fluent.Center(
                          child: IconButton(
                        icon: Icon(fluent.FluentIcons.play),
                        iconSize: 27,
                        onPressed: () {},
                      )),
                    ],
                  ),
                  IconButton(
                    icon: Icon(fluent.FluentIcons.next),
                    iconSize: 25,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.repeat),
                    iconSize: 20,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1.28/3.22',
                  style: TextStyle(color: Colors.white60),
                ),
                fluent.SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: Icon(fluent.FluentIcons.volume3),
                  iconSize: 25,
                  onPressed: () {},
                ),
                SliderTheme(
                  data: SliderThemeData(
                      activeTrackColor: Colors.red,
                      trackHeight: 3,
                      thumbColor: Colors.red),
                  child: Slider(
                      value: _sliderval,
                      max: 300,
                      divisions: 30,
                      onChanged: (slidevalue) {
                        setState(() {
                          _sliderval = slidevalue;
                        });
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
