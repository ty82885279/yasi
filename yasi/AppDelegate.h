//
//  AppDelegate.h
//  yasi
//
//  Created by MrLee on 2020/4/23.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "IELTS_LeftSlideViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic)UIWindow * window;

@property (strong, nonatomic) IELTS_LeftSlideViewController *LeftSlideVC;
@property (strong, nonatomic) UINavigationController *mainNavigationController;


@end

