import 'dart:async';
import 'dart:io';

import 'package:drip/pages/explore_page/explorepage.dart';
import 'package:drip/providers/providers.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../datasources/audiofiles/activeaudiodata.dart';
import '../../datasources/audiofiles/playback.dart';

class TrendingHeader extends ConsumerStatefulWidget {
  final List headList;

  const TrendingHeader({Key? key, required this.headList}) : super(key: key);

  @override
  ConsumerState<TrendingHeader> createState() => _TrendingHeaderState();
}

class _TrendingHeaderState extends ConsumerState<TrendingHeader> {
  int _currentPage = 0;
  late Timer _timer;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  int indx = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        PageView.builder(
            controller: _pageController,
            itemCount: headList.length,
            itemBuilder: (context, index) {
              return GestureDetector(

                onTap: () {
                  print(headList[index]['videoId']);
                  CurrentMusicInstance currentMusicInstance =
                      CurrentMusicInstance(
                          title: headList[index]['title'],
                          author: ['NA'],
                          thumbs: [
                            headList[index]['image'],
                            headList[index]['imageMedium']
                          ],
                          urlOfVideo: 'NA',
                          videoId: headList[index]['videoId']);
                  ref
                      .read(audioControlCentreProvider)
                      .open(currentMusicInstance);
                  // ref.read(searchQueryProvider.notifier).state = headList[index]['title'];
                  // ref.read(currentPageIndexProvider.notifier).state = 1;
                },
                child: ShaderMask(
                    blendMode: BlendMode.luminosity,
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black])
                          .createShader(bounds);
                    },
                    child: widget.headList.isEmpty
                        ? FadeInImage(
                            placeholder: const AssetImage('assets/driprec.png'),
                            width: size.width,
                            height: size.height,
                            fit: BoxFit.cover,
                            image: const AssetImage('assets/driprec.png'))
                        : Stack(
                            children: [
                              Positioned.fill(
                                child: ExtendedImage.network(
                                  widget.headList[index]['image'],
                                  cache: true,
                                  fit: BoxFit.cover,
                                  clearMemoryCacheIfFailed: true,
                                ),
                              ),
                              Positioned.fill(
                                left: 10,
                                top: 150,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: SizedBox(
                                      width: size.width / 2.5,
                                      child: Text(
                                        headList[index]['title'],
                                        style: const TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.w600),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                ),
                              )
                            ],
                          )),
              );
            }),
      ],
    );
  }
}
