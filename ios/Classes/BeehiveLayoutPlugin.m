#import "BeehiveLayoutPlugin.h"
#if __has_include(<beehive_layout/beehive_layout-Swift.h>)
#import <beehive_layout/beehive_layout-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "beehive_layout-Swift.h"
#endif

@implementation BeehiveLayoutPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBeehiveLayoutPlugin registerWithRegistrar:registrar];
}
@end
