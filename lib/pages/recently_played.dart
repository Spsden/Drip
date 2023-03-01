import 'package:drip/pages/common/track_cards.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:drip/datasources/searchresults/local_models/recently_played.dart'
    as recent_model;

import '../datasources/audiofiles/activeaudiodata.dart';
import '../datasources/audiofiles/playback.dart';
import '../theme.dart';
import 'moods_page.dart';

class RecentlyPlayed extends StatefulWidget {
  const RecentlyPlayed({Key? key}) : super(key: key);

  @override
  State<RecentlyPlayed> createState() => _RecentlyPlayedState();
}

class _RecentlyPlayedState extends State<RecentlyPlayed> {
  @override
  void dispose() {
    super.dispose();
    // Hive.box('recentlyPlayed').close();
  }

  @override
  void initState() {
    super.initState();

    // recentlyPlayed = Hive.box('recentlyPlayed').get('currentMusicInstance',defaultValue: )
  }

  @override
  Widget build(BuildContext context) {
    return fluent.ScaffoldPage(
      content: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Recently played from search',
                style: fluent.FluentTheme.of(context)
                    .typography
                    .titleLarge
                    ?.copyWith(fontSize: 30, fontWeight: FontWeight.w600)),
          ),
          const RecentlyPlayedWidget(),
          const MoodsAndCategories()
          //Expanded(child: MoodsAndCategories())
        ],
      ),
    );
  }
}

class RecentlyPlayedWidget extends ConsumerWidget {
  const RecentlyPlayedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child:

      ValueListenableBuilder(
        valueListenable: Hive.box('recentlyPlayed').listenable(),
        builder: (context, Box box, _) {
          List recent = List.from(box.values.toList().reversed);
          if (box.values.isEmpty) {
            return const Center(
              child: Text('No recent searches'),
            );
          }
          return GridView.builder(
            itemCount: recent.length,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 350.0,
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 8 / 2),
            itemBuilder: (context, index) {
              recent_model.RecentlyPlayed recentlyPlayed = recent[index];
              return Center(
                child: TrackCardSmall(
                  onTrackTap: () async{
                    CurrentMusicInstance currentMusicInstance =
                    CurrentMusicInstance(
                        title: recentlyPlayed.title,
                        author: recentlyPlayed.author,
                        thumbs: recentlyPlayed.thumbs,
                        urlOfVideo: 'NA',
                        videoId: recentlyPlayed.videoId);

                    ref
                        .read(audioControlCentreProvider)
                        .open(currentMusicInstance);

                  },
                  color: Colors.transparent,
                  data: TrackCardData(
                      title: recentlyPlayed.title,
                      duration: "NA",
                      album: 'NA',
                      artist: recentlyPlayed.author.join(", "),
                      thumbnail: recentlyPlayed.thumbs.first),
                ),

                //     ListTile(
                //
                //
                //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                //     onTap: () async {
                //       CurrentMusicInstance currentMusicInstance =
                //       CurrentMusicInstance(
                //           title: recentlyPlayed.title,
                //           author: recentlyPlayed.author
                //              ,
                //           thumbs: recentlyPlayed.thumbs
                //             ,
                //           urlOfVideo: 'NA',
                //           videoId: recentlyPlayed.videoId);
                //
                //       ref.read(audioControlCentreProvider).open(currentMusicInstance);
                //
                //     },
                //
                //     tileColor:
                //
                //     ref.watch(themeProvider).mode ==
                //         ThemeMode.dark ||
                //         ref.watch(themeProvider).mode ==
                //             ThemeMode.system
                //         ? Colors.grey[850]?.withOpacity(0.9)
                //         : Colors.grey[30]?.withOpacity(0.9),
                //
                //     leading:
                //
                //     ExtendedImage.network(
                //       recentlyPlayed.thumbs.first.toString(),
                //
                //       fit: BoxFit.cover,
                //       cache: false,
                //       shape: BoxShape.rectangle,
                //       borderRadius: BorderRadius.circular(5),
                //     ),
                //       title: Text(recentlyPlayed.title,maxLines: 1,overflow: TextOverflow.ellipsis,),
                //     subtitle: Text(recentlyPlayed.author.join(" "),maxLines: 1,overflow: TextOverflow.ellipsis,),
                // ),
              );
            },
          );
        },
      ),
    );
  }
}
