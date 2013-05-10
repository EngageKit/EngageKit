//
//  EngageKit.m
//  EngageKit
//
//  Created by Atsushi Nagase on 5/8/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import "EngageKit.h"
#import "Mixpanel.h"
#import <Parse/Parse.h>

@implementation EngageKit

static EngageKit *sharedInstance = nil;

#pragma mark * Initializiation

+ (instancetype)sharedInstanceWithMixpanelToken:(NSString *)mixpanelToken
                             parseApplicationId:(NSString *)applicationId
                                 parseClientKey:(NSString *)parseClientKey {
  @synchronized(self) {
    if (sharedInstance == nil) {
      sharedInstance =
      [[super alloc] initWithMixpanelToken:mixpanelToken
                        parseApplicationId:applicationId
                            parseClientKey:parseClientKey];
    }
    return sharedInstance;
  }
}

+ (instancetype)sharedInstance {
  @synchronized(self) {
    if (sharedInstance == nil) {
      NSLog(@"%@ warning sharedInstance called before sharedInstanceWithMixpanelToken:parseApplicationId:parseClientKey:", self);
    }
    return sharedInstance;
  }
}

#pragma mark - Initializing

- (id)initWithMixpanelToken:(NSString *)mixpanelToken
         parseApplicationId:(NSString *)applicationId
             parseClientKey:(NSString *)parseClientKey {
  if(self = [super init]) {
    [Mixpanel sharedInstanceWithToken:mixpanelToken];
    [Parse setApplicationId:applicationId clientKey:parseClientKey];
  }
  return self;
}

#pragma mark - Identify

- (BOOL)identify {
  PFUser *user = [PFUser currentUser];
  [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    if(succeeded) {
      MixpanelPeople *people = [[Mixpanel sharedInstance] people];
      if(user.email)
        [people set:@"$email" to:user.email];
      if(user.username)
        [people set:@"$username" to:user.username];
      if(user.createdAt)
        [people set:@"$created" to:user.createdAt];
      [[Mixpanel sharedInstance] identify:user.objectId];
    }
  }];
  return !!user;
}

#pragma mark - UIApplicationDelegate

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  [[[Mixpanel sharedInstance] people] addPushDeviceToken:deviceToken];
  [PFPush storeDeviceToken:deviceToken];
}

- (BOOL)handleOpenURL:(NSURL *)URL {
  // TODO: handle options and open web view modally.
  return NO;
}

@end
