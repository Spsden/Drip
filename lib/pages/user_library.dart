import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:drip/customwidgets/saved_playlists_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserLibrary extends StatefulWidget {
  const UserLibrary({Key? key}) : super(key: key);

  @override
  State<UserLibrary> createState() => _UserLibraryState();
}

class _UserLibraryState extends State<UserLibrary> {
  List<Widget> list = List.generate(10, (index) => const PlaylistContainer());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: const [
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
  void showContentDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => fluent.ContentDialog(
        style: fluent.ContentDialogThemeData(

            decoration: fluent.BoxDecoration(
                color: fluent.FluentTheme.of(context).micaBackgroundColor,
                borderRadius: BorderRadius.circular(8))),
        title: const Text('Playlist Link'),
        content: const fluent.TextBox(),
        actions: [
          fluent.Button(
            child: const Text('Import'),
            onPressed: () {
              Navigator.pop(context, 'User deleted file');
              // Delete file here
            },
          ),
          fluent.FilledButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
        ],
      ),
    );
    setState(() {});
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
        debugPrint("Tapped import");
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
          children: [
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
    List<Widget> recent =
        List.generate(10, (index) => const PlaylistContainer());
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GridView.builder(
          itemCount: recent.length,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisExtent: 370,
            maxCrossAxisExtent: 400.0,
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 15.0,
            childAspectRatio: 100 / 115,
          ),

          //
          // const SliverGridDelegateWithMaxCrossAxisExtent(
          //     maxCrossAxisExtent: 350.0,
          //     mainAxisSpacing: 15.0,
          //     crossAxisSpacing: 10.0,
          //     childAspectRatio: 8 / 2),
          itemBuilder: (context, index) {
            //recent_model.RecentlyPlayed recentlyPlayed = recent[index];
            return Center(child: recent[index]

                //     ListTile(
                //
                //
                //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                //     onTap: () async {
                //       CurrentMusicInstance currentMusicInstance =
                //       CurrentMusicInstance(
                //           title: recentlyPlayed.title,
                //           author: recentlyPlayed.author
                //              ,
                //           thumbs: recentlyPlayed.thumbs
                //             ,
                //           urlOfVideo: 'NA',
                //           videoId: recentlyPlayed.videoId);
                //
                //       ref.read(audioControlCentreProvider).open(currentMusicInstance);
                //
                //     },
                //
                //     tileColor:
                //
                //     ref.watch(themeProvider).mode ==
                //         ThemeMode.dark ||
                //         ref.watch(themeProvider).mode ==
                //             ThemeMode.system
                //         ? Colors.grey[850]?.withOpacity(0.9)
                //         : Colors.grey[30]?.withOpacity(0.9),
                //
                //     leading:
                //
                //     ExtendedImage.network(
                //       recentlyPlayed.thumbs.first.toString(),
                //
                //       fit: BoxFit.cover,
                //       cache: false,
                //       shape: BoxShape.rectangle,
                //       borderRadius: BorderRadius.circular(5),
                //     ),
                //       title: Text(recentlyPlayed.title,maxLines: 1,overflow: TextOverflow.ellipsis,),
                //     subtitle: Text(recentlyPlayed.author.join(" "),maxLines: 1,overflow: TextOverflow.ellipsis,),
                // ),
                );
          },
        ));
  }
}
