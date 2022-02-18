// import 'package:drip/pages/audioplayerbar.dart';
// import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart' as mat;
//
// class NowPlaying extends StatefulWidget {
//   final Size size;
//   const NowPlaying({Key? key, required this.size}) : super(key: key);
//
//   @override
//   _NowPlayingState createState() => _NowPlayingState();
// }
//
// class _NowPlayingState extends State<NowPlaying> {
//
//   double containerHeight = 100;
//   double containerWidth = double.infinity;
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//     //  alignment: AlignmentGeometry.lerp(a, b, t),
//       width: double.infinity,
//       height: containerHeight,
//       curve: Curves.bounceOut,
//      color: mat.Colors.transparent,
//       duration: Duration(milliseconds: 500),
//       child: Stack(
//         children: [
//           AudioPlayerBar(),
//           mat.Positioned(
//             left: 40,
//             top : 5,
//             child: IconButton(icon: Icon(FluentIcons.expand_menu), onPressed: () {
//               setState(() {
//                 containerHeight = containerHeight == 100 ?  widget.size.height: 100;
//                 //containerWidth = containerWidth == 150 ? 250 : 150;
//               });
//             }),
//           ),
//
//         ],
//       ),
//
//
//
//       );
//
//   }
// }
