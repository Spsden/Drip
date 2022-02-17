import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drip/datasources/searchresults/artistpagedataclass.dart';
import 'package:drip/datasources/searchresults/searchresultsservice.dart';
import 'package:drip/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:provider/provider.dart';

import 'common/backButton.dart';

class ArtistsPage extends StatefulWidget {
  final String channelId;
  const ArtistsPage({Key? key, required this.channelId}) : super(key: key);

  @override
  _ArtistsPageState createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> with AutomaticKeepAliveClientMixin<ArtistsPage>,SingleTickerProviderStateMixin {
   late ArtistsPageData _artistsPage ;

   bool status = false;
   bool fetched = false;
   late mat.TabController _tabController ;



  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {

    super.initState();
    _tabController = mat.TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {

    super.dispose();
    _tabController.dispose();
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
      SearchMusic.getArtistPage(widget.channelId).then((value) => {
        if(mounted){
          setState(() {
            _artistsPage = value;
            fetched = true;
          })
        }
      });
    }
    return Stack(
      children: [


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
                actions: <Widget>[
                  mat.IconButton(
                    icon: Icon(mat.Icons.more_horiz_rounded),
                    tooltip: 'Comment Icon',
                    onPressed: () {},
                  ), //IconButton
                  // mat.IconButton(
                  //   icon: Icon(mat.Icons.settings),
                  //   tooltip: 'Setting Icon',
                  //   onPressed: () {},
                  // ), //IconButton
                ],

                expandedHeight: height /2,
                stretch: true,
                flexibleSpace: mat.FlexibleSpaceBar(
                  titlePadding: mat.EdgeInsets.only(left: 20,bottom: 60,right: 20),
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

                                style: const mat.TextStyle(
                                    fontSize: 35
                                ),
                              ),
                              Row(

                                children: [
                                  mat.Icon(mat.Icons.subscriptions),
                                  spacer,
                                  Text(
                                    _artistsPage.subscribers.toString()

                                    ,
                                    style: const mat.TextStyle(
                                        fontSize: 10,
                                        letterSpacing: 0.2
                                    ),
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                ],
                              )






                            ]

                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        // width: 85,
                        child: mat.ElevatedButton(
                          style: mat.ButtonStyle(
                            backgroundColor: mat.MaterialStateProperty.all(context.watch<AppTheme>().color)
                          ),
                          onPressed: () {},
                          child: Text(
                            'Play'
                          ),
                        )


                        //   onPressed: () {
                        //     SearchMusic.getArtistPage('UC13ToEQgfmTe8_GW19LYtCg').then((value) => {
                        //       if(mounted){
                        //         setState(() {
                        //           _artistsPage = value;
                        //           // print(artistsPageData.)
                        //         })
                        //       }
                        //
                        //     });
                        //   },
                        // ),
                      ),


                    ],


                  ),
                  stretchModes: const [
                    mat.StretchMode.zoomBackground,
                    mat.StretchMode.blurBackground,
                  ],
                  background: ShaderMask(
                    blendMode: BlendMode.luminosity,
                    shaderCallback: (bounds) {
                      return const LinearGradient(
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
                    child:  CachedNetworkImage(


                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => const Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/artist.jpg'),
                      ),
                      imageUrl: _artistsPage.thumbnails!.last.url.toString(),
                      placeholder: (context, url) => const Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/artist.jpg')),
                    ),
                  ),
                ),

                bottom: mat.TabBar(
                  indicatorWeight: 5,
                  indicatorSize: mat.TabBarIndicatorSize.label,
                  automaticIndicatorColorAdjustment: true,
                  isScrollable: true,
                  indicator: mat.UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 4.0,
                      color: context.watch<AppTheme>().color

                    )
                  ),



                  tabs: [
                    mat.Tab(text: 'Albums'),
                    mat.Tab(text: 'Songs'),
                    mat.Tab(text: 'Singles'),
                    mat.Tab(text: 'Videos'),
                    mat.Tab(text: 'Related'),


                  ],
                  controller: _tabController,
                ),
              ),

              // SliverPersistentHeader(delegate:
              // MySliverAppBar(expandedHeight: height/2.5),pinned: true,),



            ],
          ),

        Positioned.fill(
          top: 12,
          left: 10,
          child: Align(
            alignment: Alignment.topLeft,
            child: FloatingBackButton(onPressed: () {
              Navigator.of(context).pop();
            },)
          ),
        ),
      ],
    );


  }

  @override

  bool get wantKeepAlive => true;
}

// class MySliverAppBar extends SliverPersistentHeaderDelegate {
//   final double expandedHeight;
//
//   MySliverAppBar({required this.expandedHeight});
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     var size = MediaQuery.of(context).size;
//
//     return Stack(
//       fit: StackFit.expand,
//       overflow: Overflow.visible,
//       children: [
//         Opacity(
//           opacity: 1- shrinkOffset / expandedHeight,
//           child:  CachedNetworkImage(
//
//             fit: BoxFit.cover,
//             errorWidget: (context, url, error) => const Image(
//               fit: BoxFit.cover,
//               image: AssetImage('assets/artist.jpg'),
//             ),
//             imageUrl: _,
//             placeholder: (context, url) => const Image(
//                 fit: BoxFit.fill,
//                 image: AssetImage('assets/artist.jpg')),
//           ),
//         ),
//
//         Center(
//           child: Opacity(
//             opacity: shrinkOffset / expandedHeight,
//             child: Text(
//               "MySliverAppBar",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w700,
//                 fontSize: 23,
//               ),
//             ),
//           ),
//         ),
//
//       ],
//     );
//   }
//
//   @override
//   double get maxExtent => expandedHeight;
//
//   @override
//   double get minExtent => mat.kToolbarHeight;
//
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
// }
