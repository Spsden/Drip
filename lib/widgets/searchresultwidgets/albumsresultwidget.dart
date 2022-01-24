import 'package:drip/datasource/searchresults/albumsdataclass.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 250,
          //width: double.infinity,
          child: Expanded(
            child: ListView.builder(
              itemCount: albums.length,
              shrinkWrap: false,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  width: 200,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.transparent,
                    child: Wrap(
                      children: [
                        CachedNetworkImage(
                          width: 200,
                          height: 200,
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
                          imageUrl: albums[index].thumbnails[1].url.toString(),
                          placeholder: (context, url) => const Image(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/artist.jpg')),
                        ),
                        ListTile(
                          title: Text(
                            albums[index].title.toString(),
                            style: const TextStyle(
                              ///color: Theme.of(context).colorScheme.secondary,
                              color: Colors.white,
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          subtitle: Text(
                            albums[index].artists[0].name.toString() +
                                '\n' +
                                albums[index].year.toString(),
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
        )
      ],
    );
  }
}
