//
//  IELTS_RecordModel.h
//  yasi
//
//  Created by MrLee on 2020/4/30.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IELTS_RecordModel : JSONModel


@property (nonatomic, copy) NSString <Optional>*CreatedAt;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString <Optional>*DeletedAt;

@property (nonatomic, copy) NSString <Optional>*UpdatedAt;

@property (nonatomic, copy) NSString <Optional>*userid;

@property (nonatomic, copy) NSString <Optional>*listen;

@property (nonatomic, copy) NSString <Optional>*speak;

@property (nonatomic, copy) NSString <Optional>*read;

@property (nonatomic, copy) NSString <Optional>*write;

@property (nonatomic, copy) NSString <Optional>*total;

@property (nonatomic, copy) NSString <Optional>*average;

@property (nonatomic, copy) NSString <Optional>*note;

@end

NS_ASSUME_NONNULL_END
