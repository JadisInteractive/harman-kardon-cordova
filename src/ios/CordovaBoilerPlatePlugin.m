// TODO comments, header
#import "CordovaBoilerPlatePlugin.h"

@implementation CordovaBoilerPlatePlugin
 
- (void)pluginInitialize
{
	// Plugin specific initialize login goes here
}

- (void)doSomethingNoArgs:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
 	// TODO 

 	// Error state 
 	pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];

 	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)doSomethingOneArg:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* argA = [command.arguments objectAtIndex:0];

 	// TODO 

    // Error state
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];

 	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)doSomethingMultipleArgs:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
	NSString* argA = [command.arguments objectAtIndex:0];
    // TODO argB an object?

 	// TODO 

 	// Error state
 	pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];

 	[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end