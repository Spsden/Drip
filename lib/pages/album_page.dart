import 'package:drip/datasources/searchresults/models/albumdataclass.dart';
import 'package:drip/datasources/searchresults/requests/searchresultsservice.dart';
import 'package:drip/pages/common/track_cards.dart';
import 'package:drip/pages/searchresultwidgets/search_page_drip.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasources/audiofiles/activeaudiodata.dart';
import '../providers/audio_player_provider.dart';
import '../theme.dart';

class AlbumPage extends ConsumerStatefulWidget {
  const AlbumPage({super.key, required this.albumId});

  final String albumId;

  @override
  ConsumerState<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends ConsumerState<AlbumPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final Future<AlbumDataClass?> res = SearchMusic.getAlbum(widget.albumId);
    Typography typography = FluentTheme.of(context).typography;
    const spacer = SizedBox(width: 10.0);
    const biggerSpacer = SizedBox(width: 40.0);
    var size = MediaQuery.of(context).size;

    return FutureBuilder<AlbumDataClass?>(
      future: res,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.hasData) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  mat.SliverAppBar(
                    expandedHeight: size.width > 500
                        ? size.height * 0.27
                        : size.height * 0.23,
                    stretch: true,
                    flexibleSpace: mat.FlexibleSpaceBar(
                      background: Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(08),
                            color: ref.watch(themeProvider).mode ==
                                        ThemeMode.dark ||
                                    ref.watch(themeProvider).mode ==
                                        ThemeMode.system
                                ? Colors.grey[150].withOpacity(0.6)
                                : Colors.grey[30].withOpacity(0.9)),
                        width: size.width * 0.9,
                        height: size.width > 500
                            ? size.height * 0.27
                            : size.height * 0.23,
                        child: LayoutBuilder(
                          builder: (context, constraints) => Row(
                            //  mainAxisSize: MainAxisSize.min,
                            children: [
                              ExtendedImage.network(
                                snapshot.data?.output?.thumbnails?.last.url ??
                                    "assets/ytCover.png",
                                width: size.width > 500
                                    ? size.height / 4.4
                                    : constraints.maxWidth / 2.8,
                                height: size.width > 500
                                    ? size.height / 4.4
                                    : constraints.maxWidth / 2.8,
                                fit: BoxFit.cover,
                                cache: false,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              spacer,
                              Column(
                                crossAxisAlignment:
                                    mat.CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          snapshot.data?.output?.title ?? "NA",
                                          softWrap: true,
                                          style: typography.titleLarge,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  spacer,
                                  SizedBox(
                                    width: constraints.maxWidth / 1.4,
                                    child: Text(
                                      snapshot.data?.output?.description ??
                                          "NA",
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  const mat.Spacer(),
                                  FilledButton(
                                    child: const Row(
                                      children: [
                                        Icon(FluentIcons.play),
                                        spacer,
                                        Text('Shuffle',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500)),
                                      ],
                                    ),
                                    onPressed: () async {
                                      // AudioControlClass.shuffle(_tracks);

                                      print("pressed here");
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ), // Method to create the top Container
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        List<Tracks> tracks =
                            snapshot.data?.output?.tracks ?? [];
                        return TrackCardLarge(
                            data: TrackCardData(
                                title: tracks[index].title,
                                album: tracks[index].album,
                                artist: tracks[index]
                                    .artists
                                    ?.map((e) => e.name)
                                    .join(" "),
                                duration: tracks[index].duration,
                                thumbnail: null),
                            songIndex: index,
                            onTrackTap: () {
                             // print(tracks[index]);

                              CurrentMusicInstance currentMusicInstance =
                              CurrentMusicInstance(
                                  title: tracks[index].title  ?? "NA" ,
                                  author: tracks[index]
                                      .artists
                                      ?.map((e) => e.name.toString()).toList() ?? [],
                                  thumbs: [],
                                  urlOfVideo: 'NA',
                                  videoId: tracks[index].videoId.toString());

                              ref.read(audioPlayerProvider).open(currentMusicInstance);
                            },
                            color: index % 2 != 0
                                ? Colors.transparent
                                : ref.watch(themeProvider).mode ==
                                            ThemeMode.dark ||
                                        ref.watch(themeProvider).mode ==
                                            ThemeMode.system
                                    ? Colors.grey[150]
                                    : Colors.grey[30],
                            SuperSize: size,
                            fromQueue: false);
                      },
                      childCount: snapshot.data?.output?.tracks?.length,
                    ),
                  ),
                ],
              );

            } else {
              return Placeholder();
            }
          }
        }
      }),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
