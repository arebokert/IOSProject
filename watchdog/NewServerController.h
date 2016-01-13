//
//  newServerController.h
//  watchdog
//
//  Created by Erik Mårtensson.
//  Copyright (c) 2016 None. All rights reserved.
//

#ifndef watchdog_NewServerController_h
#define watchdog_NewServerController_h
@class Server;
@interface NewServerController : UITableViewController <UIAlertViewDelegate>;

@property (nonatomic, weak) IBOutlet UITextField *titleText;
@property (nonatomic, weak) IBOutlet UITextField *addressText;

@property (weak, nonatomic) IBOutlet UIButton *selectTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *selectDateButton;


-(Server*)getServerObject;

@end

#endif
