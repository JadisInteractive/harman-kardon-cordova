#import "HKAudio.h"

@implementation HKAudio

- (void)greet:(CDVInvokedUrlCommand*)command
{

    NSString* callbackId = [command callbackId];
    NSString* name = [[command arguments] objectAtIndex:0];
    NSString* msg = [NSString stringWithFormat: @"Hello, %@", name];


    //HKWControlHandler *hkwController = [[HKWControlHandler alloc] init];

    //hkwController = [HKWControlHandler sharedInstance];

    //if (!hkwController.isInitialized ) {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Initializing"
                                                    message:@"If this dialog appears, please check if any other HK WirelessHD App is running on the phone and kill it. Or, your phone is not in a Wifi network."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];


    //}

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}




@end