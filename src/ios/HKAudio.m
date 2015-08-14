#import "HKAudio.h"

@implementation HKAudio

- (void)greet:(CDVInvokedUrlCommand*)command
{

    NSString* callbackId = [command callbackId];
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

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];

}



- (void)getActiveDeviceCount:(CDVInvokedUrlCommand*)command
{

    NSLog(@"getActiveDeviceCount");

    NSString* callbackId = [command callbackId];
    //  NSString* name = [[command arguments] objectAtIndex:0];
    //  NSString* msg = [NSString stringWithFormat: @"Hello, %@", name];
    NSString* msg = [NSString stringWithFormat: @"success"];



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


#pragma mark - HKWDeviceEventHandler Delegate

-(void)hkwDeviceStateUpdated:(long long)deviceId withReason:(NSInteger)reason{

    NSLog(@"%@", NSStringFromSelector(_cmd));
}


-(void)hkwErrorOccurred:(NSInteger)errorCode withErrorMessage:(NSString*)errorMesg{
    NSLog(@"%@: %@", NSStringFromSelector(_cmd), errorMesg);

}




@end