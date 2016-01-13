//
//  Socket.m
//  watchdog
//
//  Created by Erik Mårtensson
//  Copyright © 2016 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"
#import "Socket.h"

@implementation Socket

- (instancetype)initSocketWithIPAndPort:(NSString*)ip port:(NSInteger)port{
    self = [super init];
    CFReadStreamRef inStream;
    CFWriteStreamRef outStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)ip, port, &inStream, &outStream);
    self.inputStream = (__bridge NSInputStream *)inStream;
    self.outputStream = (__bridge NSOutputStream *)outStream;
    [self.inputStream setDelegate:self];
    [self.outputStream setDelegate:self];
    return self;
}

-(Boolean)checkServer:(Server*)host{
    [self.inputStream open];
    [self.outputStream open];
    Boolean ret = false;
    NSString *typeDef;
    if([host.type isEqualToString:@"Ping"]){
        typeDef = @"PI";
    } else if([host.type isEqualToString:@"HTTP"]){
        typeDef = @"HT";
    }
    NSString *output  = [typeDef stringByAppendingString:host.address];
    NSData *data = [[NSData alloc] initWithData:[output dataUsingEncoding:NSASCIIStringEncoding]];
    [self.outputStream write:[data bytes] maxLength:[data length]];
    [NSThread sleepForTimeInterval:2.0f];
    while ([self.inputStream hasBytesAvailable]){
        uint8_t buffer[1024];
        NSInteger length = [self.inputStream read:buffer maxLength:sizeof(buffer)];
        NSString *output = [[NSString alloc] initWithBytes:buffer length:length encoding:NSASCIIStringEncoding];
        
        if (output != nil)
        {
            if([output isEqualToString:@"0"]){
                ret = true;
            } else {
                ret = false;
            }
        } else {
            ret = false;
        }
    }
    [self.inputStream close];
    [self.outputStream close];
    return ret;
}

@end