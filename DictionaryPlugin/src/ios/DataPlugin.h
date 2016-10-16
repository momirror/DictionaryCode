//
//  DataPlugin.h
//  HelloCordova
//
//  Created by msp on 16/1/8.
//
//

#import <Cordova/CDVPlugin.h>

@interface DataPlugin : CDVPlugin
- (void)parseData:(CDVInvokedUrlCommand*)command;
- (void)getAllData:(CDVInvokedUrlCommand*)comand;
@end
