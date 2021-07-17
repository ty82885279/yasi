//
//  IELTS_SelectTimeViewController.h
//  yasi
//
//  Created by MrLee on 2020/4/26.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IELTS_datePicker.h"

NS_ASSUME_NONNULL_BEGIN

@interface IELTS_SelectTimeViewController : UIViewController
@property (weak, nonatomic) IBOutlet IELTS_datePicker *yearP;
@property (weak, nonatomic) IBOutlet IELTS_datePicker *monthP;
@property (weak, nonatomic) IBOutlet IELTS_datePicker *dataP;
@property (weak, nonatomic) IBOutlet UILabel *y1;
@property (weak, nonatomic) IBOutlet UILabel *y2;
@property (weak, nonatomic) IBOutlet UILabel *y3;
@property (weak, nonatomic) IBOutlet UILabel *y4;
@property (weak, nonatomic) IBOutlet UILabel *m1;
@property (weak, nonatomic) IBOutlet UILabel *m2;
@property (weak, nonatomic) IBOutlet UILabel *d1;
@property (weak, nonatomic) IBOutlet UILabel *d2;



@end

NS_ASSUME_NONNULL_END
