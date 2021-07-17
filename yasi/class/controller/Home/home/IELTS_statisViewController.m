//
//  IELTS_statisViewController.m
//  yasi
//
//  Created by MrLee on 2020/5/6.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import "IELTS_statisViewController.h"
#import "IELTS_RecordModel.h"
#import "LewBarChart.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@interface IELTS_statisViewController ()
@property (weak, nonatomic) IBOutlet UILabel *passL;
@property (weak, nonatomic) IBOutlet UILabel *failL;
@property (weak, nonatomic) IBOutlet UILabel *totalL;

@property(nonatomic,strong)NSMutableArray *yVals1;
@property(nonatomic,strong)NSMutableArray *yVals2;
@property(nonatomic,strong)NSMutableArray *yVals3;
@property(nonatomic,strong)NSMutableArray *yVals4;
@property(nonatomic,strong)NSMutableArray *yVals5;


@property (nonatomic)LewBarChart *barChart;

@end

@implementation IELTS_statisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    NSString *tar = [userInfo objectForKey:@"target"];

    NSInteger pass  = 0 ;
    NSInteger fail  = 0 ;
    _yVals1 = [[NSMutableArray alloc] init];
    _yVals2 = [[NSMutableArray alloc] init];
    _yVals3 = [[NSMutableArray alloc] init];
    _yVals4 = [[NSMutableArray alloc] init];
    _yVals5 = [[NSMutableArray alloc] init];
    
//    NSLog(@"times ----- %ld",_arr.count);
    //
    for (IELTS_RecordModel *model in _arr) {

        
        if ([model.total floatValue]>=[tar floatValue]) {
            
            
            pass = pass + 1 ;
        }else if([model.total floatValue]<[tar floatValue]){
            
            fail = fail + 1 ;
        }
        
    }
    _passL.text =  [NSString stringWithFormat:@"%ld",pass];
    _failL.text =  [NSString stringWithFormat:@"%ld",fail];
    _totalL.text = [NSString stringWithFormat:@"%ld",_arr.count];
    //
    
    
    if (_arr.count>=5) {
        
        _arr = [_arr subarrayWithRange:NSMakeRange(_arr.count-5, 5)];
    }else{
        
//        NSLog(@"----%ld",_arr.count);
        
        for ( int i=0;i<=(5-_arr.count); i++) {
            IELTS_RecordModel *mode = [[IELTS_RecordModel alloc]init];
            mode.listen = @"0";
            mode.speak = @"0";
            mode.read = @"0";
            mode.write = @"0";
            mode.total = @"0";
            
            [_arr addObject:mode];
            
        }
//        NSLog(@"----%ld",_arr.count);
        
    }
    
    for (IELTS_RecordModel *model in _arr) {
        int lis = [model.listen intValue];
        int sp = [model.speak intValue];
        int read = [model.read intValue];
        int write = [model.write intValue];
        int total = [model.total intValue];
//        NSLog(@"=====%d",lis);
        [_yVals1 addObject:@(lis)];
        [_yVals2 addObject:@(sp)];
        [_yVals3 addObject:@(read)];
        [_yVals4 addObject:@(write)];
        [_yVals5 addObject:@(total)];

        
    }
    [self setupBarChart];


    
}

-(void)setupNav{
    
    self.title = @"Score Statistics";
    
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
- (void)setupBarChart{
    _barChart = [[LewBarChart alloc]initWithFrame:CGRectMake(0, 340, SCREEN_WIDTH, 300)];


    
    LewBarChartDataSet *set1 = [[LewBarChartDataSet alloc] initWithYValues:_yVals1 label:@"listen"];
    [set1 setBarColor:[UIColor colorWithRed:210.0 / 255.0 green:223.0 / 255.0 blue:49.0 / 255.0 alpha:1.0f]];
    LewBarChartDataSet *set2 = [[LewBarChartDataSet alloc] initWithYValues:_yVals2 label:@"speak"];
    [set2 setBarColor:[UIColor colorWithRed:56.0 / 255.0 green:255.0 / 255.0 blue:78.0 / 250.0 alpha:1.0f]];
    
    LewBarChartDataSet *set3 = [[LewBarChartDataSet alloc] initWithYValues:_yVals3 label:@"read"];
    [set3 setBarColor:[UIColor colorWithRed:255.0 / 255.0 green:105.0 / 255.0 blue:180.0 / 255.0 alpha:1.0f]];
    
    LewBarChartDataSet *set4 = [[LewBarChartDataSet alloc] initWithYValues:_yVals4 label:@"write"];
    [set4 setBarColor:[UIColor colorWithRed:255.0 / 255.0 green:199.0 / 255.0 blue:126.0 / 255.0 alpha:1.0f]];
    
    LewBarChartDataSet *set5 = [[LewBarChartDataSet alloc] initWithYValues:_yVals5 label:@"total"];
       [set5 setBarColor:[UIColor colorWithRed:0.0 / 255.0 green:191.0 / 255.0 blue:255.0 / 255.0 alpha:1.0f]];
    

    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    [dataSets addObject:set3];
    [dataSets addObject:set4];
    [dataSets addObject:set5];

    
    LewBarChartData *data = [[LewBarChartData alloc] initWithDataSets:dataSets];
    data.xLabels = @[@"1",@"2",@"3",@"4",@"5"];
    data.itemSpace = 6;
    _barChart.data = data;
    _barChart.displayAnimated = YES;
    
    _barChart.chartMargin = UIEdgeInsetsMake(20, 15, 45, 15);
    //    _barChart.showXAxis = NO;
    _barChart.showYAxis = NO;
    _barChart.showNumber = YES;
    _barChart.legendView.alignment = LegendAlignmentHorizontal;
    
    [self.view addSubview:_barChart];
    [_barChart show];
    
    CGPoint legendCenter = CGPointMake(SCREEN_WIDTH-_barChart.legendView.bounds.size.width/2, -18);
    _barChart.legendView.center = legendCenter;
}

-(void)backHome{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
