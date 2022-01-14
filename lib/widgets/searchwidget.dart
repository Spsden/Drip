import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final TextEditingController textcontroller;
  final Widget? leading;
  final bool textErase;
  final String? hintText;
  final Function(String) onSubmitted;

  const SearchWidget({
    Key? key,
    required this.textcontroller,
    this.leading,
    this.textErase = true,
    this.hintText,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String tempQuery = '';
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          shadowColor: Colors.black26,
          margin: const EdgeInsets.fromLTRB(18, 7, 18, 7),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Colors.black,
          elevation: 5.0,
          child: SizedBox(
            height: 50,
            width: 450.0,
            child: Center(
              child: TextField(
                controller: widget.textcontroller,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  fillColor: Colors.black54,
                  prefixIcon: widget.leading,
                  suffixIcon: widget.textErase
                      ? IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () => {
                            widget.textcontroller.text = '',
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  hintText: widget.hintText,
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (searchText) {
                  if (searchText.trim() != '') {
                    query = searchText;
                    widget.onSubmitted(searchText);
                  }
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
