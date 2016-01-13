//
//  newServerController.h
//  watchdog
//
//  Created by Erik Mårtensson on 03/01/16.
//  Copyright (c) 2016 None. All rights reserved.
//

#ifndef watchdog_NewServerController_h
#define watchdog_NewServerController_h
@class Server;
@interface NewServerController : UITableViewController <UIAlertViewDelegate>;

//@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) IBOutlet UITextField *titleText;
@property (nonatomic, weak) IBOutlet UITextField *addressText;
@property (nonatomic, weak) IBOutlet UITextField *timeoutText;

@property (weak, nonatomic) IBOutlet UIButton *selectTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *selectDateButton;


-(Server*)getServerObject;

@end

#endif
