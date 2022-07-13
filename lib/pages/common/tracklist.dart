import 'package:drip/datasources/audiofiles/audiocontrolcentre.dart';
import 'package:drip/datasources/audiofiles/activeaudiodata.dart';
import 'package:drip/datasources/searchresults/searchresultsservice.dart';
import 'package:drip/datasources/searchresults/songsdataclass.dart';
import 'package:drip/datasources/searchresults/watchplaylistdataclass.dart';
import 'package:drip/pages/common/loading_widget.dart';
import 'package:drip/pages/common/track_cards.dart';
import 'package:drip/pages/search.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/src/provider.dart';

import '../../theme.dart';

///Trackbars for main Search Page

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

  void printing() async {
    watchPlaylists.tracks?.forEach((track) {
      print(track.title.toString());
    });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //bool loading = _TrackListState().isLoading;
    // _sc.addListener(() {
    //   if (_sc.position.pixels == _sc.position.maxScrollExtent) {
    //     widget.onScroll;
    //     print('scrollslol');
    //   }
    // });
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
                  child: loadingWidget(context));
            } else {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: TrackCardLarge(
                  data: TrackCardData(
                      title: widget.songs[index].title.toString(),
                      artist: widget.songs[index].artists![0].name.toString(),
                      album: 'Drip',
                      duration: widget.songs[index].duration.toString(),
                      thumbnail:
                          widget.songs[index].thumbnails[0].url.toString()),
                  songIndex: index,
                  onTrackTap: () async {



                      //playerAlerts.buffering = true;
                      await context.read<ActiveAudioData>().songDetails(
                          widget.songs[index].videoId.toString(),
                        widget.songs[index].videoId.toString(),
                        widget.songs[index].artists![0].name.toString(),
                        widget.songs[index].title.toString(),
                        widget.songs[index].thumbnails[0].url.toString(),
                        // widget.songs[index].thumbnails.map((e) => ThumbnailLocal(height: e.height, url: e.url.toString(), width: e.width)).toList(),
                        widget.songs[index].thumbnails.last.url.toString(),
                      );
                      currentMediaIndex = 0;
                      //
                      await AudioControlClass.play(

                          videoId: widget.songs[index].videoId.toString(),
                          context: context,
                      );


                  },
                  color: index % 2 != 0
                      ? Colors.transparent
                      : context.watch<AppTheme>().mode == ThemeMode.dark ||
                              context.watch<AppTheme>().mode == ThemeMode.system
                          ? Colors.grey[150]
                          : Colors.grey[30],
                  SuperSize: MediaQuery.of(context).size,
                  widthy: 800,
                  fromQueue: true,
                ),
              );
            }
          }),
    );
  }
}

//Track list for infinite Pagination with search

class TrackList extends StatefulWidget {
  final String songQuery;

  const TrackList({Key? key, required this.songQuery}) : super(key: key);

  @override
  _TrackListState createState() => _TrackListState();
}

class _TrackListState extends State<TrackList> {
  String query = '';
  static const _pageSize = 20;

  final FloatingSearchBarController _controller = FloatingSearchBarController();

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
          query == '' ? widget.songQuery : query, _pageSize);
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
    Typography typography = FluentTheme.of(context).typography;
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomScrollView(
                scrollBehavior: const FluentScrollBehavior(),
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 50)),
                  SliverToBoxAdapter(
                      child: Text(
                    query,

                    // widget.songQuery == ''
                    //   ? '  Results for \"${query}\"'
                    //   : '  Results for \"${widget.songQuery}\"',
                    style: typography.display?.apply(fontSizeFactor: 1.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 15,
                    ),
                  ),
                  AnimationLimiter(
                    child: PagedSliverList.separated(
                      //physics: BouncingScrollPhysics(),

                      pagingController: _pagingController,
                      // padding: const EdgeInsets.all(10),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      builderDelegate: PagedChildBuilderDelegate<Songs>(
                        animateTransitions: true,
                        transitionDuration: const Duration(milliseconds: 200),
                        firstPageProgressIndicatorBuilder: (_) => Center(
                          child: loadingWidget(context),
                        ),
                        newPageProgressIndicatorBuilder: (_) =>
                            Center(child: loadingWidget(context)),
                        itemBuilder: (context, songs, index) =>
                            AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 370),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: TrackListItem(
                                songs: songs,
                                color: index % 2 != 0
                                    ? Colors.transparent
                                    : context.watch<AppTheme>().mode ==
                                                ThemeMode.dark ||
                                            context.watch<AppTheme>().mode ==
                                                ThemeMode.system
                                        ? Colors.grey[150]
                                        : Colors.grey[40],
                              ),
                            ),
                          ),
                        ),
                        // firstPageErrorIndicatorBuilder: (context) =>
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class TrackListItem extends StatefulWidget {
  final Songs songs;
  final Color color;

  const TrackListItem({Key? key, required this.songs, required this.color})
      : super(key: key);

  @override
  _TrackListItemState createState() => _TrackListItemState();
}

class _TrackListItemState extends State<TrackListItem> {
  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(width: 10.0);
    const biggerSpacer = SizedBox(width: 40.0);
    return mat.Material(
      borderRadius: mat.BorderRadius.circular(10),
      color: widget.color,
      child: mat.InkWell(
        onTap: () async {


          //playerAlerts.buffering = true;
          await context.read<ActiveAudioData>().songDetails(
              widget.songs.videoId,
              widget.songs.videoId,
              widget.songs.artists![0].name,
              widget.songs.title,
              widget.songs.thumbnails[0].url,
              //widget.songs.thumbnails.map((e) => ThumbnailLocal(height: e.height, url: e.url.toString(), width: e.width)).toList(),
              widget.songs.thumbnails.last.url.toString());

          await AudioControlClass.play(

              videoId: widget.songs.videoId.toString(),
              context: context, );

        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FadeInImage(
                  placeholder: const AssetImage('assets/cover.jpg'),
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.songs.thumbnails.first.url.toString(),
                  )),
              // CachedNetworkImage(
              //   memCacheHeight: 40,
              //   memCacheWidth: 40,
              //   width: 40,
              //   height: 40,
              //   imageBuilder: (context, imageProvider) => CircleAvatar(
              //     backgroundColor: Colors.transparent,
              //     foregroundColor: Colors.transparent,
              //     radius: 100,
              //     backgroundImage: imageProvider,
              //   ),
              //   fit: BoxFit.cover,
              //   errorWidget: (context, _, __) => const Image(
              //     fit: BoxFit.cover,
              //     image: AssetImage('assets/cover.jpg'),
              //   ),
              //   imageUrl: widget.songs.thumbnails.first.url.toString(),
              //   placeholder: (context, url) => const Image(
              //       fit: BoxFit.cover,
              //       image: AssetImage('assets/cover.jpg')),
              // ),
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
              if (MediaQuery.of(context).size.width > 500)
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
              const Icon(FluentIcons.more_vertical)
              // mat.IconButton(
              //     iconSize : 10,
              //     onPressed: () {}, icon: Icon(FluentIcons.play))
            ],
          ),
        ),
      ),
    );
  }
}
