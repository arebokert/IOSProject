//
//  Server.h
//  watchdog
//
//  Created by Erik Mårtensson on 03/01/16.
//  Copyright (c) 2016 None. All rights reserved.
//

#ifndef watchdog_Server_h
#define watchdog_Server_h

@interface Server : NSObject <NSCoding>

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *timeout;
@property (nonatomic, strong) NSDate *lastCheck;
@property (nonatomic, assign) BOOL successful;


- (instancetype)initServerWithType:(NSString *)type serverTitle:(NSString *)title serverAddress:(NSString *)address maxTimeout:(NSString *)timeout;
-(bool*)timeoutPassed;
-(NSString*)getLastCheckString;
-(void)setLastCheck:(NSDate *)lastCheckDate;
@end

#endif
