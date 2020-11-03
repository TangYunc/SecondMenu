//
//  NSString+KKDSizeWithFont.m
//  KKDictionary
//
//  Created by KungJack on 29/11/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import "NSString+KKDSizeWithFont.h"
#import "KKDToolsDefine.h"
@implementation NSString (KKDSizeWithFont)
-(CGSize)getStringSizeWithFont:(UIFont *)font{
    
    CGSize size ;
    if(isIOS6){
        size = [self sizeWithFont:font];
    }else{
        size = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    }
    return size;
    
}

+(CGSize)getStringSizeWithFont:(UIFont *)font{
    return [[NSString string]getStringSizeWithFont:font];
}

-(CGSize)getStringSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    
    CGSize resultSize ;
    if(isIOS6){
         resultSize = [self sizeWithFont:font constrainedToSize:size];
    }else{
       resultSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil ].size;
    }
    return resultSize;
    
}
-(CGSize)getStringSizeWithAttribute:(NSDictionary *)attribute constrainedToSize:(CGSize)size{
    CGSize resultSize ;

    resultSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil ].size;
    return resultSize;
}
-(CGSize)getStringSizeWithAttribute:(NSDictionary *)attribute
{
    CGSize size = [self sizeWithAttributes:attribute];
    return size;
}

+(CGSize)getStringSizeWithAttribute:(NSDictionary *)attribute constrainedToSize:(CGSize)size{
    return [[NSString new]getStringSizeWithAttribute:attribute constrainedToSize:size];
}

- (CGSize)calculatlabelWidthLabelWidth:(CGFloat)labelWidth labelHeight:(CGFloat)labelHeight font:(UIFont *)font isWidth:(BOOL)isWidth{
    CGSize size = CGSizeMake(0, 0);
    if (isWidth) {
        //求宽
        size = CGSizeMake(MAXFLOAT, labelHeight);
    }else{
        //求高
        size = CGSizeMake(labelWidth, MAXFLOAT);
    }
    CGSize labelSize = [self boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    //MARK:因为涉及到界面适配，所以难免出现小数，这时候采用四舍五入并且加1可以防止小数问题
    labelSize = CGSizeMake(labelSize.width + 1, labelSize.height + 1);
    return labelSize;
}

@end
