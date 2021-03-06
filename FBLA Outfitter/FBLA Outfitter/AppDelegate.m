//
//  AppDelegate.m
//  FBLA Outfitter
//
//  Created by Colby Tobin on 10/25/15.
//  Copyright (c) 2015 Tobin Technologies. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *identifier;
    CGSize iosScreenSize = [[UIScreen mainScreen] bounds].size;
    NSString *board;
    NSString *user = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
    
    if(user != nil)
        identifier = @"logged";
    else
        identifier = @"fail";
    
    if(iosScreenSize.height == 480)
        board = @"Iphone4";
    if(iosScreenSize.height == 568)
        board = @"Iphone5";
    if(iosScreenSize.height == 667)
        board = @"Main";
    if(iosScreenSize.height == 736)
        board = @"Iphone6plus";
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:board bundle:nil];
    
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber=10;
    self.window.rootViewController = viewController;
    [self.window makeKeyAndVisible];

    return YES;
}

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

@end
