//
//  Storage.m
//  watchdog
//
//  Created by Erik Mårtensson.
//  Copyright © 2016 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Server.h"
#import "Storage.h"

@implementation Storage

-(instancetype)init{
    self = [super init];
    self.settings = [NSUserDefaults standardUserDefaults];
    return self;
}

-(NSMutableArray *)getServers{
    @try {
        self.servers = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:[self.settings objectForKey:@"Servers"]]];
        return self.servers;
    } @catch ( NSException *ex ) {
        NSLog(@"%@", [ex callStackSymbols]);
        return nil;
    }
}

- (void)saveServers{
    NSData *tempData = [NSKeyedArchiver archivedDataWithRootObject:self.servers];
    [self.settings setObject:tempData forKey:@"Servers"];
    [self.settings synchronize];
}

@end
