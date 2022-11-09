import 'dart:async';

import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetCheckerController extends GetxController {
  bool isInternet = true;
  late bool internet;
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void onInit() {
    internetCheck().then((value) {
      isInternet = false;
      update();
      connectionOnChange();
    });
    super.onInit();
  }

  Future internetCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print("I am connected to a mobile network.");
      internet = true;
    } else {
      internet = false;
    }
  }

  connectionOnChange() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        print("I am connected to a mobile network.");
        internet = true;
        update();
      } else {
        print(" I am connected to a wifi network.");
        internet = false;
        update();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    subscription.cancel();
  }
}
