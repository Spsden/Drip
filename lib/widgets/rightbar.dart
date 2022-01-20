// import 'dart:ui';

// import 'package:drip/screens/explorepage.dart';
// import 'package:drip/widgets/topbar.dart';
// import 'package:flutter/material.dart';

// class RightContainer extends StatefulWidget {
//   final Function loadpage;
//   const RightContainer({Key? key, required this.loadpage}) : super(key: key);

//   @override
//   _RightContainerState createState() => _RightContainerState();
// }

// class _RightContainerState extends State<RightContainer> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         //shadowColor: Colors.red.shade600,
//         toolbarHeight: 40.0,
//         flexibleSpace: TopBar(),
//       ),
//       body: Stack(
//         children: [
//           SizedBox.expand(
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     colors: [Colors.black, Colors.red.shade800],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter),
//               ),
//             ),
//           ),
//           Expanded(child: YouTubeHomeScreen()),
//         ],
//         // children: [
//         //   Expanded(child: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.green,Colors.blue],begin: Alignment.topCenter,end: Alignment.bottomCenter),)
//         //   Expanded(child: YouTubeHomeScreen()),
//         // ],
//       ),
//     );
//   }
// }
