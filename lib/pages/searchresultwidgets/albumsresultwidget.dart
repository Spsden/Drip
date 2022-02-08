import 'package:drip/datasources/searchresults/albumsdataclass.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../theme.dart';

class AlbumSearch extends StatelessWidget {
  late List<Albums> albums = [];

  AlbumSearch({
    Key? key,
    required this.albums,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    final bool rotated =
        MediaQuery.of(context).size.height < MediaQuery.of(context).size.width;
    double boxSize = !rotated
        ? MediaQuery.of(context).size.width / 2
        : MediaQuery.of(context).size.height / 2.5;
    if (boxSize > 250) boxSize = 250;
    Typography typography = FluentTheme.of(context).typography;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          //padding: EdgeInsets.only(top: 20),
          // margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 270,
          //width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: albums.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  //         );
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color:
                            context.watch<AppTheme>().mode == ThemeMode.dark ||
                                    context.watch<AppTheme>().mode ==
                                        ThemeMode.system
                                ? Colors.grey[150]
                                : Colors.grey[30]

                        // if(co)

                        //fluent.Colors.grey[40]

                        // context.watch<AppTheme>().cardColor

                        ),
                    margin: EdgeInsets.all(10),
                    width: boxSize - 30,
                    child: Column(
                      children: [
                        Expanded(
                          child: mat.Card(
                            margin: EdgeInsets.only(top: 15.0),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: CachedNetworkImage(
                              width: 150,
                              height: 150,
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
                              imageUrl:
                                  albums[index].thumbnails[1].url.toString(),
                              placeholder: (context, url) => const Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/artist.jpg')),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          albums[index].title.toString(),
                          style:
                              typography.bodyStrong?.apply(fontSizeFactor: 1.2),
                          textAlign: TextAlign.center,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            albums[index].artists[0].name.toString() +
                                '\n' +
                                albums[index].year.toString(),
                            style: typography.bodyStrong
                                ?.apply(fontSizeFactor: 1.0),
                            textAlign: TextAlign.center,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
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
