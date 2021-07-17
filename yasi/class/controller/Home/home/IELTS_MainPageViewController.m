//
//  MainPageViewController.m
//  LeftSlide
//
//  Created by huangzhenyu on 15/6/18.
//  Copyright (c) 2015年 eamon. All rights reserved.
//

#import "IELTS_MainPageViewController.h"
#import "AppDelegate.h"
#import "FSCalendar.h"
#import "IELTS_addRecVic.h"
#import "IELTS_RecordModel.h"
#import "IELTS_recordTableViewCell.h"
#import "IELTS_RecordDetailViewController.h"
#import "IELTS_statisViewController.h"

@interface IELTS_MainPageViewController ()<FSCalendarDataSource, FSCalendarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *nodataImg;
@property (weak, nonatomic) IBOutlet UILabel *nodataL;
@property (weak, nonatomic) IBOutlet UIButton *RecordBtn;
@property (weak, nonatomic) IBOutlet UIButton *tongjiBtn;

@property (strong, nonatomic) FSCalendar *calendar;
@property (weak, nonatomic) IBOutlet UIView *TopView;
@property (weak, nonatomic) IBOutlet UILabel *dateL;
@property (weak, nonatomic) IBOutlet UILabel *d1;
@property (weak, nonatomic) IBOutlet UILabel *d2;
@property (weak, nonatomic) IBOutlet UILabel *d3;

@property (strong, nonatomic) FSCalendar *cal;

@property (weak, nonatomic) IBOutlet UITableView *recordTable;

@property (nonatomic,strong)NSMutableArray *dateArr;

@end

@implementation IELTS_MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Ctime:) name:@"checkTime" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadre:) name:@"loadRecord" object:nil];
   
    self.title = @"IELTS Record";
    
    [self setupTableview];

//    [self loadRecord];
    
    _RecordBtn.selected = YES;
    _tongjiBtn.selected = NO;
    
    [self loadcal];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
    NSFontAttributeName : [UIFont fontWithName:@"PingFangSC-Regular" size:17]}];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = YES;

    //导航栏左侧按钮
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"sidebar button"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
//    self.view.frame =CGRectMake(100, 200, 100, 1000);
}
-(void)Ctime:(NSNotification *)noti
{

 NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
 _dateL.text = [userInfo objectForKey:@"time"];
    
  NSInteger days =  [self getDaysFrom: [self strToNsdate:[self getCurrentTimes]] To:[self strToNsdate:[userInfo objectForKey:@"time"]]];
    NSLog(@"天数----%ld",days);
    
    if (days>=1000) {
        _d1.text = @"9";
        _d2.text = @"9";
        _d3.text = @"9";
    }else{
        _d1.text = [NSString stringWithFormat:@"%ld", days/100];
        _d2.text = [NSString stringWithFormat:@"%ld", days%100/10];
        _d3.text = [NSString stringWithFormat:@"%ld", days%10];
    }
    
    
//    [_calendar selectDate:[self strToNsdate:[userInfo objectForKey:@"time"]]];

}

-(void)loadre:(NSNotification *)noti{
    
    [self loadRecord];
}
- (IBAction)recordAction:(UIButton *)sender {
   _RecordBtn.selected = YES;
//    _tongjiBtn.selected = NO;
//    _RecordBtn.userInteractionEnabled = NO;
//    _tongjiBtn.userInteractionEnabled = YES;
}

- (IBAction)tongjiAction:(UIButton *)sender {
    
//    _RecordBtn.selected = NO;
//    _tongjiBtn.selected = YES;
//    _RecordBtn.userInteractionEnabled = YES;
//    _tongjiBtn.userInteractionEnabled = ;
    
    
    IELTS_statisViewController *tongji = [[IELTS_statisViewController alloc]init];
    tongji.arr = _dateArr;
    [self.navigationController pushViewController:tongji animated:NO];
      
}
- (IBAction)Addreocrd:(UIButton *)sender {
    
    IELTS_addRecVic *vc = [[IELTS_addRecVic alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    nav.modalPresentationStyle = 0;
    
    [self presentViewController:nav animated:NO completion:nil];
    
    
}

- (void)loadcal
{
   
    _calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(10 , 20, 345-20,260)];
    
//    calendar.scope = FSCalendarScopeWeek;
 
    _calendar.scrollDirection = FSCalendarScrollDirectionHorizontal;
//    calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    [_calendar selectDate:[NSDate date] scrollToDate:YES];
    
    
    _calendar.scope = FSCalendarScopeWeek;
    _calendar.dataSource = self;
    _calendar.delegate = self;
    _calendar.backgroundColor = [UIColor clearColor];
    
    //
    _calendar.appearance.weekdayTextColor= [UIColor blackColor];
//    _calendar.appearance.weekdayFont = ;
    _calendar.appearance.titleDefaultColor = RGB(212, 88, 0, 1);
    _calendar.appearance.titleFont = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    _calendar.appearance.headerTitleColor = RGB(212, 88, 0, 1);
    _calendar.appearance.borderRadius=10;
    //
    [self.TopView addSubview:_calendar];
    

    
   
}

-(void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY.MM.dd"];

}

-(void)calendarCurrentPageDidChange:(FSCalendar *)calendar{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY.MM.dd"];
   

 
}

//拉出左侧菜单
- (void) openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
   
}
-(NSString*)getCurrentTimes{

NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

// ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

[formatter setDateFormat:@"yyy-MM-dd"];

//现在时间,你可以输出来看下是什么格式

NSDate *datenow = [NSDate date];



NSString *currentTimeString = [formatter stringFromDate:datenow];

return currentTimeString;

}

-(NSDate *)strToNsdate:(NSString *)str{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //拷贝时间格式，与字符串格式相同
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //把字符串theTime转为日期
    NSDate *theDate = [dateFormatter dateFromString:str];
    return theDate;
}

-(NSInteger)getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate
{
NSCalendar *gregorian = [[NSCalendar alloc]
initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

NSDate *fromDate;
NSDate *toDate;
[gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:serverDate];
[gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:endDate];
NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];


return dayComponents.day;
}

-(void)setupTableview{
//    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _recordTable.dataSource = self;//遵循数据源
    _recordTable.delegate = self;
    
    _recordTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_recordTable registerNib:[UINib nibWithNibName:@"IELTS_recordTableViewCell" bundle:nil] forCellReuseIdentifier:@"IELTS_recordTableViewCell"];
    
    _recordTable.backgroundView.backgroundColor = [UIColor clearColor];

    _recordTable.backgroundColor = [UIColor clearColor];
    
 
}
#pragma tableview
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dateArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 75;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IELTS_recordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IELTS_recordTableViewCell"];
    cell.recordModel = _dateArr[indexPath.row];
    
    NSString *index =[NSString stringWithFormat:@"%ld",indexPath.row+1];
    
    NSLog(@"index----%@",index);
    
    cell.indexL.text = index;
//    [cell.indexBtn setTitle:index forState:UIControlStateNormal];
    cell.backgroundColor = [UIColor clearColor];
    
  
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;

}
//
#pragma mark 测试
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除
    if (@available(iOS 11.0, *)) {
        UIContextualAction *delete = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            
    NSMutableDictionary *deleteDict = [NSMutableDictionary dictionary];
    IELTS_RecordModel *model = self.dateArr[indexPath.row];
    
    [deleteDict setObject:model.userid forKey:@"uid"];
    [deleteDict setObject:[NSString stringWithFormat:@"%ld",model.ID]  forKey:@"rid"];
    
    
    NSString *address = [NSString stringWithFormat:@"%@%@",Address,@"/deleteRecord"];
    
    [[HttpRequest shardWebUtil]postNetworkRequestURLString:address parameters:deleteDict success:^(id obj) {
        
//        NSLog(@"数据==%@",obj);
//        obj[@"status"] is
    
        
        if ([obj[@"status"] isEqualToString:@"3000"]) {
            
            [self.dateArr removeObjectAtIndex:indexPath.row];
            completionHandler (YES);
            [self.recordTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        
    } fail:^(NSError *error) {
        
        NSLog(@"错误==%@",error);
    }];
            
            
            
        }];
    delete.image = [UIImage imageNamed:@"detele"];//这里还可以设置图片
    delete.backgroundColor = [UIColor blackColor];
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[delete]];
    return config;
    } else {
        return nil;
        // Fallback on earlier versions
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IELTS_RecordModel *reM = _dateArr[indexPath.row];
    IELTS_RecordDetailViewController *detail = [[IELTS_RecordDetailViewController alloc]init];
    detail.recordM = reM;
    
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)loadRecord{
    
    _dateArr = [NSMutableArray array];
    
    __weak typeof(self) weakSelf = self;
    NSString *address = [NSString stringWithFormat:@"%@%@",Address,@"/allRecord"];
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[userInfo objectForKey:@"id"] forKey:@"userid"];
    
    
//    NSLog(@"字典----%@",dic);
    [[HttpRequest shardWebUtil]getNetworkRequestURLString:address parameters:dic success:^(id obj) {
        
        NSLog(@"data----%@",obj[@"data"]);
        
        for (NSDictionary *d in obj[@"data"]) {
            
            IELTS_RecordModel *model = [[IELTS_RecordModel alloc]initWithDictionary:d error:nil];
            if (model !=nil) {
                
                [weakSelf.dateArr addObject:model];
                
            }
            
        }
       dispatch_async(dispatch_get_main_queue(), ^{
           // UI更新代码
           [weakSelf.recordTable reloadData];
        });
        NSLog(@"arr ===== %@",weakSelf.dateArr);
        if (weakSelf.dateArr.count==0) {
            
            weakSelf.nodataImg.hidden = NO;
            weakSelf.nodataL.hidden = NO;
            
        }else{
            
            weakSelf.nodataImg.hidden = YES;
             weakSelf.nodataL.hidden = YES;
        }
        
    } fail:^(NSError *error) {
        
        
    }];
   
        
    
}
@end
