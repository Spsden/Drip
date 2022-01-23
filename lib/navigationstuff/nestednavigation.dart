// import 'dart:core';
// import 'package:drip/screens/explorepage.dart';
// import 'package:flutter/material.dart';
//
// class TabNavigatorRoutes {
//   static const String homePage = '/';
//   static const String searchPage = '/searchpage';
//   static const String playlistPage = '/playlists';
//
// }
//
// class TabNavigator extends StatelessWidget {
//   final GlobalKey<NavigatorState> navigatorkey;
//   final TabItem tabItem;
//   const TabNavigator({Key? key, required this.navigatorkey, this.tabItem}) : super(key: key);
//
//   void _push(BuildContext context, {String widgetparams : 'lol'}){
//     var routeBuilders = _routeBuilders(context,widgetparams : widgetparams);
//
//     Navigator.push(context, MaterialPageRoute(
//       builder: (context) => routeBuilders!![TabNavigatorRoutes.searchPage](context)
//     ));
//   }
//
//   Map<String,WidgetBuilder> _routeBuilders(BuildContext context, {String widgetparams : 'lol'}) {
//     return {
//       TabNavigatorRoutes.homePage : (context) => YouTubeHomeScreen()
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
