import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:drip/customwidgets/saved_playlists_widget.dart';
class UserLibrary extends StatefulWidget {
  const UserLibrary({Key? key}) : super(key: key);

  @override
  State<UserLibrary> createState() => _UserLibraryState();
}

class _UserLibraryState extends State<UserLibrary> {

  List<Widget> list = List.generate(10, (index) => const PlaylistContainer());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return
              //
              // fluent.Acrylic(
              //
              // tint: Colors.red,
              // blurAmount: 10,
              //  child:
              list[index];

            // );


          }, gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisExtent:370 ,
          maxCrossAxisExtent: 400.0,
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 15.0,
          childAspectRatio: 100 / 115,
        ),),
      ),
    );

  }
}
