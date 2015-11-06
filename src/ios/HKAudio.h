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

//Refreshing Speaker Information
- (void) refreshDeviceInfoOnce:(CDVInvokedUrlCommand*)command;
- (void) startRefreshDeviceInfo:(CDVInvokedUrlCommand*)command;
- (void) stopRefreshDeviceInfo:(CDVInvokedUrlCommand*)command;

//Playback & Volume Control
- (void) playCAF:(CDVInvokedUrlCommand*)command;
- (void) isPlaying:(CDVInvokedUrlCommand*)command;
- (void) stop:(CDVInvokedUrlCommand*)command;
- (void) pause:(CDVInvokedUrlCommand*)command;
- (void) playCAFFromCertainTime:(CDVInvokedUrlCommand*)command;
- (void) playWAV:(CDVInvokedUrlCommand*)command;
- (void) playStreamingMedia:(CDVInvokedUrlCommand*)command;
- (void) getPlayerState:(CDVInvokedUrlCommand*)command;
- (void) setVolume:(CDVInvokedUrlCommand*)command;
- (void) mute:(CDVInvokedUrlCommand*)command;
- (void) setVolumeDevice:(CDVInvokedUrlCommand*)command;
- (void) getVolume:(CDVInvokedUrlCommand*)command;
- (void) getDeviceVolume:(CDVInvokedUrlCommand*)command;
- (void) getMaximumVolumeLevel:(CDVInvokedUrlCommand*)command;
- (void) unmute:(CDVInvokedUrlCommand*)command;
- (void) isMuted:(CDVInvokedUrlCommand*)command;

//Device (Speaker) Management
- (void) addDeviceToSession:(CDVInvokedUrlCommand*)command;
- (void) removeDeviceFromSession:(CDVInvokedUrlCommand*)command;
- (void) getDeviceCount:(CDVInvokedUrlCommand*)command;
- (void) getGroupCount:(CDVInvokedUrlCommand*)command;
- (void) getActiveDeviceCount:(CDVInvokedUrlCommand*)command;
- (void) getDeviceCountInGroupIndex:(CDVInvokedUrlCommand*)command;
- (void) getDeviceInfoByIndex:(CDVInvokedUrlCommand*)command;
- (void) getDeviceGroupByDeviceId:(CDVInvokedUrlCommand*)command;
- (void) getDeviceInfoById:(CDVInvokedUrlCommand*)command;
- (void) isDeviceAvailable:(CDVInvokedUrlCommand*)command;
- (void) isDeviceActive:(CDVInvokedUrlCommand*)command;
- (void) removeDeviceFromGroup:(CDVInvokedUrlCommand*)command;
- (void) getDeviceGroupByIndex:(CDVInvokedUrlCommand*)command;
- (void) getDeviceGroupByGroupId:(CDVInvokedUrlCommand*)command;
- (void) getDeviceGroupNameByIndex:(CDVInvokedUrlCommand*)command;
- (void) getDeviceGroupByIndex:(CDVInvokedUrlCommand*)command;
- (void) setDeviceName:(CDVInvokedUrlCommand*)command;
- (void) setDeviceGroupName:(CDVInvokedUrlCommand*)command;
- (void) setDeviceRole:(CDVInvokedUrlCommand*)command;
- (void) getActiveGroupCount:(CDVInvokedUrlCommand*)command;
- (void) refreshDeviceWiFiSignal:(CDVInvokedUrlCommand*)command;
- (void) getWifiSignalStrengthType:(CDVInvokedUrlCommand*)command;

//Methods
- (void) initializeHKWController;
- (void) updateDeviceStatus:(long long)deviceId;
- (NSDictionary*) getDeviceInfo:(long long)deviceId;
- (NSDictionary*) getGroupInfo:(long long)deviceId;


@property(nonatomic, retain) UIAlertController* alertInitializing;
@property (strong) NSString* callbackId;


@end
