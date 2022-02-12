import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_acrylic/flutter_acrylic.dart';

class PlayListMain extends StatefulWidget {
  const PlayListMain({Key? key}) : super(key: key);

  @override
  _PlayListMainState createState() => _PlayListMainState();
}

class _PlayListMainState extends State<PlayListMain> {
  //WindowEffect effect = WindowEffect.transparent;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Expanded(
      child: CustomScrollView(

        slivers: [
        SliverPersistentHeader(delegate:
        MySliverAppBar(expandedHeight: height/2.5),pinned: true,),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: Text('lol'),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: Text('lol'),
            ),
          )
,
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: Text('lol'),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: Text('lol'),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: Text('lol'),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: Text('lol'),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: Text('lol'),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: Text('lol'),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
              child: Text('lol'),
            ),
          )



        ],
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var size = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Opacity(
          opacity: 1- shrinkOffset / expandedHeight,
          child: Image.network(
            "https://wallpaperaccess.com/full/2817687.jpg",
            fit: BoxFit.cover,
          ),
        ),

        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              "MySliverAppBar",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
          ),
        ),
        Positioned(
          top:
          expandedHeight / 2 - shrinkOffset,
          left: size.width < 900 ?


          size.width * 0.05 : size.width * 0.02,
          child: Opacity(
            opacity: size.width < 900 ? (1 - shrinkOffset / expandedHeight) : ( 1 - shrinkOffset/expandedHeight ) ,
            child: mat.Card(
              elevation: 10,
              child: SizedBox(
                height: size.width < 900 ?
                expandedHeight/1.8 :size.width/6,
                width: size.width < 900 ?
                expandedHeight/1.8 :  size.width /6 ,
                child: FlutterLogo(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => mat.kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
