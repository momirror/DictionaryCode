//
//  DataPlugin.h
//  HelloCordova
//
//  Created by msp on 16/1/8.
//
//

#import <Cordova/CDVPlugin.h>
#import <DictionaryFramework/DictionaryFramework.h>

@interface DataPlugin : CDVPlugin
- (void)saveData:(CDVInvokedUrlCommand*)command;
- (void)getAllData:(CDVInvokedUrlCommand*)comand;
@end
