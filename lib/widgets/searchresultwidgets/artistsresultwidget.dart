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
    return Column(
      children: [
        SizedBox(
          //width: double.infinity,
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
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 250,
          // width: 800,
          child: ListView.builder(
            itemCount: artists.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            itemBuilder: (context, index) {
              return Container(
                //color: Colors.transparent,
                margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                width: 160,
                child: Card(
                  color: Colors.transparent,
                  child: Wrap(
                    children: [
                      CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 80,
                          backgroundImage: imageProvider,
                        ),
                        fit: BoxFit.cover,
                        errorWidget: (context, _, __) => const Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/artist.jpg'),
                        ),
                        imageUrl: artists[index].thumbnails![1].url.toString(),
                        placeholder: (context, url) => const Image(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/artist.jpg')),
                      ),
                      ListTile(
                        title: Text(
                          artists[index].artist.toString(),
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
        ),
      ],
    );
  }
}
