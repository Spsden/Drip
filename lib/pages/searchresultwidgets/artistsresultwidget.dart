import 'package:drip/datasources/searchresults/artistsdataclass.dart';
import 'package:drip/datasources/searchresults/searchresultsservice.dart';
import 'package:drip/pages/artistspage.dart';
import 'package:drip/pages/search.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

import '../../theme.dart';
import '../common/loading_widget.dart';

class ArtistsSearch extends StatelessWidget {
  late List<Artists> artists = [];

  ArtistsSearch({
    Key? key,
    required this.artists,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    return Column(
      children: [
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
              return ArtistCard(artists: Artists(artist: artists[index].artist,
                  browseId: artists[index].browseId,
                  category: artists[index].category,
                  radioId: artists[index].radioId,
                  resultType: artists[index].resultType,
                  shuffleId: artists[index].shuffleId,
                  thumbnails: artists[index].thumbnails
              ));




            },
          ),
        ),
      ],
    );
  }
}

class ArtistCard extends StatelessWidget {
  const ArtistCard({Key? key, required this.artists}) : super(key: key);
  
  final Artists artists;

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;

    //return


    return Hero(
      tag: artists.shuffleId.toString(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent
        ),
        width: 200,
        child: Column(

          children: [
            mat.InkWell(
              onTap: () {
              //   Navigator.of(context).pushNamed('artistsPage',
              //       arguments: artists.browseId.toString());
              // }
              // ,

          Navigator.push(context,
         mat.MaterialPageRoute(builder: (context) => ArtistsPage(channelId: artists.browseId.toString())));

        },


              child: mat.Card(
                elevation: 5,
                clipBehavior: Clip.antiAlias,
                shape: const CircleBorder(),
                child:




                CachedNetworkImage(
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    backgroundColor: mat.Colors.transparent,
                    foregroundColor: Colors.transparent,
                    radius:84,
                    backgroundImage: imageProvider,
                  ),
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/artist.jpg'),
                  ),
                  imageUrl: artists.thumbnails?.last.url.toString() ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOAQ7BhOGwDxmTw_6aRu2zlOiQ-WdTdF2XUxKBEAz_Q1MrOReLWZ-W4FaCUBkt5xod2cA&usqp=CAU',
                  placeholder: (context, url) => const Image(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/artist.jpg')),
                ),

              ),
            ),
            const SizedBox(height: 10,),
            Text(
                artists.artist.toString(),
              textAlign: TextAlign.left,
              softWrap: false,
                  style:
                typography.body?.apply(fontSizeFactor: 1.2),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,

      ),

          ],
        ),
      )

      );

  }
}

class ArtistsSearchResults extends StatefulWidget {
  final String artistQuery;
  const ArtistsSearchResults({Key? key, required this.artistQuery}) : super(key: key);

  @override
  _ArtistsSearchResultsState createState() => _ArtistsSearchResultsState();
}

class _ArtistsSearchResultsState extends State<ArtistsSearchResults> {

  FloatingSearchBarController _controller = FloatingSearchBarController();

  String query = '';
  static const _pageSize = 10;

  final _pagingController = PagingController<int, Artists>(
    // 2
    firstPageKey: 1,
  );


  @override
  void initState() {
    // TODO: implement initState
    _pagingController.addPageRequestListener((pageKey) {
      fetchArtists(pageKey);
    });
    super.initState();
  }

  Future <void> fetchArtists(int pageKey) async {
    try {
      final List<Artists> newItems = await SearchMusic.getOnlyArtists(query == '' ? widget.artistQuery : query, _pageSize);
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

      // mat.RaisedButton(
      //   child: Text('test me'),
      //   onPressed: () {
      //
      //     SearchMusic.getOnlyArtists(query == '' ? widget.artistQuery : query, _pageSize).then((value) => {
      //       print(value[2].artist)
      //     });
      //
      //
      //   },
      // )


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

                    widget.artistQuery == ''
                      ? ' Results for \"${query}\"'
                      : ' Results for \"${widget.artistQuery}\"',
                    style:  typography.display?.apply(fontSizeFactor: 1.0),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,)
              ),
              const SliverToBoxAdapter(
                //child: SizedBox(height: 15,),
              ),
              PagedSliverGrid(pagingController: _pagingController,

                  builderDelegate: PagedChildBuilderDelegate<Artists>(
                      animateTransitions: true,
                      transitionDuration: const Duration(milliseconds: 200),
                      firstPageProgressIndicatorBuilder: (_) => Center(
                        child: loadingWidget(context)
                      ),
                      newPageProgressIndicatorBuilder: (_) => Center(
                        child:loadingWidget(context),
                      ),
                      itemBuilder: (context, artists, index) => ArtistCard(
                        artists: artists,
                      ),),
                  gridDelegate:  const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1/1.5,
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

class MyClip extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromCircle(center: const Offset(0,0),radius: 80);
  }

  bool shouldReclip(oldClipper) {
    return false;
  }
}


