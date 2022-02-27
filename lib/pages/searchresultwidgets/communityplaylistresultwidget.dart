import 'package:drip/datasources/searchresults/communityplaylistdataclass.dart';
import 'package:fluent_ui/fluent_ui.dart' ;
import 'package:flutter/material.dart' as mat;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'package:provider/provider.dart';

import '../../datasources/searchresults/searchresultsservice.dart';
import '../../theme.dart';
import '../common/loading_widget.dart';
import '../playlistmainpage.dart';
import '../search.dart';


class CommunityPlaylistSearch extends StatelessWidget {
  late List<CommunityPlaylist> communityPlaylist = [];
  CommunityPlaylistSearch({
    Key? key,
    required this.communityPlaylist,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
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
          //margin: const EdgeInsets.symmetric(vertical: 20.0),
          height: 280,
          //width: double.infinity,
          child: ListView.builder(
            itemCount: communityPlaylist.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),

            itemBuilder: (context, index) {
              return mat.InkWell(

                onTap: () {
                  // Navigator.of(context).pushNamed('communityPlaylists',
                  //     arguments: communityPlaylist[index].browseId.toString()

                  Navigator.push(context,
                      mat.MaterialPageRoute(builder: (context) => PlaylistMain(playlistId: communityPlaylist[index].browseId.toString())));



                },
                child:  Padding(
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
                    margin: const EdgeInsets.all(10),
                    width: boxSize - 30,
                    child: Column(
                      children: [
                        Expanded(
                          child: mat.Card(
                            margin: const EdgeInsets.only(top: 15.0),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child:

                            FadeInImage(placeholder:
                            const AssetImage('assets/cover.jpg'),
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,

                                image:  NetworkImage(
                                    communityPlaylist[index].thumbnails.first.url.toString()
                                )),


                            // CachedNetworkImage(
                            //   width: 150,
                            //   height: 150,
                            //   // imageBuilder: (context, imageProvider) =>
                            //   //     CircleAvatar(
                            //   //   radius: 80,
                            //   //   backgroundImage: imageProvider,
                            //   // ),
                            //   fit: BoxFit.cover,
                            //   errorWidget: (context, _, __) => const Image(
                            //     fit: BoxFit.cover,
                            //     image: AssetImage('assets/artist.jpg'),
                            //   ),
                            //   imageUrl:
                            //   communityPlaylist[index].thumbnails.first.url.toString(),
                            //   placeholder: (context, url) => const Image(
                            //       fit: BoxFit.fill,
                            //       image: AssetImage('assets/artist.jpg')),
                            // ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          communityPlaylist[index].title.toString(),
                          style:
                          typography.bodyStrong?.apply(fontSizeFactor: 1.2),
                          textAlign: TextAlign.center,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            communityPlaylist[index].author.toString() +
                                '\n' +
                                communityPlaylist[index].itemCount.toString(),
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

class CommunityPlaylistCard extends StatelessWidget {
  const CommunityPlaylistCard({Key? key, required this.communityPlaylist}) : super(key: key);
  final CommunityPlaylist communityPlaylist;

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;

    final bool rotated =
        MediaQuery.of(context).size.height < MediaQuery.of(context).size.width;
    double boxSize = !rotated
        ? MediaQuery.of(context).size.width / 2
        : MediaQuery.of(context).size.height / 2.5;
    if (boxSize > 250) boxSize = 250;
    return mat.Material(
      child: mat.InkWell(
        onTap: () {
          Navigator.push(context,
              mat.MaterialPageRoute(builder: (context) => PlaylistMain(playlistId: communityPlaylist.browseId.toString())));


        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: context.watch<AppTheme>().mode ==
                    ThemeMode.dark ||
                    context.watch<AppTheme>().mode ==
                        ThemeMode.system
                    ? Colors.grey[150].withOpacity(0.4)
                    : Colors.grey[30]

              // if(co)

              //fluent.Colors.grey[40]

              // context.watch<AppTheme>().cardColor

            ),
            // margin: const EdgeInsets.only(right: 10),
            width:
            (boxSize - 30) * (16 / 9),
            height: (boxSize - 30) * (16 / 9),

            child: Column(
              children: [
                Expanded(
                  child: mat.Card(
                    //  margin: const EdgeInsets.all(8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child:

                    FadeInImage(placeholder:
                    const AssetImage('assets/cover.jpg'),
                        //width : (boxSize - 30) * (16 / 9),
                        // height: 37,
                        fit: BoxFit.cover,

                        image:  NetworkImage(
                            communityPlaylist.thumbnails.first.url.toString()
                        )),




                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  communityPlaylist.title,
                  textAlign: TextAlign.left,
                  softWrap: false,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                // Container(
                //   margin: const EdgeInsets.only(bottom: 15,left: 5,right: 5),
                //   child: Text(
                //     playlistDataClass.title,
                //
                //     textAlign: TextAlign.center,
                //     softWrap: false,
                //     overflow: TextOverflow.ellipsis,
                //     style: TextStyle(
                //       fontSize: 11,
                //
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class PlaylistInfinitePaginationWidget extends StatefulWidget {
  final String communityPlaylistQuery;
  const PlaylistInfinitePaginationWidget({Key? key, required this.communityPlaylistQuery, }) : super(key: key);

  @override
  _PlaylistInfinitePaginationWidgetState createState() => _PlaylistInfinitePaginationWidgetState();
}

class _PlaylistInfinitePaginationWidgetState extends State<PlaylistInfinitePaginationWidget> {

  FloatingSearchBarController _controller = FloatingSearchBarController();

  String query = '';
  static const _pageSize = 10;

  final _pagingController = PagingController<int, CommunityPlaylist>(
    // 2
    firstPageKey: 1,
  );


  @override
  void initState() {
    // TODO: implement initState
    _pagingController.addPageRequestListener((pageKey) {
      fetchCommunityPlaylist(pageKey);
    });
    super.initState();
  }

  Future <void> fetchCommunityPlaylist(int pageKey) async {
    try {
      final List<CommunityPlaylist> newItems = await SearchMusic.getOnlyCommunityPlaylists(query == '' ? widget.communityPlaylistQuery : query, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if(isLastPage){
        _pagingController.appendLastPage(newItems);

      }else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pagingController.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    return SearchFunction(liveSearch: false ,
      controller: _controller,
      onSubmitted:
          (searchQuery) async {
        query = searchQuery;
        _pagingController.refresh();

      },
      body: Center(




        child:



        mat.RefreshIndicator(
          onRefresh: () => Future.sync(
                () => _pagingController.refresh(),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
                SliverToBoxAdapter(

                    child: Text(

                      widget.communityPlaylistQuery == ''
                          ? ' Results for \"${query}\"'
                          : ' Results for \"${widget.communityPlaylistQuery}\"',
                      style:  typography.display?.apply(fontSizeFactor: 1.0),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,)
                ),
                const SliverToBoxAdapter(
                  //child: SizedBox(height: 15,),
                ),
                PagedSliverGrid(pagingController: _pagingController,

                  builderDelegate: PagedChildBuilderDelegate<CommunityPlaylist>(
                    animateTransitions: true,
                    transitionDuration: const Duration(milliseconds: 200),
                    firstPageProgressIndicatorBuilder: (_) => Center(
                      child: loadingWidget(context)
                    ),
                    newPageProgressIndicatorBuilder: (_) => Center(
                      child: loadingWidget(context)
                    ),
                    itemBuilder: (context, CommunityPlaylists, index) => CommunityPlaylistCard(
                      communityPlaylist : CommunityPlaylists,
                    ),),
                  gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
                    childAspectRatio: 1/1.2,
                  ),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

