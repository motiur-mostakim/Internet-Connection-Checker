import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // This will be called whenever the connection changes.
      checkConnection(result);
    });
  }

  void checkConnection(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile) {
      Fluttertoast.showToast(msg: "Connected With Mobile");
    } else if (result == ConnectivityResult.wifi) {
      Fluttertoast.showToast(msg: "Connected With Wifi");
    } else {
      Fluttertoast.showToast(msg: "Not Connected");
    }
  }

  @override
  void dispose() {
    // Cancel the subscription when the widget is disposed.
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () async {
                var connectivityResult =
                    await Connectivity().checkConnectivity();
                checkConnection(connectivityResult);
              },
              child: const Text("Check Connection"))),
    );
  }
}
