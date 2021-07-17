//
//  IELTS_recordTableViewCell.m
//  yasi
//
//  Created by MrLee on 2020/4/30.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import "IELTS_recordTableViewCell.h"

@implementation IELTS_recordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setRecordModel:(IELTS_RecordModel *)recordModel{
    
    _recordModel = recordModel;
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    CGFloat target = [[userInfo objectForKey:@"target"] floatValue];
    CGFloat total = [recordModel.total floatValue];
    
    _timeL.text =  [recordModel.CreatedAt substringToIndex:10];
    _scoreL.text = recordModel.total;
    
    if (total>=target) {
        
        _passImg.image = [UIImage imageNamed:@"mypass"];
        _ispass = true;
    }else{
        _passImg.image = [UIImage imageNamed:@"mynot"];
        _ispass = false;
    }
        
}

@end
