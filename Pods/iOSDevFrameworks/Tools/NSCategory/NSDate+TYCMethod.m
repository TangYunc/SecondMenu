//
//  NSDate+TYCMethod.m
//  OnlineHosptial
//
//  Created by tangyunchuan on 2019/3/19.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "NSDate+TYCMethod.h"

@implementation NSDate (TYCMethod)

+(NSInteger)compareDate:(NSString*)date01 withDate:(NSString*)date02{
    
    NSInteger index;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy/MM/dd"];
    NSDate *dt1 = [[NSDate alloc] init];
    NSDate *dt2 = [[NSDate alloc] init];
    dt1 = [df dateFromString:date01];
    dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];

    switch (result) {
        case NSOrderedAscending:
             //date02比date01大
            index = 1;
            break;
        case NSOrderedDescending:
            //date02比date01小
            index = -1;
            break;
        case NSOrderedSame:
             //date02=date01
            index = 0;
            break;
            
        default:
            break;
    }
    return index;
}

+(NSString *)timeSwitchTimestamp:(NSString *)formatTime{
    NSInteger resultTimeSp = [self timeSwitchTimestamp:formatTime andFormatter:@"yyyy/MM/dd"];
    NSString *resultStr = [NSString stringWithFormat:@"%ld", resultTimeSp];
    return resultStr;
}

+(NSString *)timestampSwitchTime:(NSInteger)timestamp{
    
    NSString *resultStr = [self timestampSwitchTime:timestamp andFormatter:@"yyyy/MM/dd"];
    return resultStr;
}

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];

    return timeSp;
}


+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];

    return confromTimespStr;
}


+ (NSString *)getTodayTimeSp{
    //日期转时间戳
    NSString *timeSp = [self getTodayTimeSpWithFormatter:@"YYYY/MM/dd"];
    return timeSp;
}

+ (NSString *)getTodayTimeSpWithFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *todayDate = [NSDate date];
    //日期转时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[todayDate timeIntervalSince1970]];
    return timeSp;
}

+ (NSString *)getTodayTimeDate{
    
    NSString *todayDateStr = [self getTodayTimeDateWithFormatter:@"YYYY/MM/dd"];
    return todayDateStr;
}

+ (NSString *)getTodayTimeDateWithFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *todayDate = [NSDate date];
    NSString *todayDateStr = [formatter stringFromDate:todayDate];
    return todayDateStr;
}

+ (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr andFormatter:(NSString *)format{
    
    NSInteger timeDifference = 0;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    NSDate *deadline = [formatter dateFromString:deadlineStr];
    NSTimeInterval oldTime = [nowDate timeIntervalSince1970];
    NSTimeInterval newTime = [deadline timeIntervalSince1970];
    timeDifference = newTime - oldTime;
    
    return timeDifference;
}

+(NSString *)timestampSwitchDate:(NSDate *)date andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *todayDateStr = [formatter stringFromDate:date];
    return todayDateStr;
}

+ (NSString *)timesSpWithFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *todayDate = [NSDate date];
    //日期转String
    NSString *todayDateStr = [formatter stringFromDate:todayDate];
    return todayDateStr;
}

+ (NSTimeInterval)getZeroTimesSpWithTime:(NSString *)timesSp{
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:[timesSp integerValue]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    NSDate *zeroDate = [calendar dateFromComponents:components];
    return [zeroDate timeIntervalSince1970];
}

@end
