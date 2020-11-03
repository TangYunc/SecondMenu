//
//  LabelManager.m
//  Doctor
//
//  Created by yuanxin on 15/5/8.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import "LabelManager.h"

@implementation LabelManager

+(TTTAttributedLabel *)TTTAttributedLabelText:(NSString *)text lableDelegate:(id)delegate lableFont:(UIFont *)font colorForURl:(UIColor *)urlcolor withFrame:(CGRect)frame{
    TTTAttributedLabel *butedLabel = [[TTTAttributedLabel alloc]initWithFrame:frame];
    butedLabel.delegate = delegate;
    butedLabel.backgroundColor = [UIColor clearColor];
    UIFont *labelfont = nil;
    if (font)
        labelfont = font;
    else
        labelfont = [UIFont systemFontOfSize:14];
    butedLabel.font = labelfont;
    butedLabel.numberOfLines = 0;
    butedLabel.lineBreakMode = NSLineBreakByWordWrapping;
    butedLabel.text = text;
    butedLabel.linkAttributes = @{(NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:YES],
                                  (NSString*)kCTForegroundColorAttributeName : (id)[[UIColor blueColor] CGColor]};
    butedLabel.highlightedShadowColor = [UIColor whiteColor];
    butedLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
    NSError *error;
    
    NSString *regulaStr = @"<a[^>]+>[^>]+a>";

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:text
                                                options:0
                                                  range:NSMakeRange(0, [text length])];

    
    NSString *resultString = butedLabel.text;
    
    NSMutableDictionary *linksDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    
    for( NSInteger i = 0 ; i < [arrayOfAllMatches count] ; i++ ){
        
        NSTextCheckingResult *match = [arrayOfAllMatches objectAtIndex:i];
        NSString *substringForMatch = [text substringWithRange:match.range];
        //(<div class=\"hdwiki_tmml\"><a.+?>)(.+?)(</a></div>)
        NSRegularExpression *regexContent = [NSRegularExpression regularExpressionWithPattern:@"(?<=>).*?(?=</a>)"
                                                                                      options:NSRegularExpressionCaseInsensitive
                                                                                        error:&error];
        NSTextCheckingResult *linkMacth = [regexContent firstMatchInString:substringForMatch options:0 range:NSMakeRange(0, [substringForMatch length])];
        NSString *linkContentString = [substringForMatch substringWithRange:linkMacth.range];
        
        // 匹配链接
        NSString *linkRegulaStr = @"((http{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
        NSRegularExpression *linkRegexContent = [NSRegularExpression regularExpressionWithPattern:linkRegulaStr
                                                                                          options:NSRegularExpressionCaseInsensitive
                                                                                            error:&error];
        
        NSRange subStringForMatchInResultStringRang = [resultString rangeOfString:substringForMatch];// 获取截取的链接区域在新的结果字符中的rang
        // 查找链接
        NSTextCheckingResult *linkStringMacth = [linkRegexContent firstMatchInString:substringForMatch options:0 range:NSMakeRange(0, [substringForMatch length])];
        // 链接
        NSString *linkString = [substringForMatch substringWithRange:linkStringMacth.range];
        resultString = [resultString stringByReplacingCharactersInRange:subStringForMatchInResultStringRang withString:linkContentString];

        [linksDictionary setObject:linkString forKey:NSStringFromRange(NSMakeRange(subStringForMatchInResultStringRang.location, linkContentString.length))];
    }
    
    butedLabel.text = resultString;
    
    for(NSString *linkRang in [linksDictionary allKeys]){
        
        NSString *linkString = [linksDictionary objectForKey:linkRang];
        NSRange  rang = NSRangeFromString(linkRang);
        [butedLabel addLinkToURL:[NSURL URLWithString:linkString] withRange:rang];
        
    }
    
    return butedLabel;
    
}

@end
