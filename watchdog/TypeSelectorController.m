//
//  TypeSelectorController.m
//  watchdog
//
//  Created by Erik Mårtensson.
//  Copyright (c) 2016 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TypeSelectorController.h"

@implementation TypeSelectorController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pickerItems = @[@"Ping", @"HTTP"];
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        [self performSegueWithIdentifier:@"unwindToNewServerFromType" sender:self];
    }
    [super viewWillDisappear:animated];
}

- (NSString *)getSelection{
    NSString *tempString = [self pickerView:self.pickerView titleForRow:[self.pickerView selectedRowInComponent:0] forComponent:0];
    return tempString;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerItems.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerItems[row];
}

@end