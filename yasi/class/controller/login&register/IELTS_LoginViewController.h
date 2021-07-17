//
//  IELTS_LoginViewController.h
//  yasi
//
//  Created by MrLee on 2020/4/23.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum _PageType {

Login  = 0,

Regist

} PageType;

@interface IELTS_LoginViewController : UIViewController
@property (assign,nonatomic)PageType type;
@property (weak, nonatomic) IBOutlet UILabel *frontTitle;
@property (weak, nonatomic) IBOutlet UILabel *backTitle;
@property (weak, nonatomic) IBOutlet UITextField *accoutTF;
@property (weak, nonatomic) IBOutlet UITextField *psw;
@property (weak, nonatomic) IBOutlet UITextField *pswSure;
@property (weak, nonatomic) IBOutlet UIButton *clickBtn;
@property (weak, nonatomic) IBOutlet UIImageView *pswImg;


@end

NS_ASSUME_NONNULL_END
