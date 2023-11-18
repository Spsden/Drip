import 'package:flutter/material.dart';

// class TopResults extends StatelessWidget {
//   const TopResults({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  FluentCard();
//   }
// }

class TopResultType {
  final String title;
  final String? description;
  final String? someId;
  final List<String?> thumbs;

  TopResultType({
    required this.title,
    this.description,
    this.someId,
    required this.thumbs,
  });
}

class TopResults extends StatelessWidget {
  const TopResults({super.key, required this.topResult});

  final TopResultType topResult;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: const Color(0x55000000),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    topResult.thumbs.last ?? "https://upload.wikimedia.org/wikipedia/en/3/39/The_Weeknd_-_Starboy.png",
                    // width: MediaQuery.of(context).size.width /3,
                    height: MediaQuery.of(context).size.height / 3.5,

                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topResult.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        'Description goes here. This is a placeholder for the card content.',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              ],
            ),
            // Text(
            //   'Title',
            //   style: TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.blue,
            //   ),
            // ),
            // Text(
            //   'Description goes here. This is a placeholder for the card content.',
            //   style: TextStyle(fontSize: 16),
            // ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Button tapped
            //     },
            //     child: Text(
            //       'ACTION',
            //       style: TextStyle(color: Colors.blue),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
