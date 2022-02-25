
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../datasources/audiofiles/activeaudiodata.dart';
import '../../theme.dart';

class Globals{

  Future<Color?> getColor(BuildContext context) async{
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(NetworkImage( context.watch<ActiveAudioData>().thumbnailLarge.toString())
    );

    AppTheme().albumArtColor = paletteGenerator.dominantColor!.color;

    // audioPlayerBarColor =


    return paletteGenerator.dominantColor?.color;
  }

}



//final ValueNotifier<BuildContext> navContext = ValueNotifier<BuildContext>();

//  class PopNavigationService{
//
//   BuildContext navigationContext = BuildContext();
//
//   final ValueNotifier<BuildContext> navContext = ValueNotifier<BuildContext>();
//
//
// }