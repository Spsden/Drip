import 'package:drip/datasources/audiofiles/activeaudiodata.dart';
import 'package:drip/datasources/searchresults/models/songsdataclass.dart';
import 'package:drip/datasources/searchresults/models/watchplaylistdataclass.dart';
import 'package:drip/pages/common/loading_widget.dart';
import 'package:drip/pages/common/track_cards.dart';
import 'package:drip/providers/providers.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../providers/audio_player_provider.dart';
import '../../theme.dart';

///Trackbars for main Search Page

class TrackBars extends ConsumerStatefulWidget {
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

class _TrackBarsState extends ConsumerState<TrackBars> {

  final ScrollController _sc = ScrollController();

  late WatchPlaylists watchPlaylists;

  // void printing() async {
  //   watchPlaylists.tracks?.forEach((track) {
  //     print(track.title.toString());
  //   });
  // }

  @override
  void initState() {

    super.initState();

;
  }

  @override
  void dispose() {

    super.dispose();

    _sc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Hive.openBox('recentlyPlayed');
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
                  child:
                      loadingWidget(context, ref.watch(themeProvider).color));
            } else {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: TrackCardLarge(
                  data: TrackCardData(
                      title: widget.songs[index].title.toString(),
                      artist: widget.songs[index].artists!.isEmpty
                          ? noneAlbum.first.name
                          : widget.songs[index].artists!.first.name,
                      album: 'Drip',
                      duration: widget.songs[index].duration.toString(),
                      thumbnail:
                          widget.songs[index].thumbnails[0].url.toString()),
                  songIndex: index,
                  onTrackTap: () async {
                    CurrentMusicInstance currentMusicInstance =
                        CurrentMusicInstance(
                            title: widget.songs[index].title.toString(),
                            author: widget.songs[index].artists
                                    ?.map((e) => e.name.toString())
                                    .toList() ??
                                [],
                            thumbs: widget.songs[index].thumbnails
                                    ?.map((e) => e.url.toString())
                                    .toList() ??
                                [],
                            urlOfVideo: 'NA',
                            videoId: widget.songs[index].videoId);

                    ref.read(audioPlayerProvider).open(currentMusicInstance);


                  },
                  color: index % 2 != 0
                      ? Colors.transparent
                      : ref.watch(themeProvider).mode == ThemeMode.dark ||
                              ref.watch(themeProvider).mode == ThemeMode.system
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

class TrackList extends ConsumerStatefulWidget {
  final String songQuery;

  const TrackList({Key? key, required this.songQuery}) : super(key: key);

  @override
  _TrackListState createState() => _TrackListState();
}

class _TrackListState extends ConsumerState<TrackList> {


  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: ListView.custom(
        physics: const BouncingScrollPhysics(),
        childrenDelegate:
        SliverChildBuilderDelegate((context,index) {
          const pageLimit = 20;

          final page = index ~/ pageLimit + 1;
          final itemIndexInPage = index % pageLimit;

          final results = ref.watch(songsListResultsProvider(page));
          return results.when(
              data: (results) {
                if (itemIndexInPage >= results.length) {


                  return null;
                }

                final result = results[itemIndexInPage];
                return Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: TrackListItem(songs: result, color: itemIndexInPage % 2 != 0 ?Colors.transparent
                      : ref.watch(themeProvider).mode ==
                      ThemeMode.dark ||
                      ref.watch(themeProvider).mode ==
                          ThemeMode.system
                      ? Colors.grey[150]
                      : Colors.grey[40],),
                );
              },
            error: (err, stack) => Text('error $err'),
            loading: () => loadingWidget(context, ref.watch(themeProvider).color));
        }),
      ),
    );
  }
}

class TrackListItem extends ConsumerStatefulWidget {
  final Songs songs;
  final Color color;

  const TrackListItem({Key? key, required this.songs, required this.color})
      : super(key: key);

  @override
  _TrackListItemState createState() => _TrackListItemState();
}

class _TrackListItemState extends ConsumerState<TrackListItem> {
  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(width: 10.0);
    const biggerSpacer = SizedBox(width: 40.0);
    return mat.Material(
      borderRadius: mat.BorderRadius.circular(10),
      color: widget.color,

      child: mat.InkWell(
        onTap: () async {

          CurrentMusicInstance currentMusicInstance = CurrentMusicInstance(title:widget.songs.title
              , author: widget.songs.artists?.map((e) => e.name.toString()).toList() ?? [],
              thumbs:   widget.songs.thumbnails?.map((e) => e.url.toString()).toList() ??
                  [], urlOfVideo: 'NA', videoId: widget.songs.videoId);
         await  ref.read(audioPlayerProvider).open(currentMusicInstance);




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

              spacer,

              SizedBox(
                width: MediaQuery.of(context).size.width * 1 / 4,
                child: Text(
                  widget.songs.title.toString(),

                  overflow: TextOverflow.ellipsis,
                ),
              ),
              spacer,
              SizedBox(
                width: MediaQuery.of(context).size.width * 1 / 8,
                child: Text(
                  widget.songs.artists![0].name.toString(),

                  overflow: TextOverflow.ellipsis,
                ),
              ),
              spacer,
              if (MediaQuery.of(context).size.width > 500)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1 / 8,
                  child: Text(
                    widget.songs.album!.name.toString(),

                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 1 / 15,
                child: Text(
                  widget.songs.duration.toString(),

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
