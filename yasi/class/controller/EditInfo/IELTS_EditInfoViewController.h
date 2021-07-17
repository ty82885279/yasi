//
//  IELTS_EditInfoViewController.h
//  yasi
//
//  Created by MrLee on 2020/4/25.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IELTS_EditInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *avatarBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn;
@property (weak, nonatomic) IBOutlet UITextField *targetTF;

@property (weak, nonatomic) IBOutlet UIButton *ABtn;
@property (weak, nonatomic) IBOutlet UIButton *GBtn;
@property (weak, nonatomic) IBOutlet UILabel *ALable;
@property (weak, nonatomic) IBOutlet UILabel *GLable;
@property (weak, nonatomic) IBOutlet UIButton *SureBtn;
@property (strong,nonatomic)NSString *status;//info status

@end

NS_ASSUME_NONNULL_END
