import 'package:drip/pages/artistspage.dart';
import 'package:drip/pages/common/tracklist.dart';
import 'package:drip/pages/explore_page/explorepage.dart';
import 'package:drip/pages/playlistmainpage.dart';

import 'package:drip/pages/searchresultwidgets/albumsresultwidget.dart';
import 'package:drip/pages/searchresultwidgets/artistsresultwidget.dart';
import 'package:drip/pages/searchresultwidgets/search_page_drip.dart';
import 'package:drip/pages/user_library.dart';

import 'package:flutter/material.dart';

class FirstPageStack extends StatefulWidget {
  final GlobalKey? navigatorKey;

  const FirstPageStack({
    Key? key,
    this.navigatorKey,
  }) : super(key: key);

  @override
  FirstPageStackState createState() => FirstPageStackState();
}

class FirstPageStackState extends State<FirstPageStack> {
  bool onWillPop() {
    if (Navigator.of(context).canPop()) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: 'youtubehomescreen',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'youtubehomescreen':
            return MaterialPageRoute(
                builder: (context) => const YouTubeHomeScreen(),
                settings: settings);

          // case 'searchpage':
          //   final args = settings.arguments;
          //   return PageRouteBuilder(
          //       pageBuilder: (context, animation, secondaryAnimation) =>
          //           SecondPageStack(
          //             searchArgs: args.toString(),
          //             fromFirstPage: true,
          //             navigatorKey: widget.navigatorKey,
          //           ),
          //       transitionsBuilder:
          //           (context, animation, secondaryAnimation, child) {
          //         const begin = Offset(1.0, 0.0);
          //         const end = Offset.zero;
          //         const curve = Curves.fastLinearToSlowEaseIn;
          //
          //         var tween = Tween(begin: begin, end: end)
          //             .chain(CurveTween(curve: curve));
          //
          //         return SlideTransition(
          //           position: animation.drive(tween),
          //           child: child,
          //         );
          //       });

          case 'songslistpage':
            final args = settings.arguments;
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    TrackList(songQuery: args.toString()),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.fastLinearToSlowEaseIn;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                });


          // case 'playlists':
          //   final args = settings.arguments;
          //   return PageRouteBuilder(pageBuilder: (context, animation , secondaryAnimation) =>   PlaylistMain(playlistId: args.toString(),),
          //       transitionsBuilder: (context,animation,secondaryAnimation,child) {
          //         const begin = Offset(1.0, 0.0);
          //         const end = Offset.zero;
          //         const curve = Curves.fastLinearToSlowEaseIn;
          //
          //         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          //
          //         return SlideTransition(
          //           position: animation.drive(tween),
          //           child: child,
          //         );
          //       });
          //
          //
          //   break;
          //
          // default:
          //   throw Exception("Invalid route");
        }
        return null;
      },
    );
  }
}

class SecondPageStack extends StatefulWidget {
  const SecondPageStack({
    Key? key,
    required this.searchArgs,
    this.fromFirstPage,
    this.navigatorKey,
  }) : super(key: key);
  final String searchArgs;
  final bool? fromFirstPage;
  final GlobalKey? navigatorKey;

  @override
  SecondPageStackState createState() => SecondPageStackState();
}

class SecondPageStackState extends State<SecondPageStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'searchpage',
      key: widget.navigatorKey,
      onGenerateRoute: (RouteSettings settingsforpagetwo) {
        switch (settingsforpagetwo.name) {
          case 'searchpage':
            // final args =
            return MaterialPageRoute(
                builder: (context) =>
                    AllSearchResults2(navigatorKey: widget.navigatorKey));

          //     AllSearchResults(
          //     navigatorKey : widget.navigatorKey,
          //     searchQuery : 'Arijit'),
          // settings: settingsforpagetwo);

          case 'songslistpage':
            final args = settingsforpagetwo.arguments;
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    TrackList(songQuery: args.toString()),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.fastLinearToSlowEaseIn;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                });


          case 'artistListPage':
            final args = settingsforpagetwo.arguments;
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ArtistsSearchResults(artistQuery: args.toString()),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.fastLinearToSlowEaseIn;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                });

          case 'albumsListPage':
            final args = settingsforpagetwo.arguments;
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AlbumsSearchResults(albumsQuery: args.toString()),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.fastLinearToSlowEaseIn;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                });


          case 'artistsPage':
            final args = settingsforpagetwo.arguments;
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ArtistsPage(
                      channelId: args.toString(),
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.fastLinearToSlowEaseIn;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                });

          case 'communityPlaylists':
            final args = settingsforpagetwo.arguments;
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    PlaylistMain(
                      playlistId: args.toString(),
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  // const begin = Offset(1.0, 0.0);
                  // const end = Offset.zero;
                  // const curve = Curves.fastLinearToSlowEaseIn;

                  // var tween = Tween(begin: begin, end: end)
                  //     .chain(CurveTween(curve: curve));

                  return Align(
                      child: FadeTransition(
                    //position: animation.drive(tween),
                    opacity: animation,
                    child: child,
                  ));
                });

        }
        return null;
      },
    );
  }
}




class ThirdPageStack extends StatefulWidget {
  const ThirdPageStack({super.key, this.fromFirstPage, this.navigatorKey});

  // final String searchArgs;
  final bool? fromFirstPage;
  final GlobalKey? navigatorKey;

  @override
  State<ThirdPageStack> createState() => _ThirdPageStackState();
}

class _ThirdPageStackState extends State<ThirdPageStack> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'saved_playlists',
      key : widget.navigatorKey,
      onGenerateRoute: (RouteSettings settingsForPageThree) {
        switch(settingsForPageThree.name){
          case 'saved_playlists':
            return MaterialPageRoute(builder: (context) => const UserLibrary());
          case 'playlist_page':
            final  args = settingsForPageThree.arguments;
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>

                    PlaylistMain(
                      playlistId: args.toString(),
                    ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(1.0, 0.0);
                  const end = Offset.zero;
                  const curve = Curves.fastLinearToSlowEaseIn;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                });
        }
        return null;
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
