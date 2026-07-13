
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../extens/constants.dart';
import 'custom_button.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (S) {
        // Get.offAll(SplashView());
      },
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off_outlined, size: 100),
            20.ph,
            const Text("Internet Unavailable"),
            20.ph,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7),
              child: CustomButton(loading: false,
                  onPressed: () {
                  },
                  title: "Retry"),
            ),
            20.ph,
            ElevatedButton(
              onPressed: (){},
              //onPressed: () =>
                  // AppSettings.openAppSettings(type: AppSettingsType.wifi),
              child: const Text('Open Network Settings'),
            )
          ],
        )),
      ),
    );
  }
}
