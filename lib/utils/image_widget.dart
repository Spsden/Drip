import 'dart:ffi';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
     required this.imageUrl,  this.size = const mat.Size(100, 100),  this.cache = false, required this.loadingUrl
  }) : super(key: key);

  final String imageUrl;
  final mat.Size size;
  final bool cache;
  final String loadingUrl;


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
