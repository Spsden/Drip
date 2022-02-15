import 'dart:ui';

import 'package:drip/datasources/searchresults/artistpagedataclass.dart';
import 'package:drip/datasources/searchresults/searchresultsservice.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_acrylic/flutter_acrylic.dart';

class ArtistsPage extends StatefulWidget {
  const ArtistsPage({Key? key}) : super(key: key);

  @override
  _ArtistsPageState createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
   late ArtistsPageData _artistsPage ;

   bool status = false;
   bool fetched = false;



  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    const spacer = SizedBox(width: 10.0);
    const biggerSpacer = SizedBox(width: 40.0);
    var size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;

    if(!status){
      status = true;
      SearchMusic.getArtistPage('UC13ToEQgfmTe8_GW19LYtCg').then((value) => {
        if(mounted){
          setState(() {
            _artistsPage = value;
            fetched = true;
          })
        }
      });
    }
    return

    (!fetched) ? SizedBox() :
   CustomScrollView(
      controller: _scrollController,

      slivers: [
        mat.SliverAppBar(
          //leadingWidth: 0,
         titleSpacing: 0,


         toolbarHeight: 90,
         collapsedHeight: 100,
         // titleSpacing: 5,
          pinned: true,
          //snap: true,
         // floating: true,
          // actions: <Widget>[
          //   mat.IconButton(
          //     icon: Icon(mat.Icons.comment),
          //     tooltip: 'Comment Icon',
          //     onPressed: () {},
          //   ), //IconButton
          //   mat.IconButton(
          //     icon: Icon(mat.Icons.settings),
          //     tooltip: 'Setting Icon',
          //     onPressed: () {},
          //   ), //IconButton
          // ],

          expandedHeight: height /2,
          stretch: true,
          flexibleSpace: mat.FlexibleSpaceBar(
            title: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  width: 200,
                  child: Column(
                      crossAxisAlignment: mat.CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,

                      children :  [
                        Text(
                            //'Sonu Nigam',
                          _artistsPage.name.toString(),

                          style: mat.TextStyle(
                            fontSize: 35
                          ),
                        ),
                        Text(
                          'Sonu Nigam is an Indian singer, music director, and actor. He has been described in the media as one of the most popular and successful playback singers of Hindi Cinema. The recipient of several '

                          ,
                          style: mat.TextStyle(
                            fontSize: 10,
                            letterSpacing: 0.2
                          ),
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),





                      ]

                  ),
                ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                 // width: 85,
                  child: FilledButton(
                    autofocus: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:  [
                        //Icon(FluentIcons.more),
                        // spacer,
                        Icon(FluentIcons.play_solid),
                        size.width > 700 ?
                        Text('Shuffle',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500)) : SizedBox(),

                      ],
                    ),
                    onPressed: () {
                      SearchMusic.getArtistPage('UC13ToEQgfmTe8_GW19LYtCg').then((value) => {
                        if(mounted){
                          setState(() {
                            _artistsPage = value;
                           // print(artistsPageData.)
                      })
                        }

                      });
                    },
                  ),
                ),


              ],


            ),
            stretchModes: [
              mat.StretchMode.zoomBackground,
              mat.StretchMode.blurBackground,
            ],
            background: ShaderMask(
              blendMode: BlendMode.luminosity,
              shaderCallback: (bounds) {
                return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black
                    ]
                ).createShader(
                  bounds
                );
              },
              child: Image.network(
                 "https://wallpaperaccess.com/full/2817687.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

      // SliverPersistentHeader(delegate:
      // MySliverAppBar(expandedHeight: height/2.5),pinned: true,),



      ],
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
