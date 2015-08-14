#import <Cordova/CDV.h>
#import "HKWControlHandler.h"
#import "GlobalConstraints.h"
#import "HKWDeviceEventHandlerSingleton.h"
#import "HKWPlayerEventHandlerSingleton.h"

@interface HKAudio : CDVPlugin <HKWDeviceEventHandlerDelegate>{

}


//Cordova Methods
- (void) greet:(CDVInvokedUrlCommand*)command;
- (void) startRefreshDeviceInfo:(CDVInvokedUrlCommand*)command;
- (void) stopRefreshDeviceInfo:(CDVInvokedUrlCommand*)command;
- (void) getGroupCount:(CDVInvokedUrlCommand*)command;

//Methods
-(void)  initializeHKWController;

@property(nonatomic, retain) UIAlertController* alertInitializing;


@end