//
//  TypeSelectorController.h
//  watchdog
//
//  Created by Erik Mårtensson on 04/01/16.
//  Copyright (c) 2016 None. All rights reserved.
//

#ifndef watchdog_TypeSelectorController_h
#define watchdog_TypeSelectorController_h
@class Server;
@interface TypeSelectorController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong, nonatomic) IBOutlet NSArray *pickerItems;

-(NSString*)getSelection;

@end

#endif
