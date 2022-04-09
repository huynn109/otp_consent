///
/// It is compatible Android only.
///
import 'dart:async';

import 'package:flutter/services.dart';

///
///
class OtpConsent {
  /// Create instance [OtpConsent] plugin
  static OtpConsent? _singleton;

  factory OtpConsent() => _singleton ??= OtpConsent._();

  OtpConsent._() {
    _channel.setMethodCallHandler(_handleMethod); // Set callback from native
  }

  /// [MethodChannel] used to communicate with the platform side.
  static const MethodChannel _channel = const MethodChannel('otp_consent');
  final StreamController<Map<String, String>> _smsController =
      StreamController.broadcast();

  Stream<Map<String, String>>? get sms => _smsController.stream;

  Future<bool> startListening({String? senderPhoneNumber}) async {
    final bool startListening = await _channel.invokeMethod(
        'startListening', {"senderPhoneNumber": senderPhoneNumber});
    return startListening;
  }

  Future<void> get stopListening async {
    return await _channel.invokeMethod('stopListening');
  }

  Future<dynamic> _handleMethod(MethodCall methodCall) async {
    switch (methodCall.method) {
      case "onSmsConsentReceived":
        Map<String, String> hm = {
          'sms': methodCall.arguments['sms'],
          'smsParsed': methodCall.arguments['smsParsed']
        };
        _smsController.add(hm);
        break;
    }
  }
}

mixin OtpConsentAutoFill {
  final OtpConsent? _otpConsent = OtpConsent();
  String? sms;
  StreamSubscription? _subscription;

  Future<bool> startOtpConsent({String? senderPhoneNumber}) async {
    _subscription?.cancel();
    _subscription = _otpConsent?.sms?.listen((sms) {
      this.sms = sms['sms'];
      smsReceived(sms['smsParsed']);
    });
    var startListening =
        await _otpConsent?.startListening(senderPhoneNumber: senderPhoneNumber);
    return startListening ?? false;
  }

  Future<void> stopOtpConsent() async {
    await _otpConsent?.stopListening;
    _cancel();
  }

  void _cancel() {
    _subscription?.cancel();
  }

  void smsReceived(String? sms);
}
