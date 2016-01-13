//
//  Server.m
//  watchdog
//  Created by Erik Mårtensson on 03/01/16.
//  Copyright (c) 2016 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"
#import "Timer.h"

@implementation Server

- (instancetype)initServerWithType:(NSString *)type serverTitle:(NSString *)title serverAddress:(NSString *)address maxTimeout:(NSString *)timeout{
    self = [super init];
    if (self) {
        self.type = type;
        self.title = title;
        self.address = address;
        self.timeout = timeout;
        self.lastCheck = [NSDate date];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.type = [decoder decodeObjectForKey:@"type"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.address = [decoder decodeObjectForKey:@"address"];
        self.timeout = [decoder decodeObjectForKey:@"timeout"];
        self.lastCheck = [decoder decodeObjectForKey:@"lastCheck"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.type forKey:@"type"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.address forKey:@"address"];
    [encoder encodeObject:self.timeout forKey:@"timeout"];
    [encoder encodeObject:self.lastCheck forKey:@"lastCheck"];
}

- (bool*)timeoutPassed{
    if(self.lastCheck){
        NSDate *tempDate = [NSDate dateWithTimeInterval:[self.timeout intValue] sinceDate:self.lastCheck];
        NSTimeInterval timeWithTimeout = [self.lastCheck timeIntervalSinceDate:tempDate];
        NSTimeInterval timeSinceCheck = [self.lastCheck timeIntervalSinceDate:[NSDate date]];
        
        if((NSInteger)timeSinceCheck < (NSInteger)timeWithTimeout){
            return true;
        } else {
            return false;
        }
    } else {
        return true;
    }
}

-(NSString*)getLastCheckString{
    if(self.lastCheck){
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];;
        [dateFormat setDateFormat:@"dd-MM-yyyy HH:mm"];
        return [dateFormat stringFromDate:self.lastCheck];
    } else {
        return @"No check has been made yet.";
    }
}

-(void)setLastCheck:(NSDate *)lastCheckDate{
    _lastCheck = lastCheckDate;
}

@end