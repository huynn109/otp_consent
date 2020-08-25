import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:otp_consent/otp_consent.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with OtpConsentAutoFill {
  var otpConsent = OtpConsent();

  @override
  void initState() {
    super.initState();
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
                    startOtpConsent();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void smsReceived(String sms) {
    log('smsReceived $sms');
    log('parsed ${this.sms}');
  }

  @override
  void dispose() {
    stopOtpConsent();
    super.dispose();
  }
}
