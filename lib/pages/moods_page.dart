import 'package:drip/datasources/searchresults/moods_data_class.dart';
import 'package:drip/datasources/searchresults/searchresultsservice.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

import '../theme.dart';

class MoodsAndCategories extends StatefulWidget {
  const MoodsAndCategories({Key? key}) : super(key: key);

  @override
  _MoodsAndCategoriesState createState() => _MoodsAndCategoriesState();
}

class _MoodsAndCategoriesState extends State<MoodsAndCategories> {
  late MoodsCategories _moodsCategories;

  bool fetched = false;
  bool status = false;
  RandomColor _randomColor = RandomColor();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Typography typography = FluentTheme.of(context).typography;
    const spacer = SizedBox(height: 10.0);
    const biggerSpacer = SizedBox(height: 40.0);
    if (!status) {
      SearchMusic.getMoods().then((value) => {
            if (mounted)
              {
                setState(() {
                  status = true;
                  _moodsCategories = value;
                  fetched = true;
                })
              }
          });
    }
    return (!fetched)
        ? mat.Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
                color: context.watch<AppTheme>().color, size: 150),
          )
        : mat.ListView(
            // controller: _scrollController,
            clipBehavior: Clip.hardEdge,
            primary: false,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.fromLTRB(10, 70, 10, 125),
            children: [
              Text(
                'Moods & moments',
                style: typography.title,
              ),
              spacer,
              GridView.builder(
                  shrinkWrap: true,
                  itemCount: _moodsCategories.moodsMoments?.length,
                  gridDelegate:
                  const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150.0,
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1.5 / 1),
                  itemBuilder: (context, index) => Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(color: Colors.transparent),
                    child: mat.Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: mat.Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _moodsCategories.moodsMoments![index].title
                                  .toString(),
                              style: typography.subtitle?.copyWith(
                                  fontSize: 25,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          )),
                      color: _randomColor.randomColor(),

                    ),
                  )),
              biggerSpacer,


              Text(
                  'Genres',
                  style: typography.title,
                ),
                spacer,
                GridView.builder(
                    shrinkWrap: true,
                    itemCount: _moodsCategories.genres?.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150.0,
                            mainAxisSpacing: 15.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1.5 / 1),
                    itemBuilder: (context, index) => Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: mat.Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: mat.Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _moodsCategories.genres![index].title
                                        .toString(),
                                    style: typography.subtitle?.copyWith(
                                        fontSize: 25,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                )),
                            color: _randomColor.randomColor(),

                          ),
                        )),




              ]);
  }
}
