//
//  NSDate+TYCMethod.h
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/3/19.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (TYCMethod)


/**
 比较两个日期的大小

 @param date01 时间一
 @param date02 时间二
 @return 比较结果
 */
+(NSInteger)compareDate:(NSString*)date01 withDate:(NSString*)date02;



/**
 日期字符串转换为时间戳

 @param formatTime 要转换到日期字符串
 @return 要转换到日期的时间戳
 */
+(NSString *)timeSwitchTimestamp:(NSString *)formatTime;



/**
 时间戳转时间

 @param timestamp 要转换到时间戳
 @return 时间
 */
+(NSString *)timestampSwitchTime:(NSInteger)timestamp;



/**
 将某个时间转化成 时间戳

 @param formatTime 要转换到时间
 @param format "YYYY-MM-dd hh:mm:ss"----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 @return 时间戳
 */
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;



/**
 将某个时间戳转化成 时间

 @param timestamp 时间戳
 @param format "YYYY-MM-dd hh:mm:ss"----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 @return 时间字符串
 */
+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;




/**
 获取今天到时间戳
 
 @return 今天的时间戳
 */
+ (NSString *)getTodayTimeSp;

/**
 获取今天到时间戳

 @param format "YYYY-MM-dd hh:mm:ss"----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 @return 今天的时间戳
 */
+ (NSString *)getTodayTimeSpWithFormatter:(NSString *)format;



/**
 获取今天时间字符串

 @return 今天到时间
 */
+ (NSString *)getTodayTimeDate;

/**
  获取今天时间字符串

 @param format "YYYY-MM-dd hh:mm:ss"----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 @return 今天到时间
 */
+ (NSString *)getTodayTimeDateWithFormatter:(NSString *)format;


/**
 *  获取时间差值  截止时间-当前时间
 *  nowDateStr : 当前时间
 *  deadlineStr : 截止时间
 *  @return 时间戳差值
 */
+ (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr andFormatter:(NSString *)format;

/**
 将某个时间戳转化成 时间
 
 @param date 时间
 @param format "YYYY-MM-dd hh:mm:ss"----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 @return 时间字符串
 */

+(NSString *)timestampSwitchDate:(NSDate *)date andFormatter:(NSString *)format;
/**
 将某个时间戳转化成 时间String
 
 @param format "YYYY-MM-dd hh:mm:ss"----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 @return 时间字符串
 */
+ (NSString *)timesSpWithFormatter:(NSString *)format;

/**
将某个时间戳转成当天零点的时间

@param timesSp 希望转换的时间戳
@return 时间戳
*/
+ (NSTimeInterval)getZeroTimesSpWithTime:(NSString *)timesSp;
@end

NS_ASSUME_NONNULL_END
