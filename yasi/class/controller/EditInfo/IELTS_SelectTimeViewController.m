//
//  IELTS_SelectTimeViewController.m
//  yasi
//
//  Created by MrLee on 2020/4/26.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import "IELTS_SelectTimeViewController.h"

@interface IELTS_SelectTimeViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)NSArray *yearArr;
@property(nonatomic,strong)NSMutableArray *monthArr;
@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,strong)NSString *yStr;
@property(nonatomic,strong)NSString *mStr;
@property(nonatomic,strong)NSString *dStr;

@property(nonatomic,strong)NSString *timeStr;
@end

@implementation IELTS_SelectTimeViewController

- (void)viewDidLoad {
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    if (![[userInfo objectForKey:@"time"] isEqualToString:@"no"]) {
        
        NSString *tStr = [userInfo objectForKey:@"time"];
        NSArray *array = [tStr componentsSeparatedByString:@"-"];
        _yStr = array[0];
        _mStr = array[1];
        _dStr = array[2];
    }
    
    [super viewDidLoad];
    [self setupPicker];
    [self initArr];
    
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 1001) {
        
        return 6;
    }else if (pickerView.tag == 1002){
        return 12;
    }else{
        
    } return 30;
   
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor clearColor];
        }
    }
 
    NSArray *tempArr = [NSArray array];
    if (pickerView.tag == 1001) {
        tempArr = _yearArr;
        
    }else if (pickerView.tag == 1002){
        tempArr = _monthArr;
    }else if (pickerView.tag == 1003){
        tempArr = _dataArr;
    }
    
    
    UILabel *tepL;
    tepL = [[UILabel alloc]init];
    
    tepL.text = tempArr[row];
    tepL.adjustsFontSizeToFitWidth = YES;
    tepL.textAlignment = 1;
    tepL.transform = CGAffineTransformMakeRotation(M_PI_2);
    tepL.textColor = [UIColor whiteColor];
    
    return tepL;
        

    
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 44;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    NSLog(@"----%ld",(long)row);
    if (pickerView.tag == 1001) {
        
        NSString *yStr = _yearArr[row];
        _yStr = yStr;
        
        for(int i =0; i < yStr.length; i++)
        {
            if (i==0) {
                
                _y1.text =[NSString stringWithFormat:@"%c", [yStr characterAtIndex:i]];
            }
            if (i ==1){
                _y2.text =[NSString stringWithFormat:@"%c", [yStr characterAtIndex:i]];
            }
            if (i ==2){
                _y3.text =[NSString stringWithFormat:@"%c", [yStr characterAtIndex:i]];
            }
            if (i ==3){
                _y4.text =[NSString stringWithFormat:@"%c", [yStr characterAtIndex:i]];
            }
           
        }
    }
    //
 if (pickerView.tag == 1002) {
          
          NSString *mStr = _monthArr [row];
          if (mStr.length == 1) {
             
              _mStr = [NSString stringWithFormat:@"0%@",mStr];
          }else{
              _mStr = mStr;
          }
          
          for(int i =0; i < mStr.length; i++)
          {
              if(mStr.length==1) {
                  if (i == 0) {
                      
                      _m1.text = @"0";
                      _m2.text =[NSString stringWithFormat:@"%c", [mStr characterAtIndex:i]];
                  }
                  
              }else{
                  if (i == 0) {
                      
                      _m1.text =[NSString stringWithFormat:@"%c", [mStr characterAtIndex:i]];
                      
                  }
                 
                  if (i == 1) {
                      
                      
                      _m2.text =[NSString stringWithFormat:@"%c", [mStr characterAtIndex:i]];
                  }
              }
              
              
          }
      }
    //
    //日
    if (pickerView.tag == 1003) {
        
        NSString *dStr = _dataArr [row];
        if (dStr.length == 1) {
             _dStr = [NSString stringWithFormat:@"0%@",dStr];
         }else{
             _dStr = dStr;
         }
       
        for(int i =0; i < dStr.length; i++)
        {
            if(dStr.length==1) {
                if (i == 0) {
                    
                    _d1.text = @"0";
                    _d2.text =[NSString stringWithFormat:@"%c", [dStr characterAtIndex:i]];
                }
                
            }else{
                if (i == 0) {
                    
                    _d1.text =[NSString stringWithFormat:@"%c", [dStr characterAtIndex:i]];
                    
                }
               
                if (i == 1) {
                    
                    
                    _d2.text =[NSString stringWithFormat:@"%c", [dStr characterAtIndex:i]];
                }
            }
            
            
        }
    }
}


-(void)initArr{
    _yearArr = @[@"2020",@"2021",@"2022",@"2023",@"2024",@"2025"];
    _monthArr = [NSMutableArray array];
    _dataArr = [NSMutableArray array];
    
    for (int m = 1; m<=12; m++) {
        
        NSString *monstr= [NSString stringWithFormat:@"%d",m];
        [_monthArr addObject:monstr];
        
    }
    
    for (int d = 1; d<= 30; d++) {
        
        NSString *daystr= [NSString stringWithFormat:@"%d",d];
        [_dataArr addObject:daystr];
        
    }
//    NSLog(@"shuzu -=----%@",_monthArr);
    
    
}
-(void)setupPicker{
    
    self.yearP.tag = 1001;
    self.monthP.tag = 1002;
    self.dataP.tag = 1003;
        
    self.yearP.delegate = self;
    self.yearP.dataSource = self;
    self.yearP.transform = CGAffineTransformMakeRotation(M_PI*3/2);
    //
    self.monthP.delegate = self;
    self.monthP.dataSource = self;
    self.monthP.transform = CGAffineTransformMakeRotation(M_PI*3/2);
    //
    
    self.dataP.delegate = self;
    self.dataP.dataSource = self;
    self.dataP.transform = CGAffineTransformMakeRotation(M_PI*3/2);
    
   NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    
    [self initArr];
   
    if ([[userInfo objectForKey:@"time"] isEqualToString:@"no"]) {
        
        NSLog(@"1111");
        [_yearP selectRow:1 inComponent:0 animated:NO];
        [_monthP selectRow:3 inComponent:0 animated:NO];
        [_dataP selectRow:27 inComponent:0 animated:NO];
        _y1.text = @"2";
        _y2.text = @"0";
        _y3.text = @"2";
        _y4.text = @"1";
        _m1.text = @"0";
        _m2.text = @"4";
        _d1.text = @"2";
        _d2.text = @"8";
        
        
    }else{
//        NSLog(@"2222");
        NSString *timeStr =[userInfo objectForKey:@"time"];
        NSArray *array = [timeStr componentsSeparatedByString:@"-"];
        NSString *y = array[0];
        NSString *m = array[1];
        NSString *d = array[2];
        
        //
        for(int i =0; i < y.length; i++){
           if (i==0) {
               
               _y1.text =[NSString stringWithFormat:@"%c", [y characterAtIndex:i]];
           }
           if (i ==1){
               _y2.text =[NSString stringWithFormat:@"%c", [y characterAtIndex:i]];
           }
           if (i ==2){
               _y3.text =[NSString stringWithFormat:@"%c", [y characterAtIndex:i]];
           }
           if (i ==3){
               _y4.text =[NSString stringWithFormat:@"%c", [y characterAtIndex:i]];
           }
          
       }
        //
        
        for(int i =0; i < m.length; i++)
        {
            
            if (i == 0) {
                
                _m1.text =[NSString stringWithFormat:@"%c", [m characterAtIndex:i]];
                
            }
           
            if (i == 1) {
                
                
                _m2.text =[NSString stringWithFormat:@"%c", [m characterAtIndex:i]];
            }
            
            
            
        }
        
        //
        for(int i =0; i < d.length; i++)
               {
                   
                   if (i == 0) {
                       
                       _d1.text =[NSString stringWithFormat:@"%c", [d characterAtIndex:i]];
                       
                   }
                  
                   if (i == 1) {
                       
                       
                       _d2.text =[NSString stringWithFormat:@"%c", [d characterAtIndex:i]];
                   }
                   
                   
                   
               }
        
        //pickerView显示用户的时间
//        NSLog(@"y---m---d---%@,%@,%@",y,m,d);
        [_yearP selectRow:[_yearArr indexOfObject:y] inComponent:0 animated:NO];
//        NSLog(@"转----%d",[m intValue]);
        
        if ([m intValue]<10) {
            
            m = [m substringFromIndex:1];
            
//            NSLog(@"weizhi-----%lu",(unsigned long)[_monthArr indexOfObject:m]);
//            NSLog(@"数组---%@",_monthArr);
              [_monthP selectRow:[_monthArr indexOfObject:m] inComponent:0 animated:NO];
        }else{
//            NSLog(@"weizhi-----%lu",(unsigned long)[_monthArr indexOfObject:m]);
//            NSLog(@"数组---%@",_monthArr);
            [_monthP selectRow:[_monthArr indexOfObject:m] inComponent:0 animated:NO];
        }
        //
        if ([d intValue]<10) {
                   
            d = [d substringFromIndex:1];
            [_dataP selectRow:[_monthArr indexOfObject:d] inComponent:0 animated:NO];
        }else{
            [_dataP selectRow:[_monthArr indexOfObject:d] inComponent:0 animated:NO];
        }
      
      
        
        //Todo
        /*
         登录后显示用户的真实考试时间
         
         */
        
    }
   
}
- (IBAction)dismiss:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)SaveTimeToLocalInfo:(UIButton *)sender {
    
    
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
//    NSLog(@"++++ %@",[userInfo objectForKey:@"time"]);
    
    if ([[userInfo objectForKey:@"time"] isEqualToString:@"no"]) {
        _timeStr = @"2021-04-28";
    }else{
        _timeStr = [NSString stringWithFormat:@"%@-%@-%@",_yStr,_mStr,_dStr];
        [userInfo setObject:_timeStr forKey:@"time"];
        [userInfo synchronize];
    }
   
   
    [[NSNotificationCenter defaultCenter] postNotificationName:@"time" object:_timeStr];

    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    
   [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
