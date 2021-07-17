//
//  IELTS_phtotView.h
//  yasi
//
//  Created by MrLee on 2020/4/26.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface IELTS_phtotView : UIView

typedef void (^ActionPopStyleHander)(NSInteger style);
@property(nonatomic,copy)ActionPopStyleHander styleHander;


@property(nonatomic,strong)UIView *popView;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSArray *actionArray;
-(instancetype)initWithTitle:(NSString*)title actionNames:(NSArray*)actions styleHander:(ActionPopStyleHander)hander;
-(void)showActionAlert;


//


typedef void (^CompleteAction)(void);


@property(nonatomic,copy)CompleteAction confirmHander;

-(instancetype)initWithWithTitle:(NSString*)title confirm:(CompleteAction)hander;
-(void)showCompleteHUD;
@property(nonatomic,strong)UIImageView *baseImageView;


@end

NS_ASSUME_NONNULL_END
