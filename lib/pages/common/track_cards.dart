import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;

class TrackCardData {
  final String thumbnail;
  final String title;
  final String artist;
  final String album;
  final String duration;


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
    required this.SuperSize
    ,
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

    var spacer = SizedBox(width: size/80);
    var  biggerSpacer = SizedBox(width: size/40);
    if (SuperSize.width > 700) {
      return mat.Material(
        borderRadius: mat.BorderRadius.circular(10),
        color: color,
        child: mat.InkWell(
          customBorder: mat.RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
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
                CachedNetworkImage(

                  memCacheHeight: 40,
                  memCacheWidth: 40,
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
                  errorWidget: (context, _, __) =>
                  const Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/cover.jpg'),
                  ),
                  imageUrl: data.thumbnail,


                  placeholder: (context, url) =>
                  const Image(
                      fit: BoxFit.cover, image: AssetImage('assets/cover.jpg')),
                ),
                spacer,
                SizedBox(
                  width: size * 1 / 6,
                  child: Text(
                    data.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                spacer,
                SizedBox(
                  width: size * 1 / 8,
                  child: Text(
                    data.artist,

                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // spacer,
                // if (localSize > 300)
                //   SizedBox(
                //     width: localSize * 1 / 8,
                //     child: Text(
                //       data.album,
                //       overflow: TextOverflow.ellipsis,
                //     ),
                //   ),
                SizedBox(
                  // width: localSize * 1 / 15,
                  child: Text(
                    data.duration,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                biggerSpacer,
                const Icon(FluentIcons.more)
              ],
            ),
          ),
        ),
      );
    } else {
      return TrackCardSmall(color: color,data: data, onTrackTap: () { onTrackTap(); },);

    }
  }
}

class TrackCardSmall extends StatelessWidget {
  const TrackCardSmall({Key? key, required this.color, required this.data, required this.onTrackTap}) : super(key: key);
  final Color color;
  final TrackCardData data;
  final Function() onTrackTap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;

    var spacer = SizedBox(width: size/80);
    return  mat.Material(
      borderRadius: mat.BorderRadius.circular(10),
      color: color,
      child: mat.InkWell(
        onTap: () {
          onTrackTap();
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FadeInImage(placeholder:
                  const AssetImage('assets/cover.jpg'),
                      width: 37,
                      height: 37,
                      fit: BoxFit.cover,

                      image:  NetworkImage(
                        data.thumbnail,
                      )),
                  // CachedNetworkImage(
                  //   memCacheWidth: 40,
                  //   memCacheHeight: 40,
                  //   width: 50,
                  //   height: 50,
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
                  //   imageUrl: data.thumbnail,
                  //   placeholder: (context, url) => const Image(
                  //       fit: BoxFit.cover, image: AssetImage('assets/cover.jpg')),
                  // ),
                  spacer,
                  mat.Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: mat.CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1 / 2.3,
                        child: Text(
                          data.title,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      spacer,
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 1 / 2.5,
                        child: Text(
                          data.artist,
                          // widget.isFromPrimarySearchPage ? widget.songs[index].artists![0].name.toString() : 'Atif',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    // width: MediaQuery.of(context).size.width * 1 / 8,
                    child: Text(
                      data.duration,
                      // widget.isFromPrimarySearchPage ? widget.songs[index].artists![0].name.toString() : 'Atif',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  spacer,
                  const Icon(FluentIcons.more)
                ],
              ),


            ],

          ),
        ),
      ),
    );;
  }
}

