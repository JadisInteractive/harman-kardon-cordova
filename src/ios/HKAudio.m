#import "HKAudio.h"

@implementation HKAudio

- (void)greet:(CDVInvokedUrlCommand*)command
{

     self.callbackId = [command callbackId];
   // NSString* callbackId = [command callbackId];
  //  NSString* name = [[command arguments] objectAtIndex:0];
  //  NSString* msg = [NSString stringWithFormat: @"Hello, %@", name];
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
        NSLog(@"hkwController is initializesd");
    }

    [self initializeHKWController];


    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId: self.callbackId];

}



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


- (void)startRefreshDeviceInfo:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


- (void)stopRefreshDeviceInfo:(CDVInvokedUrlCommand*)command
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
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




#pragma mark - HKWController Helper Functions


-(void)  initializeHKWController {

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


- (void)updateDeviceStatus:(long long)deviceId
{
    NSDictionary* deviceInfo = [self getDeviceInfo:deviceId];

    if (self.callbackId) {
        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:deviceInfo];
        [result setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    }
}

/* Get the current device info.
 */
- (NSDictionary*)getDeviceInfo:(long long)deviceId
{

    DeviceInfo* currentDevice = [[HKWControlHandler sharedInstance] getDeviceInfoById:deviceId];

    //ipAddress, port, groupId, role, groupName,
    NSMutableDictionary* deviceData = [NSMutableDictionary dictionaryWithCapacity:2];
    [deviceData setObject:[NSNumber numberWithLongLong:currentDevice.deviceId] forKey:@"deviceId"];
    [deviceData setObject:currentDevice.deviceName forKey:@"deviceName"];
    return deviceData;
}


#pragma mark - HKWDeviceEventHandler Delegate

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

    //[self updateDeviceStatus:deviceId];

   }


-(void)hkwErrorOccurred:(NSInteger)errorCode withErrorMessage:(NSString*)errorMesg{
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), errorMesg);

}




@end