import 'package:collection/collection.dart';
import 'package:drip/customwidgets/hovered_card.dart';
import 'package:drip/datasources/searchresults/models/albumsdataclass.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';


import '../../datasources/searchresults/requests/searchresultsservice.dart';
import '../../theme.dart';
import '../common/loading_widget.dart';
import '../legacy_search.dart';

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
          height: boxSize + 15,

          //width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: albums.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: 15),
                child: AlbumCard(
                    albums: Albums(
                        title: albums[index].title,
                        thumbnails: albums[index].thumbnails,
                        browseId: albums[index].browseId,
                        artists: albums[index].artists,
                        duration: albums[index].duration,
                        resultType: albums[index].resultType,
                        category: albums[index].category,
                        isExplicit: albums[index].isExplicit,
                        type: albums[index].type,
                        year: albums[index].year)),
              );
            },
          ),
        )
      ],
    );
  }
}

class AlbumCard extends ConsumerWidget {
  const AlbumCard({Key? key, required this.albums}) : super(key: key);
  final Albums albums;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Typography typography = FluentTheme.of(context).typography;
    return HoveredCard(


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
                      albums.thumbnails![1].url.toString(),
                    ),
                  ),
                ),
              ],
            ),
            Column(

              children: [
                Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    albums.title,
                    textAlign: TextAlign.center,
                    style:
                    typography.bodyStrong?.apply(fontSizeFactor: 1.0,),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Padding(padding:
                const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    '${albums.artists.firstOrNull == null ? 'NA' : albums.artists[0].name}\n${albums.year}',
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
                    albums.year,
                    textAlign: TextAlign.center,
                    style:
                    typography.bodyStrong?.apply(fontSizeFactor: 1.0),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                )
              ],
            )
          ],
        ));
  }
}

class AlbumsSearchResults extends ConsumerStatefulWidget {
  final String albumsQuery;

  const AlbumsSearchResults({Key? key, required this.albumsQuery})
      : super(key: key);

  @override
  _AlbumsSearchResultsState createState() => _AlbumsSearchResultsState();
}

class _AlbumsSearchResultsState extends ConsumerState<AlbumsSearchResults> {
  final FloatingSearchBarController _controller = FloatingSearchBarController();

  String query = '';
  static const _pageSize = 10;

  final _pagingController = PagingController<int, Albums>(
    // 2
    firstPageKey: 1,
  );

  @override
  void initState() {
    // TODO: implement initState
    _pagingController.addPageRequestListener((pageKey) {
      fetchAlbums(pageKey);
    });
    super.initState();
  }

  Future<void> fetchAlbums(int pageKey) async {
    try {
      final List<Albums> newItems = await SearchMusic.getOnlyAlbums(
          query == '' ? widget.albumsQuery : query, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
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
    return SearchFunction(
      liveSearch: false,
      controller: _controller,
      onSubmitted: (searchQuery) async {
        query = searchQuery;
        _pagingController.refresh();
      },
      body: Center(
        child: mat.RefreshIndicator(
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
                  widget.albumsQuery == ''
                      ? ' Results for "$query"'
                      : ' Results for "${widget.albumsQuery}"',
                  style: typography.display?.apply(fontSizeFactor: 1.0),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
                const SliverToBoxAdapter(
                    //child: SizedBox(height: 15,),
                    ),
                PagedSliverGrid(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<Albums>(
                    animateTransitions: true,
                    transitionDuration: const Duration(milliseconds: 200),
                    firstPageProgressIndicatorBuilder: (_) => Center(
                      child: loadingWidget(
                          context, ref.watch(themeProvider).color),
                    ),
                    newPageProgressIndicatorBuilder: (_) => Center(
                      child: loadingWidget(
                          context, ref.watch(themeProvider).color),
                    ),
                    itemBuilder: (context, Albums, index) => AlbumCard(
                      albums: Albums,
                    ),
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
                    childAspectRatio: 180 / 200,
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
