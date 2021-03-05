import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_local_authentication/flutter_local_authentication.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _supportsAuthentication = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool supportsLocalAuthentication = false;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      supportsLocalAuthentication =
          await FlutterLocalAuthentication.supportsAuthentication;
    } on PlatformException {
      supportsLocalAuthentication = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _supportsAuthentication = supportsLocalAuthentication;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child:
              Text('Supports Local Authentication: $_supportsAuthentication\n'),
        ),
      ),
    );
  }
}