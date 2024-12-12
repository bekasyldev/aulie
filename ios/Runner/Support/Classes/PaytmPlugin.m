#import "PaytmPlugin.h"
//#import <paytm/paytm-Swift.h>
#import <Runner-Swift.h>

@implementation PaytmPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [SwiftPaytmPlugin registerWithRegistrar:registrar];
    
    
    
}
@end
