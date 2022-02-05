import 'package:drip/pages/common/musiclist.dart';
import 'package:drip/pages/explorepage.dart';
import 'package:drip/pages/search.dart';
import 'package:drip/pages/searchpage.dart';


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
            return MaterialPageRoute(builder: (context) => AllSearchResults(searchQuery: args.toString()), settings: settings);
            break;

          case 'songslistpage' :
            final args = settings.arguments;
            return MaterialPageRoute(builder: (context) => MusicList(isExpandedPage: true,incomingquery: args.toString(),songs: [],toSongsList: args.toString(),) , settings: settings);
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
    return Navigator(
      initialRoute: 'searchpage',
      onGenerateRoute: (RouteSettings settingsforpagetwo) {

        switch (settingsforpagetwo.name) {

          case 'searchpage' :
            return MaterialPageRoute(builder: (context) => AllSearchResults(searchQuery: 'lol') , settings: settingsforpagetwo);
            break;

          case 'songslistpage' :
            final args = settingsforpagetwo.arguments;
            return MaterialPageRoute(builder: (context) => MusicList(isExpandedPage: true,incomingquery: args.toString(),songs: [],toSongsList: args.toString(),) , settings: settingsforpagetwo);
            break;
        }
      },



    );
  }
}



