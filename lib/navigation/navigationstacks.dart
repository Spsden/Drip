
import 'package:drip/main.dart';
import 'package:drip/pages/artistspage.dart';
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

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  bool onWillPop(){
    if(Navigator.of(context).canPop())
    {
      return true;
    } return false;
  }


  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: 'youtubehomescreen',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'youtubehomescreen':
            return MaterialPageRoute(
                builder: (context) => YouTubeHomeScreen(), settings: settings);
            break;

          // case 'searchpage':
          //   final args = settings.arguments;
          //   return PageRouteBuilder(pageBuilder: (context, animation , secondaryAnimation) => AllSearchResults(searchQuery: args.toString()),
          //   transitionsBuilder: (context,animation,secondaryAnimation,child) {
          //     const begin = Offset(1.0, 0.0);
          //     const end = Offset.zero;
          //     const curve = Curves.fastLinearToSlowEaseIn;
          //
          //     var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          //
          //     return SlideTransition(
          //       position: animation.drive(tween),
          //       child: child,
          //     );
          //   });
          //     //
          //     // MaterialPageRoute(
          //     //   builder: (context) =>
          //     //       AllSearchResults(searchQuery: args.toString()),
          //     //   settings: settings);
          //   break;

        case 'searchpage':
          final args = settings.arguments;
          return PageRouteBuilder(pageBuilder: (context, animation , secondaryAnimation) => SecondPageStack(searchArgs: args.toString(),fromFirstPage: true),
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
  const SecondPageStack({Key? key, required this.searchArgs, this.fromFirstPage}) : super(key: key);
  final String searchArgs;
  final bool? fromFirstPage;

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
           // final args =
            return MaterialPageRoute(
                builder: (context) => AllSearchResults(      searchQuery: widget.fromFirstPage ==  true ?  widget.searchArgs.toString() : ''),
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


          case 'artistsPage':
            final args = settingsforpagetwo.arguments;
            return PageRouteBuilder(pageBuilder: (context, animation , secondaryAnimation) =>   ArtistsPage(),
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

            break;
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
