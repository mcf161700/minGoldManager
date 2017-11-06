//
//  AppDelegate.h
//  GoldManager
//
//  Created by minchangfeng on 2017/6/30.
//  Copyright © 2017年 Gevent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "BaseNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) BaseNavigationController *rootNaviController;

+ (AppDelegate *)sharedInstance;
@end

