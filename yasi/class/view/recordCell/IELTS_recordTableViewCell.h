//
//  IELTS_recordTableViewCell.h
//  yasi
//
//  Created by MrLee on 2020/4/30.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IELTS_RecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface IELTS_recordTableViewCell : UITableViewCell

@property(nonatomic,strong) IELTS_RecordModel* recordModel;

@property (weak, nonatomic) IBOutlet UILabel *indexL;

@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *scoreL;
@property (weak, nonatomic) IBOutlet UIImageView *passImg;
@property (nonatomic,assign) BOOL ispass;

@end

NS_ASSUME_NONNULL_END
