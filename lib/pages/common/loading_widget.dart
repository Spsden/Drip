
import 'package:fluent_ui/fluent_ui.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget loadingWidget(BuildContext context,Color colour,{double size = 150 }) {
  return LoadingAnimationWidget.staggeredDotsWave(color:colour , size: size);
}