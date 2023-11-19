import 'package:extended_image/extended_image.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;

class TrackCardData {
  final String? thumbnail;
  final String? title;
  final String? artist;
  final String? album;
  final String? duration;

  TrackCardData({
    required this.title,
    required this.thumbnail,
    required this.artist,
    required this.album,
    required this.duration,
  });
}

class TrackCardLarge extends StatelessWidget {
  const TrackCardLarge({
    Key? key,
    //required this.listOfSongs,
    required this.data,
    required this.songIndex,
    required this.onTrackTap,
    required this.color,
    required this.SuperSize,
    this.widthy,
    required this.fromQueue,

    // required this.size
  }) : super(key: key);

  // final _TrackCardType _type;
  final int songIndex;
  final TrackCardData data;
  final Function() onTrackTap;
  final Color color;
  final Size SuperSize;
  final int? widthy;
  final bool fromQueue;

  //final List<TrackCardData> listOfSongs;
  //final Size size;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;

    var spacer = SizedBox(width: size / 80);
    //var biggerSpacer = SizedBox(width: size / 40);
    if (SuperSize.width > 700) {
      return mat.InkWell(
        customBorder: mat.RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        //  onHover: ,
        onTap: () async {
          onTrackTap();
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //mainAxisSize: MainAxisSize.min,
            children: [
              ExtendedImage.network(
                data.thumbnail.toString(),
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                cache: false,
                shape: BoxShape.circle,
              ),
              spacer,
              SizedBox(
                width: size * 1 / 6,
                child: Text(
                  data.title.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              spacer,
              SizedBox(
                width: size * 1 / 8,
                child: Text(
                  data.artist.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                // width: localSize * 1 / 15,
                child: Text(
                  data.duration.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return TrackCardSmall(
        color: color,
        data: data,
        onTrackTap: () {
          onTrackTap();
        },
      );
    }
  }
}

class TrackCardSmall extends StatelessWidget {
  const TrackCardSmall(
      {Key? key,
      required this.color,
      required this.data,
      required this.onTrackTap})
      : super(key: key);
  final Color color;
  final TrackCardData data;
  final Function() onTrackTap;

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size.width;

   /// var spacer = SizedBox(width: size / 80);
    return mat.ListTile(




      visualDensity: const mat.VisualDensity(vertical: -2),
      dense: true,
      tileColor:
          FluentTheme.of(context).resources.cardBackgroundFillColorDefault,
      onTap: () {
        onTrackTap();
      },

      //tileColor: ButtonState.resolveWith((states) => Colors.grey),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Text(data.title ?? 'NA',
          maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        data.artist ?? 'NA',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: ExtendedImage.network(
        data.thumbnail.toString(),
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        cache: false,
        shape: BoxShape.rectangle,
        enableMemoryCache: true,
        borderRadius: BorderRadius.circular(5),
      ),
    );

    //   mat.Material(
    //   borderRadius: mat.BorderRadius.circular(10),
    //   color: color,
    //   child: mat.InkWell(
    //     onTap: () {
    //       onTrackTap();
    //     },
    //     child: Padding(
    //       padding: const EdgeInsets.all(5),
    //       child: Column(
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: [
    //               FadeInImage(placeholder:
    //               const AssetImage('assets/cover.jpg'),
    //                   width: 37,
    //                   height: 37,
    //                   fit: BoxFit.cover,
    //
    //                   image:  NetworkImage(
    //
    //                     data.thumbnail.toString(),
    //                   )),
    //
    //               spacer,
    //               mat.Column(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: mat.CrossAxisAlignment.start,
    //                 children: [
    //                   SizedBox(
    //                   //  width: MediaQuery.of(context).size.width * 1 / 2.3,
    //                     child: Text(
    //                       data.title.toString(),
    //                       style: const TextStyle(
    //                           fontSize: 17, fontWeight: FontWeight.w400),
    //                       overflow: TextOverflow.ellipsis,
    //                     ),
    //                   ),
    //                   spacer,
    //                   SizedBox(
    //                    // width: MediaQuery.of(context).size.width * 1 / 2.5,
    //                     child: Text(
    //                       data.artist.toString(),
    //                       // widget.isFromPrimarySearchPage ? widget.songs[index].artists![0].name.toString() : 'Atif',
    //                       overflow: TextOverflow.ellipsis,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //               SizedBox(
    //                 // width: MediaQuery.of(context).size.width * 1 / 8,
    //                 child: Text(
    //                   data.duration.toString(),
    //                   // widget.isFromPrimarySearchPage ? widget.songs[index].artists![0].name.toString() : 'Atif',
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //               ),
    //               spacer,
    //               const Icon(FluentIcons.more)
    //             ],
    //           ),
    //
    //
    //         ],
    //
    //       ),
    //     ),
    //   ),
    // );
  }
}
