import 'package:drip/datasources/searchresults/playlist_data_class.dart';
import 'package:drip/pages/playlistmainpage.dart';
import 'package:fluent_ui/fluent_ui.dart' ;
import 'package:flutter/material.dart' as mat;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';




import '../../datasources/searchresults/searchresultsservice.dart';
import '../../theme.dart';
import '../common/loading_widget.dart';






class PlaylistCard extends ConsumerWidget {
  const PlaylistCard({Key? key, required this.playlistDataClass}) : super(key: key);
  final PlaylistDataClass playlistDataClass;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
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
          mat.MaterialPageRoute(builder: (context) => PlaylistMain(playlistId: playlistDataClass.playlistId.toString())));


        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color:ref.watch(themeProvider).mode ==
                    ThemeMode.dark ||
                    ref.watch(themeProvider).mode ==
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
                         playlistDataClass.thumbnails!.first.url.toString()
                        )),




                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  playlistDataClass.title,
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


class PlaylistSearchResults extends ConsumerStatefulWidget {
  final String playlistParams;
  const PlaylistSearchResults({Key? key, required this.playlistParams,}) : super(key: key);

  @override
  _PlaylistSearchResultsState createState() => _PlaylistSearchResultsState();
}

class _PlaylistSearchResultsState extends ConsumerState<PlaylistSearchResults> {

 // FloatingSearchBarController _controller = FloatingSearchBarController();
 late List<PlaylistDataClass> list = [];
  bool fetched = false;
  bool status = false;


  @override
  void initState() {


    super.initState();
  }



  @override
  void dispose() {

    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    if(!status){
      status = true;
      SearchMusic.getMoodPlaylists(widget.playlistParams.toString()).then((value) {
       // print(value.length);
        if(mounted){


          setState(() {
            list = value;
            fetched = true;
      });

      }

        //result = value
      });
    }
   return
   Stack(
     children: [
       (!fetched) ?


   Center(
     child: loadingWidget(context,ref.watch(themeProvider).color)
   ) :


   Stack(
     children: [


       AnimationLimiter(
         child: GridView.builder(gridDelegate:



         const SliverGridDelegateWithMaxCrossAxisExtent(
           maxCrossAxisExtent: 200.0,
           mainAxisSpacing: 15.0,
           crossAxisSpacing: 15.0,
           childAspectRatio: 1 / 1,
         ),
             itemCount: list.length,

             itemBuilder: (context,index) {
               return AnimationConfiguration.staggeredGrid(
                 position: index,
                   duration: const Duration(milliseconds: 375),
                   columnCount: 4,
                   child: SlideAnimation(child: FadeInAnimation(child: PlaylistCard(playlistDataClass: list[index]))));
             }
         ),
       ),



     ],

   ),

     ],
   );


  }
}
