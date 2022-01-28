import 'package:drip/datasource/audioplayer/audiodata.dart';
import 'package:drip/datasource/searchresults/searchresultstwo.dart';
import 'package:drip/datasource/searchresults/songsdataclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SongsListPage extends StatefulWidget {
  final String incomingquery;

  const SongsListPage({Key? key, required this.incomingquery})
      : super(key: key);

  @override
  _SongsListPageState createState() => _SongsListPageState();
}

class _SongsListPageState extends State<SongsListPage> {
  List<Songs> songlist = [];
  static int page = 0;
  int numofresultsload = 10;
  ScrollController _sc = ScrollController();
  bool isLoading = false;
  bool fetched = false;
  String thispagesearchquery = '';




  @override
  void initState() {
    songLoader(page);
    super.initState();

    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent && !isLoading) {
        songLoader(page);
      }
    });




    
  }

  void songLoader(int page) {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    SearchMusic.getOnlySongs(
            thispagesearchquery == ''
                ? widget.incomingquery
                : thispagesearchquery,
            numofresultsload)
        .then((value) {
          if (this.mounted) {
            setState(() {
              songlist = value;
              fetched = true;
              isLoading = false;
              page++;
              numofresultsload += 20;
            });
          }
    });
  }



  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  void onClick(){
    var thumbnail;

  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 40, 20, 20),
              //width: 400,
              child: Row(
                children: [
                  Navigator.of(context).canPop()
                      ? Row(
                          children: [
                            InkWell(
                                child: const Icon(
                                    fluent.FluentIcons.chevron_left_med),
                                hoverColor: Colors.red,
                                onTap: () {
                                  Navigator.of(context).pop();
                                }),
                            const fluent.SizedBox(
                              width: 20,
                            ),
                          ],
                        )
                      : SizedBox(),
                  fluent.SizedBox(
                    width: 400,
                    child: CupertinoSearchTextField(
                      style: TextStyle(color: Colors.white),
                      onSubmitted: (_value) async {
                        setState(() {
                          songlist.clear();
                          numofresultsload = 20;
                          page = 0;
                          thispagesearchquery = _value;
                          songLoader(page);
                          fetched = true;
                        });
                      },
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 0.5),
                          // color: Colors.red.shade900.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                thispagesearchquery == ''
                    ? 'Results for \"${widget.incomingquery}\"'
                    : 'Results for \"$thispagesearchquery\"',
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 40.0,
                ),
              ),
            ),
          ),
          Container(
            child: (!fetched)
                ? Container(
                    alignment: Alignment.center,
                    width: 500,
                    height: 500,
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.red, size: 300))
                : Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 10),
                        itemCount: songlist.length + 1,
                        controller: _sc,
                        shrinkWrap: true,
                        //scrollDirection: Axis.vertical,
                        // padding: const EdgeInsets.only(bottom: 10),
                        itemBuilder: (context, index) {
                          if (index == songlist.length) {
                            return Container(
                                alignment: Alignment.center,
                                width: 500,
                                height: 500,
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                    color: Colors.red, size: 100));
                          } else {
                            return InkWell(
                              hoverColor: Colors.red.withOpacity(0.4),
                              onTap: () => context.read<AudioData>().songDetails(songlist[index].videoId, songlist[index].artists![0].name, songlist[index].title, songlist[index].thumbnails[0].url),

                              child: Container(
                               // padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                margin: const EdgeInsets.fromLTRB(0,5,0,5),
                                color: Colors.brown.withOpacity(0.4),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        fluent.MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            errorWidget: (context, _, __) =>
                                                const Image(
                                              fit: BoxFit.cover,
                                              image:
                                                  AssetImage('assets/cover.jpg'),
                                            ),
                                            imageUrl: songlist[index]
                                                .thumbnails[0]
                                                .url
                                                .toString(),
                                            placeholder: (context, url) =>
                                                const Image(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        'assets/cover.jpg')),
                                          )),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          songlist[index].title.toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Icon(
                                        fluent.FluentIcons.play_solid,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          songlist[index]
                                              .artists![0]
                                              .name
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                          width: 200,
                                          child: Text(
                                            songlist[index]
                                                .album!
                                                .name
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                          width: 150,
                                          child: Text(
                                            songlist[index].duration.toString(),
                                            overflow: TextOverflow.ellipsis,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                  ),
          ),
        ],
      ),
    );
  }
}
