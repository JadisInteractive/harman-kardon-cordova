#import "HKAudio.h"

@implementation HKAudio

- (void)greet:(CDVInvokedUrlCommand*)command
{

    NSString* callbackId = [command callbackId];
    NSString* name = [[command arguments] objectAtIndex:0];
    NSString* msg = [NSString stringWithFormat: @"Hello, %@", name];


    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Initializing"
                                                    message:@"If this dialog appears, please check if any other HK WirelessHD App is running on the phone and kill it. Or, your phone is not in a Wifi network."
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

/*

    HKWControlHandler *hkwController = [[HKWControlHandler alloc] init];
    hkwController = [HKWControlHandler sharedInstance];
    NSLog(@"bool %s", hkwController.isInitialized ? "true" : "false");


    if (!hkwController.isInitialized ) {


        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Initializing"
                                                                        message:@"If this dialog appears, please check if any other HK WirelessHD App is running on the phone and kill it. Or, your phone is not in a Wifi network."
                                                                preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];

        [alert addAction:defaultAction];
        [self.viewController  presentViewController:alert animated:YES completion:nil];


    }
 */

    CDVPluginResult* result = [CDVPluginResult

                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:callbackId];
}




@end