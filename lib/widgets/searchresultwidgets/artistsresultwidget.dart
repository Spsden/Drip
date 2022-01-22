import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:drip/datasource/searchresults/artistsdataclass.dart';

class ArtistsSearch extends StatelessWidget {
  late List<Artists> artists = [];
  ArtistsSearch({
    Key? key,
    required this.artists,
  }) : super(key: key);

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
                  'Artists',
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
            height: 250,
            child: ListView.builder(
              itemCount: artists.length,
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                  child: Column(
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            radius: 80,
                            backgroundImage: imageProvider,
                          ),
                          fit: BoxFit.cover,
                          errorWidget: (context, _, __) => const Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/artist.jpg'),
                          ),
                          imageUrl:
                              artists[index].thumbnails![1].url.toString(),
                          placeholder: (context, url) => const Image(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/artist.jpg')),
                        ),
                      ),
                      Text(
                        artists[index].artist.toString(),
                        style: TextStyle(
                          ///color: Theme.of(context).colorScheme.secondary,
                          color: Colors.white,
                          fontSize: 18,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
