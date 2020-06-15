#import "OtpConsentPlugin.h"
#if __has_include(<otp_consent/otp_consent-Swift.h>)
#import <otp_consent/otp_consent-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "otp_consent-Swift.h"
#endif

@implementation OtpConsentPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOtpConsentPlugin registerWithRegistrar:registrar];
}
@end
