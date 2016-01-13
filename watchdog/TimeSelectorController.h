//
//  TimeSelectorController.h
//  watchdog
//
//  Created by Erik Mårtensson.
//  Copyright (c) 2016 None. All rights reserved.
//

#ifndef watchdog_TimeSelectorController_h
#define watchdog_TimeSelectorController_h
@class Server;
@interface TimeSelectorController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

-(NSInteger)getSelection;

@end

#endif
