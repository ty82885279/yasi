//
//  IELTS_AboutAppViewController.m
//  yasi
//
//  Created by MrLee on 2020/5/6.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import "IELTS_AboutAppViewController.h"

@interface IELTS_AboutAppViewController ()

@end

@implementation IELTS_AboutAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupNav];
}
-(void)setupNav{
    
    self.title = @"About App";
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
    NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Regular" size:17]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = YES;

    //导航栏左侧按钮
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 15, 25);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
}
-(void)backHome
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
