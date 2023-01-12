import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasources/audiofiles/playback.dart';
import '../theme.dart';

// class FloatingSlider extends ConsumerWidget {
//   const FloatingSlider({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return fluent.Flyout(
//       child: SliderTheme(
//         data: SliderThemeData(
//             activeTrackColor: ref.watch(themeProvider).color,
//             thumbColor: ref.watch(themeProvider).color),
//         child: Slider(
//             value: ref.watch(audioControlCentreProvider).volume,
//             min: 0.0,
//             max: 100,
//             //divisions: 30,
//             onChanged: (volume) {
//               ref.read(audioControlCentreProvider).setVolume(volume);
//             }),
//       ),
//       content: ,
//     );
//   }
// }
