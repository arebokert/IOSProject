//
//  MasterViewController.h
//  watchdog
//
//  Created by Erik Mårtensson.
//  Copyright (c) 2016 None. All rights reserved.
//

@class DetailViewController;

@interface MasterViewController : UITableViewController <NSCoding>


@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSMutableArray *servers;
@property (strong, nonatomic) NSUserDefaults *settings;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

- (void)saveSettings;

@end

