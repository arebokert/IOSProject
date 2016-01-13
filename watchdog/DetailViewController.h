//
//  DetailViewController.h
//  watchdog
//
//  Created by Erik Mårtensson.
//  Copyright (c) 2016 None. All rights reserved.
//

#ifndef watchdog_TypeSelectorController_h
#define watchdog_TypeSelectorController_h
@class Server;
@interface DetailViewController : UIViewController;

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *lastCheckedText;
@property (weak, nonatomic) IBOutlet UILabel *serverTypeText;
@property (weak, nonatomic) IBOutlet UILabel *serverNameText;
@property (weak, nonatomic) IBOutlet UILabel *serverAddressText;
@property (weak, nonatomic) IBOutlet UILabel *timeoutText;
@property (strong, nonatomic) Server *server;

@end

#endif
