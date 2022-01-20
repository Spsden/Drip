import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SizedBox(
        height: 40.0,
        child: WindowTitleBarBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: MoveWindow(
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(
                    8,
                    0,
                    0,
                    0,
                  ),
                  // child: Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     'Drip',
                  //     style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 20,
                  //         letterSpacing: 4,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                ),
              )),
              // SearchWidget(
              //   onSubmitted: (_query) {
              //     setQuery(_query);
              //     isSearchSelected = true;
              //   },
              //   // textcontroller: controller,
              // ),
              Expanded(child: MoveWindow()),
              Row(
                children: [
                  MinimizeWindowButton(
                    colors: WindowButtonColors(iconNormal: Colors.red),
                  ),
                  MaximizeWindowButton(
                      colors: WindowButtonColors(iconNormal: Colors.red)),
                  CloseWindowButton(
                      colors: WindowButtonColors(iconNormal: Colors.red))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
