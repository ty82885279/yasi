//
//  IELTS_FeedbackViewController.m
//  yasi
//
//  Created by MrLee on 2020/5/6.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import "IELTS_FeedbackViewController.h"

@interface IELTS_FeedbackViewController ()
@property (weak, nonatomic) IBOutlet UITextView *feedTV;
@property (weak, nonatomic) IBOutlet UITextField *feedTF;

@end

@implementation IELTS_FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
}
- (IBAction)sure:(UIButton *)sender {
    
    if (_feedTF.text.length==0||_feedTV.text.length==0) {
        
        [SVProgressHUD showErrorWithStatus:@"Please enter content"];
        [SVProgressHUD dismissWithDelay:1];
    }else{
        
        [SVProgressHUD showSuccessWithStatus:@"Submitted successfully"];
        [SVProgressHUD dismissWithDelay:1];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)setupNav{
    
    self.title = @"Feedback";
    
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
