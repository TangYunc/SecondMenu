//
//  NSString+ReadSum.m
//  OnlineHosptial
//
//  Created by mazhijun on 2019/9/21.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//


#import "NSString+ReadSum.h"

@implementation NSString (readSum)

+(NSString*)getReadSumWithString:(NSString *)amountStr{
    
    if(amountStr && ![amountStr isEqualToString:@""])
        
    {

        NSInteger num = [amountStr integerValue];
        
        if(num >=10000)
        
        {
            
            return @"1w+";
            
        }else{
            
            return amountStr;
        }
        
    }
    
    return amountStr;
    
    
}
@end
