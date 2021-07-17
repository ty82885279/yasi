//
//  IELTS_EditInfoViewController.m
//  yasi
//
//  Created by MrLee on 2020/4/25.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import "IELTS_EditInfoViewController.h"
#import "IELTS_phtotView.h"
#import "IELTS_SelectTimeViewController.h"
#import "IELTS_User.h"
#import "UIButton+WebCache.h"

@interface IELTS_EditInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)NSMutableDictionary *postDict;
@property(nonatomic,assign)BOOL hasPhoto;

@end

@implementation IELTS_EditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTime:) name:@"time" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setavatar:) name:@"avatar" object:nil];
    
    //
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    
    [_postDict setObject:[userInfo objectForKey:@"avatar"] forKey:@"avatar"];
    [_avatarBtn.imageView sd_setImageWithURL:[NSURL URLWithString:[userInfo objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@""]];

    //
     _postDict = [NSMutableDictionary dictionary];
    
    
    [_postDict setValue:[userInfo objectForKey:@"id"] forKey:@"id"];
    [_postDict setValue:[userInfo objectForKey:@"account"] forKey:@"account"];
    [_postDict setValue:[userInfo objectForKey:@"psw"] forKey:@"psw"];
    [_postDict setValue:[userInfo objectForKey:@"updated_at"] forKey:@"updated_at"];
    [_postDict setValue:[userInfo objectForKey:@"deleted_at"] forKey:@"deleted_at"];
    [_postDict setValue:[userInfo objectForKey:@"created_at"] forKey:@"created_at"];



    _hasPhoto = NO;//no photo
    
   
    
    [_avatarBtn.imageView setContentMode:UIViewContentModeScaleAspectFill];
    if ([self.status isEqualToString:@"no"]) { //first
        
        _ABtn.selected  = YES;
        
        [_postDict setValue:@"A" forKey:@"type"];
        
        NSDate *date = [NSDate date];
        date = [IELTS_Tools dateWithFromDate:date years:0 months:10 days:0];
        
        NSLog(@"----%@",date);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [formatter stringFromDate:date];
        [_dateBtn setTitle:dateStr forState:UIControlStateNormal];
        [userInfo setObject:dateStr forKey:@"time"];
        [userInfo synchronize];
        [_postDict setValue:dateStr forKey:@"time"];
        
        [_postDict setValue:@"no" forKey:@"avatar"];
    }else{
        
        if ([[userInfo objectForKey:@"avatar"] isEqualToString:@"no"]) {
            
            [_avatarBtn setBackgroundImage:[UIImage imageNamed:@"add photo"] forState:UIControlStateNormal];
            [_postDict setValue:@"no" forKey:@"avatar"];
            
        }else{
            
            
            [_avatarBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[userInfo objectForKey:@"avatar"]] forState:UIControlStateNormal];
//            [_avatarBtn.imageView sd_setImageWithURL:[NSURL URLWithString:[userInfo objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@""]];
             [_postDict setValue:[userInfo objectForKey:@"avatar"] forKey:@"avatar"];
            NSLog(@"111");
            
        }
        //
        
        _nameTF.text = [userInfo objectForKey:@"name"];
        [_postDict setValue:[userInfo objectForKey:@"name"] forKey:@"name"];
        
        [_dateBtn setTitle:[userInfo objectForKey:@"time"] forState:UIControlStateNormal];
        
        [_postDict setValue:[userInfo objectForKey:@"time"] forKey:@"time"];
        
        _targetTF.text = [userInfo objectForKey:@"target"];
        
        [_postDict setValue:[userInfo objectForKey:@"target"] forKey:@"target"];
        
        if ([[userInfo objectForKey:@"type"] isEqualToString:@"A"]) {
            _ABtn.selected = YES;
        }else{
            _GBtn.selected = YES;
        }
        
        [_postDict setValue:[userInfo objectForKey:@"type"] forKey:@"type"];
        
        
    }
    
}
- (IBAction)AvatarClick:(UIButton *)sender {
    NSLog(@"设置头像1");
    
    
    __block NSUInteger blockSourceType = 0;
    IELTS_phtotView *popView = [[IELTS_phtotView alloc]initWithTitle:@"Set Avatar" actionNames:@[@"Take a photo",@"Select From Album"] styleHander:^(NSInteger style) {
        if (style==0) {
                   blockSourceType = UIImagePickerControllerSourceTypeCamera;
               }else{
                   blockSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
               }
               UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc]init];
               imagePickerVC.delegate = self;
               imagePickerVC.allowsEditing = YES;
               imagePickerVC.sourceType = blockSourceType;
               
        [self presentViewController:imagePickerVC animated:YES completion:nil];
        
              
    }];
    [popView showActionAlert];
    
}
- (IBAction)dateClick:(UIButton *)sender {
    
    NSLog(@"设置日期");
    IELTS_SelectTimeViewController *IELTS_SelectTime = [[IELTS_SelectTimeViewController alloc]init];
    IELTS_SelectTime.modalPresentationStyle = 0;
    [self presentViewController:IELTS_SelectTime animated:YES completion:nil];
    
}
- (IBAction)typeClick:(UIButton *)sender {
    NSLog(@"选择类型--%ld",sender.tag);
    
    if (sender.tag == 1001) {
        
        _ABtn.selected = YES;
        _GBtn.selected = NO;
        _ABtn.userInteractionEnabled = NO;
        _GBtn.userInteractionEnabled = YES;
        _ALable.textColor = UIColorFromRGB(0xD45800);
        _GLable.textColor = [UIColor whiteColor];
        [_postDict setValue:@"A" forKey:@"type"];
        
    }else if (sender.tag == 1002){
        _ABtn.selected = NO;
        _GBtn.selected = YES;
        _ABtn.userInteractionEnabled = YES;
        _GBtn.userInteractionEnabled = NO;
        _ALable.textColor = [UIColor whiteColor];
        _GLable.textColor = UIColorFromRGB(0xD45800);
         [_postDict setValue:@"G" forKey:@"type"];
    
    }
}
- (IBAction)SureClick:(UIButton *)sender {
    NSLog(@"done");
    [_postDict setValue:[_dateBtn titleForState:UIControlStateHighlighted] forKey:@"time"];
    
    if ([self.status isEqualToString:@"no"]) {
        
        if (_nameTF.text.length==0||_targetTF.text.length==0) {
            
            IELTS_phtotView *infoHud = [[IELTS_phtotView alloc]initWithWithTitle:@"Please complete the information" confirm:^{
                
            }];
            [infoHud showCompleteHUD];
        }else if ([_targetTF.text floatValue]<=0||[_targetTF.text floatValue]>9.0) {
                  
                   
                  [SVProgressHUD showErrorWithStatus:@"Score greater than 0 and less than or equal to 9"];
                  [SVProgressHUD dismissWithDelay:1];
              }else{
                  
                  
                  [_postDict setValue:_targetTF.text forKey:@"target"];
                  [_postDict setValue:_nameTF.text forKey:@"name"];
                  [_postDict setValue:@"1" forKey:@"status"];
                  
                   NSLog(@"111dic ---- %@",_postDict);
                  
                  //
                  NSString *address = [NSString stringWithFormat:@"%@%@",Address,@"/updataUser"];
                  [[HttpRequest shardWebUtil]postNetworkRequestURLString:address parameters:_postDict success:^(id obj) {
                      
                      
                      //
                      NSString *status = obj[@"status"];
                      if ([status isEqualToString:@"3000"]) {
                          IELTS_User *userModel = [[IELTS_User alloc]initWithDictionary:obj[@"data"] error:nil];
                          NSLog(@"用户信息---%@",userModel);
                        
                          
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
                          //
                          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                                      [self dismissViewControllerAnimated:YES completion:nil];

                                  });

                        
                          //
                          
                           
                         
                          NSLog(@"返回的信息--%@",userModel);
                      }else{
                          
                          [SVProgressHUD showErrorWithStatus:@"Error, please try again"];
                          [SVProgressHUD dismissWithDelay:1];
                      }
                      
                      
                      //
                  } fail:^(NSError *error) {
                      [SVProgressHUD showErrorWithStatus:@"Error, please try again"];
                      [SVProgressHUD dismissWithDelay:1];
                      NSLog(@"err---%@",error);
                  }];
                  //
              }
               
    }else{
        
         NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        
        [_postDict setObject:[userInfo objectForKey:@"avatar"] forKey:@"avatar"];
        [_avatarBtn.imageView sd_setImageWithURL:[NSURL URLWithString:[userInfo objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"add photo"]];
        
        
        [_postDict setValue:_targetTF.text forKey:@"target"];
        
    
    [_postDict setValue:_nameTF.text forKey:@"name"];
  
    [_postDict setValue:@"1" forKey:@"status"];
    NSLog(@"dic ---- %@",_postDict);
    NSString *address = [NSString stringWithFormat:@"%@%@",Address,@"/updataUser"];
    [[HttpRequest shardWebUtil]postNetworkRequestURLString:address parameters:_postDict success:^(id obj) {
        
        
        //
        NSString *status = obj[@"status"];
        if ([status isEqualToString:@"3000"]) {
            IELTS_User *userModel = [[IELTS_User alloc]initWithDictionary:obj[@"data"] error:nil];
            NSLog(@"用户信息---%@",userModel);
          
            
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
            //
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                        [self dismissViewControllerAnimated:YES completion:nil];

                    });

          
            //
            
             
           
            NSLog(@"返回的信息--%@",userModel);
        }else{
            
            [SVProgressHUD showErrorWithStatus:@"Error, please try again"];
            [SVProgressHUD dismissWithDelay:1];
        }
        
        
        //
    } fail:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"Error, please try again"];
        [SVProgressHUD dismissWithDelay:1];
        NSLog(@"err---%@",error);
    }];
    }
}


#pragma mark UINavigationControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    __weak typeof(self) weakSelf = self;
    _hasPhoto = YES;
   
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSLog(@"pic----%@",image);
    [_avatarBtn setBackgroundImage:image forState:UIControlStateNormal];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    NSString *address = [NSString stringWithFormat:@"%@%@",Address,@"/uploadAvatar"];
 
    //
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
        
        
        //post请求
        [manager POST:address parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat   = @"YYYY-MM-dd-hh:mm:ss:SSS";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
          
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            float progress =  1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
            NSLog(@"上传图片进度%f",progress);
            [SVProgressHUD showProgress:progress status:@"uploading"];
            if (progress==1) {
                
//                [SVProgressHUD dismissWithDelay:1];
            }
            
           
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
            NSLog(@"--%@",responseObject);
            
            NSLog(@"上传成功");
            NSString *status = responseObject[@"status"];
            if ([status isEqualToString:@"3000"]) {
                
                [SVProgressHUD showSuccessWithStatus:@"Upload Success"];
                [SVProgressHUD dismissWithDelay:1];
                [weakSelf.postDict setValue:responseObject[@"data"] forKey:@"avatar"];
                
                [weakSelf.avatarBtn.imageView sd_setImageWithURL:[NSURL URLWithString:responseObject[@"data"]] placeholderImage:[UIImage imageNamed:@"add photo"]];
                
                NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
                [userInfo setObject:responseObject[@"data"] forKey:@"avatar"];
                [userInfo synchronize];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"setavatar" object:nil];
                
                NSLog(@"111");
                NSLog(@"时间-----%@--%@",[userInfo objectForKey:@"time"],userInfo);
                [weakSelf.dateBtn setTitle:[userInfo objectForKey:@"changin"] forState:UIControlStateNormal] ;
                NSLog(@"222");
            }else if([status isEqualToString:@"3001"]){
                [SVProgressHUD showErrorWithStatus:@"Upload Fail"];;
                [SVProgressHUD dismissWithDelay:1];
            }
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败：%@",error);
        }];
}

-(void)setTime:(NSNotification *)noti

{

    NSLog(@"设置头像2");
    NSString *timeStr = [noti object];

    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
//    [_avatarBtn.imageView sd_setImageWithURL:[NSURL URLWithString:[userInfo objectForKey:@"avatat"]] placeholderImage:[UIImage imageNamed:@"add photo"]];
    [_dateBtn setTitle:timeStr forState:UIControlStateNormal];
    [userInfo setObject:timeStr forKey:@"time"];
    [userInfo synchronize];
    [_postDict setValue:timeStr forKey:@"time"];

}
-(void)setavatar:(NSNotification *)noti

{

    NSLog(@"设置头像3");
   
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];

    [_avatarBtn.imageView sd_setImageWithURL:[NSURL URLWithString:[userInfo objectForKey:@"avatat"]] placeholderImage:[UIImage imageNamed:@"add photo"]];
    [_postDict setObject:[userInfo objectForKey:@"avatat"] forKey:@"avatar"];

}


-(void)dealloc{

[[NSNotificationCenter defaultCenter] removeObserver:self];

}



@end
