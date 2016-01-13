//
//  Storage.h
//  watchdog
//
//  Created by Erik Mårtensson.
//  Copyright © 2016 None. All rights reserved.
//

#ifndef Storage_h
#define Storage_h

@class Server;
@interface Storage : NSObject 


- (instancetype)init;
@property (nonatomic, strong) NSUserDefaults *settings;
@property (nonatomic, strong) NSMutableArray *servers;
-(NSMutableArray *)getServers;
- (void)saveServers;

@end


#endif /* Storage_h */
