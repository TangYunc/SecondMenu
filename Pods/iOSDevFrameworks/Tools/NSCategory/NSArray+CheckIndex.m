//
//  NSArray+CheckIndex.m
//  Doctor
//
//  Created by Fa Kong on 15/9/9.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import "NSArray+CheckIndex.h"

@implementation NSArray (CheckIndex)

-(id)objectAtCheckIndex:(NSUInteger)index{

    if(self.count>0){
        if(index>-1&&index<self.count){
            return [self objectAtIndex:index];
        }
    }
    return nil;
    
}

@end
