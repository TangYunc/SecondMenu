//
//  DateConvertTools.m
//  KKDictionary
//
//  Created by KungJack on 7/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import "DateConvertTools.h"
//#import "ToolsHeader.h"

@implementation DateConvertTools

+(NSString *)hourAndMin:(NSInteger)hour min:(NSInteger)min{
    if(hour>12){
        return [NSString stringWithFormat:@"下午 %@:%@",[self format:hour-12],[self format:min]];
    }else{
        return [NSString stringWithFormat:@"上午 %@:%@",[self format:hour],[self format:min]];
    }
}

+(NSString*)format:(NSInteger)time{
    return  (time > 9 ? [NSString stringWithFormat:@"%ld",(long)time]:[NSString stringWithFormat:@"0%ld",(long)time]);
}

+(NSString*)convertTimeToFormatDate:(NSString *)formatString timeLine:(NSString *)timeLine{
    
    NSDateFormatter *format =  [[NSDateFormatter alloc]init];
    [format setDateFormat:formatString];
    // 从时间戳获取日期
    NSDate *timeLineDate = [NSDate dateWithTimeIntervalSince1970:[timeLine integerValue]];
    // 获取当前日期
    NSDate *nowDate = [NSDate date];
    // 设置要获取的格式
    NSInteger unitFlags = NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:nowDate];
    
    //获取当前年月日
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger Min = [comps minute];
    
    NSDateComponents *timeLineComps = [calendar components:unitFlags fromDate:timeLineDate];
    
    NSInteger timeLineYear=[timeLineComps year];
    NSInteger timeLineMonth = [timeLineComps month];
    NSInteger timeLineDay = [timeLineComps day];
    NSInteger timeLineHour = [timeLineComps hour];
    NSInteger timeLineMin = [timeLineComps minute];
    
    if(timeLineYear == year && timeLineMonth == month){//相同年月
        
        NSInteger subDay = day - timeLineDay;// 当前天 去除时间戳取到的日期
        if(subDay == 0){
            NSInteger subHour = hour - timeLineHour;
            NSInteger subMin = (subHour>0?(Min+subHour*60):Min) - timeLineMin;
            if(subMin>=60){
                return [NSString stringWithFormat:@"%ld小时前",subMin/60];
            }else if(subMin==0){
                return @"刚刚";
            }else if(subMin<=30){
                return [NSString stringWithFormat:@"%ld分钟前",(long)subMin];
            }else{
                return @"半小时前";
            }
        }else if(subDay == 1){
            return [NSString stringWithFormat:@"昨天"];
        }else if(subDay == 2){
            return [NSString stringWithFormat:@"前天"];
        }
        
    }
    
    return [format stringFromDate:[NSDate dateWithTimeIntervalSince1970:[timeLine integerValue]]];
    
}

+(NSString*)convertTimeByUsedQuickInquiryToFormatDate:(NSString *)formatString timeLine:(NSString *)timeLine{
    /*
    由龙代明添加备注。

    系统派发时间显示规则: 1、刚刚:一分钟前

    2、N分钟前: 10分钟前

    3、超过10分钟，显示具体时间: 12: 23
     
    4、超过24小时，显示r昨天J
     
    5、超过48小时，显示「前天J

    6、超过72小时，显示具体日期及时间
     */
    
    NSDateFormatter *format =  [[NSDateFormatter alloc]init];
    [format setDateFormat:formatString];
    // 从时间戳获取日期
    NSDate *timeLineDate = [NSDate dateWithTimeIntervalSince1970:[timeLine integerValue]];
    // 获取当前日期
    NSDate *nowDate = [NSDate date];
    // 设置要获取的格式
    NSInteger unitFlags = NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:nowDate];
    
    //获取当前年月日
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger Min = [comps minute];
    
    NSDateComponents *timeLineComps = [calendar components:unitFlags fromDate:timeLineDate];
    
    NSInteger timeLineYear=[timeLineComps year];
    NSInteger timeLineMonth = [timeLineComps month];
    NSInteger timeLineDay = [timeLineComps day];
    NSInteger timeLineHour = [timeLineComps hour];
    NSInteger timeLineMin = [timeLineComps minute];
    
    if(timeLineYear == year && timeLineMonth == month){//相同年月
        
        NSInteger subDay = day - timeLineDay;// 当前天 去除时间戳取到的日期
        if(subDay == 0){
            NSInteger subHour = hour - timeLineHour;
            NSInteger subMin = (subHour>0?(Min+subHour*60):Min) - timeLineMin;
            if(subMin<=1){
                return @"刚刚";
            }else if(subMin<=10 && subMin>1){
                return [NSString stringWithFormat:@"%ld分钟前",(long)subMin];
            }else {
                [format setDateFormat:@"HH:mm"];
                return [format stringFromDate:[NSDate dateWithTimeIntervalSince1970:[timeLine integerValue]]];
            }
        }else if(subDay == 1){
            return [NSString stringWithFormat:@"昨天"];
        }else if(subDay == 2){
            return [NSString stringWithFormat:@"前天"];
        }
        
    }
    
    return [format stringFromDate:[NSDate dateWithTimeIntervalSince1970:[timeLine integerValue]]];
}

+(NSString*)convertTimeByUsedMineConstultingToFormatDate:(NSString *)formatString timeLine:(NSString *)timeLine{
    /*

    系统派发时间显示规则: 1、刚刚:5分钟之内

    2、N分钟前: 不足一小时

    3、N小时前，当天时展示

    4、超出当前自然日，显示具体日期及时间
     */
    NSDateFormatter *format =  [[NSDateFormatter alloc]init];
    [format setDateFormat:formatString];
    // 从时间戳获取日期
    NSDate *timeLineDate = [NSDate dateWithTimeIntervalSince1970:[timeLine integerValue]];
    // 获取当前日期
    NSDate *nowDate = [NSDate date];
    // 设置要获取的格式
    NSInteger unitFlags = NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:nowDate];
    
    //获取当前年月日
    NSInteger year=[comps year];
    NSInteger month = [comps month];
    NSInteger day = [comps day];
    NSInteger hour = [comps hour];
    NSInteger Min = [comps minute];
    
    NSDateComponents *timeLineComps = [calendar components:unitFlags fromDate:timeLineDate];
    
    NSInteger timeLineYear=[timeLineComps year];
    NSInteger timeLineMonth = [timeLineComps month];
    NSInteger timeLineDay = [timeLineComps day];
    NSInteger timeLineHour = [timeLineComps hour];
    NSInteger timeLineMin = [timeLineComps minute];
    
    if(timeLineYear == year && timeLineMonth == month){//相同年月
        
        NSInteger subDay = day - timeLineDay;// 当前天 去除时间戳取到的日期
        if(subDay == 0){
            NSInteger subHour = hour - timeLineHour;
            NSInteger subMin = (subHour>0?(Min+subHour*60):Min) - timeLineMin;
            if(subMin>=60){
                return [NSString stringWithFormat:@"%ld小时前",subMin/60];
            }else if(subMin<5){
                return @"刚刚";
            }else{
                return [NSString stringWithFormat:@"%ld分钟前",(long)subMin];
            }
        }
    }
    
    return [format stringFromDate:[NSDate dateWithTimeIntervalSince1970:[timeLine integerValue]]];
    
}


+(NSString*)convertTimeToStandardFormatDate:(NSString *)formatString timeLine:(NSString *)timeLine{
    NSTimeInterval interval = [timeLine integerValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatString];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+(BOOL)isMoreThanOneDayWithTime:(NSDate *)lastRefreshDate{
   
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH";
    
 
    // 从时间戳获取日期
   // NSDate *timeLineDate = [NSDate dateWithTimeIntervalSince1970:[timeLine integerValue]];
    
    
    
    NSString *dateStr = [fmt stringFromDate:lastRefreshDate];
    
    
    //获取当前时间
    NSDate *now = [NSDate date];
    NSString *nowStr = [fmt stringFromDate:now];
    
   
    NSDate *date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay|NSCalendarUnitHour;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    if (cmps.year>0||cmps.month>0||cmps.day>0||cmps.hour>=24) {
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)isLessThanMonthWithTime:(NSDate *)lastRefreshDate{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH";
    NSString *dateStr = [fmt stringFromDate:lastRefreshDate];
    
    //获取当前时间
    NSDate *now = [NSDate date];
    NSString *nowStr = [fmt stringFromDate:now];
    
    NSDate *date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay|NSCalendarUnitHour;
    NSDateComponents *cmps = [calendar components:unit fromDate:now toDate:date options:0];
    
    if (cmps.year>0||cmps.month>0) {
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)getDateAccordingTimeLine:(NSString *)timeLine formatStyle:(NSString *)formate{
    
    NSDate *nowDate = [NSDate dateWithTimeIntervalSince1970:[timeLine intValue]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:formate];
    return[formatter stringFromDate:nowDate];
}

+ (NSString *)getWeekDayForTimeLine:(NSString *)timeLine
{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeLine integerValue]];
    //    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

+(NSString *)getAgeWithDate:(NSString *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *birthDay = [dateFormatter dateFromString:date];
    NSDate *currentDate = [NSDate date];
    
    // 出生日期转换 年月日
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:birthDay];
    NSInteger brithDateYear  = [components1 year];
    NSInteger brithDateDay   = [components1 day];
    NSInteger brithDateMonth = [components1 month];
    
    // 获取系统当前 年月日
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:currentDate];
    NSInteger currentDateYear  = [components2 year];
    NSInteger currentDateDay   = [components2 day];
    NSInteger currentDateMonth = [components2 month];
    
    // 计算年龄
    NSInteger iAge = currentDateYear - brithDateYear - 1;
    if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
        iAge++;
    }
    
    return [NSString stringWithFormat:@"%ld",(long)iAge];
}
@end
