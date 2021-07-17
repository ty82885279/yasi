//
//  IELTS_addRecVic.m
//  yasi
//
//  Created by MrLee on 2020/4/30.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import "IELTS_addRecVic.h"

@interface IELTS_addRecVic ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tf1;
@property (weak, nonatomic) IBOutlet UITextField *tf2;
@property (weak, nonatomic) IBOutlet UITextField *tf3;
@property (weak, nonatomic) IBOutlet UITextField *tf4;
@property (weak, nonatomic) IBOutlet UILabel *totalL;
@property (weak, nonatomic) IBOutlet UILabel *avaL;
@property (weak, nonatomic) IBOutlet UITextField *noteL;

@end

@implementation IELTS_addRecVic

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNav];
}

#pragma mark -UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"begin");
    NSLog(@"----%@",textField.text);
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"end");
    NSLog(@"----%@",textField.text);
}
#pragma mark -监听uitextfield的值得变化
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//   NSLog(@"textField4 - 正在编辑, 当前输入框内容为: %@",textField.text);
//   return YES;
//}

#pragma mark -给每个cell中的textfield添加事件，只要值改变就调用此函数
-(void)changedTextField:(UITextField *)textField
{
    NSLog(@"值是---%@",textField.text);
    if ([textField.text floatValue]>9) {
        [SVProgressHUD showErrorWithStatus:@"The score cannot be more than 9."];
        [SVProgressHUD dismissWithDelay:0.7 completion:^{
            textField.text = @"";
        }];
    }
    if (![_tf1.text isEqualToString:@""]&&![_tf3.text isEqualToString:@""]&&![_tf3.text isEqualToString:@""]&&![_tf4.text isEqualToString:@""]) {
        _avaL.text = [NSString stringWithFormat:@"%.2f",([_tf1.text floatValue]+[_tf2.text floatValue]+[_tf3.text floatValue]+[_tf4.text floatValue])/4.0];
         NSString * str = [NSString stringWithFormat:@"%.3f",([_tf1.text floatValue]+[_tf2.text floatValue]+[_tf3.text floatValue]+[_tf4.text floatValue])/4.0];;
         NSArray * arr =  [str componentsSeparatedByString:@"."];
         CGFloat value=0.0;
         if ([arr[1] integerValue]<=250) {
                value = [arr[0] floatValue];
        }else if([arr[1] integerValue]>250&&[arr[1] integerValue]<=740){
                value = [arr[0] floatValue]+0.5;
        }else{
                value = [arr[0] floatValue]+1.0;
        }
        _totalL.text = [NSString stringWithFormat:@"%.1f",value];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}

-(void)initNav{
    
    self.title = @"Add Record";
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
    [menuBtn addTarget:self action:@selector(diss:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    
    _tf1.delegate = self;
    
    _tf2.delegate = self;
    _tf3.delegate = self;
    _tf4.delegate = self;
    _tf1.text = @"";
    _tf2.text = @"";
    _tf3.text = @"";
    _tf4.text = @"";
    _tf1.textColor = [UIColor whiteColor];
    _tf2.textColor = [UIColor whiteColor];
    _tf3.textColor = [UIColor whiteColor];
    _tf4.textColor = [UIColor whiteColor];
    [_tf1 addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    [_tf2 addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    [_tf3 addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    [_tf4 addTarget:self action:@selector(changedTextField:) forControlEvents:UIControlEventEditingChanged];
    
}
-(void)diss:(UIButton *)btn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)sureAction:(UIButton *)sender {
    
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    
    if (_tf1.text.length>0&&_tf2.text.length>0&&_tf3.text.length>0&&_tf1.text.length>0) {
        
        NSMutableDictionary *scoreDict = [NSMutableDictionary dictionary];
        [scoreDict setValue:_tf1.text forKey:@"listen"];
        [scoreDict setValue:_tf2.text forKey:@"speak"];
        [scoreDict setValue:_tf3.text forKey:@"read"];
        [scoreDict setValue:_tf4.text forKey:@"write"];
        [scoreDict setValue:_totalL.text forKey:@"total"];
        [scoreDict setValue:_avaL.text forKey:@"average"];
        if (_noteL.text.length>0) {
            
            [scoreDict setValue:_noteL.text forKey:@"note"];
        }else{
            [scoreDict setValue:@"No note" forKey:@"note"];
        }
        
        [scoreDict setObject:[userInfo objectForKey:@"id"] forKey:@"userid"];
        
        NSString *address = [NSString stringWithFormat:@"%@%@",Address,@"/record"];
        
        NSLog(@"dic ---%@",scoreDict);
        [SVProgressHUD showWithStatus:@""];
        [[HttpRequest shardWebUtil]postNetworkRequestURLString:address parameters:scoreDict success:^(id obj) {
            
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadRecord" object:nil];
            
            
            
            [SVProgressHUD showSuccessWithStatus:@"Add Success"];
            [SVProgressHUD dismissWithDelay:1];
            NSLog(@"OK---%@",obj);
             [self dismissViewControllerAnimated:YES completion:nil];
            
        } fail:^(NSError *error) {
            
            [SVProgressHUD showErrorWithStatus:@"Add Fail"];
            [SVProgressHUD dismissWithDelay:1];
            NSLog(@"错误%@",error);
             [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        
    }else{
        
        [SVProgressHUD showErrorWithStatus:@"Please input score"];
        [SVProgressHUD dismissWithDelay:1];
        
    }
    
    
}


@end
