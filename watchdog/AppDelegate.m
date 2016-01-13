//
//  AppDelegate.m
//  watchdog
//
//  Created by Erik Mårtensson.
//  Copyright (c) 2016 None. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MasterViewController.h"
#import "Server.h"
#import "Socket.h"
#import "Storage.h"

@implementation AppDelegate

- (void) application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    NSLog(@"Background fetch started.");
    
    UINavigationController *rootController = (UINavigationController *)self.window.rootViewController;
    MasterViewController *masterViewController;
    if (rootController.viewControllers){
        for (UINavigationController *view in rootController.viewControllers) {
            if ([view isKindOfClass:[UINavigationController class]])
                for (UIViewController *view2 in view.viewControllers)
                    if ([view2 isKindOfClass:[MasterViewController class]])
                        masterViewController = (MasterViewController *)view2;
        }
    }
    
    Boolean successful = false;
    
    for(Server *server in [masterViewController.storage getServers]){
        if([server timeoutPassed]){
            Socket *conn = [[Socket alloc] initSocketWithIPAndPort:@"192.168.1.150" port:24070];
            successful = [conn checkServer:server];
            NSDate *cur = [NSDate date];
            [server setLastCheck:cur];
            server.successful = successful;
            [masterViewController.storage saveServers];
            if(server.successful == false){
                NSString *tempString = @"Server did not respond! Host: ";
                [self showAlertForError:[tempString stringByAppendingString:server.title]];
            }
            NSLog(@"Check was made.");
        } else {
            NSLog(@"Check was not made.");
        }
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
    
    NSLog(@"Background fetch completed...");
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    // Override point for customization after application launch.
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    [[UIApplication sharedApplication]
     setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    splitViewController.delegate = self;
    return YES;
}

/*
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
 */

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

- (void)showAlertForError:(NSString*)error {
    UILocalNotification *errorNotification = [[UILocalNotification alloc] init];
    errorNotification.alertBody = error;
    errorNotification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:errorNotification];
}

@end

