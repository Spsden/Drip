import 'package:flutter/material.dart';
class DripPlaceHolder extends StatelessWidget {
  const DripPlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      
      width: double.infinity,
      height: double.infinity,
      child: Image.asset('assets/driprec.png'),
    );
  }
}
