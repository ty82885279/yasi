//
//  IELTS_LoginViewController.m
//  yasi
//
//  Created by MrLee on 2020/4/23.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import "IELTS_LoginViewController.h"
#import "IELTS_User.h"
#import "IELTS_EditInfoViewController.h"

@interface IELTS_LoginViewController ()

@property(nonatomic,strong)NSMutableArray *dict;
@property(nonatomic,strong)NSMutableArray *userDict;
@end

@implementation IELTS_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dict = [NSMutableDictionary dictionary];
    _userDict = [NSMutableDictionary dictionary];
    
    self.type= Login;
    
    
    switch (self.type) {
        case 0:
        {
            //登录
            [_clickBtn setTitle:@"             Sign in" forState:UIControlStateNormal];
            _backTitle.text = @"Sign in";
            _frontTitle.text = _backTitle.text;
        }
        break;
        case 1:
        {
            //注册
            [_clickBtn setTitle:@"             Register" forState:UIControlStateNormal];
            _backTitle.text = @"Register";
            _frontTitle.text = _backTitle.text;
        }
        default:
            break;
    }
}

- (IBAction)Click:(UIButton *)sender {
    NSLog(@"点击按钮");
    
    if (_type ==Login) {
        
        NSLog(@"登录");
        if (_accoutTF.text.length==0||_psw.text.length==0){
            NSLog(@"用户名和密码不能为空");
            [SVProgressHUD showErrorWithStatus:@"Account and password cannot be empty!"];
            [SVProgressHUD dismissWithDelay:1];
          
           
        }else{
            NSLog(@"开始登录");
            [_dict setValue:_accoutTF.text forKey:@"account"];
            [_dict setValue:_psw.text forKey:@"psw"];
            
            NSString *address = [NSString stringWithFormat:@"%@%@",Address,@"/login"];
            NSLog(@"地址----%@",address);
            [[HttpRequest shardWebUtil]getNetworkRequestURLString:address parameters:_dict success:^(id obj) {
                
                NSLog(@"数据--%@",obj);
                NSString *status = obj[@"status"];
                NSLog(@"====%@",obj[@"data"]);
                if ([status isEqualToString:@"3000"]) {
                    IELTS_User *userModel = [[IELTS_User alloc]initWithDictionary:obj[@"data"] error:nil];
                    NSLog(@"用户信息---%@",userModel);
                    if (userModel.ID == 0) {
                        
                       [SVProgressHUD showErrorWithStatus:@"Wrong account or password!"];
                       [SVProgressHUD dismissWithDelay:1];
                    }else{
//                        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
//                        [SVProgressHUD dismissWithDelay:1];
                        
                        
                        
                        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
                       
                        [userInfo setValue:[NSString stringWithFormat:@"%ld",(long)userModel.ID] forKey:@"id"];
                        [userInfo setValue:userModel.CreatedAt forKey:@"created_at"];
                        [userInfo setValue:userModel.UpdatedAt forKey:@"updated_at"];
                        [userInfo setValue:userModel.DeletedAt forKey:@"deleted_at"];
                        [userInfo setValue:userModel.account forKey:@"account"];
                        [userInfo setValue:userModel.psw forKey:@"psw"];
                        [userInfo setValue:userModel.status forKey:@"status"];
                        [userInfo setValue:userModel.name forKey:@"name"];
                        [userInfo setValue:userModel.time forKey:@"time"];
                        [userInfo setValue:userModel.target forKey:@"target"];
                        [userInfo setValue:userModel.type forKey:@"type"];
                        [userInfo setValue:userModel.avatar forKey:@"avatar"];
                        [userInfo setValue:@"1" forKey:@"islogin"];
                        [userInfo synchronize];
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"changin" object:nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"checkTime" object:nil];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadRecord" object:nil];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                                    [self dismissViewControllerAnimated:YES completion:nil];
                            
                            NSLog(@"用户状态：%@",userModel.status);
                                                  if ([userModel.status isEqualToString:@"no"]) {
                                                   
                                                      NSLog(@"----设置--");
                                                      IELTS_EditInfoViewController *IELTS_EditInfo = [[IELTS_EditInfoViewController alloc]init];
                                                      IELTS_EditInfo.status = @"no";
                                                      IELTS_EditInfo.modalPresentationStyle = UIModalPresentationFullScreen;
                                                      
                                                      [[IELTS_Tools getRootViewController] presentViewController:IELTS_EditInfo animated:YES completion:nil];
                                                      
                                                      
                                                  }else{
                                                      
                                                      
                                                      [self dismissViewControllerAnimated:YES completion:nil];
                                                  }

                                });

                        
                      
                        
                    }
                    
                }
            } fail:^(NSError *error) {
                
                NSLog(@"失败---%@",error);
            }];
            
        }
        
    }else if (_type == Regist){
        NSLog(@"注册");
        
        if (_accoutTF.text.length==0||_psw.text.length==0||_pswSure.text.length == 0){
                   NSLog(@"用户名和密码不能为空");
                   [SVProgressHUD showErrorWithStatus:@"Input cannot be empty!"];
                   [SVProgressHUD dismissWithDelay:1];
           
            
        }else{
            
            if (![_psw.text isEqualToString:_pswSure.text]) {
                           
                           [SVProgressHUD showErrorWithStatus:@"Two different passwords!"];
                           [SVProgressHUD dismissWithDelay:1];
                return;
            }
            //
               NSLog(@"开始注册");
               [_dict setValue:_accoutTF.text forKey:@"account"];
               [_dict setValue:_psw.text forKey:@"psw"];
               
               NSString *address = [NSString stringWithFormat:@"%@%@",Address,@"/register"];
               NSLog(@"地址----%@",address);
               [[HttpRequest shardWebUtil]postNetworkRequestURLString:address parameters:_dict success:^(id obj) {
                   
                   NSLog(@"数据--%@",obj);
                   NSString *status = obj[@"status"];
                   NSLog(@"====%@",obj[@"data"]);
                   if ([status isEqualToString:@"3000"]) {
                       IELTS_User *userModel = [[IELTS_User alloc]initWithDictionary:obj[@"data"] error:nil];
                       NSLog(@"用户信息---%@",userModel);
                       if (userModel.ID == 0) {
                           
                          [SVProgressHUD showErrorWithStatus:@"Wrong account or password"];
                          [SVProgressHUD dismissWithDelay:1];
                           
                       }else{
                           [SVProgressHUD showSuccessWithStatus:@"Register Success"];
                           [SVProgressHUD dismissWithDelay:1];
                       }
                       
                   }
               } fail:^(NSError *error) {
                   
                   NSLog(@"失败---%@",error);
               }];
               
           }
    }
}

- (IBAction)change:(UIButton *)sender {
    
    if (_type == Login) {
        //切换为注册页面
        NSLog(@"去注册");
        _type = Regist;
        [_clickBtn setTitle:@"             Register" forState:UIControlStateNormal];
        _backTitle.text = @"Register";
        _frontTitle.text = _backTitle.text;
        
        _pswImg.hidden = NO;
        _pswSure.hidden = NO;
    }else if (_type == Regist){
        
        //切换为登录页面
        NSLog(@"去登录");
        _type = Login;
         [_clickBtn setTitle:@"             Sign in" forState:UIControlStateNormal];
        _backTitle.text = @"Sign in";
                   _frontTitle.text = _backTitle.text;
        _pswImg.hidden = YES;
        _pswSure.hidden = YES;
        
    }
}


@end
