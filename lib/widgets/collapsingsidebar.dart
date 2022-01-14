import 'package:flutter/material.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';

import 'package:mibe/screens/rightside.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  late List<CollapsibleItem> _items;

  final AssetImage _avatarImg = const AssetImage('assets/sps.jpg');

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    // _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Home',
        icon: Icons.home,
        onPressed: () => {},
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Playlist',
        icon: Icons.playlist_add,
        onPressed: () => {},
      ),
      CollapsibleItem(
        text: 'Search',
        icon: Icons.search,
        onPressed: () => {},
      ),
      CollapsibleItem(
        text: 'Notifications',
        icon: Icons.notifications,
        onPressed: () => {},
      ),

      // CollapsibleItem(
      //   text: 'Face',
      //   icon: Icons.face,
      //   onPressed: () => setState(() => _headline = 'Face'),
      // ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var collapsebool = true;
    return SafeArea(
      child: CollapsibleSidebar(
        minWidth: 70,
        iconSize: 25,
        borderRadius: 0,
        fitItemsToBottom: false,
        screenPadding: 0,
        isCollapsed: collapsebool,
        items: _items,
        avatarImg: _avatarImg,
        title: 'Mibe',
        onTitleTap: () {
          // collapsebool = true ? collapsebool = false : collapsebool = true;
          //collapsebool = false;
        },
        body: const RightSide(),
        // _body(size, context),
        backgroundColor: Colors.black,
        selectedIconBox: Colors.red.shade800,
        selectedTextColor: Colors.white,
        selectedIconColor: Colors.black,
        unselectedIconColor: Colors.white,
        unselectedTextColor: Colors.white,
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        titleStyle: const TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold),
        toggleTitleStyle:
            const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        sidebarBoxShadow: const [
          BoxShadow(
            color: Color(0xCC382728),
            // color: Colors.black54,
            blurRadius: 0,
            // spreadRadius: 0.01,
            // offset: Offset(3, 3),
          ),
          BoxShadow(
            color: Color(0xCC382728),
            blurRadius: 0,
            // spreadRadius: 0.01,
            // offset: Offset(3, 3),
          ),
        ],
      ),
    );
  }

  // Widget _body(Size size, BuildContext context) {
  //   return Container(
  //     height: double.infinity,
  //     width: double.infinity,
  //     color: Colors.blueGrey[50],
  //     child: Center(
  //       child: Transform.rotate(
  //         angle: math.pi / 2,
  //         child: Transform.translate(
  //           offset: Offset(-size.height * 0.3, -size.width * 0.23),
  //           child: Text(
  //             _headline,
  //             style: Theme.of(context).textTheme.headline1,
  //             overflow: TextOverflow.visible,
  //             softWrap: false,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

// Widget _body(Size size, BuildContext context) {
//     return Container(
//       height: double.infinity,
//       width: double.infinity,
//       color: Colors.blueGrey[50],
//       child: Center(
//         child: Transform.rotate(
//           angle: math.pi / 2,
//           child: Transform.translate(
//             offset: Offset(-size.height * 0.3, -size.width * 0.23),
//             child: Text(
//               _headline,
//               style: Theme.of(context).textTheme.headline1,
//               overflow: TextOverflow.visible,
//               softWrap: false,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
