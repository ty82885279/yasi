//
//  AppDelegate.m
//  yasi
//
//  Created by MrLee on 2020/4/23.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import "AppDelegate.h"
#import "IELTS_LoginViewController.h"
#import "ViewController.h"
#import "IELTS_EditInfoViewController.h"

//
#import "IELTS_MainPageViewController.h"
#import "IELTS_settingViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];   //设置通用背景颜色
    [self.window makeKeyAndVisible];
    
    IELTS_MainPageViewController *mainVC = [[IELTS_MainPageViewController alloc] init];
    
    
    
    self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    IELTS_settingViewController *leftVC = [[IELTS_settingViewController alloc] init];
    self.LeftSlideVC = [[IELTS_LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
    self.window.rootViewController = self.LeftSlideVC;
    
    //导航栏颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor clearColor]];
    [self.window makeKeyAndVisible];
   
    dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);

        dispatch_after(timer, dispatch_get_main_queue(), ^{
        
     NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
            NSString *islogin = [userInfo objectForKey:@"islogin"];
            if (![islogin isEqualToString:@"1"]) {
                IELTS_LoginViewController *loginVc = [[IELTS_LoginViewController alloc]init];
                         if (@available(iOS 13.0, *)) {
                             loginVc.modalPresentationStyle = UIModalPresentationFullScreen;
                         }
                          [self.window.rootViewController presentViewController:loginVc animated:YES completion:^{
                              
                          }];
                
            }
    

        });

        
      
  
    
   
            
    
   
    
    return YES;
}



@end
