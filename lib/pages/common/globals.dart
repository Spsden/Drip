
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

import 'package:image/image.dart' as imageLib;
import 'package:palette_generator/palette_generator.dart';

import '../../datasources/audiofiles/activeaudiodata.dart';
import '../../theme.dart';

class Globals{
  //
  // Future<Color?> getColor(BuildContext context) async{
  //   final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage( context.watch<ActiveAudioData>().thumbnailLarge.toString())
  //   );
  //
  //   AppTheme().albumArtColor = paletteGenerator.dominantColor!.color;
  //
  //   // audioPlayerBarColor =
  //
  //
  //   return paletteGenerator.dominantColor?.color;
  // }

  static Future<Color> colorGenerator(String imageUrl)async {
   
    PaletteGenerator paletteGenerator;
    paletteGenerator = await PaletteGenerator.fromImageProvider(ExtendedNetworkImageProvider(imageUrl));
    Color dominantColor = paletteGenerator.dominantColor?.color ?? AppTheme().color;
    //AppTheme().albumArtColor = dominantColor;
    if (dominantColor.computeLuminance() > 0.6) {
      Color contrastColor =
          paletteGenerator.darkMutedColor?.color ?? Colors.black;
      if (dominantColor == contrastColor) {
        contrastColor = paletteGenerator.lightMutedColor?.color ?? Colors.white;
      }
      if (contrastColor.computeLuminance() < 0.6) {
        dominantColor = contrastColor;
      }
    }
   // AppTheme().al;
   // print(dominantColor.value.toString());
     AppTheme().albumArtColor = dominantColor;

    print('cpmes here');

    return dominantColor;
  }

}




// const String keyPalette = 'palette';
// const String keyNoOfItems = 'noIfItems';
//
// int noOfPixelsPerAxis = 12;
//
// Color getAverageColor(List<Color> colors) {
//   int r = 0, g = 0, b = 0;
//
//   for (int i = 0; i < colors.length; i++) {
//     r += colors[i].red;
//     g += colors[i].green;
//     b += colors[i].blue;
//   }
//
//   r = r ~/ colors.length;
//   g = g ~/ colors.length;
//   b = b ~/ colors.length;
//
//   return Color.fromRGBO(r, g, b, 1);
// }
//
// Color abgrToColor(int argbColor) {
//   int r = (argbColor >> 16) & 0xFF;
//   int b = argbColor & 0xFF;
//   int hex = (argbColor & 0xFF00FF00) | (b << 16) | r;
//   return Color(hex);
// }
//
// List<Color> sortColors(List<Color> colors) {
//   List<Color> sorted = [];
//
//   sorted.addAll(colors);
//   sorted.sort((a, b) => b.computeLuminance().compareTo(a.computeLuminance()));
//
//   return sorted;
// }
//
// List<Color> generatePalette(Map<String, dynamic> params) {
//   List<Color> colors = [];
//   List<Color> palette = [];
//
//   colors.addAll(sortColors(params[keyPalette]));
//
//   int noOfItems = params[keyNoOfItems];
//
//   if (noOfItems <= colors.length) {
//     int chunkSize = colors.length ~/ noOfItems;
//
//     for (int i = 0; i < noOfItems; i++) {
//       palette.add(
//           getAverageColor(colors.sublist(i * chunkSize, (i + 1) * chunkSize)));
//     }
//   }
//
//   return palette;
// }
//
// List<Color> extractPixelsColors(Uint8List? bytes) {
//   List<Color> colors = [];
//
//   List<int> values = bytes!.buffer.asUint8List();
//   imageLib.Image? image = imageLib.decodeImage(values);
//
//   List<int?> pixels = [];
//
//   int? width = image?.width;
//   int? height = image?.height;
//
//   int xChunk = width! ~/ (noOfPixelsPerAxis + 1);
//   int yChunk = height! ~/ (noOfPixelsPerAxis + 1);
//
//   for (int j = 1; j < noOfPixelsPerAxis + 1; j++) {
//     for (int i = 1; i < noOfPixelsPerAxis + 1; i++) {
//       int? pixel = image?.getPixel(xChunk * i, yChunk * j);
//       pixels.add(pixel);
//       colors.add(abgrToColor(pixel!));
//     }
//   }
//
//   return colors;
// }
//
//
//
//
