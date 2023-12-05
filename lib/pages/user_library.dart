import 'package:drip/datasources/searchresults/local_models/saved_playlist.dart';
import 'package:drip/datasources/searchresults/requests/searchresultsservice.dart';
import 'package:drip/providers/local/saved_playlist_provider.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:drip/datasources/searchresults/models/playlistdataclass.dart'
    as playlist;
import 'package:drip/datasources/searchresults/local_models/tracks_local.dart'
    as tracks;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:drip/customwidgets/saved_playlists_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:window_manager/window_manager.dart';

class UserLibrary extends ConsumerStatefulWidget {
  const UserLibrary({super.key});

  @override
  ConsumerState<UserLibrary> createState() => _UserLibraryState();
}

class _UserLibraryState extends ConsumerState<UserLibrary> {
  SavedPlayList addToLocalData(playlist.Playlists data) {
    SavedPlayList savedPlayList = SavedPlayList(
        playListTitle: data.title ?? "NA",
        playListSource: "Youtube",
        id: data.id ?? "NA",
        thumbnail: data.thumbnails.last.url ?? "NA",
        description: data.description ?? "NA",
        author: data.author?.name ?? "NA",
        trackCount: data.trackCount.toString(),
        year: data.year ?? "NA",
        tracks: List<tracks.Track>.from(data.tracks.map((e) => tracks.Track(
            album: List<String>.from(['lol']),
            artists: List<String>.from(e.artists.map((e) => e.name).toList()),
            duration: e.duration,
            durationSeconds: e.durationSeconds,
            isAvailable: e.isAvailable,
            isExplicit: e.isExplicit,
            thumbnails: List<String>.from([e.thumbnails.first.url]),
            title: e.title,
            videoId: e.videoId))));
    return savedPlayList;
  }

  Future<bool> addPlaylist(String url) async {
    try {
      Uri uri = Uri.parse(url);
      String lol = uri.query.split("=")[1].split("&")[0];
      print(lol);

      playlist.Playlists playlists = await SearchMusic.getPlaylist(lol, 50);
      ref
          .read(savedPlayListHiveData.notifier)
          .addSavedPlaylist(addToLocalData(playlists));
      return true;
    } catch (e) {
      debugPrint('An error occurred: $e');

      return false;
    }
  }

  final TextEditingController _textEditingController = TextEditingController();

  void showContentDialog(BuildContext context) async {
  showDialog<String>(
      context: context,
      builder: (context) => fluent.ContentDialog(
        style: fluent.ContentDialogThemeData(
            decoration: fluent.BoxDecoration(
                color: fluent.FluentTheme.of(context).micaBackgroundColor,
                borderRadius: BorderRadius.circular(8))),
        title: const Text('Playlist Link'),
        content: fluent.TextBox(
          controller: _textEditingController,
        ),
        actions: [
          fluent.Button(
            child: const Text('Import'),
            onPressed: () async {
              String ll = _textEditingController.text;
              //   'https://music.youtube.com/playlist?list=PLEKd4tmw8baciGt7F1Gl-bltDdbmAULkT&feature=share';

              if(await addPlaylist(ll)){
                Navigator.pop(context, 'User added a playlist');



              } else{
                _textEditingController.clear();
                _textEditingController.text = "invalid link";


              }




              // Delete file here
            },
          ),
          fluent.FilledButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, 'User canceled dialog');
                _textEditingController.clear();
              }),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showContentDialog(context);
        },
        label: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
      body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ImportedAndSavedPlaylists()


          ),
    );
  }
}

// class UserLibrary extends ConsumerWidget {
//   const UserLibrary({Key? key}) : super(key: key);
//
//
//
//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton.extended(onPressed: (){}, label: const Icon(
//         Icons.add,
//         size: 50,
//       ),),
//       body:
//
//       const Padding(
//         padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 10),
//         child:  ImportedAndSavedPlaylists()
//
//       //   ListView(
//       //     children:  [
//       //       AddPlayListWidget(),
//       //       // Container(
//       //       //   child: Row(
//       //       //     children: [
//       //       //       Container(
//       //       //         width: 200,
//       //       //         height: 200,
//       //       //         color: Colors.yellow,
//       //       //       ),
//       //       //       Container(
//       //       //         width: 200,
//       //       //         height: 200,
//       //       //         color: Colors.red,
//       //       //       )
//       //       //     ],
//       //       //   ),
//       //       // ),
//       //
//       // // fluent.AutoSuggestBox(items: []),
//       //       DragToMoveArea(child: Container(color: Colors.blue,width: 300,)),
//       //
//       //     ],
//       //   ),
//       ),
//     );
//   }
// }

// class AddPlayListWidget extends ConsumerStatefulWidget {
//   const AddPlayListWidget({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<AddPlayListWidget> createState() => _AddPlayListWidgetState();
// }
//
// class _AddPlayListWidgetState extends ConsumerState<AddPlayListWidget> {
//
//
//   SavedPlayList addToLocalData(playlist.Playlists data) {
//     SavedPlayList savedPlayList = SavedPlayList(
//         playListTitle: data.title ?? "NA",
//         playListSource: "Youtube",
//         id: data.id ?? "NA",
//         thumbnail: data.thumbnails.last.url ?? "NA",
//         description: data.description ?? "NA",
//         author: data.author?.name ?? "NA",
//         trackCount: data.trackCount.toString(),
//         year: data.year ?? "NA",
//         tracks: List<tracks.Track>.from(data.tracks.map((e) => tracks.Track(
//             album: List<String>.from(['lol']),
//             artists: List<String>.from(e.artists.map((e) => e.name).toList()),
//             duration: e.duration,
//             durationSeconds: e.durationSeconds,
//             isAvailable: e.isAvailable,
//             isExplicit: e.isExplicit,
//             thumbnails: List<String>.from([e.thumbnails.first.url]),
//             title: e.title,
//             videoId: e.videoId))));
//     return savedPlayList;
//   }
//
//   String pol(String x) {
//     return x;
//   }
//
//   Future addPlaylist(String url) async {
//     Uri uri = Uri.parse(url);
//     String lol = uri.query.split("=")[1].split("&")[0];
//     print(lol);
//
//     playlist.Playlists playlists = await SearchMusic.getPlaylist(lol, 50);
//       ref.read(savedPlayListHiveData.notifier).addSavedPlaylist(addToLocalData(playlists));
//     // final recentlyPlayedBox = Hive.box('savedPnnlaylists');
//     // recentlyPlayedBox.add(addToLocalData(playlists));
//   }
//
//   final TextEditingController _textEditingController = TextEditingController();
//
//   void showContentDialog(BuildContext context) async {
//     final result = await showDialog<String>(
//       context: context,
//       builder: (context) => fluent.ContentDialog(
//         style: fluent.ContentDialogThemeData(
//             decoration: fluent.BoxDecoration(
//                 color: fluent.FluentTheme.of(context).micaBackgroundColor,
//                 borderRadius: BorderRadius.circular(8))),
//         title: const Text('Playlist Link'),
//         content: fluent.TextBox(
//           controller: _textEditingController,
//         ),
//         actions: [
//           fluent.Button(
//             child: const Text('Import'),
//             onPressed: () async {
//               String ll = _textEditingController.text;
//               //   'https://music.youtube.com/playlist?list=PLEKd4tmw8baciGt7F1Gl-bltDdbmAULkT&feature=share';
//               addPlaylist(ll);
//
//
//               debugPrint(ll);
//               _textEditingController.clear();
//
//               Navigator.pop(context, 'User deleted file');
//               // Delete file here
//             },
//           ),
//           fluent.FilledButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.pop(context, 'User canceled dialog');
//                 _textEditingController.clear();
//               }),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _textEditingController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         width: double.infinity,
//         height: 200,
//         child: Row(
//           children: [
//             buttonSquare(context),
//             // SizedBox(width: 200,),
//             //buttonSquare(context)
//
//             //  fluent.FilledButton(child: Text('Hahaha'), onPressed: () {})
//           ],
//         ));
//   }
//
//   Widget buttonSquare(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         //  debugPrint("Tapped import");
//         showContentDialog(context);
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//         width: 150,
//         height: 150,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             color: fluent.FluentTheme.of(context).cardColor),
//         child: const Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.add,
//               size: 50,
//             ),
//             Text("Import Playlist")
//           ],
//         ),
//       ),
//     );
//   }
// }

// Future<void> deleteSavedPlaylistById(String playlistId) async {
//   final box = Hive.box('savedPlaylists');
//   // Find the playlist by the `id` field and delete it
//   final keyToDelete = box.keys.firstWhere(
//         (k) => box.get(k).id == playlistId,
//     orElse: () => null,
//   );
//
//   if (keyToDelete != null) {
//     await box.delete(keyToDelete);
//   }
// }

class ImportedAndSavedPlaylists extends ConsumerWidget {
  const ImportedAndSavedPlaylists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  List<Widget> recent =
    // List.generate(10, (index) => const PlaylistContainer());
    // final AsyncValue<List<SavedPlayList>> savedPlayLists =
    // ref.watch(savedPlaylistsProvider);
    final savedPlaylists = ref.watch(getAllSavedPlaylistsProvider);
    return savedPlaylists.when(
      data: ((data) {
        print(data.toString());
        return GridView.builder(
            itemCount: data.length,
            physics: const BouncingScrollPhysics(),
            // shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: 390,
              maxCrossAxisExtent: 380.0,
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 15.0,
              //   childAspectRatio: 80 / 100,
            ),
            itemBuilder: (context, index) {
              SavedPlayList savedPlayList = data[index];
              // recent_model.RecentlyPlayed recentlyPlayed = recent[index];
              return

                  //Placeholder() ;
                  //FeelGoodPlaylist();
                  PlaylistContainer(
                data: savedPlayList,
                delCallBack: () {
                  ref
                      .read(savedPlayListHiveData.notifier)
                      .removeSavedPlaylist(savedPlayList.id);
                },
              );
            });
      }),
      error: ((error, stackTrace) {
        return Text(error.toString());
      }),
      loading: () {
        return CircularProgressIndicator();
      },
    );

    // ValueListenableBuilder(
    //   valueListenable: Hive.box('savedPlaylists').listenable(),
    //
    //   builder: (context, Box box, _) {
    //     List<SavedPlayList> recent = List.from(box.values.toList().reversed);
    //     box.keys.forEach((element) {print(element.toString() + "yyyyy" + element.runtimeType.toString());});
    //     //recent.forEach((element) {print(element.);});
    //     if (box.values.isEmpty) {
    //       return const Center(
    //         child: Text('No recent searches'),
    //       );
    //     }
    //     return GridView.builder(
    //         itemCount: recent.length,
    //         physics: const BouncingScrollPhysics(),
    //         // shrinkWrap: true,
    //         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    //           mainAxisExtent: 390,
    //           maxCrossAxisExtent: 380.0,
    //           mainAxisSpacing: 15.0,
    //           crossAxisSpacing: 15.0,
    //           //   childAspectRatio: 80 / 100,
    //         ),
    //         itemBuilder: (context, index) {
    //           SavedPlayList savedPlayList = recent[index];
    //           // recent_model.RecentlyPlayed recentlyPlayed = recent[index];
    //           return
    //
    //             //Placeholder() ;
    //             //FeelGoodPlaylist();
    //             PlaylistContainer(data: savedPlayList);
    //         });
    //   });
  }
}

// class ImportedAndSavedPlaylists extends ConsumerWidget {
//   const ImportedAndSavedPlaylists({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     //  List<Widget> recent =
//     // List.generate(10, (index) => const PlaylistContainer());
//     return ValueListenableBuilder(
//         valueListenable: Hive.box('savedPlaylists').listenable(),
//
//         builder: (context, Box box, _) {
//           List<SavedPlayList> recent = List.from(box.values.toList().reversed);
//           box.keys.forEach((element) {print(element.toString() + "yyyyy" + element.runtimeType.toString());});
//          //recent.forEach((element) {print(element.);});
//           if (box.values.isEmpty) {
//             return const Center(
//               child: Text('No recent searches'),
//             );
//           }
//           return GridView.builder(
//               itemCount: recent.length,
//               physics: const BouncingScrollPhysics(),
//              // shrinkWrap: true,
//               gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                 mainAxisExtent: 390,
//                 maxCrossAxisExtent: 380.0,
//                 mainAxisSpacing: 15.0,
//                 crossAxisSpacing: 15.0,
//              //   childAspectRatio: 80 / 100,
//               ),
//               itemBuilder: (context, index) {
//                 SavedPlayList savedPlayList = recent[index];
//                 // recent_model.RecentlyPlayed recentlyPlayed = recent[index];
//                 return
//
//                     //Placeholder() ;
//                   //FeelGoodPlaylist();
//                     PlaylistContainer(data: savedPlayList);
//               });
//         });
//   }
// }
