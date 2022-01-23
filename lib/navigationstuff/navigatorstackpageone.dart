import 'package:drip/screens/explorepage.dart';
import 'package:drip/screens/searchpagerevision.dart';
import 'package:flutter/material.dart';

class FirstPageStack extends StatefulWidget {
  const FirstPageStack({Key? key}) : super(key: key);

  @override
  _FirstPageStackState createState() => _FirstPageStackState();
}

class _FirstPageStackState extends State<FirstPageStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'youtubehomescreen',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'youtubehomescreen':
            return MaterialPageRoute(builder: (context) => YouTubeHomeScreen() , settings: settings);
            break;

          case 'searchpage':
            final args = settings.arguments;
            return MaterialPageRoute(builder: (context) => SearchPage(incomingquery: args.toString()) , settings: settings);
            break;

          default:
            throw Exception("Invalid route");
            
        }
      },
    );
  }
}


class SecondPageStack extends StatefulWidget {
  const SecondPageStack({Key? key}) : super(key: key);

  @override
  _SecondPageStackState createState() => _SecondPageStackState();
}

class _SecondPageStackState extends State<SecondPageStack> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

