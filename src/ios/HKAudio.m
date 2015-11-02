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

}

- (void)playWAV:(CDVInvokedUrlCommand*)command
{

}

- (void)playStreamingMedia:(CDVInvokedUrlCommand*)command
{

}

- (void)getPlayerState:(CDVInvokedUrlCommand*)command
{

}


// ===============================================================
#pragma mark - Volume Control

- (void)mute:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];
    [[HKWControlHandler sharedInstance]  mute];
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


    [[HKWControlHandler sharedInstance]  setVolume:[volume integerValue]];
    NSString* msg = [NSString stringWithFormat: @"stopped"];

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}

- (void)setVolumeDevice:(CDVInvokedUrlCommand*)command
{

}

- (void)getVolume:(CDVInvokedUrlCommand*)command
{

}

- (void)getDeviceVolume:(CDVInvokedUrlCommand*)command
{

}

- (void)getMaximumVolumeLevel:(CDVInvokedUrlCommand*)command
{

}

- (void)unmute:(CDVInvokedUrlCommand*)command
{

}

- (void)isMuted:(CDVInvokedUrlCommand*)command
{

}


// ===============================================================
#pragma mark - Device (Speaker) Management

- (void)getActiveDeviceCount:(CDVInvokedUrlCommand*)command
{

    NSLog(@"%@", NSStringFromSelector(_cmd));

    NSString* callbackId = [command callbackId];
    NSInteger deviceCount = [[HKWControlHandler sharedInstance] getActiveDeviceCount];
    NSString* msg = [NSString stringWithFormat: @"%d", deviceCount];


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
    NSString* msg = [NSString stringWithFormat: @"%d", groupCount];


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
    NSString* msg = [NSString stringWithFormat: @"%d", deviceCount];


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

}

- (void)getDeviceInfoByGroupIndexAndDeviceIndex:(CDVInvokedUrlCommand*)command
{

}

- (void)getDeviceInfoByIndex:(CDVInvokedUrlCommand*)command
{

}

- (void)getDeviceGroupByDeviceId:(CDVInvokedUrlCommand*)command
{

}

- (void)getDeviceInfoById:(CDVInvokedUrlCommand*)command
{

}

- (void)isDeviceAvailable:(CDVInvokedUrlCommand*)command
{

}

- (void)isDeviceActive:(CDVInvokedUrlCommand*)command
{

}

- (void)removeDeviceFromGroup:(CDVInvokedUrlCommand*)command
{

}

- (void)getDeviceGroupByIndex:(CDVInvokedUrlCommand*)command
{

}

- (void)getDeviceGroupByGroupId:(CDVInvokedUrlCommand*)command
{

}

- (void)getDeviceGroupNameByIndex:(CDVInvokedUrlCommand*)command
{

}

- (void)getDeviceGroupIdByIndex:(CDVInvokedUrlCommand*)command
{

}

- (void)setDeviceName:(CDVInvokedUrlCommand*)command
{

}

- (void)setDeviceGroupName:(CDVInvokedUrlCommand*)command
{

}

- (void)setDeviceRole:(CDVInvokedUrlCommand*)command
{

}

- (void)getActiveGroupCount:(CDVInvokedUrlCommand*)command
{

}

- (void)refreshDeviceWiFiSignal:(CDVInvokedUrlCommand*)command
{

}

- (void)getWifiSignalStrengthType:(CDVInvokedUrlCommand*)command
{

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
