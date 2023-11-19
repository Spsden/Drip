import 'package:drip/pages/searchresultwidgets/top_results_widget.dart';
import 'package:drip/providers/providers.dart';

import 'package:flutter/material.dart' as mat;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drip/pages/recently_played.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../common/tracklist.dart';
import 'albumsresultwidget.dart';
import 'artistsresultwidget.dart';
import 'communityplaylistresultwidget.dart';

class SearchResultClass {
  final String title;
  final List<Item> items;

  SearchResultClass({
    required this.title,
    required this.items,
  });
}

class Item {
  final String? id;
  final String type;
  final String title;
  final List<String> images;
  final String image;
  final String subtitle;
  final String? subscribers;
  final String? artist;
  final String? album;
  final String? duration;
  final String? views;
  final String? year;

  Item({
    required this.id,
    required this.type,
    required this.title,
    required this.images,
    required this.image,
    required this.subtitle,
    this.subscribers,
    this.artist,
    this.album,
    this.duration,
    this.views,
    this.year,
  });
}

class StaggeredAnimationContainer extends StatelessWidget {
  final int index;
  final Widget child;

  const StaggeredAnimationContainer(
      {super.key, required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      child: SlideAnimation(
        horizontalOffset: 50.0,
        child: FadeInAnimation(
          child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: child),
        ),
      ),
    );
  }
}

class AllSearchResults2 extends ConsumerStatefulWidget {
  final GlobalKey? navigatorKey;

  const AllSearchResults2({this.navigatorKey, super.key});

  @override
  ConsumerState<AllSearchResults2> createState() => _AllSearchResults2State();
}

class _AllSearchResults2State extends ConsumerState<AllSearchResults2>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    const spacer = SizedBox(height: 10.0);
    //const biggerSpacer = SizedBox(height: 40.0);

    final String searchQuery = ref.watch(searchQueryProvider);
    Typography typography = FluentTheme.of(context).typography;
    final AsyncValue<List<Map<String, dynamic>>> searchResults =
        ref.watch(dripApiSearchResultsProvider);

    return mat.Scaffold(
        body: searchQuery.isEmpty
            ? const Center(
                child: RecentlyPlayed(),
              )
            : searchResults.when(
                data: (results) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: results.length,
                    itemBuilder: ((context, index) {
                      switch (results[index]['title']) {
                        case 'Top result':
                          var topData = results[index]['items'][0];
                          return TopResults(
                            topResult: TopResultType(
                                title: topData['title'],
                                thumbs: topData['images'].length == 1
                                    ? topData['images'][0]
                                    : topData['images'][1],
                                someId: topData['id'],
                            type: topData['type'],
                            description: topData['subtitle']),
                          );
                        case 'Songs':
                          return StaggeredAnimationContainer(
                            index: index,
                            child: SizedBox(
                                //  height: 400,
                                child: Column(children: [
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Songs & Videos",
                                      style: typography.subtitle
                                          ?.apply(fontSizeFactor: 1.0),
                                    ),
                                    FilledButton(
                                      child: const Row(
                                        children: [
                                          //Icon(FluentIcons.more),
                                          // spacer,
                                          Text('Show more',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            'songslistpage',
                                            arguments: searchQuery);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: TrackBars(
                                    songs: const [],
                                    localApi: true,
                                    dynamicData: results[index]['items'],
                                    isFromPrimarySearchPage: true,
                                  )),
                            ])),
                          );

                        case 'Videos':
                          // Handle Videos
                          return StaggeredAnimationContainer(
                            index: index,
                            child: SizedBox(
                                // height: 400,
                                child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: TrackBars(
                                      songs: const [],
                                      localApi: true,
                                      dynamicData: results[index]['items'],
                                      isFromPrimarySearchPage: true,
                                    ))),
                          );
                        case 'Artists':
                          return StaggeredAnimationContainer(
                            index: index,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Artists",
                                        style: typography.subtitle
                                            ?.apply(fontSizeFactor: 1.0),
                                      ),
                                      FilledButton(
                                        child: const Row(
                                          children: [
                                            //Icon(FluentIcons.more),
                                            // spacer,
                                            Text('Show more',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            mat.MaterialPageRoute(
                                              builder: (context) =>
                                                  ArtistsSearchResults(
                                                      artistQuery: searchQuery),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                spacer,
                                ArtistsSearch(
                                    artists: const [],
                                    localApi: true,
                                    dynamicData: results[index]['items']),
                              ],
                            ),
                          );

                        case 'Featured playlists':
                          return StaggeredAnimationContainer(
                            index: index,
                            child: Column(children: [
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Featured playlists",
                                      style: typography.subtitle
                                          ?.apply(fontSizeFactor: 1.0),
                                    ),
                                    FilledButton(
                                      child: const Row(
                                        children: [
                                          //Icon(FluentIcons.more),
                                          // spacer,
                                          Text('Show more',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          mat.MaterialPageRoute(
                                            builder: (context) =>
                                                PlaylistInfinitePaginationWidget(
                                              communityPlaylistQuery:
                                                  searchQuery,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              spacer,
                              CommunityPlaylistSearch(
                                communityPlaylist: const [],
                                localApi: true,
                                dynamicData: results[index]['items'],
                              ),
                            ]),
                          );
                        case 'Community playlists':
                          return StaggeredAnimationContainer(
                            index: index,
                            child: Column(children: [
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Community playlists",
                                      style: typography.subtitle
                                          ?.apply(fontSizeFactor: 1.0),
                                    ),
                                    FilledButton(
                                      child: const Row(
                                        children: [
                                          //Icon(FluentIcons.more),
                                          // spacer,
                                          Text('Show more',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          mat.MaterialPageRoute(
                                            builder: (context) =>
                                                PlaylistInfinitePaginationWidget(
                                              communityPlaylistQuery:
                                                  searchQuery,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              spacer,
                              CommunityPlaylistSearch(
                                communityPlaylist: const [],
                                localApi: true,
                                dynamicData: results[index]['items'],
                              ),
                            ]),
                          );
                        case 'Albums':
                          return StaggeredAnimationContainer(
                            index: index,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Albums",
                                        style: typography.subtitle
                                            ?.apply(fontSizeFactor: 1.0),
                                      ),
                                      FilledButton(
                                        child: const Row(
                                          children: [
                                            //Icon(FluentIcons.more),
                                            // spacer,
                                            Text('Show more',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ],
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                                spacer,
                                AlbumSearch(
                                  albums: const [],
                                  localApi: true,
                                  dynamicData: results[index]['items'],
                                ),
                              ],
                            ),
                          );

                        // case 'Podcasts':
                        //   // Handle Podcasts
                        //   print('Selected Podcasts');
                        //   break;
                        // case 'Profiles':
                        //   // Handle Profiles
                        //   print('Selected Profiles');
                        //   break;
                        // case 'Episodes':
                        //   // Handle Episodes
                        //   print('Selected Episodes');
                        default:
                          // Handle case where x doesn't match any of the options
                          return const SizedBox.shrink();
                      }
                    }),
                  );
                },
                error: (err, _) => Text(err.toString()),
                loading: () => const ProgressRing()));
  }

  @override
  bool get wantKeepAlive => true;
}
