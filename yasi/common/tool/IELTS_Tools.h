//
//  IELTS_Tools.h
//  yasi
//
//  Created by MrLee on 2020/4/26.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IELTS_Tools : NSObject
+ (UIViewController *)getRootViewController;

+ (NSDate *)dateWithFromDate:(NSDate *)date years:(NSInteger)years months:(NSInteger)months days:(NSInteger)days;

+ (BOOL)isNumber:(NSString *)strValue;
@end

NS_ASSUME_NONNULL_END
