//
//  DetailViewController.m
//  watchdog
//
//  Created by Erik Mårtensson.
//  Copyright (c) 2016 None. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Server.h"
#import "DetailViewController.h"


@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
}

- (void)configureView {
    self.serverTypeText.text = self.server.type;
    self.serverNameText.text = self.server.title;
    self.serverAddressText.text = self.server.address;
    self.timeoutText.text = self.server.timeout;
    self.lastCheckedText.text = [self.server getLastCheckString];
    if(self.server.successful){
        self.lastCheckedText.textColor = [UIColor greenColor];
    } else {
        self.lastCheckedText.textColor = [UIColor redColor];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
