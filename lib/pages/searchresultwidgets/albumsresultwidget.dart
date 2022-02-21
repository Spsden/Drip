import 'package:drip/datasources/searchresults/albumsdataclass.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import '../../datasources/searchresults/searchresultsservice.dart';
import '../../theme.dart';
import '../search.dart';

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
              return

                  AlbumCard(albums: Albums(title: albums[index].title,
                  thumbnails: albums[index].thumbnails,
                  browseId: albums[index].browseId,
                  artists: albums[index].artists,
                  duration: albums[index].duration,
                  resultType: albums[index].resultType,
                  category: albums[index].category,
                  isExplicit: albums[index].isExplicit,
                  type: albums[index].type,
                  year: albums[index].year));


            },
          ),
        )
      ],
    );
  }
}


class AlbumCard extends StatelessWidget {
  const AlbumCard({Key? key, required this.albums}) : super(key: key);
  final Albums albums;

  @override
  Widget build(BuildContext context) {
    final bool rotated =
        MediaQuery.of(context).size.height < MediaQuery.of(context).size.width;
    double boxSize = !rotated
        ? MediaQuery.of(context).size.width / 2
        : MediaQuery.of(context).size.height / 2.5;
    if (boxSize > 250) boxSize = 250;
    Typography typography = FluentTheme.of(context).typography;
    return  mat.InkWell(
      onTap: () {
        showSnackbar(

          context,


          const Snackbar(

            content: Text('Coming Soon',style: TextStyle(
                fontSize: 30
            ),),

          ),
          alignment: Alignment.center,
          duration: const Duration(milliseconds: 200)


        );

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
                  child: CachedNetworkImage(
                    width: 150,
                    height: 150,
                    memCacheHeight: 150,
                    memCacheWidth: 150,
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
                    albums.thumbnails![1].url.toString(),
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
                albums.title.toString(),
                style:
                typography.bodyStrong?.apply(fontSizeFactor: 1.2),
                textAlign: TextAlign.center,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Text(
                  albums.artists[0].name.toString() +
                      '\n' +
                      albums.year.toString(),
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
  }
}





class AlbumsSearchResults extends StatefulWidget {
  final String albumsQuery;
  const AlbumsSearchResults({Key? key, required this.albumsQuery}) : super(key: key);

  @override
  _AlbumsSearchResultsState createState() => _AlbumsSearchResultsState();
}

class _AlbumsSearchResultsState extends State<AlbumsSearchResults> {

  FloatingSearchBarController _controller = FloatingSearchBarController();

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

  Future <void> fetchAlbums(int pageKey) async {
    try {
      final List<Albums> newItems = await SearchMusic.getOnlyAlbums(query == '' ? widget.albumsQuery : query, _pageSize);
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

                      widget.albumsQuery == ''
                          ? ' Results for \"${query}\"'
                          : ' Results for \"${widget.albumsQuery}\"',
                      style:  typography.display?.apply(fontSizeFactor: 1.0),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,)
                ),
                const SliverToBoxAdapter(
                  //child: SizedBox(height: 15,),
                ),
                PagedSliverGrid(pagingController: _pagingController,

                  builderDelegate: PagedChildBuilderDelegate<Albums>(
                    animateTransitions: true,
                    transitionDuration: const Duration(milliseconds: 200),
                    firstPageProgressIndicatorBuilder: (_) => Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                          color: context.watch<AppTheme>().color, size: 300),
                    ),
                    newPageProgressIndicatorBuilder: (_) => Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                          color: context.watch<AppTheme>().color, size: 100),
                    ),
                    itemBuilder: (context, Albums, index) => AlbumCard(
                      albums: Albums,
                    ),),
                  gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1/1.3,
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
