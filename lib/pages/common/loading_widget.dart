import 'package:drip/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

Widget loadingWidget(BuildContext context) {
  return LoadingAnimationWidget.staggeredDotsWave(color: context.watch<AppTheme>().color, size: 150);
}