import 'package:cached_network_image/cached_network_image.dart';
import 'package:drip/datasources/searchresults/searchresultstwo.dart';
import 'package:drip/datasources/searchresults/songsdataclass.dart';
import 'package:drip/pages/search.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/src/provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../theme.dart';

class TrackList extends StatefulWidget {
  final String incomingSongQuery;

  const TrackList({Key? key, required this.incomingSongQuery})
      : super(key: key);

  @override
  _TrackListState createState() => _TrackListState();
}

class _TrackListState extends State<TrackList> {
  static List<Songs> songlist = [];

  //List<Songs> threesonglist = songs;
  static int page = 0;
  int numOfResultsLoad = 10;
  final ScrollController _sc = ScrollController();
  bool isLoading = false;
  bool fetched = false;
  bool status = false;
  String thisPageSearchQuery = '';
  final YoutubeExplode _youtubeExplode = YoutubeExplode();
  final FloatingSearchBarController _controller = FloatingSearchBarController();

  void songLoader(int page) {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    SearchMusic.getOnlySongs(
            thisPageSearchQuery == ''
                ? widget.incomingSongQuery
                : thisPageSearchQuery,
            numOfResultsLoad)
        .then((value) {
      if (mounted) {
        setState(() {
          songlist = value;
          fetched = true;
          isLoading = false;
          page++;
          numOfResultsLoad += 20;
        });
      }
    });
  }

  @override
  void initState() {
    _controller.query = widget.incomingSongQuery;
    songLoader(page);
    super.initState();

    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent && !isLoading) {
        songLoader(page);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!status) {
      status = true;
      numOfResultsLoad = 20;
      page = 0;
      songLoader(page);
      fetched = true;
    }
    return SearchFunction(
        liveSearch: false,
        controller: _controller,
        onSubmitted: (songQuery) async {
          setState(() {
            fetched = false;
            thisPageSearchQuery = songQuery;
            status = false;
            songlist = [];
          });
        },
        body: (!fetched)
            ? Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: context.watch<AppTheme>().color, size: 300),
              )
            : Placeholder());
  }
}

class TrackBars extends StatefulWidget {
  const TrackBars({Key? key}) : super(key: key);

  @override
  _TrackBarsState createState() => _TrackBarsState();
}

class _TrackBarsState extends State<TrackBars> {
  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(width: 10.0);
    const biggerSpacer = SizedBox(width: 40.0);
    return ScaffoldPage(
      header: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.grey[150],
          borderRadius: BorderRadius.circular(8),
          // boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                CachedNetworkImage(
                  width: 40,
                  height: 40,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.transparent,
                    radius: 100,
                    backgroundImage: imageProvider,
                  ),
                  fit: BoxFit.cover,
                  errorWidget: (context, _, __) => const Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/cover.jpg'),
                  ),
                  imageUrl:
                      'https://i0.wp.com/www.opindia.com/wp-content/uploads/2020/06/atif.jpg?fit=1200%2C871&ssl=1',
                  placeholder: (context, url) => const Image(
                      fit: BoxFit.cover, image: AssetImage('assets/cover.jpg')),
                ),
                biggerSpacer,

                SizedBox(
                  width: MediaQuery.of(context).size.width * 1 / 4,
                  child: Text(
                    'Kuch iss tarah teri palke meri palko se milade aasu tere sare ',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                spacer,
                SizedBox(
                  width:  MediaQuery.of(context).size.width * 1 / 8,
                  child: Text(
                    'Atif Aslam',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                spacer,
                SizedBox(
                  width:  MediaQuery.of(context).size.width * 1 / 8,
                  child: Text(
                    'Doorie by Jal',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width:  MediaQuery.of(context).size.width * 1 / 15,
                  child: Text(
                    '2:45',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                biggerSpacer,
                Icon(FluentIcons.play)
                // mat.IconButton(
                //     iconSize : 10,
                //     onPressed: () {}, icon: Icon(FluentIcons.play))
              ],
            ))),
      ),
    );
  }
}
