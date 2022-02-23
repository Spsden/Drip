import 'package:drip/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:provider/provider.dart';

class FloatingBackButton extends StatelessWidget {
  const FloatingBackButton({Key? key, required this.onPressed}) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return mat.FloatingActionButton.small( backgroundColor: context.watch<AppTheme>().color,
        child: const Icon(FluentIcons.back),
        onPressed: () async{
          await onPressed();
        });
  }
}


class CustomBack extends StatelessWidget {
  const CustomBack({Key? key, required this.thisContext}) : super(key: key);
  final BuildContext thisContext;

  @override
  Widget build(BuildContext context) {
    return mat.BackButton(
      onPressed: () {Navigator.maybePop(thisContext);},
    );
  }
}



