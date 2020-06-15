import 'dart:async';

import 'package:flutter/services.dart';

class OtpConsent {
  static OtpConsent _singleton;
  static const MethodChannel _channel = const MethodChannel('otp_consent');
  final StreamController<String> _smsController = StreamController.broadcast();

  factory OtpConsent() => _singleton ??= OtpConsent._();

  OtpConsent._() {
    _channel.setMethodCallHandler(_handleMethod); // Set callback from native
  }

  Stream<String> get sms => _smsController.stream;

  Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<bool> get startListening async {
    final bool startListening = await _channel.invokeMethod('startListening');
    return startListening;
  }

  Future<bool> get stopListening async {
    final bool stopListening = await _channel.invokeMethod('stopListening');
    return stopListening;
  }

  Future<dynamic> _handleMethod(MethodCall methodCall) async {
    switch (methodCall.method) {
      case "onSmsConsentReceived":
        _smsController.add(methodCall.arguments);
        break;
      case "onTimeout":
        break;
      case "onSmsConsentPermissionDenied":
        break;
      case "onShowPermissionDialog":
        break;
      case "onStopListener":
        break;
    }
  }
}

mixin OtpConsentAutoFill {
  final OtpConsent _otpConsent = OtpConsent();
  String sms;
  StreamSubscription _subscription;

  Future<void> startSmsListening() async {
    _subscription?.cancel();
    _subscription = _otpConsent.sms.listen((sms) {
      this.sms = sms;
      smsReceived(sms);
    });
    await _otpConsent.startListening;
  }

  Future<void> stopSmsListen() async {
    await _otpConsent.stopListening;
  }

  void cancel() {
    _subscription?.cancel();
  }

  void smsReceived(String sms);
}
