#import <Cordova/CDV.h>
#import "HKWControlHandler.h"
#import "HKWDeviceEventHandlerSingleton.h"
#import "HKWPlayerEventHandlerSingleton.h"

@interface HKAudio : CDVPlugin

- (void) greet:(CDVInvokedUrlCommand*)command;

@end