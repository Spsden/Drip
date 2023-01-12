import 'package:collection/collection.dart';
import 'package:drip/datasources/searchresults/models/communityplaylistdataclass.dart';
import 'package:fluent_ui/fluent_ui.dart' ;
import 'package:flutter/material.dart' as mat;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'package:provider/provider.dart';

import '../../customwidgets/hovered_card.dart';
import '../../datasources/searchresults/requests/searchresultsservice.dart';
import '../../theme.dart';
import '../common/loading_widget.dart';
import '../playlistmainpage.dart';
import '../legacy_search.dart';


class CommunityPlaylistSearch extends ConsumerWidget {
   List<CommunityPlaylist> communityPlaylist ;
  CommunityPlaylistSearch({
    Key? key,
    required this.communityPlaylist,
  }) : super(key: key);


  @override
  Widget build(BuildContext context,WidgetRef ref) {
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
           height: boxSize + 15,
          //width: double.infinity,
          child: ListView.builder(
            itemCount: communityPlaylist.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) {
             return Container(
                 margin: const EdgeInsets.only(right: 15.0),
                 child: CommunityPlaylistCard(communityPlaylist:communityPlaylist[index] ));
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

    return mat.InkWell(
        onTap: () {
          Navigator.push(context,
              mat.MaterialPageRoute(builder: (context) => PlaylistMain(playlistId: communityPlaylist.browseId.toString())));


        },
        child: HoveredCard(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(

                  children: [
                    Expanded(

                      child: FadeInImage(
                        height: 170,


                        placeholder: const AssetImage('assets/cover.jpg'),
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            communityPlaylist.thumbnails[0].url
                          //albums.thumbnails![1].url.toString(),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(padding:
                    const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: Text(
                        communityPlaylist.title,
                        textAlign: TextAlign.center,
                        style:
                        typography.bodyStrong?.apply(fontSizeFactor: 1.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Padding(padding:
                    const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: Text(
                        'by ${communityPlaylist.author}' ?? 'NA',
                        textAlign: TextAlign.center,
                        style:
                        typography.subtitle?.apply(fontSizeFactor: 0.7, color: mat.Colors.white60),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                    ),

                  ],
                )
              ],
            ))
    );
  }
}


class PlaylistInfinitePaginationWidget extends ConsumerStatefulWidget {
  final String communityPlaylistQuery;
  const PlaylistInfinitePaginationWidget({Key? key, required this.communityPlaylistQuery, }) : super(key: key);

  @override
  _PlaylistInfinitePaginationWidgetState createState() => _PlaylistInfinitePaginationWidgetState();
}

class _PlaylistInfinitePaginationWidgetState extends ConsumerState<PlaylistInfinitePaginationWidget> {

  final FloatingSearchBarController _controller = FloatingSearchBarController();

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
                          ? ' Results for "$query"'
                          : ' Results for "${widget.communityPlaylistQuery}"',
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
                      child: loadingWidget(context,ref.watch(themeProvider).color),
                    ),
                    newPageProgressIndicatorBuilder: (_) => Center(
                      child: loadingWidget(context,ref.watch(themeProvider).color),
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

