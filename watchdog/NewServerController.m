//
//  NewServerController.m
//  watchdog
//
//  Created by Erik Mårtensson.
//  Copyright (c) 2016 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Server.h"
#import "NewServerController.h"
#import "TypeSelectorController.h"
#import "TimeSelectorController.h"

@implementation NewServerController

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (Server*)getServerObject{
    Server* serverObject = [[Server alloc] initServerWithType:self.selectTypeButton.titleLabel.text serverTitle:self.titleText.text serverAddress:self.addressText.text maxTimeout:self.selectDateButton.titleLabel.text];
    return serverObject;
}

- (IBAction)backFromTypeSelector:(UIStoryboardSegue *)segue{
    TypeSelectorController* controller = segue.sourceViewController;
    NSString* temporarySelection = [controller getSelection];
    [self.selectTypeButton setTitle:temporarySelection forState:UIControlStateNormal];
    
    [self.tableView reloadData];
}

- (IBAction)backFromDateSelector:(UIStoryboardSegue *)segue{
    TimeSelectorController* controller = segue.sourceViewController;
    NSInteger temporarySelection = [controller getSelection];
    [self.selectDateButton setTitle:[NSString stringWithFormat: @"%ld", temporarySelection] forState:UIControlStateNormal];
    [self.tableView reloadData];
}

- (void)showAlertForError:(NSString*)error {
    UIAlertView* alertMessage = [[UIAlertView alloc] initWithTitle:@"Error"
                                                       message:error
                                                      delegate:self
                                             cancelButtonTitle:@"Ok"
                                             otherButtonTitles:nil, nil];
    [alertMessage show];
}


- (IBAction)Click:(id)sender {
    if([self.selectTypeButton.titleLabel.text isEqualToString:@"Select type"]){
        [self showAlertForError:@"You have to select a type before saving!"];
    } else if([self.titleText.text isEqualToString:@""]){
        [self showAlertForError:@"You have to type in a title for the server!"];
    } else if([self.addressText.text isEqualToString:@""]){
        [self showAlertForError:@"You have to type in an address for the server!"];
    } else if([self.selectDateButton.titleLabel.text isEqualToString:@"Select time"]){
        [self showAlertForError:@"You have to select a timeout before saving!"];
    } else if([self.selectDateButton.titleLabel.text isEqualToString:@"0"]){
        [self showAlertForError:@"You may not choose 0 as interval!"];
    } else {
        [self performSegueWithIdentifier:@"unwindToMainMenu" sender:self];
    }
    
}


@end