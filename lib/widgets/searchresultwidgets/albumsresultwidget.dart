import 'package:drip/datasource/searchresults/albumsdataclass.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class AlbumSearch extends StatelessWidget {
  late List<Albums> albums = [];
  AlbumSearch({
    Key? key,
    required this.albums,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Albums',
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
              itemCount: albums.length,
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                            errorWidget: (context, _, __) => const Image(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/ytCover.png',
                                )),
                            imageUrl:
                                albums[index].thumbnails[1].url.toString(),
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
                        albums[index].title.toString(),
                        textAlign: TextAlign.center,
                        softWrap: false,
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
    );
  }
}
