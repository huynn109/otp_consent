import 'package:flutter/material.dart';
import 'package:otp_consent/otp_consent.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with OtpConsentAutoFill {
  String? otp;
  bool startListen = false;

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
                  child: Text(startListen ? 'Started' : 'Start Listening'),
                  onPressed: () async {
                    var startListen = await startOtpConsent();
                    setState(() {
                      this.startListen = startListen;
                    });
                  },
                ),
                Text(otp ?? ""),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void smsReceived(String? sms) {
    setState(() {
      otp = sms;
      startListen = false;
    });
  }
}
