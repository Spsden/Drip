import 'package:flutter/material.dart';

Widget noResult(
  //BuildContext context,
  String texthere,
) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox.square(
          //dimension: 300,
          child: Text(
            '$texthere',
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 20,
            ),
          ),
        )
      ],
    ),
  );
}
