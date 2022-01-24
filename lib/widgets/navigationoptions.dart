// import 'package:flutter/material.dart';
//
// class NavigationOptions extends StatefulWidget {
//   final String title;
//   final IconData icon;
//   final bool isSelected;
//   final Function onTap;
//   const NavigationOptions(
//       {Key? key,
//       required this.title,
//       required this.icon,
//       required this.isSelected,
//       required this.onTap})
//       : super(key: key);
//
//   @override
//   _NavigationOptionsState createState() => _NavigationOptionsState();
// }
//
// class _NavigationOptionsState extends State<NavigationOptions> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       hoverColor: Colors.yellow.withOpacity(0.8),
//       //focusColor: Colors.red,
//       onTap: () {
//         widget.onTap.call();
//         print('lol ho gya na ?');
//       },
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 20),
//         child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//               color: widget.isSelected
//                   ? Colors.red.shade900.withOpacity(0.8)
//                   : Colors.transparent),
//           width: 60.0,
//           //color: Colors.white,
//           child: Column(
//             children: [
//               Container(
//                 height: 40,
//                 //height: 80.0,
//                 //width: 101.0,
//                 child: Center(
//                   child: Icon(
//                     widget.icon,
//                     color: widget.isSelected ? Colors.black : Colors.white,
//                     size: 30.0,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 5),
//                 child: Center(
//                   child: Text(
//                     widget.title,
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
