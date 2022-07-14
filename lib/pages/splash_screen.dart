import 'package:drip/main.dart';
import 'package:drip/pages/common/loading_widget.dart';
import 'package:drip/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as mat;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.pushAndRemoveUntil(
            context,
            mat.MaterialPageRoute(builder: (_) => const MyHomePage()),
                (route) => false));
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: context.watch<AppTheme>().mode ==
          ThemeMode.dark ||
          context.watch<AppTheme>().mode ==
              ThemeMode.system
          ? Colors.grey[150].withOpacity(0.4)
          : Colors.grey[30],
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(


              child: Image.asset(

                  'assets/driplogocircle.png',
              height:MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width/4,),

          ),
          Text('Drip Music'
          ,style: FluentTheme.of(context).typography.title,),
         SizedBox(
           height: 10,
         ),
          
          loadingWidget(context,size: 80)

        ],
      ),
    );


  }
}
