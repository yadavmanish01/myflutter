import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myflutter/modules/splash/splash_services.dart';

class Splashview extends StatefulWidget {
  const Splashview({super.key});

  @override
  State<Splashview> createState() => _SplashviewState();
}


class _SplashviewState extends State<Splashview> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    navigate();
  }

  Future<void> navigate() async {
    final route = await SplashServices().getInitialRoute();

    if (!mounted) return;

    context.goNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/myflutterlogo.png")
      ),
    );
  }
}
