import 'package:fluent_ui/fluent_ui.dart';

import 'package:provider/provider.dart';

import '../../datasources/audiofiles/activeaudiodata.dart';
import '../../datasources/audiofiles/audiocontrolcentre.dart';
import '../../datasources/searchresults/artistsdataclass.dart';
import '../../theme.dart';
import '../common/track_cards.dart';
import 'artistsresultwidget.dart';

class TopResultsWidget extends StatelessWidget {
  const TopResultsWidget({Key? key, this.topResult}) : super(key: key);
  final dynamic topResult;

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    const spacer = SizedBox(height: 10.0);
    const biggerSpacer = SizedBox(height: 40.0);
    final Widget topResultWidget ;

    switch(topResult.resultType.toString()) {
      case 'video':
        topResultWidget =   Container(
          margin: const EdgeInsets.only(
              left: 20, right: 20),
          child: TrackCardLarge(data: TrackCardData(
              duration: topResult.duration,
              album: '',
              title: topResult.title,
              artist: '${topResult.artists.first
                  .name}',
              thumbnail: topResult.thumbnails.first
                  .url.toString()
          ),
              songIndex: 0,
              onTrackTap: () async {
                var audioUrl =
                await AudioControlClass.getAudioUri(
                    topResult.videoId.toString());
                // print(audioUrl.toString());

                playerAlerts.buffering = true;
                await context
                    .read<ActiveAudioData>()
                    .songDetails(
                    audioUrl,
                    topResult.videoId.toString(),
                    topResult.artists[0].name,
                    topResult.title.toString(),
                    topResult
                        .thumbnails[0]
                        .url
                        .toString(),
                  //  topResult.thumbnails.map((e) => ThumbnailLocal(height: e.height, url: e.url.toString(), width: e.width)).toList(),
                    topResult.thumbnails.last.url.toString()



                );
                currentMediaIndex = 0;

                await AudioControlClass.play(
                    audioUrl: audioUrl,
                    videoId:
                    topResult.videoId.toString(),
                    context: context);
              },
              color: context
                  .watch<AppTheme>()
                  .mode == ThemeMode.dark ||
                  context
                      .watch<AppTheme>()
                      .mode ==
                      ThemeMode.system
                  ? Colors.grey[150]
                  : Colors.grey[30]
              ,
              SuperSize: MediaQuery
                  .of(context)
                  .size,
              fromQueue: false),
        );
        break;

      case 'artist':
        return ArtistCard(artists: Artists(
            artist: topResult.artist,
            browseId: topResult.browseId,
            radioId: topResult.radioId,
            category: topResult.category,
            resultType: topResult.resultType,
            shuffleId: topResult.shuffleId,
            thumbnails: topResult.thumbnails
        )
        );
        break;

      default :
        return const Text('lol');
        break;


    }

    return SizedBox(

    //  height: 260,
      //color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Top Results",
            style: typography.subtitle
                ?.apply(fontSizeFactor: 1.0),
          ),

        ],
      ),
          spacer,
          topResultWidget














        ]
    ));
  }
}

