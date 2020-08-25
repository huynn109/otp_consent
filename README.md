# otp_consent

Flutter plugin to provide SMS User Consent API gives the content of a single SMS message to us if the user gives permission.
For Android, that's where this package is useful. No need for iOS

## Getting Started

SMS need to follow some rules as describe here
- Contains one-time code
- 4-10 digit alphanumeric with one number
- Not from contact

### Usage

```dart
import 'import package:otp_consent/otp_consent.dart';
```
Extend OtpConsentAutoFill mixin that will offer you:
- startOtpConsent(): to listen SMS code from the native
- stopOtpConsent(): to stop listen broadcast receiver from native
- smsReceived(sms): call get value otp when the sms is received. 
- sms: get sms code received

