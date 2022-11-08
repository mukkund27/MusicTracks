import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:musicplayer/View/no_connection.dart';

import 'View/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasinternet = false;
  ConnectivityResult result = ConnectivityResult.none;
  @override
  void initState() {
    Connectivity connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((status) {
      if (status == ConnectivityResult.mobile ||
          status == ConnectivityResult.wifi) {
        setState(() {
          hasinternet = true;
        });
      } else {
        setState(() {
          hasinternet = false;
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: hasinternet == true ? const HomePage() : const NoConnection(),
    );
  }
}
