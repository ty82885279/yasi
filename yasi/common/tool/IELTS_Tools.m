//
//  IELTS_Tools.m
//  yasi
//
//  Created by MrLee on 2020/4/26.
//  Copyright © 2020 MrLee. All rights reserved.
//

#import "IELTS_Tools.h"

@implementation IELTS_Tools

+ (UIViewController *)getRootViewController{

    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
   
    return window.rootViewController;
}

 + (NSDate *)dateWithFromDate:(NSDate *)date years:(NSInteger)years months:(NSInteger)months days:(NSInteger)days{
      NSDate  * latterDate;
     if (date) {
          latterDate = date;
      }else{
          latterDate = [NSDate date];
      }
      NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
     NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute
                                           fromDate:latterDate];

     [comps setYear:years];
     [comps setMonth:months];
     [comps setDay:days];

     return [calendar dateByAddingComponents:comps toDate:latterDate options:0]; }


+ (BOOL)isNumber:(NSString *)strValue
{
    if (strValue == nil || [strValue length] <= 0)
    {
        return NO;
    }
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[strValue componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    if (![strValue isEqualToString:filtered])
    {
        return NO;
    }
    return YES;
}

@end

