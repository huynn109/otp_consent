import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:otp_consent/otp_consent.dart';

void main() => runApp(MaterialApp(home: MyApp(),));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>  {

  @override
  void initState() {
    super.initState();
    OtpConsent().startListening();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin otp consent example app'),
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                MaterialButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: Text('Start Listening'),
                  onPressed: () async {
                    OtpConsent().startListening();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void smsReceived(String sms) {
    log('smsReceived $sms');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
