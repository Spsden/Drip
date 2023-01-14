import 'package:drip/home_screen.dart';

import 'package:fluent_ui/fluent_ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500)).then((value) =>
        Navigator.pushAndRemoveUntil(
            context, _createRoute(), (route) => false));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;


        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/driplogocircle.png',
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 4,
            ),
          ),
          Text(
            'Drip Music',
            style: FluentTheme.of(context).typography.title,
          ),
          const SizedBox(
            height: 10,
          ),
          ProgressRing()

          //        Consumer(
          //          builder: (context,watch,child) {
          //            final value = watch.read(themeProvider).color;
          // return loadingWidget(context,value,size: 80);
          //
          //          },)
        ],
      ),
    );
  }
}
