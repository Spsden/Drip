import 'package:cached_network_image/cached_network_image.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:drip/datasources/audiofiles/audiocontrolcentre.dart';
import 'package:drip/datasources/audiofiles/audiodata.dart';
import 'package:drip/datasources/searchresults/searchresultstwo.dart';
import 'package:drip/datasources/searchresults/songsdataclass.dart';
import 'package:drip/datasources/searchresults/watchplaylistdataclass.dart';
import 'package:drip/pages/search.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/src/provider.dart';

import '../../theme.dart';

class TrackBars extends StatefulWidget {
  final bool isFromPrimarySearchPage;
  final List<Songs> songs;
  final VoidCallback? onScroll;
  final bool? isLoading;


  const TrackBars(
      {Key? key,
      required this.isFromPrimarySearchPage,
      required this.songs,
      this.onScroll,
      this.isLoading})
      : super(key: key);

  @override
  _TrackBarsState createState() => _TrackBarsState();
}

class _TrackBarsState extends State<TrackBars> {
  //_TrackListState().
  final ScrollController _sc = ScrollController();

  late WatchPlaylists watchPlaylists;

  void printing() async{
    watchPlaylists.tracks?.forEach((track){
      print(track.title.toString());
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //bool loading = _TrackListState().isLoading;
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        widget.onScroll;
        print('scrollslol');
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _sc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(width: 10.0);
    const biggerSpacer = SizedBox(width: 40.0);
    return Container(
      alignment: Alignment.centerLeft,
      //padding: EdgeInsets.only(top: 20),
      // margin: const EdgeInsets.symmetric(vertical: 20.0),
      // height: 250,
      child: ListView.builder(
          itemCount: widget.isFromPrimarySearchPage
              ? widget.songs.length
              : widget.songs.length + 1,
          shrinkWrap: true,
          controller: _sc,
          itemBuilder: (context, index) {
            if (index == widget.songs.length) {
              return Container(
                  alignment: Alignment.center,
                  width: 500,
                  height: 500,
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: context.watch<AppTheme>().color, size: 100));
            } else {
              return HoverButton(
                cursor: SystemMouseCursors.copy,
                // splashColor: Colors.grey[130],
                // customBorder: mat.ShapeBorder(),
                //hoverColor: Colors.grey[130],
                onPressed: () async {
                  var audioUrl =
                  await AudioControlClass.getAudioUri(widget.songs[index].videoId);
                  print(audioUrl.toString());

                  playerAlerts.buffering = true;
                  await context.read<ActiveAudioData>().songDetails(
                      audioUrl,
                      widget.songs[index].videoId,
                      widget.songs[index].artists![0].name,
                      widget.songs[index].title,
                      widget.songs[index].thumbnails[0].url);

                  currentMediaIndex = 0;



                  await AudioControlClass.play(audioUrl: audioUrl, videoId: widget.songs[index].videoId.toString(), context: context);



                },
                builder: (BuildContext, states) {
                  return AnimatedContainer(
                    margin:
                        const EdgeInsets.only(left: 10, right: 20, bottom: 15),
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ButtonThemeData.buttonColor(Brightness.dark, states
                          // FluentTheme.of(context),
                          // states,

                          ),
                    ),
                    duration: FluentTheme.of(context).fastAnimationDuration,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CachedNetworkImage(
                              width: 40,
                              height: 40,
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
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
                              imageUrl: widget.songs[index].thumbnails.first.url
                                  .toString(),

                              // widget.isFromPrimarySearchPage ? widget.songs[index].thumbnails.first.url.toString() : 'https://loveshayariimages.in/wp-content/uploads/2020/09/Sad-Alone-Boy-Images-104.jpg',
                              placeholder: (context, url) => const Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/cover.jpg')),
                            ),
                            spacer,

                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1 / 4,
                              child: Text(
                                widget.songs[index].title.toString(),
                                // widget.isFromPrimarySearchPage ? widget.songs[index].title.toString() : 'Kuch is tarah',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            spacer,
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1 / 8,
                              child: Text(
                                widget.songs[index].artists![0].name.toString(),
                                // widget.isFromPrimarySearchPage ? widget.songs[index].artists![0].name.toString() : 'Atif',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            spacer,
                            if( MediaQuery.of(context).size.width > 500)
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1 / 8,
                              child: Text(
                                widget.songs[index].album!.name.toString(),
                                //  widget.isFromPrimarySearchPage ? widget.songs[index].album!.name.toString() : 'The jal band',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1 / 15,
                              child: Text(
                                widget.songs[index].duration.toString(),
                                //widget.isFromPrimarySearchPage ? widget.songs[index].duration.toString() : '5:25',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            biggerSpacer,
                            Icon(FluentIcons.play)
                            // mat.IconButton(
                            //     iconSize : 10,
                            //     onPressed: () {}, icon: Icon(FluentIcons.play))
                          ],
                        )),
                  );
                },
              );
            }
          }),
    );
  }
}

class TrackList extends StatefulWidget {
  final String songQuery;

  const TrackList({Key? key, required this.songQuery}) : super(key: key);

  @override
  _TrackListState createState() => _TrackListState();
}

class _TrackListState extends State<TrackList> {
  String query = '';
  static const _pageSize = 20;

  FloatingSearchBarController _controller = FloatingSearchBarController();

  final _pagingController = PagingController<int, Songs>(
    // 2
    firstPageKey: 1,
  );

  @override
  void initState() {
    // 3
    _pagingController.addPageRequestListener((pageKey) {
      fetchSongs(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    // 4
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> fetchSongs(int pageKey) async {
    try {
      final List<Songs> newItems = await SearchMusic.getOnlySongs(
        query == '' ? widget.songQuery : query,
          _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SearchFunction(
        liveSearch: false,
        controller: _controller,
        onSubmitted: (searchQuery) async {

            query = searchQuery;


          _pagingController.refresh();
          // setState(() {
          //
          // });
        },
        body: Center(
          child: mat.RefreshIndicator(
            onRefresh: () => Future.sync(
              () => _pagingController.refresh(),
            ),
            child: PagedListView.separated(
              pagingController: _pagingController,
              padding: const EdgeInsets.all(10),
              separatorBuilder: (context, index) => SizedBox(
                height: 0,
              ),
              builderDelegate: PagedChildBuilderDelegate<Songs>(
                animateTransitions: true,
                transitionDuration: const Duration(milliseconds: 200),
                firstPageProgressIndicatorBuilder: (_) => Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: context.watch<AppTheme>().color, size: 300),
                ),
                newPageProgressIndicatorBuilder: (_) => Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                      color: context.watch<AppTheme>().color, size: 100),
                ),
                itemBuilder: (context, songs, index) => TrackListItem(
                  songs: songs,
                ),
                // firstPageErrorIndicatorBuilder: (context) =>
              ),
            ),
          ),
        ));
  }
}

class TrackListItem extends StatefulWidget {
  final Songs songs;

  const TrackListItem({Key? key, required this.songs}) : super(key: key);

  @override
  _TrackListItemState createState() => _TrackListItemState();
}

class _TrackListItemState extends State<TrackListItem> {
  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(width: 10.0);
    const biggerSpacer = SizedBox(width: 40.0);
    return HoverButton(
      cursor: SystemMouseCursors.copy,
      // splashColor: Colors.grey[130],
      // customBorder: mat.ShapeBorder(),
      //hoverColor: Colors.grey[130],
      onPressed: () async {
        var audioUrl =
            await AudioControlClass.getAudioUri(widget.songs.videoId);
        print(audioUrl.toString());

        playerAlerts.buffering = true;
        await context.read<ActiveAudioData>().songDetails(
            audioUrl,
            widget.songs.videoId,
            widget.songs.artists![0].name,
            widget.songs.title,
            widget.songs.thumbnails[0].url);

        await AudioControlClass.play(audioUrl: audioUrl, videoId: widget.songs.videoId.toString(), context: context);
      },
      builder: (BuildContext, states) {
        return AnimatedContainer(
          margin: const EdgeInsets.only(left: 10, right: 20, bottom: 15),
          padding: const EdgeInsets.only(top: 5, bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ButtonThemeData.buttonColor(Brightness.dark, states
                // FluentTheme.of(context),
                // states,

                ),
          ),
          duration: FluentTheme.of(context).fastAnimationDuration,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
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
                    imageUrl: widget.songs.thumbnails.first.url.toString(),

                    // widget.isFromPrimarySearchPage ? widget.songs[index].thumbnails.first.url.toString() : 'https://loveshayariimages.in/wp-content/uploads/2020/09/Sad-Alone-Boy-Images-104.jpg',
                    placeholder: (context, url) => const Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/cover.jpg')),
                  ),
                  spacer,

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1 / 4,
                    child: Text(
                      widget.songs.title.toString(),
                      // widget.isFromPrimarySearchPage ? widget.songs[index].title.toString() : 'Kuch is tarah',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  spacer,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1 / 8,
                    child: Text(
                      widget.songs.artists![0].name.toString(),
                      // widget.isFromPrimarySearchPage ? widget.songs[index].artists![0].name.toString() : 'Atif',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  spacer,
                  if( MediaQuery.of(context).size.width > 500)
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1 / 8,
                    child: Text(
                      widget.songs.album!.name.toString(),
                      //  widget.isFromPrimarySearchPage ? widget.songs[index].album!.name.toString() : 'The jal band',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1 / 15,
                    child: Text(
                      widget.songs.duration.toString(),
                      //widget.isFromPrimarySearchPage ? widget.songs[index].duration.toString() : '5:25',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  biggerSpacer,
                  const Icon(FluentIcons.play)
                  // mat.IconButton(
                  //     iconSize : 10,
                  //     onPressed: () {}, icon: Icon(FluentIcons.play))
                ],
              )),
        );
      },
    );
  }
}
