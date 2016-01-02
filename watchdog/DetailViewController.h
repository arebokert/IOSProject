//
//  DetailViewController.h
//  watchdog
//
//  Created by Erik Mårtensson on 02/01/16.
//  Copyright (c) 2016 None. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

