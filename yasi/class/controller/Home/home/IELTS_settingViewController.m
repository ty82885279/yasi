//
//  IELTS_settingViewController.m
//  yasi
//
//  Created by MrLee on 2020/4/29.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import "IELTS_settingViewController.h"
#import "IELTS_EditInfoViewController.h"
#import "IELTS_AboutAppViewController.h"
#import "IELTS_FeedbackViewController.h"
#import "IELTS_LoginViewController.h"


@interface IELTS_settingViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarV;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *targetL;

@end

@implementation IELTS_settingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setMyAvatar:) name:@"setavatar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changein:) name:@"changin" object:nil];
    
    
     NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    
     NSLog(@"头像地址----%@",[userInfo objectForKey:@"avatar"]);
    
    [_avatarV sd_setImageWithURL:[NSURL URLWithString:[userInfo objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"add photo"]];
    _nameL.text = [userInfo objectForKey:@"name"];
    _targetL.text = [userInfo objectForKey:@"target"];
    
}
- (IBAction)editAction:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"avatar" object:nil];
    
    IELTS_EditInfoViewController *edit = [[IELTS_EditInfoViewController alloc]init];
    edit.modalPresentationStyle = 0;
    
    [self presentViewController:edit animated:YES completion:nil];
    
    
}
- (IBAction)feedback:(UIButton *)sender {
    IELTS_FeedbackViewController *feed = [[IELTS_FeedbackViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:feed];
    nav.modalPresentationStyle = 0;
    [self presentViewController:nav animated:YES completion:nil];
}
- (IBAction)aboutApp:(UIButton *)sender {
     
    IELTS_AboutAppViewController *about = [[IELTS_AboutAppViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:about];
    nav.modalPresentationStyle = 0;
    [self presentViewController:nav animated:YES completion:nil];
    
}
- (IBAction)logout:(UIButton *)sender {
    
    
    [self clearAllUserDefaultsData];
    
    IELTS_LoginViewController *login = [[IELTS_LoginViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
    login.modalPresentationStyle = 0;
    [self presentViewController:login animated:YES completion:nil];
}

- (void)clearAllUserDefaultsData{

NSUserDefaults*userDefaults = [NSUserDefaults  standardUserDefaults];

NSDictionary*dic = [userDefaults  dictionaryRepresentation];

    for(id key in dic) {
    [userDefaults  removeObjectForKey:key];

    }

    [userDefaults  synchronize];

}


-(void)setMyAvatar:(NSNotification *)noti

{

    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    
    [_avatarV sd_setImageWithURL:[NSURL URLWithString:[userInfo objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"add photo"]];
//    _nameL.text = [userInfo objectForKey:@"name"];
//    _targetL.text = [userInfo objectForKey:@"target"];
    
//     NSLog(@"头像地址----%@",[userInfo objectForKey:@"avatar"]);

}

-(void)changein:(NSNotification *)noti

{

    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    
    [_avatarV sd_setImageWithURL:[NSURL URLWithString:[userInfo objectForKey:@"avatar"]] placeholderImage:[UIImage imageNamed:@"add photo"]];
    _nameL.text = [userInfo objectForKey:@"name"];
    _targetL.text = [userInfo objectForKey:@"target"];
    
     NSLog(@"头像地址----%@",[userInfo objectForKey:@"avatar"]);

}
-(void)dealloc{
    
   [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
