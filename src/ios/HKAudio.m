#import "HKAudio.h"

@implementation HKAudio

// ===============================================================
#pragma mark - SDK Initialization

- (void)start:(CDVInvokedUrlCommand*)command
{

    self.callbackId = [command callbackId];
    NSString* msg = [NSString stringWithFormat: @"success"];



    NSLog(@"hkwController initialized? %d", [[HKWControlHandler sharedInstance] isInitialized]);

    //Show an alert while initializing
    if (![[HKWControlHandler sharedInstance] isInitialized] ) {

        self.alertInitializing = [UIAlertController alertControllerWithTitle:@"Initializing"
                                                                     message:@"If this dialog appears, please check if any other HK WirelessHD App is running on the phone and kill it. Or, your phone is not in a Wifi network."
                                                              preferredStyle:UIAlertControllerStyleAlert];

        [self.viewController  presentViewController:self.alertInitializing animated:YES completion:nil];
    }
    else
    {
        NSLog(@"hkwController is initialized");
    }

    [self initializeHKWController];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId: self.callbackId];

}

-(void)initializeHKWController {

    if (![[HKWControlHandler sharedInstance] initializing] && ![[HKWControlHandler sharedInstance] isInitialized] ) {
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            //Background Thread
            if ([[HKWControlHandler sharedInstance] initializeHKWirelessController:[NSString stringWithFormat:@"%s" , kLicenseKeyGlobal] withSpeakersAdded:false ] != 0)
            {
                NSLog(@"initializeHKWirelessControl failed : invalid license key");
                return;
            }

            NSLog(@"initializeHKWirelessControl - OK");
            [HKWDeviceEventHandlerSingleton sharedInstance].delegate = self;

            // dismiss the network initialization dialog
            if (self.alertInitializing != nil) {
                [self.alertInitializing dismissViewControllerAnimated:true completion: nil];
            }

            dispatch_async(dispatch_get_main_queue(), ^(void){
                //Run UI Updates
            });
        });

    }
}


// ===============================================================
#pragma mark - Refreshing Speaker Information

- (void)refreshDeviceInfoOnce:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSString* callbackId = [command callbackId];
    NSString* msg = [NSString stringWithFormat: @"Refreshing device status one time."];

    [[HKWControlHandler sharedInstance] refreshDeviceInfoOnce];

    CDVPluginResult* result = [CDVPluginResult

                                resultWithStatus:CDVCommandStatus_OK
                                messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId: callbackId];
}

- (void)startRefreshDeviceInfo:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSString* callbackId = [command callbackId];
    NSString* msg = [NSString stringWithFormat: @"continuous refreshing started. refreshes every two seconds."];

    [[HKWControlHandler sharedInstance] startRefreshDeviceInfo];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}


- (void)stopRefreshDeviceInfo:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSString* callbackId = [command callbackId];
    NSString* msg = [NSString stringWithFormat: @"continuous refreshing stopped"];

    [[HKWControlHandler sharedInstance] stopRefreshDeviceInfo];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}


// ===============================================================
#pragma mark - Playback Control

- (void)playCAF:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* urlString = (NSString *)[command argumentAtIndex:0];
    NSString* songName = (NSString *)[command argumentAtIndex:1];
    BOOL resumeFlag = (BOOL)[command argumentAtIndex:2];

    NSString* callbackId = [command callbackId];
    BOOL success = [[HKWControlHandler sharedInstance] playCAF:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] songName:songName resumeFlag:resumeFlag];

    NSString* msg = [NSString stringWithFormat: @"%d", success];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)isPlaying:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];
    BOOL groupCount = [[HKWControlHandler sharedInstance]  isPlaying];
    NSString* msg = [NSString stringWithFormat: @"%d", groupCount];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)pause:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];
    [[HKWControlHandler sharedInstance]  pause];
    NSString* msg = [NSString stringWithFormat: @"paused"];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)stop:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];
    [[HKWControlHandler sharedInstance]  stop];
    NSString* msg = [NSString stringWithFormat: @"stopped"];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)playCAFFromCertainTime:(CDVInvokedUrlCommand*)command
{
    NSString* urlString = (NSString *)[command argumentAtIndex:0];
    NSString* songName = (NSString *)[command argumentAtIndex:1];
    NSInteger startTime = (NSInteger)[command argumentAtIndex:2];

    NSString* callbackId = [command callbackId];

    BOOL success = [[HKWControlHandler sharedInstance] playCAFFromCertainTime:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] songName:songName startTime:startTime];

    NSString* msg = [NSString stringWithFormat: @"%d", success];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];

}

/* - (void)playWAV:(CDVInvokedUrlCommand*)command
{
    NSString* soundFilePath = (NSString *)[command argumentAtIndex:0];

    NSString* callbackId = [command callbackId];

    BOOL success = [[HKWControlHandler sharedInstance] playWAV:[NSURL URLWithString:[soundFilePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];

    NSString* msg = [NSString stringWithFormat: @"%d", success];

    CDVPluginResult* result = [CDVPluginResult

                                resultWithStatus:CDVCommandStatus_OK
                                messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
} */

/* - (void)playStreamingMedia:(CDVInvokedUrlCommand*)command
{
    NSString* streamingMediaUrl = (NSString *)[command argumentAtIndex:0];

    NSString* callbackId = [command callbackId];

    BOOL success = [[HKWControlHandler sharedInstance] playStreamingMedia:[NSURL URLWithString:[streamingMediaUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];

    NSString* msg = [NSString stringWithFormat: @"%d", success];

    CDVPluginResult* result = [CDVPluginResult

                                resultWithStatus:CDVCommandStatus_OK
                                messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
} */

- (void)getPlayerState:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];
    NSInteger getPlayerState = [[HKWControlHandler sharedInstance] getPlayerState];
    NSString* msg = [NSString stringWithFormat: @"%ld", (long)getPlayerState];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}


// ===============================================================
#pragma mark - Volume Control

- (void)mute:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];
    [[HKWControlHandler sharedInstance] mute];
    NSString* msg = [NSString stringWithFormat: @"mute"];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)setVolume:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    id volume = [command argumentAtIndex:0];


    [[HKWControlHandler sharedInstance] setVolume:[volume integerValue]];
    NSString* msg = [NSString stringWithFormat: @"stopped"];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)setVolumeDevice:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    id deviceId = [command argumentAtIndex:0];
    id volume = [command argumentAtIndex:1];

    [[HKWControlHandler sharedInstance] setVolumeDevice:[volume integerValue]];
    NSString* msg = [NSString stringWithFormat: @"volume set"];

    CDVPluginResult* result = [CDVPluginResult
                               
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];
    
    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getVolume:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    NSInteger getVolume = [[HKWControlHandler sharedInstance] getVolume];
    NSString* msg = [NSString stringWithFormat: @"%ld", (long)getVolume];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];

}

- (void)getDeviceVolume:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];
    NSInteger getDeviceVolume = [[HKWControlHandler sharedInstance] getDeviceVolume];
    NSString* msg = [NSString stringWithFormat: @"%d", getMaximumVolumeLevel];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getMaximumVolumeLevel:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];
    NSInteger getMaximumVolumeLevel = [[HKWControlHandler sharedInstance] getMaximumVolumeLevel];
    NSString* msg = [NSString stringWithFormat: @"%ld", (long)getMaximumVolumeLevel];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)unmute:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];
    [[HKWControlHandler sharedInstance] unmute];
    NSString* msg = [NSString stringWithFormat: @"unmute"];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)isMuted:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];
    BOOL isMuted = [[HKWControlHandler sharedInstance] isMuted];
    NSString* msg = [NSString stringWithFormat: @"%d", isMuted];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}


// ===============================================================
#pragma mark - Device (Speaker) Management

- (void)getActiveDeviceCount:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];
    NSInteger deviceCount = [[HKWControlHandler sharedInstance] getActiveDeviceCount];
    NSString* msg = [NSString stringWithFormat: @"%ld", (long)deviceCount];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getGroupCount:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];
    NSInteger groupCount = [[HKWControlHandler sharedInstance] getGroupCount];
    NSString* msg = [NSString stringWithFormat: @"%ld", (long)groupCount];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getDeviceCount:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];
    NSInteger deviceCount = [[HKWControlHandler sharedInstance] getDeviceCount];
    NSString* msg = [NSString stringWithFormat: @"%ld", (long)deviceCount];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)addDeviceToSession:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    id deviceId = [command argumentAtIndex:0];

    NSString* callbackId = [command callbackId];
    BOOL success = [[HKWControlHandler sharedInstance] addDeviceToSession:(long long)deviceId];
    NSString* msg = [NSString stringWithFormat: @"%d", success];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)removeDeviceFromSession:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    id deviceId = [command argumentAtIndex:0];

    NSString* callbackId = [command callbackId];
    BOOL success = [[HKWControlHandler sharedInstance] removeDeviceFromSession:(long long)deviceId];
    NSString* msg = [NSString stringWithFormat: @"%d", success];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getDeviceCountInGroupIndex:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    NSInteger groupCount = [[HKWControlHandler sharedInstance] getGroupCount];
    NSInteger groupIndex = groupCount - 1;
    NSInteger deviceCount = [[HKWControlHandler sharedInstance] getDeviceCountInGroupIndex:(NSInteger)groupIndex];
    NSString* msg = [NSString stringWithFormat: @"%ld", (long)deviceCount];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getDeviceInfoByGroupIndexAndDeviceIndex:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    NSInteger deviceCount = [[HKWControlHandler sharedInstance] getDeviceCount];
    NSInteger groupCount = [[HKWControlHandler sharedInstance] getGroupCount];
    NSInteger groupIndex = groupCount - 1;
    NSInteger deviceIndex = deviceCount - 1;

    DeviceInfo *deviceInfo = [[HKWControlHandler sharedInstance] getDeviceInfoByGroupIndexAndDeviceIndex:(NSInteger) groupIndex deviceIndex:[(NSInteger) deviceIndex]];

    NSString* msg = [NSString stringWithFormat: @"%d", *deviceInfo];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getDeviceInfoByIndex:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    NSInteger deviceCount = [[HKWControlHandler sharedInstance] getDeviceCount];
    NSInteger deviceIndex = deviceCount - 1;

    DeviceInfo *deviceInfo = [[HKWControlHandler sharedInstance] getDeviceInfoByIndex:[(NSInteger)deviceIndex]];

    NSString* msg = [NSString stringWithFormat: @"%d", *deviceInfo];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getDeviceGroupByDeviceId:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    id deviceId = [command argumentAtIndex:0];

    DeviceGroup* currentGroup = [[HKWControlHandler sharedInstance] getDeviceGroupByDeviceId:(long long) deviceId];

    NSString* msg = [NSString stringWithFormat: @"%@", currentGroup];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getDeviceInfoById:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    id deviceId = [command argumentAtIndex:0];

    DeviceInfo *deviceInfo = [[HKWControlHandler sharedInstance] getDeviceInfoById:(long long) deviceId];

    NSString* msg = [NSString stringWithFormat: @"%d", *deviceInfo];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)isDeviceAvailable:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    id deviceId = [command argumentAtIndex:0];

    BOOL success = [[HKWControlHandler sharedInstance] isDeviceAvailable:(long long)deviceId];

    NSString* msg = [NSString stringWithFormat: @"%d", success];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)isDeviceActive:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    id deviceId = [command argumentAtIndex:0];

    BOOL success = [[HKWControlHandler sharedInstance] isDeviceActive:(long long)deviceId];

    NSString* msg = [NSString stringWithFormat: @"%d", success];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)removeDeviceFromGroup:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    id deviceId = [command argumentAtIndex:0];
    NSString* msg = [NSString stringWithFormat: @"device removed from group"];

    [[HKWControlHandler sharedInstance] removeDeviceFromGroup:(long long)deviceId];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getDeviceGroupByIndex:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    id groupIndex = [command argumentAtIndex:0];
    DeviceGroup* deviceGroup = [[HKWControlHandler sharedInstance] getDeviceGroupByIndex:[groupIndex integerValue]];

    NSString* msg = [NSString stringWithFormat: @"%@", deviceGroup];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getDeviceGroupByGroupId:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    id groupId = [command argumentAtIndex:0];
    DeviceGroup* deviceGroup = [[HKWControlHandler sharedInstance] getDeviceGroupByGroupId:(long long) groupId];

    NSString* msg = [NSString stringWithFormat: @"%@", deviceGroup];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getDeviceGroupNameByIndex:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    id groupIndex = [command argumentAtIndex:0];
    NSString* deviceGroupName = [[HKWControlHandler sharedInstance] getDeviceGroupNameByIndex:[groupIndex integerValue]];

    NSString* msg = [NSString stringWithFormat: @"%@", deviceGroupName];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getDeviceGroupIdByIndex:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    id groupIndex = [command argumentAtIndex:0];
    NSNumber *deviceGroupId = [[HKWControlHandler sharedInstance] getDeviceGroupIdByIndex:[groupIndex integerValue]];

    NSString* msg = [NSString stringWithFormat: @"%@", deviceGroupId];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)setDeviceName:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    id deviceId = [command argumentAtIndex:0];
    NSString* deviceName = [command argumentAtIndex:1];

    BOOL success = [[HKWControlHandler sharedInstance] setDeviceName:(long long)deviceId deviceName:(NSString *)deviceName];

    NSString* msg = [NSString stringWithFormat: @"%d", success];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)setDeviceGroupName:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    id deviceId = [command argumentAtIndex:0];
    NSString* groupName = [command argumentAtIndex:1];

    BOOL success = [[HKWControlHandler sharedInstance] setDeviceName:(long long)deviceId groupName:(NSString *)groupName];

    NSString* msg = [NSString stringWithFormat: @"%d", success];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)setDeviceRole:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    id deviceId = [command argumentAtIndex:0];
    id role = [command argumentAtIndex:1];

    BOOL success = [[HKWControlHandler sharedInstance] setDeviceRole:(long long)deviceId role:[role integerValue]];

    NSString* msg = [NSString stringWithFormat: @"%d", success];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getActiveGroupCount:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];
    NSInteger activeGroupCount = [[HKWControlHandler sharedInstance] getActiveGroupCount];
    NSString* msg = [NSString stringWithFormat: @"%d", activeGroupCount];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)refreshDeviceWiFiSignal:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    id deviceId = [command argumentAtIndex:0];

    BOOL success = [[HKWControlHandler sharedInstance] refreshDeviceWiFiSignal:(long long)deviceId];

    NSString* msg = [NSString stringWithFormat: @"%d", success];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)getWifiSignalStrengthType:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];

    NSInteger wifiSignal = [[HKWControlHandler sharedInstance] getWifiSignalStrengthType:(NSInteger)wifiSignal];

    NSString* msg = [NSString stringWithFormat: @"%d", wifiSignal];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}


// ===============================================================
#pragma mark - HKWDeviceEventHandlerSingleton


// ===============================================================
#pragma mark - HKWDeviceEventHandlerDelegate

-(void)hkwDeviceStateUpdated:(long long)deviceId withReason:(NSInteger)reason{

    NSInteger activeDeviceCount  = [[HKWControlHandler sharedInstance] getActiveDeviceCount];
    NSInteger groupCount         = [[HKWControlHandler sharedInstance] getGroupCount];
    NSString *groupName          = [[HKWControlHandler sharedInstance] getDeviceGroupNameByIndex:0];
    NSInteger deviceCount        = [[HKWControlHandler sharedInstance] getDeviceCountInGroupIndex:0];
    DeviceInfo *deviceInfo       = [[HKWControlHandler sharedInstance] getDeviceInfoByGroupIndexAndDeviceIndex:0 deviceIndex:0];

    NSLog(@"%@ deviceId: %lld", NSStringFromSelector(_cmd), deviceId);
    NSLog(@"Active device count: %d", activeDeviceCount);
    NSLog(@"Group count: %d", groupCount);
    NSLog(@"Group Name: %@", groupName);
    NSLog(@"Device Count: %d",  deviceCount);
    NSLog(@"Device Info IP: %@",  deviceInfo.ipAddress);
    NSLog(@"Device Info Name: %@",  deviceInfo.deviceName);

    //Add Device to Session (select device)
    // [[HKWControlHandler sharedInstance] addDeviceToSession:deviceInfo.deviceId];

    //Remove Device from Session (select device)
    // [[HKWControlHandler sharedInstance] removeDeviceFromSession:deviceInfo.deviceId];

    [self updateDeviceStatus:deviceId];
}


-(void)hkwErrorOccurred:(NSInteger)errorCode withErrorMessage:(NSString*)errorMesg{
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), errorMesg);

}


// ===============================================================
#pragma mark - HKWPlayerEventHandlerSingleton


// ===============================================================
#pragma mark - HKWPlayerEventHandlerDelegate
-(void)hkwPlayEnded{

}

// ===============================================================
#pragma mark - Helper Functions

- (void)updateDeviceStatus:(long long)deviceId
{
    NSDictionary* deviceInfo = [self getDeviceInfo:deviceId];

    if (self.callbackId) {
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:deviceInfo];
        [result setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    }
}

/* Get the current device info. */
- (NSDictionary*)getDeviceInfo:(long long)deviceId
{

    DeviceInfo* currentDevice = [[HKWControlHandler sharedInstance] getDeviceInfoById:deviceId];

    //ipAddress, port, groupId, role, groupName,
    NSMutableDictionary* deviceData = [NSMutableDictionary dictionaryWithCapacity:18];
    /*! The device id */
    [deviceData setObject:[NSNumber numberWithLongLong:currentDevice.deviceId] forKey:@"deviceId"];
    /*! The device name */
    [deviceData setObject:currentDevice.deviceName forKey:@"deviceName"];
    /*! The IP address of the speaker */
    [deviceData setObject:currentDevice.ipAddress forKey:@"ipAddress"];
    /*! The port number of the speaker */
    [deviceData setObject:[NSNumber numberWithInteger:currentDevice.port] forKey:@"port"];
    /*! The ID of the group that the speaker belongs to */
    [deviceData setObject:[NSNumber numberWithLongLong:currentDevice.groupId] forKey:@"groupId"];
    /*! The role of the speaker */
    [deviceData setObject:[NSNumber numberWithInteger:currentDevice.role] forKey:@"role"];
    /*! The name of the group that the speaker belongs to */
    [deviceData setObject:currentDevice.groupName forKey:@"groupName"];
    /*! The model name of the speaker */
    [deviceData setObject:currentDevice.modelName forKey:@"modelName"];
    /*! The zone name of the speaker. The ZN is used for representing group ID & group name in a single string, separated by '#&#' */
    [deviceData setObject:currentDevice.zoneName forKey:@"zoneName"];
    /*! The current volume level of the speaker */
    [deviceData setObject:[NSNumber numberWithInteger:currentDevice.volume] forKey:@"volume"];
    /*! The firmware version of the speaker */
    [deviceData setObject:currentDevice.version forKey:@"version"];
    /*! The mac address of the speaker */
    [deviceData setObject:currentDevice.macAddress forKey:@"macAddress"];
    /*! The wifi signal strength of the speaker. This value changes over time. */
    [deviceData setObject:[NSNumber numberWithInteger:currentDevice.wifiSignalStrength] forKey:@"wifiSignalStrength"];
    /*! balace value in stereo mode. The value range from -6 to 6, 0 is neutral. */
    [deviceData setObject:[NSNumber numberWithInteger:currentDevice.balance] forKey:@"balance"];
    /*! The channleType: 1 is stereo, etc. */
    [deviceData setObject:[NSNumber numberWithInteger:currentDevice.channelType] forKey:@"channelType"];
    /*! Indicates if the speaker is active (added to the current playback session) */
    [deviceData setObject:[NSNumber numberWithBool:currentDevice.active] forKey:@"active"];
    /*! Indicates whether the speaker is playing, regardless of the source */
    [deviceData setObject:[NSNumber numberWithBool:currentDevice.isPlaying] forKey:@"isPlaying"];
    /*! Indicates whether the speaker is the master in stereo or group mode. 1 if the speaker is standalone. */
    [deviceData setObject:[NSNumber numberWithBool:currentDevice.isMaster] forKey:@"isMaster"];

    return deviceData;
}


/* Get the current Group info. */
- (NSDictionary*)getGroupInfo:(long long)deviceId
{
    DeviceGroup* currentGroup = [[HKWControlHandler sharedInstance] getDeviceGroupByDeviceId:deviceId];

    //ipAddress, port, groupId, role, groupName,
    NSMutableDictionary* groupData = [NSMutableDictionary dictionaryWithCapacity:4];
    /*! The group name */
    [groupData setObject:currentGroup.groupName forKey:@"groupName"];

    /*! The list of devices that belong to the group */
    //[groupData setObject:currentGroup.deviceList forKey:@"deviceList"];

    /*! The ID of the group that the speaker belongs to */
    [groupData setObject:[NSNumber numberWithLongLong:currentGroup.groupId] forKey:@"groupId"];
    /*! The active status indicating whether the speaker is added to the current session for playback. */
    [groupData setObject:[NSNumber numberWithBool:currentGroup.active] forKey:@"active"];

    return groupData;
}


// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------
// ---------------------------------------------------------------------------------------------


@end
