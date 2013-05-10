//
//  EngageKitDemoAppDelegate.m
//  EngageKitDemo
//
//  Created by Atsushi Nagase on 5/8/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "EngageKitDemoAppDelegate.h"
#import <EngageKit/EngageKit.h>

@implementation EngageKitDemoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  [[EngageKit sharedInstance]
   application:application
   didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
  if([[EngageKit sharedInstance] handleOpenURL:url]) {
    return YES;
  }
  return NO;
}

@end
