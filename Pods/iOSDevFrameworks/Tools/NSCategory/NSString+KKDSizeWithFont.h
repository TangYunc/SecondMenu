//
//  NSString+KKDSizeWithFont.h
//  KKDictionary
//
//  Created by KungJack on 29/11/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KKDSizeWithFont)
-(CGSize)getStringSizeWithFont:(UIFont *)font;
+(CGSize)getStringSizeWithFont:(UIFont *)font;

-(CGSize)getStringSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

-(CGSize)getStringSizeWithAttribute:(NSDictionary *)attribute constrainedToSize:(CGSize)size;
-(CGSize)getStringSizeWithAttribute:(NSDictionary *)attribute;
+(CGSize)getStringSizeWithAttribute:(NSDictionary *)attribute constrainedToSize:(CGSize)size;

- (CGSize)calculatlabelWidthLabelWidth:(CGFloat)labelWidth labelHeight:(CGFloat)labelHeight font:(UIFont *)font isWidth:(BOOL)isWidth;
@end
