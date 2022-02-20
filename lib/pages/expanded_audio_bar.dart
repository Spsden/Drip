import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drip/main.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import '../datasources/audiofiles/activeaudiodata.dart';

class ExpandedAudioBar extends StatefulWidget {
  const ExpandedAudioBar({Key? key}) : super(key: key);

  @override
  _ExpandedAudioBarState createState() => _ExpandedAudioBarState();
}

class _ExpandedAudioBarState extends State<ExpandedAudioBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
              child:ShaderMask(
                blendMode: BlendMode.luminosity,
                shaderCallback: (bounds) {
                  return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black])
                      .createShader(bounds);
                },
                child: CachedNetworkImage(

                  fit: BoxFit.cover,
                  errorWidget: (context, _, __) =>
                  const Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/cover.jpg'),
                  ),
                  imageUrl:
                  context.watch<ActiveAudioData>().thumbnailLarge ??

                      'https://rukminim1.flixcart.com/image/416/416/poster/3/r/d/cute-cats-hd-poster-art-bshi4736-bshil4736-large-original-imaehwdptnnqz2sp.jpeg?q=70',
                  placeholder: (context, url) => const Image(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/cover.jpg')),
                ),
              ),
            )
        ),
        const TopBar()
      ],
    );
  }
}
