//
//  BaseNavigationController.m
//  FuelTreasureProject
//
//  Created by 吴仕海 on 4/7/15.
//  Copyright (c) 2015 XiTai. All rights reserved.
//

#import "BaseNavigationController.h"
//#import "BaseViewController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
