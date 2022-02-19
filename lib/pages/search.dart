import 'package:drip/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart' as mat;

class SearchFunction extends StatefulWidget {
  final bool liveSearch;
  final Widget body;

  //final String ancestor;
  final FloatingSearchBarController controller;
  final Function(String) onSubmitted;

  const SearchFunction({
    Key? key,
    required this.liveSearch,
    required this.body,
    required this.controller,
    required this.onSubmitted,
    //required this.ancestor,
  }) : super(key: key);

  @override
  _SearchFunctionState createState() => _SearchFunctionState();
}

class _SearchFunctionState extends State<SearchFunction>
    with AutomaticKeepAliveClientMixin<SearchFunction> {
  static const _historyLength = 5;

  final List<String> _searchHistory = ['Atif', 'Arijit', 'Sonu', 'Prateek'];
  late List<String> filteredSearchHistory;
  String selectedTerm = '';

  List<String> filterSearchTerms({
    required String filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      // Reversed because we want the last added items to appear first in the UI
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      // This method will be implemented soon
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > _historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - _historyLength);
    }
    // Changes in _searchHistory mean that we have to update the filteredSearchHistory
    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  late FloatingSearchBarController floatController;

  @override
  void initState() {
    // selectedTerm = '';
    super.initState();
    filteredSearchHistory = filterSearchTerms(filter: '');
    floatController = FloatingSearchBarController();
  }

  @override
  void dispose() {
    floatController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return mat.Scaffold(
      body: FloatingSearchBar(
        height: 45,
        axisAlignment: -0.9,
        accentColor: context.watch<AppTheme>().color.withOpacity(0.2),
        debounceDelay: const Duration(milliseconds: 500),
        clearQueryOnClose: false,
       // progress: true,






        leadingActions: [
          Navigator.of(context)
          .context
          .findAncestorStateOfType<NavigatorState>()
          !.canPop()
              ?
              IconButton(
                  icon: const Icon(FluentIcons.back),
                  onPressed: () => Navigator.of(context)
                      .context
                      .findAncestorStateOfType<NavigatorState>()
                      ?.pop()) :const SizedBox()
        ],

        width: MediaQuery.of(context).size.width / 2,
        border: BorderSide(
            color: context.watch<AppTheme>().color,
            width: 2,
            style: BorderStyle.none),
        borderRadius: BorderRadius.circular(8),
        margins: const EdgeInsets.only(top: 10),
        //axisAlignment: -1,

        // width: MediaQuery.of(context).size.width *1/2,
        // openWidth: MediaQuery.of(context).size.width  ,
        transitionCurve: Curves.easeInOutCubic,
        transitionDuration: const Duration(milliseconds: 200),
        controller: widget.controller,
        body: widget.body,

        transition: CircularFloatingSearchBarTransition(),
        physics: const BouncingScrollPhysics(),
        title: Text(selectedTerm),
        hint: "Let's Play.....",
        actions: [

          // FloatingSearchBarAction.()


          FloatingSearchBarAction.searchToClear(


          )
        ],
        onQueryChanged: (query) {
          setState(() {
           //for liveSearch//
            selectedTerm = query;
            widget.onSubmitted(query);



            filteredSearchHistory = filterSearchTerms(filter: query);
          });
        },
        onSubmitted: (query) async {
          // selectedTerm = query;
          // widget.onSubmitted(query);

          setState(() {
            selectedTerm = query;
            widget.onSubmitted(query);
            addSearchTerm(query);
          });
          //await getPrimarySearchResults(selectedTerm);

          //addSearchTerm(query);


          floatController.close();
        },
        builder: (BuildContext context, Animation<double> transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: mat.Material(
              // color: Colors.white,
              elevation: 4,
              child: mat.Builder(
                builder: (context) {
                  if (filteredSearchHistory.isNotEmpty &&
                      floatController.query.isEmpty) {
                    return mat.Container(
                      //height: 50,
                      width: double.infinity,
                      decoration: mat.BoxDecoration(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: filteredSearchHistory
                            .map(
                              (term) => mat.ListTile(
                            title: Text(
                              term,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: const Icon(mat.Icons.history),
                            trailing: IconButton(
                              icon: const Icon(mat.Icons.clear),
                              onPressed: () {
                                setState(() {
                                  deleteSearchTerm(term);
                                });
                              },
                            ),
                            onTap: () async {
                              setState(() {
                                widget.controller.query = term;


                                putSearchTermFirst(term);
                               // selectedTerm = term;

                              });
                              floatController.close();
                            },
                          ),
                        )
                            .toList(),
                      )
                    );
                  } else if (filteredSearchHistory.isEmpty) {
                    return mat.ListTile(
                      title: Text(floatController.query),
                      leading: const Icon(FluentIcons.search),
                      onTap: () {
                        setState(() {
                          addSearchTerm(floatController.query);
                          selectedTerm = floatController.query;
                        });
                        floatController.close();
                      },
                    );
                  } else {
                    return const SizedBox();
                    // return Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: filteredSearchHistory
                    //       .map(
                    //         (term) => mat.ListTile(
                    //           title: Text(
                    //             term,
                    //             maxLines: 1,
                    //             overflow: TextOverflow.ellipsis,
                    //           ),
                    //           leading: Icon(mat.Icons.history),
                    //           trailing: IconButton(
                    //             icon: const Icon(mat.Icons.clear),
                    //             onPressed: () {
                    //               setState(() {
                    //                 deleteSearchTerm(term);
                    //               });
                    //             },
                    //           ),
                    //           onTap: () {
                    //             setState(() {
                    //               putSearchTermFirst(term);
                    //               selectedTerm = term;
                    //             });
                    //             floatController.close();
                    //           },
                    //         ),
                    //       )
                    //       .toList(),
                    // );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  const SearchResultsListView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      return mat.Material(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              mat.Icon(
                mat.Icons.search,
                size: 64,
              ),
              Text(
                'Start searching',
                // style: Theme.of(context).textTheme.headline5,
              )
            ],
          ),
        ),
      );
    }

    return ListView(
      children: List.generate(
        50,
        (index) => ListTile(
          title: Text('$searchTerm search result'),
          subtitle: Text(index.toString()),
        ),
      ),
    );
  }
}
