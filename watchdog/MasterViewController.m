//
//  MasterViewController.m
//  watchdog
//
//  Created by Erik Mårtensson.
//  Copyright (c) 2016 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "NewServerController.h"
#import "Server.h"
#import "Timer.h"

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", @"Testmessage");
    self.settings = [NSUserDefaults standardUserDefaults];
    @try {
        self.servers = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:[self.settings objectForKey:@"Servers"]]];
    } @catch ( NSException *ex ) {
        NSLog(@"%@", [ex callStackSymbols]);
    }
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Server *server = self.servers[indexPath.row];
        DetailViewController *control = (DetailViewController *)[segue.destinationViewController topViewController];
        control.server = server;
        //[control setLabelsWithServer:server];
        
        
        // Splitview configuration
        control.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        control.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.servers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    Server* server = self.servers[indexPath.row];
    cell.textLabel.text = server.title;
    cell.detailTextLabel.text = server.address;
    
    return cell;
}

- (IBAction)backToMainView:(UIStoryboardSegue *)segue{
    NewServerController* controller = segue.sourceViewController;
    Server* temporaryServer = [controller getServerObject];
    [self.servers addObject:temporaryServer];
    [self saveSettings];
    [self.tableView reloadData];
}

- (void)saveSettings{
    NSData *tempData = [NSKeyedArchiver archivedDataWithRootObject:self.servers];
    [self.settings setObject:tempData forKey:@"Servers"];
    [self.settings synchronize];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.servers removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        [self saveSettings];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (IBAction)setTableViewEdit:(id)sender {
    if ([self.tableView isEditing]) {
        [self.tableView setEditing:NO animated:YES];
        [self.editButton setTitle:@"Edit"];
    }
    else {
        [self.editButton setTitle:@"Done"];
        [self.tableView setEditing:YES animated:YES];
    }
}

@end
