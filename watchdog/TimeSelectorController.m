//
//  TimeSelectorController.m
//  watchdog
//
//  Created by Erik Mårtensson.
//  Copyright (c) 2016 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TimeSelectorController.h"

@implementation TimeSelectorController

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        [self performSegueWithIdentifier:@"unwindToNewServerFromDate" sender:self];
    }
    [super viewWillDisappear:animated];
}

- (NSInteger)getSelection{
    NSDateFormatter *hours = [[NSDateFormatter alloc] init];
    [hours setDateFormat:@"HH"];
    NSDateFormatter *minutes = [[NSDateFormatter alloc] init];
    [minutes setDateFormat:@"mm"];
    
    NSInteger hourInSeconds = [[hours stringFromDate:self.datePicker.date]intValue]*3600;
    NSInteger minuteInSeconds = [[minutes stringFromDate:self.datePicker.date] intValue]*60;
    NSInteger returnTime = hourInSeconds + minuteInSeconds;
    return returnTime;
}

@end