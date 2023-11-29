import 'package:drip/datasources/searchresults/local_models/saved_playlist.dart';
import 'package:drip/datasources/searchresults/requests/searchresultsservice.dart';
import 'package:drip/pages/searchresultwidgets/search_page_drip.dart';
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

import 'album_page.dart';

class UserLibrary extends ConsumerWidget {
  const UserLibrary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body:

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children:  [
            AddPlayListWidget(),
            // Container(
            //   child: Row(
            //     children: [
            //       Container(
            //         width: 200,
            //         height: 200,
            //         color: Colors.yellow,
            //       ),
            //       Container(
            //         width: 200,
            //         height: 200,
            //         color: Colors.red,
            //       )
            //     ],
            //   ),
            // ),

      // fluent.AutoSuggestBox(items: []),
            DragToMoveArea(child: Container(color: Colors.blue,width: 300,)),
            ImportedAndSavedPlaylists()
          ],
        ),
      ),
    );
  }
}




class AddPlayListWidget extends StatefulWidget {
  const AddPlayListWidget({Key? key}) : super(key: key);

  @override
  State<AddPlayListWidget> createState() => _AddPlayListWidgetState();
}

class _AddPlayListWidgetState extends State<AddPlayListWidget> {


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

  String pol(String x) {
    return x;
  }

  Future addPlaylist(String url) async {
    Uri uri = Uri.parse(url);
    String lol = uri.query.split("=")[1].split("&")[0];
    print(lol);

    playlist.Playlists playlists = await SearchMusic.getPlaylist(lol, 50);
    final recentlyPlayedBox = Hive.box('savedPlaylists');
    recentlyPlayedBox.add(addToLocalData(playlists));
  }

  final TextEditingController _textEditingController = TextEditingController();

  void showContentDialog(BuildContext context) async {
    final result = await showDialog<String>(
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
              addPlaylist(ll);
              debugPrint(ll);
              _textEditingController.clear();

              Navigator.pop(context, 'User deleted file');
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
    return SizedBox(
        width: double.infinity,
        height: 200,
        child: Row(
          children: [
            buttonSquare(context),
            // SizedBox(width: 200,),
            //buttonSquare(context)

            //  fluent.FilledButton(child: Text('Hahaha'), onPressed: () {})
          ],
        ));
  }

  Widget buttonSquare(BuildContext context) {
    return InkWell(
      onTap: () {
        //  debugPrint("Tapped import");
        showContentDialog(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        width: 150,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: fluent.FluentTheme.of(context).cardColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.add,
              size: 50,
            ),
            Text("Import Playlist")
          ],
        ),
      ),
    );
  }
}

class ImportedAndSavedPlaylists extends ConsumerWidget {
  const ImportedAndSavedPlaylists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  List<Widget> recent =
    // List.generate(10, (index) => const PlaylistContainer());
    return ValueListenableBuilder(
        valueListenable: Hive.box('savedPlaylists').listenable(),
        builder: (context, Box box, _) {
          List<SavedPlayList> recent = List.from(box.values.toList().reversed);
          recent.forEach((element) {print(element.id);});
          if (box.values.isEmpty) {
            return const Center(
              child: Text('No recent searches'),
            );
          }
          return GridView.builder(
              itemCount: recent.length,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisExtent: 370,
                maxCrossAxisExtent: 380.0,
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
                childAspectRatio: 80 / 100,
              ),
              itemBuilder: (context, index) {
                SavedPlayList savedPlayList = recent[index];
                // recent_model.RecentlyPlayed recentlyPlayed = recent[index];
                return

                    //Placeholder() ;
                  //FeelGoodPlaylist();
                    PlaylistContainer(data: savedPlayList);
              });
        });
  }
}
