//
//  EngageKit.h
//  EngageKit
//
//  Created by Atsushi Nagase on 5/8/13.
//  Copyright (c) 2013 LittleApps Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EngageKit : NSObject

+ (instancetype)sharedInstanceWithMixpanelToken:(NSString *)mixpanelToken
                             parseApplicationId:(NSString *)applicationId
                                 parseClientKey:(NSString *)parseClientKey;

+ (instancetype)sharedInstance;

- (id)initWithMixpanelToken:(NSString *)mixpanelToken
         parseApplicationId:(NSString *)applicationId
             parseClientKey:(NSString *)parseClientKey;

- (BOOL)identify;


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

- (BOOL)handleOpenURL:(NSURL *)URL;

@end
