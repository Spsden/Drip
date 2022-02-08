import 'package:drip/datasources/searchresults/communityplaylistdataclass.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../theme.dart';


class CommunityPlaylistSearch extends StatelessWidget {
  late List<CommunityPlaylist> communityPlaylist = [];
  CommunityPlaylistSearch({
    Key? key,
    required this.communityPlaylist,
  }) : super(key: key);

  // int thmbnailindex = communityPlaylist[]

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          alignment: Alignment.centerLeft,
          //margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 280,
          //width: double.infinity,
          child: ListView.builder(
            itemCount: communityPlaylist.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),

            itemBuilder: (context, index) {
              return Container(
                color:  context.watch<AppTheme>().mode == ThemeMode.dark ||
                    context.watch<AppTheme>().mode ==
                        ThemeMode.system
                    ? Colors.grey[150]
                    : Colors.grey[30],
                margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                width: 200,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color:  context.watch<AppTheme>().mode == ThemeMode.dark ||
                      context.watch<AppTheme>().mode ==
                          ThemeMode.system
                      ? Colors.grey[150]
                      : Colors.grey[30],
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      CachedNetworkImage(
                        width: 180,
                        height: 180,
                        //   imageBuilder: (context, imageProvider) =>
                        //  ,
                        // imageBuilder: (context, imageProvider) =>
                        //     CircleAvatar(
                        //   radius: 80,
                        //   backgroundImage: imageProvider,
                        // ),
                        fit: BoxFit.cover,
                        errorWidget: (context, _, __) => const Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/artist.jpg'),
                        ),
                        imageUrl: communityPlaylist[index]
                            .thumbnails[0]
                            .url
                            .toString(),
                        placeholder: (context, url) => const Image(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/artist.jpg')),
                      ),
                      ListTile(
                        title: Text(
                          communityPlaylist[index].title.toString(),
                          style: const TextStyle(
                            ///color: Theme.of(context).colorScheme.secondary,
                            color: Colors.white,
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        subtitle: Text(
                          communityPlaylist[index].author.toString(),
                          style: const TextStyle(
                            ///color: Theme.of(context).colorScheme.secondary,
                            color: Colors.white,
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
