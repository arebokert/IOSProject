//
//  Socket.h
//  watchdog
//
//  Created by Erik Mårtensson
//  Copyright © 2016 None. All rights reserved.
//

#ifndef Socket_h
#define Socket_h
@class Server;
@interface Socket : NSObject <NSStreamDelegate>

@property (nonatomic, strong) NSInputStream *inputStream;
@property (nonatomic, strong) NSOutputStream *outputStream;

- (instancetype)initSocketWithIPAndPort:(NSString*)ip port:(NSInteger)port;
-(Boolean)checkServer:(Server*)host;

@end


#endif /* Socket_h */
