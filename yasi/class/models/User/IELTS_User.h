//
//  IELTS_User.h
//  yasi
//
//  Created by MrLee on 2020/4/24.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IELTS_User : JSONModel


@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString <Optional>*CreatedAt;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString <Optional>*DeletedAt;

@property (nonatomic, copy) NSString <Optional>*UpdatedAt;

@property (nonatomic, copy) NSString <Optional>*time;

@property (nonatomic, copy) NSString <Optional>*type;

@property (nonatomic, copy) NSString <Optional>*avatar;

@property (nonatomic, copy) NSString <Optional>*target;

@property (nonatomic, copy) NSString <Optional>*account;

@property (nonatomic, copy) NSString <Optional>*psw;

@property (nonatomic, copy) NSString <Optional>*status;



@end

NS_ASSUME_NONNULL_END
