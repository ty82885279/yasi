//
//  IELTS_phtotView.m
//  yasi
//
//  Created by MrLee on 2020/4/26.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import "IELTS_phtotView.h"

@implementation IELTS_phtotView

-(instancetype)initWithTitle:(NSString *)title actionNames:(NSArray*)actions styleHander:(ActionPopStyleHander)hander{
    self = [super initWithFrame:Main_Screen];
    if (self) {
        self.backgroundColor = RGB(0, 0, 0, 0.3);
        self.title = title;
        self.actionArray = [NSArray arrayWithArray:actions];
        self.styleHander = hander;
        [self photoAlertMainView];
    }
    return self;
}

-(void)photoAlertMainView{
    self.popView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_height, 0, 50+Bottom_height+10+50+50*self.actionArray.count+1*(self.actionArray.count-1))];
    self.popView.backgroundColor = [UIColor clearColor];
    self.popView.userInteractionEnabled = YES;
    [self addSubview:self.popView];
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor=RGB(0, 0, 0, 0.5);
        self.popView.frame = CGRectMake(0, Screen_height-(50+Bottom_height+10+50+50*self.actionArray.count+1*(self.actionArray.count-1)), Screen_width, 50+Bottom_height+10+50+50*self.actionArray.count+1*(self.actionArray.count-1));
    } completion:^(BOOL finished) {
        
    }];
    UIView *titleVIew = [UIView new];
    titleVIew.backgroundColor = Top_Color;
    titleVIew.layer.masksToBounds = YES;
    titleVIew.layer.cornerRadius = 15;
    [self.popView addSubview:titleVIew];
    [titleVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.popView);
        make.height.mas_equalTo(70);
    }];
    UILabel *titleLable = [UILabel new];
    titleLable.text = self.title;
    titleLable.font = Regular_font(16);
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = [UIColor whiteColor];
    [titleVIew addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.popView);
        make.height.mas_equalTo(50);
    }];
    
    UIView *baseView = [UIView new];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.popView addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.popView);
        make.top.mas_equalTo(self.popView.mas_top).offset(50);
    }];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"Cancle" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTitleColor:RGB(51, 51, 51, 1) forState:UIControlStateNormal];
    [self.popView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(baseView);
        make.bottom.mas_equalTo(baseView.mas_bottom).offset(-Bottom_height);
        make.height.mas_equalTo(50);
    }];
    
    for (NSInteger index=0; index<self.actionArray.count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        [button setTitle:self.actionArray[index] forState:UIControlStateNormal];
        button.tag = index;
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:RGB(51, 51, 51, 1) forState:UIControlStateNormal];
        [baseView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(baseView);
            make.height.mas_equalTo(50);
            make.top.mas_equalTo(baseView.mas_top).offset(index*(1+46));
        }];
    }
}

-(void)showActionAlert{
    [[UIApplication sharedApplication].delegate.window addSubview:self];

}


-(void)clickAction:(UIButton*)button{
    if (self.styleHander) {
        self.styleHander(button.tag);
        [self dismissTheView];
    }
}

-(void)dismissTheView{
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor =RGB(0, 0, 0, 0);
        self.popView.frame = CGRectMake(0, Screen_height, Screen_width, 50+Bottom_height+10+50+50*self.actionArray.count+1*(self.actionArray.count-1));
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)cancleAction{
    [self dismissTheView];
}

//
-(instancetype)initWithWithTitle:(NSString*)title confirm:(CompleteAction)hander{
    
    self = [super initWithFrame:Main_Screen];
       if (self) {
           self.backgroundColor = RGB(0, 0, 0, 0);
           self.confirmHander = hander;
           self.title = title;
           [self confirmMainView];
       }
       return self;
}
-(void)confirmMainView{
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundColor = RGB(0, 0, 0, 0.3);
    } completion:^(BOOL finished) {
        [self confirmDetialViews];
    }];
}

-(void)confirmDetialViews{
    self.baseImageView = [[UIImageView alloc]initWithImage:ImageName(@"complete the information")];
    self.baseImageView.userInteractionEnabled = YES;
    [self addSubview:self.baseImageView];
    [self.baseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(270);
        make.height.mas_equalTo(257);
    }];
    UILabel *titleLable = [UILabel new];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.font = Regular_font(15);
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = self.title;
    titleLable.numberOfLines = 0;
    [self.baseImageView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.baseImageView.mas_top).offset(140);
        make.left.right.mas_equalTo(self.baseImageView);
        make.height.mas_equalTo(48);
    }];
    
    UIButton *confirBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirBtn.adjustsImageWhenHighlighted = NO;
    [confirBtn setBackgroundImage:[UIImage imageNamed:@"230 70 button备份 4"] forState:UIControlStateNormal] ;
    [confirBtn setTitle:@"Complete" forState:UIControlStateNormal];
    [confirBtn setTitleColor:RGB(212, 88, 0, 1) forState:UIControlStateNormal];
    [confirBtn addTarget:self action:@selector(continueAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseImageView addSubview:confirBtn];
    [confirBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.baseImageView.mas_bottom).offset(-15);
        make.centerX.mas_equalTo(self.baseImageView.mas_centerX);
        make.width.mas_equalTo(115);
        make.height.mas_equalTo(35);
    }];
}

-(void)showCompleteHUD{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

-(void)continueAction:(UIButton*)button{
    if (self.confirmHander) {
        [self dismissConrifmAlert];
        self.confirmHander();
    }
}

-(void)dismissConrifmAlert{
    [UIView animateWithDuration:0.1 animations:^{
        [self.baseImageView removeFromSuperview];
    } completion:^(BOOL finished) {
        self.backgroundColor = RGB(0, 0, 0, 0);
        [self removeFromSuperview];
    }];
}

@end
