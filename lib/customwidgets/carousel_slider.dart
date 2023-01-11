import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CarouselSlider extends StatefulWidget {
  final List data;
  const CarouselSlider({super.key, required this.data});

  @override
  _CarouselSliderState createState() => new _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  late PageController controller;
  int currentPage = 0;

  @override
  initState() {
    super.initState();
    controller = PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 1.0,
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PageView.builder(
          itemCount: widget.data.length,
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
            controller: controller,
            itemBuilder: (context, index) => builder(index)),
      ),
    );
  }

  builder(int index) {

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 1.0;
        if (controller.position.haveDimensions) {
          value = (controller.page! - index)!;
          value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * 300,
            width: Curves.easeOut.transform(value) * 450,
            child: child,
          ),
        );
      },


              child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  //clipBehavior: Clip.antiAlias,
                  child: ExtendedImage.network(
                    widget.data[index]['image'].toString(),
                    fit: BoxFit.cover,
                    cache: true,

                    clearMemoryCacheIfFailed: true,
                    // filterQuality: fluent.FilterQuality.medium,
                  )),
    );
  }
}