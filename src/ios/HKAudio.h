#import <Cordova/CDVPlugin.h>
#import <Cordova/CDV.h>
#import "HKWControlHandler.h"
#import "GlobalContraints.h"
#import "HKWDeviceEventHandlerSingleton.h"
#import "HKWPlayerEventHandlerSingleton.h"

@interface HKAudio : CDVPlugin <HKWDeviceEventHandlerDelegate, HKWPlayerEventHandlerDelegate>{

}

//Cordova Methods
- (void) start:(CDVInvokedUrlCommand*)command;
- (void) getActiveDeviceCount:(CDVInvokedUrlCommand*)command;

//Refreshing Speaker Information
- (void) startRefreshDeviceInfo:(CDVInvokedUrlCommand*)command;
- (void) stopRefreshDeviceInfo:(CDVInvokedUrlCommand*)command;

//Playback Control
- (void)playCAF:(CDVInvokedUrlCommand*)command;
- (void) isPlaying:(CDVInvokedUrlCommand*)command;
- (void) stop:(CDVInvokedUrlCommand*)command;
- (void) pause:(CDVInvokedUrlCommand*)command;
- (void) setVolume:(CDVInvokedUrlCommand*)command;
- (void) mute:(CDVInvokedUrlCommand*)command;

//Device (Speaker) Management
- (void) getGroupCount:(CDVInvokedUrlCommand*)command;
- (void) removeDeviceFromSession:(CDVInvokedUrlCommand*)command;
- (void) addDeviceToSession:(CDVInvokedUrlCommand*)command;
- (void) getDeviceCount:(CDVInvokedUrlCommand*)command;

//Methods
- (void) initializeHKWController;
- (void) updateDeviceStatus:(long long)deviceId;
- (NSDictionary*) getDeviceInfo:(long long)deviceId;
- (NSDictionary*) getGroupInfo:(long long)deviceId;


@property(nonatomic, retain) UIAlertController* alertInitializing;
@property (strong) NSString* callbackId;


@end
