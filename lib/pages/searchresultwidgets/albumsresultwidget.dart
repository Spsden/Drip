
import 'package:drip/datasources/searchresults/albumsdataclass.dart';
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

        Container(
          alignment: Alignment.centerLeft,
          //padding: EdgeInsets.only(top: 20),
         // margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 280,
          //width: double.infinity,
          child: ListView.builder(
            itemCount: albums.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            itemBuilder: (context, index) {
              return Container(
                color: Colors.transparent,

                margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                width: 200,
               // height: 300,
                child: Card(
                 // clipBehavior: ,

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.transparent,
                  child: Wrap(


                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      CachedNetworkImage(
                        width: 180,
                        height: 180,
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
        )
      ],
    );
  }
}
