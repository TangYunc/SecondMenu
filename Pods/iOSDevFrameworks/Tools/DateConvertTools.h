//
//  DateConvertTools.h
//  KKDictionary
//
//  Created by KungJack on 7/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateConvertTools : NSObject
//////////////////////////////////////////////////////////////////////////////////////////////
/// 日期转换：功能从时间戳按格式转化成时间，如果是今天的时间戳显示的样式 （今天 下午 XX:XX）支持今天昨天前天
/// 其他是就按正常的年月日显示  yyyy-MM-dd HH:mm
//////////////////////////////////////////////////////////////////////////////////////////////
+(NSString*)convertTimeByUsedMineConstultingToFormatDate:(NSString *)formatString timeLine:(NSString *)timeLine;
+(NSString*)convertTimeByUsedQuickInquiryToFormatDate:(NSString *)formatString timeLine:(NSString *)timeLine;
+(NSString*)convertTimeToFormatDate:(NSString *)formatString timeLine:(NSString *)timeLine;
+ (NSString *)getDateAccordingTimeLine:(NSString *)timeLine formatStyle:(NSString *)formate;
+ (NSString *)getWeekDayForTimeLine:(NSString *)timeLine;

/** 判断是不是超过了一天**/
+(BOOL)isMoreThanOneDayWithTime:(NSDate *)lastRefreshDate;

/** 判断是不是小于未来一个月**/
+(BOOL)isLessThanMonthWithTime:(NSDate *)lastRefreshDate;

+(NSString*)convertTimeToStandardFormatDate:(NSString *)formatString timeLine:(NSString *)timeLine;

+(NSString *)getAgeWithDate:(NSString *)date;
@end
