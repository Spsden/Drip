//
//
// import 'package:fluent_ui/fluent_ui.dart' as fluent;
// import 'package:flutter/material.dart';
//
// class CustomLeftBar extends StatefulWidget {
//   final VoidCallback indexCallBack;
//   final Function(int) onIndexChange;
//
//   const CustomLeftBar(
//       {Key? key, required this.indexCallBack, required this.onIndexChange})
//       : super(key: key);
//
//   @override
//   State<CustomLeftBar> createState() => _CustomLeftBarState();
// }
//
// class _CustomLeftBarState extends State<CustomLeftBar> {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = fluent.FluentTheme.of(context);
//     return Container(
//       height: MediaQuery
//           .of(context)
//           .size
//           .height,
//       width: 80,
//       // constraints: const BoxConstraints(minWidth: 150, maxWidth: 280),
//       decoration: BoxDecoration(color: fluent.Colors.grey[210]),
//       child: Column(
//         children: [
//           const SizedBox(height: 10,),
//           fluent.Padding(
//             padding: const EdgeInsets.all(8.0),
//
//             child: InkWell(
//
//                 hoverColor: Colors.red,
//                 child: TextButton(
//                     onPressed: () {
//                       widget.onIndexChange(0);
//                       widget.indexCallBack();
//                     },
//                     child: Column(
//                       // mainAxisAlignment: MainAxisAlignment.start,
//                         children: const [
//                           Icon(
//                             fluent.FluentIcons.home,
//                             color: Colors.white,
//                           ),
//                           SizedBox(height: 5,),
//
//                           Text(
//                             'Home',
//                             style: TextStyle(color: Colors.white,),
//                           )
//                         ]))),
//           ),
//           const SizedBox(height: 10,),
//           fluent.Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: InkWell(
//
//                 child: TextButton(
//                     onPressed: () {
//                       widget.onIndexChange(1);
//                       widget.indexCallBack();
//                     },
//                     child: Column(
//                       //mainAxisAlignment: MainAxisAlignment.start,
//                         children: const [
//                           Icon(
//                             fluent.FluentIcons.search,
//                             color: Colors.white,
//                           ),
//                           SizedBox(height: 5,),
//
//                           Text(
//                             'Search',
//                             style: TextStyle(color: Colors.white),
//                           )
//                         ]))),
//           ),
//           const SizedBox(height: 10,),
//           fluent.Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: InkWell(
//
//                 hoverColor: Colors.red,
//
//                 child: TextButton(
//                     onPressed: () {
//                       widget.onIndexChange(2);
//                       widget.indexCallBack();
//                     },
//                     child: Column(
//                       //mainAxisAlignment: MainAxisAlignment.start,
//                         children: const [
//                           Icon(
//                             fluent.FluentIcons.playlist_music,
//                             color: Colors.white,
//                           ),
//                           SizedBox(height: 5,),
//
//                           Text(
//                             'Queue',
//                             style: TextStyle(color: Colors.white),
//                           )
//                         ]))),
//           ),
//           const SizedBox(height: 10,),
//           fluent.Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: InkWell(
//
//                 child: TextButton(
//                     onPressed: () {
//                       widget.onIndexChange(3);
//                       widget.indexCallBack();
//                     },
//                     child: Column(
//                       //mainAxisAlignment: MainAxisAlignment.start,
//                         children: const [
//                           Icon(
//                             fluent.FluentIcons.settings,
//                             color: Colors.white,
//                           ),
//                           SizedBox(height: 5,),
//
//                           Text(
//                             'Home',
//                             style: TextStyle(color: Colors.white),
//                           )
//                         ]))),
//           ),
//           // fluent.Padding(
//           //   padding: const EdgeInsets.all(8.0),
//           //   child: InkWell(
//           //       child: TextButton(
//           //           onPressed: () {},
//           //           child: Row(
//           //               mainAxisAlignment: MainAxisAlignment.start,
//           //               children: const [
//           //                 Icon(
//           //                   fluent.fluentIcons.home,
//           //                   color: Colors.white,
//           //                 ),
//           //                 SizedBox(width: 10,),
//           //
//           //                 Text(
//           //                   'Home',
//           //                   style: TextStyle(color: Colors.white),
//           //                 )
//           //               ]))),
//           // ),
//         ],
//       ),
//     );
//   }
// }
//
// class LeftBarButtonModel {
//   final String title;
//   final IconData icon;
//   final Function onPressed;
//
//   LeftBarButtonModel({
//     required this.title, required this.icon, required this.onPressed,
//
//   });
// }
//
// class LeftBarButtons extends StatelessWidget {
//   const LeftBarButtons({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
//
// class LeftPaneButtons extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final VoidCallback callback;
//
//   const LeftPaneButtons({Key? key,
//     required this.title,
//     required this.icon,
//     required this.callback})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return fluent.FilledButton(
//         child: Row(children: [Icon(icon), Text(title)]),
//         onPressed: () {
//           callback;
//         });
//   }
// }
