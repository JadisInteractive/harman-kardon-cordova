// TODO comments, header
#import <Cordova/CDV.h>

@interface CordovaBoilerPlatePlugin : CDVPlugin

- (void)pluginInitialize;
- (void)doSomethingNoArgs:(CDVInvokedUrlCommand*)command;
- (void)doSomethingOneArg:(CDVInvokedUrlCommand*)command;
- (void)doSomethingMultipleArgs:(CDVInvokedUrlCommand*)command;

@end