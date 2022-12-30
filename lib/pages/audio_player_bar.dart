// import 'package:drip/datasources/audiofiles/audiocontrolcentre.dart';
// import 'package:drip/theme.dart';
// import 'package:drip/utils/responsive.dart';
// import 'package:extended_image/extended_image.dart';
// import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart' as mat;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:provider/provider.dart';
//
// import '../datasources/audiofiles/playback.dart';
//
// class BottomBar extends StatefulWidget {
//   const BottomBar({Key? key}) : super(key: key);
//
//   @override
//   State<BottomBar> createState() => _BottomBarState();
// }
//
// class _BottomBarState extends State<BottomBar>
//     with AutomaticKeepAliveClientMixin<BottomBar> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: (Responsive.isMobile(context)) ? 80 : 100,
//       //width: mat.MediaQuery.of(context).size.width - 20,
//       child: mat.Material(
//           color: Colors.transparent,
//           elevation: 10,
//           shadowColor: mat.Colors.black26,
//           child: (Responsive.isMobile(context))
//               ? _mobileNavbar(context)
//               : Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Flexible(
//                       flex: 1,
//                       child: _label(context),
//                     ),
//                     Flexible(
//                       flex: 1,
//                       child: _buttons(context),
//                     ),
//                     VolumeControl()
//                     // Flexible(flex: 1, child: VolumeControl())
//                   ],
//                 )),
//     );
//   }
//
//   @override
//   // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => true;
// }
//
// class VolumeControl extends ConsumerStatefulWidget {
//   const VolumeControl({Key? key}) : super(key: key);
//
//   @override
//   _VolumeControlState createState() => _VolumeControlState();
// }
//
// class _VolumeControlState extends ConsumerState<VolumeControl> {
//   bool volIcon = true;
//   double bufferValue = 0.0;
//
//   @override
//   Widget build(BuildContext context) {
//     return mat.Material(
//       color: Colors.transparent,
//       child: Row(
//         children: [
//           mat.IconButton(
//             icon: volIcon
//                 ? const Icon(mat.Icons.volume_up)
//                 : const Icon(mat.Icons.volume_mute),
//             iconSize: 25,
//             onPressed: () {
//               if (volIcon) {
//                AudioControlCentre.audioControlCentre.setVolume(0.0);
//                 setState(() {
//                   volIcon = !volIcon;
//                 });
//               } else if (!volIcon) {
//                 AudioControlCentre.audioControlCentre.setVolume(0.4);
//                 setState(() {
//                   volIcon = !volIcon;
//                 });
//               }
//             },
//           ),
//           SizedBox(
//               width: 150,
//               child: SizedBox(
//                 width: 100,
//                 child: mat.SliderTheme(
//                   data: mat.SliderThemeData(
//                       activeTrackColor: ref.watch(themeProvider).color,
//                       thumbColor: ref.watch(themeProvider).color),
//                   child: Slider(
//                       value: ref.watch(playBackProvider).volume,
//                       min: 0.0,
//                       max: 1.0,
//                       //divisions: 30,
//                       onChanged: (volume) {
//                         AudioControlCentre.audioControlCentre.setVolume(volume);
//
//                         //AudioPlayerControlsModel.volume(volume);
//                       }),
//                 ),
//               )),
//           const SizedBox(
//             width: 30,
//           )
//         ],
//       ),
//     );
//   }
// }
//
// Widget _buttons(BuildContext context) {
//   double smallIcons = MediaQuery.of(context).size.width > 550 ? 30 : 25;
//   double largeIcons = MediaQuery.of(context).size.width > 550 ? 40 : 30;
//
//   //final selected = context.watch<CurrentTrackModel>().selected;
//   return mat.Material(
//     color: Colors.transparent,
//     child: Row(
//       children: [
//         mat.IconButton(
//           icon: const Icon(mat.Icons.shuffle_rounded),
//           iconSize: smallIcons,
//           onPressed: () async {
//             //tracklist.value.shuffle();
//             //SearchMusic.getWatchPlaylist(videoId, limit)
//           },
//         ),
//         mat.IconButton(
//           icon: const Icon(mat.Icons.skip_previous),
//           iconSize: smallIcons,
//           onPressed: () {
//             // print(Music().filePath.toString());
//             AudioControlCentre.audioControlCentre.prev();
//           },
//         ),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: context.watch<AppTheme>().color.toAccentColor(),
//               width: 3.0,
//             ),
//             borderRadius: BorderRadius.circular(largeIcons),
//           ),
//           child: Stack(
//             children: [
//               AudioControlCentre.audioControlCentre.isPlaying
//                   ? mat.IconButton(
//                       splashRadius: 30,
//                       hoverColor: context.watch<AppTheme>().color,
//                       icon: const Icon(mat.Icons.play_arrow),
//                       iconSize: largeIcons,
//                       onPressed: ()=> AudioControlCentre.audioControlCentre.play(),
//                     )
//                   : mat.IconButton(
//                       splashRadius: 30,
//                       hoverColor: context.watch<AppTheme>().color,
//                       icon: const Icon(mat.Icons.pause),
//                       iconSize: largeIcons,
//                       onPressed: ()=> AudioControlCentre.audioControlCentre.pause(),
//                     ),
//               AudioControlCentre.audioControlCentre.isBuffering
//                   ? Container(
//                       margin: const EdgeInsets.all(8.0),
//                       width: largeIcons,
//                       height: largeIcons,
//                       child: const mat.CircularProgressIndicator(),
//                     )
//                   : const SizedBox.shrink()
//             ],
//           ),
//         ),
//         mat.IconButton(
//           icon: const Icon(mat.Icons.skip_next),
//           iconSize: smallIcons,
//           onPressed: () {
//                 AudioControlCentre.audioControlCentre.next();
//
//           },
//         ),
//         mat.IconButton(
//           icon: const Icon(mat.Icons.repeat),
//           iconSize: smallIcons,
//           onPressed: () {
//
//             print("tapped");
//
//
//           },
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _mobileNavbar(BuildContext context) {
//   return mat.InkWell(
//     borderRadius: const BorderRadius.only(
//       topLeft: Radius.circular(50),
//       topRight: Radius.circular(50),
//     ),
//     onTap: () {},
//     child: Row(
//       children: [
//         Flexible(flex: 1, child: _label(context)),
//         Flexible(
//           flex: 1,
//           child: _buttons(context),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _label(BuildContext context) {
//   final audioControlCentre = AudioControlCentre.audioControlCentre;
//   return Row(
//     children: [
//       SizedBox(width: 20),
//       ExtendedImage.network(
//         audioControlCentre.tracks
//             .elementAt(audioControlCentre.index)
//             .thumbnail!
//             .last
//             .url,
//         //listOfUpNextNotifier.value[context.read<AudioControls>().currentIndex]["thumbs"][1].url.toString(),
//         width: MediaQuery.of(context).size.width > 500 ? 70 : 0,
//         height: MediaQuery.of(context).size.height > 500 ? 70 : 0,
//         fit: BoxFit.cover,
//         cache: false,
//         shape: BoxShape.rectangle,
//         borderRadius: BorderRadius.circular(8),
//         loadStateChanged: (ExtendedImageState state) {
//           switch (state.extendedImageLoadState) {
//             case LoadState.loading:
//               return const Image(
//                   fit: BoxFit.cover, image: AssetImage('assets/cover.jpg'));
//               break;
//
//             case LoadState.completed:
//               // _controller.forward();
//               return ExtendedRawImage(
//                 image: state.extendedImageInfo?.image,
//                 width: MediaQuery.of(context).size.width > 500 ? 70 : 0,
//                 height: MediaQuery.of(context).size.height > 500 ? 70 : 0,
//                 fit: BoxFit.cover,
//                 // cache: false,
//                 // shape: BoxShape.rectangle,
//                 // borderRadius: BorderRadius.circular(8),
//               );
//
//             case LoadState.failed:
//               //_controller.reset();
//               return GestureDetector(
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: <Widget>[
//                     Image.asset(
//                       "assets/driprec.png",
//                       fit: BoxFit.fill,
//                     ),
//                   ],
//                 ),
//                 onTap: () {
//                   state.reLoadImage();
//                 },
//               );
//               break;
//           }
//         },
//       ),
//       SizedBox(width: 15),
//       Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               audioControlCentre.tracks
//                   .elementAt(audioControlCentre.index)
//                   .title ?? 'NA'
//                   ,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             SizedBox(height: 5),
//             Text(
//               audioControlCentre.tracks
//                   .elementAt(audioControlCentre.index)
//                   .artists!.first.name ?? 'NA',
//
//
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//       const SizedBox(width: 20),
//     ],
//   );
// }
