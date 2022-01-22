import 'package:drip/datasource/searchresults/communityplaylistdataclass.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:drip/datasource/searchresults/artistsdataclass.dart';

class CommunityPlaylistSearch extends StatelessWidget {
  late List<CommunityPlaylist> communityPlaylist = [];
  CommunityPlaylistSearch({
    Key? key,
    required this.communityPlaylist,
  }) : super(key: key);

  // int thmbnailindex = communityPlaylist[]

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Playlists',
                  style: TextStyle(
                    ///color: Theme.of(context).colorScheme.secondary,
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  'Show all     ',
                  style: TextStyle(
                    ///color: Theme.of(context).colorScheme.secondary,
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 260,
            //width: double.infinity,
            child: Expanded(
              child: ListView.builder(
                itemCount: communityPlaylist.length,
                shrinkWrap: false,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                //
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Card(
                            margin: EdgeInsets.only(top: 15.0),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              errorWidget: (context, _, __) => Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/ytCover.png',
                                  )),
                              imageUrl: communityPlaylist[index]
                                  .thumbnails[0]
                                  .url
                                  .toString(),
                              placeholder: (context, url) => Image(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/ytCover.png',
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          communityPlaylist[index].title.toString(),
                          textAlign: TextAlign.center,
                          // softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
