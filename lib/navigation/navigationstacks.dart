
import 'package:drip/pages/common/tracklist.dart';
import 'package:drip/pages/explorepage.dart';
import 'package:drip/pages/playlistmainpage.dart';
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
            return MaterialPageRoute(
                builder: (context) => YouTubeHomeScreen(), settings: settings);
            break;

          case 'searchpage':
            final args = settings.arguments;
            return PageRouteBuilder(pageBuilder: (context, animation , secondaryAnimation) => AllSearchResults(searchQuery: args.toString()),
            transitionsBuilder: (context,animation,secondaryAnimation,child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.fastLinearToSlowEaseIn;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            });
              //
              // MaterialPageRoute(
              //   builder: (context) =>
              //       AllSearchResults(searchQuery: args.toString()),
              //   settings: settings);
            break;

          case 'songslistpage':
            final args = settings.arguments;
            return PageRouteBuilder(pageBuilder: (context, animation , secondaryAnimation) => TrackList(songQuery: args.toString()),
                transitionsBuilder: (context,animation,secondaryAnimation,child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.fastLinearToSlowEaseIn;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                });


            break;

          case 'playlists':
            final args = settings.arguments;
            return PageRouteBuilder(pageBuilder: (context, animation , secondaryAnimation) =>   PlaylistMain(playlistId: args.toString(),),
                transitionsBuilder: (context,animation,secondaryAnimation,child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.fastLinearToSlowEaseIn;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                });


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
          case 'searchpage':
            return MaterialPageRoute(
                builder: (context) => AllSearchResults(searchQuery: ''),
                settings: settingsforpagetwo);
            break;

          case 'songslistpage':
            final args = settingsforpagetwo.arguments;
            return PageRouteBuilder(pageBuilder: (context, animation , secondaryAnimation) => TrackList(songQuery: args.toString()),
                transitionsBuilder: (context,animation,secondaryAnimation,child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.fastLinearToSlowEaseIn;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                });


            break;

          case 'communityPlaylists':
            final args = settingsforpagetwo.arguments;
            return PageRouteBuilder(pageBuilder: (context, animation , secondaryAnimation) =>   PlaylistMain(playlistId: args.toString(),),
                transitionsBuilder: (context,animation,secondaryAnimation,child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.fastLinearToSlowEaseIn;

                  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                });
        }
      },
    );
  }
}


//
// class CommunityPlaylistPageStack extends StatelessWidget {
//   const CommunityPlaylistPageStack({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return   Navigator(
//       initialRoute: 'searchpage',
//       onGenerateRoute: (RouteSettings settingsforpagetwo) {
//         switch (settingsforpagetwo.name) {
//           case 'searchpage':
//             return MaterialPageRoute(
//                 builder: (context) => AllSearchResults(searchQuery: ''),
//                 settings: settingsforpagetwo);
//             break;
//
//           case 'songslistpage':
//             final args = settingsforpagetwo.arguments;
//             return MaterialPageRoute(
//                 builder: (context) => TrackList(songQuery: args.toString(),
//                   // incomingSongQuery: args.toString(),
//                 ),
//                 settings: settingsforpagetwo);
//             break;
//
//           default:
//             throw Exception("Invalid route");
//         }
//       },
//     );
//   }
// }
//
