//
//  ChecklistsAppDelegate.m
//  Checklists
//
//  Created by Jamie Conroy on 12/03/2014.
//  Copyright (c) Jamie Conroy. All rights reserved.
//

#import "ChecklistsAppDelegate.h"
#import "AllListsViewController.h"

@implementation ChecklistsAppDelegate

@synthesize window = _window;

//Launched when the app starts for doing notifications
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)saveData
{
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    AllListsViewController *controller = (AllListsViewController *)[navigationController.viewControllers objectAtIndex:0];
    [controller.dataModel saveChecklists];
}


//The next three methods deal with the same thing
//Dealing with notifications that the app will terminate or suspend

//Method 1
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self saveData];
}

//Method 2
- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

//Method 3
- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveData];
}


//This method will be invoked when the local notification is posted
//And the app is still running (or suspended)
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"didReceiveLocalNotification %@", notification);
}

@end
