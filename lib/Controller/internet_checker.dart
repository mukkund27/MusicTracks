import 'dart:async';

import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetCheckerController extends GetxController {
  bool isInternet = false;
  bool firsttime = true;
  late bool internetStatus;
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void onInit() {
    internetCheck().then((value) {
      firsttime = false;
      connectionOnChange();
      update();
    });

    super.onInit();
  }

  Future internetCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isInternet = true;
      internetStatus = true;
      update();
    } else {
      isInternet = false;
      internetStatus = false;
      update();
    }
  }

  connectionOnChange() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        print("I am connected to a mobile network.");
        isInternet = true;
        internetStatus = true;
        update();
      } else {
        print(" I am connected to a wifi network.");
        internetStatus = false;
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
