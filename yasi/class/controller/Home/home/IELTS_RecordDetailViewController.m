//
//  IELTS_RecordDetailViewController.m
//  yasi
//
//  Created by MrLee on 2020/5/5.
//  Copyright © 2020 MrLee. All rights reserved.
//



#import "IELTS_RecordDetailViewController.h"

#define kViewWidth(View) CGRectGetWidth(View.frame)
#define kViewHeight(View) CGRectGetHeight(View.frame)

@interface IELTS_RecordDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *totalL;
@property (weak, nonatomic) IBOutlet UILabel *averL;
@property (weak, nonatomic) IBOutlet UIImageView *isPassImg;
@property (weak, nonatomic) IBOutlet UILabel *readL;
@property (weak, nonatomic) IBOutlet UILabel *speakL;
@property (weak, nonatomic) IBOutlet UILabel *writeL;
@property (weak, nonatomic) IBOutlet UILabel *listenL;
@property (weak, nonatomic) IBOutlet UILabel *noteTV;

@property (weak, nonatomic) IBOutlet UIView *radarView;


@end

@implementation IELTS_RecordDetailViewController
- (void)viewDidLayoutSubviews

{
     [super viewDidLayoutSubviews];//获取真实的frame


    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setupNav];
    [self setupRadar];
    [self setupModel];
}
-(void)setupNav{
    
    self.title = @"Record Detail";
    
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
-(void)setupRadar{

}
-(void)setupModel{
    
    _totalL.text = _recordM.total;
    _averL.text  = _recordM.average;
    _listenL.text= _recordM.listen;
    _speakL.text = _recordM.speak;
    _readL.text  = _recordM.read;
    _writeL.text = _recordM.write;
    _noteTV.text = _recordM.note;
    
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *tar = [userInfo objectForKey:@"target"];
    if ([tar floatValue]>=[_recordM.read floatValue]) {//pass
        _isPassImg.image = [UIImage imageNamed:@"mypass"];
    }else{
        _isPassImg.image = [UIImage imageNamed:@"mynot"];
    }
   
    
}
-(void)backHome
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
