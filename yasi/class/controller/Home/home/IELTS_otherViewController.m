//
//  otherViewController.m
//  LGDeckViewController
//
//  Created by huangzhenyu on 15/6/1.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import "IELTS_otherViewController.h"
#import "ViewController.h"

@interface IELTS_otherViewController ()

@end

@implementation IELTS_otherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    
    //右边导航栏的按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 28)];
    [rightButton setTitle:@"下个页面" forState:(UIControlStateNormal)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    // Add your action to your button
    rightButton.userInteractionEnabled = YES;
    [rightButton addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    //    [rightButton setBackgroundImage:[UIImage imageNamed:@"设置"] forState:(UIControlStateNormal)];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = barBtn;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    /**
     width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和  边界间距为5pix，所以width设为-5时，间距正好调整为0；width为正数 时，正好相反，相当于往左移动width数值个像素
     */
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, barBtn, nil];
}
-(void) rightBtn  {
    
//    [self.navigationController popViewControllerAnimated:YES];
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
