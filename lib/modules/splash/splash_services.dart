import 'package:firebase_auth/firebase_auth.dart';
import '../../routes/app_route_constant.dart';

class SplashServices {
  Future<String> getInitialRoute() async {
    final user = FirebaseAuth.instance.currentUser;

    await Future.delayed(const Duration(seconds: 3));

    return user != null
        ? MyAppRouteConstants.homeRouteName
        : MyAppRouteConstants.loginRouteName;
  }
}