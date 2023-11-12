import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

class PlayBackTest extends StatefulWidget {
  const PlayBackTest({Key? key}) : super(key: key);

  @override
  State<PlayBackTest> createState() => _PlayBackTestState();
}

class _PlayBackTestState extends State<PlayBackTest> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {}, child: Text("A")),
            ElevatedButton(onPressed: () {}, child: Text("B")),
            ElevatedButton(onPressed: () {}, child: Text("C")),
            MyScreen()
          ],
        ),
      ),
    );
  }
}

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => MyScreenState();
}

class MyScreenState extends State<MyScreen> {
  // Create a [Player] to control playback.
  late final player = Player();

  // Create a [VideoController] to handle video output from [Player].

  @override
  void initState() {
    super.initState();
    // Play a [Media] or [Playlist].
    player.open(Media(
      "https://rr2---sn-g5pauxapo-o5be.googlevideo.com/videoplayback?expire=1699802413&ei=zZhQZYDmHOmi9fwPoq21gAI&ip=202.43.120.196&id=o-AL1lv18eZfYt8Kv1J7xlH2ajueyxUdvDSIGBRWmADxfK&itag=251&source=youtube&requiressl=yes&mh=F_&mm=31%2C29&mn=sn-g5pauxapo-o5be%2Csn-cvh7knle&ms=au%2Crdu&mv=m&mvi=2&pl=24&initcwndbps=993750&vprv=1&mime=audio%2Fwebm&gir=yes&clen=3440118&dur=183.021&lmt=1686835151168081&mt=1699780381&fvip=1&keepalive=yes&fexp=24007246&beids=24350018&c=ANDROID_TESTSUITE&txp=4532434&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cgir%2Cclen%2Cdur%2Clmt&sig=ANLwegAwRAIgc027qW-RMvhbVzkAL_zQ1tsKl3mFhFHgKxG9U1iX56ACIF8_D08jBAVzjJlcdjuszeD7KJFXwteeD8KuE895_BSi&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AM8Gb2swRgIhANdxNNOSzwq5CNqrg5hxbCt0JXF2zpbrDhI8L1VvtmZ5AiEAkD_jL9oIUTEAMAENH51FC1ghywpIT2Bo_t-sEZnpWhI%3D",
    ));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 9.0 / 16.0,
          // Use [Video] widget to display video output.
          child: Placeholder()),
    );
  }
}
