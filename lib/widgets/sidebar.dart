// import 'dart:developer';

// import 'package:drip/models/navigationmodels.dart';
// import 'package:drip/widgets/navigationoptions.dart';
// import 'package:drip/widgets/noresult.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';

// class SideBar extends StatefulWidget {
//   const SideBar({Key? key}) : super(key: key);

//   @override
//   _SideBarState createState() => _SideBarState();
// }

// class _SideBarState extends State<SideBar> {
//   double maxWidth = 200;
//   double minWidth = 74;
//   bool isCollapsed = false;
//   int currentSelectedIndex = 0;

//   @override
//   void initState() {
//     //List<bool> buttonSelectList = [true, false, false];
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height,
//       width: 74,
//       decoration: const BoxDecoration(
//         color: Colors.black87,
//         //border: BorderRadius.zero,
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
//             child: const Text(
//               'Drip',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   letterSpacing: 4,
//                   fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: navigationItems.length,
//               itemBuilder: (context, counter) {
//                 return NavigationOptions(
//                     onTap: () {
//                       setState(() {
//                         counter == 1
//                             ? Navigator.push(
//                                 context,
//                                 PageRouteBuilder(
//                                     pageBuilder: (_, __, ___) =>
//                                         noResult(context, 'error')))
//                             : null;
//                         currentSelectedIndex = counter;
//                       });
//                     },
//                     isSelected: currentSelectedIndex == counter,
//                     title: navigationItems[counter].title,
//                     icon: navigationItems[counter].icon);
//               },
//             ),
//           ),
//           InkWell(
//               onTap: () {
//                 setState(() {
//                   isCollapsed = !isCollapsed;
//                 });
//               },
//               child: NavigationOptions(
//                   onTap: () {},
//                   isSelected: false,
//                   title: 'Collapse',
//                   icon: Icons.chevron_left))
//           // InkWell(
//           //   splashColor: Colors.blue,
//           //   child: Icon(Icons.chevron_left_rounded,
//           //       color: Colors.white54, size: 20.0),
//           // )
//         ],
//       ),
//     );
//   }
// }

// TextStyle listTitleUnselectedStyle = TextStyle(
//     color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.normal);
// TextStyle listTitleSelectedStyle = TextStyle(
//     color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.normal);
// Color selectedColor = Colors.red.shade900;
// Color unselectedColor = Colors.black54;


// // class SideBarElements extends StatefulWidget {
// //   final int buttonNumber;
// //   final bool isSelected;
// //   final IconData icon;
// //   final Function onTap;
// //   //final bool selected;
// //   final String title;

// //   const SideBarElements(
// //       {Key? key,
// //       required this.icon,
// //       required this.onTap,
// //       // required this.selected,
// //       required this.title,
// //       required this.buttonNumber,
// //       required this.isSelected})
// //       : super(key: key);

// //   @override
// //   _SideBarElementsState createState() => _SideBarElementsState();
// // }

// // class _SideBarElementsState extends State<SideBarElements> {
// //  // int currentIndex = 0;
// //   //bool isSelected = false;

// //   @override
// //   void initState() {
// //     //buttonSelectList = [true, false, false];
// //     // TODO: implement initState
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return InkWell(
// //       onTap: () => widget.onTap,
// //       child: Padding(
// //         padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 20),
// //         child: Container(
// //             decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(10.0),
// //                 color:widget.isSelected
// //                     ? Colors.red.shade900
// //                     : Colors.black),
// //             width: 60.0,
// //             //color: Colors.white,
// //             child: Column(
// //               children: [
// //                 Container(
// //                   height: 40,
// //                   //height: 80.0,
// //                   //width: 101.0,
// //                   child: Center(
// //                     child: Icon(
// //                       widget.icon,
// //                       color: Colors.white,
// //                       size: 30.0,
// //                     ),
// //                   ),
// //                 ),
// //                 Padding(
// //                   padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 5),
// //                   child: Center(
// //                     child: Text(
// //                       widget.title,
// //                       style: TextStyle(
// //                         fontSize: 10,
// //                         fontWeight: FontWeight.normal,
// //                       ),
// //                     ),
// //                   ),
// //                 )
// //               ],
// //             )),
// //       ),
// //     );
// //   }
// // }

// // class CurvePainter extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     // TODO: implement paint
// //   }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) {
// //     // TODO: implement shouldRepaint
// //     throw UnimplementedError();
// //   }
// // }
