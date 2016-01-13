//
//  MasterViewController.h
//  watchdog
//
//  Created by Erik Mårtensson.
//  Copyright (c) 2016 None. All rights reserved.
//

@class DetailViewController;
@class Storage;
@interface MasterViewController : UITableViewController <NSCoding>


@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) Storage *storage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@end

