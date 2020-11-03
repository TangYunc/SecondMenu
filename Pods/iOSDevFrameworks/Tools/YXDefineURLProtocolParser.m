//
//  YXDefineURLProtocolParser.m
//  PerfectDoc
//
//  Created by Fa Kong on 15/12/29.
//  Copyright © 2015年 YX. All rights reserved.
//

#import "YXDefineURLProtocolParser.h"

@interface YXDefineURLProtocolParser ()

@property (nonatomic,strong) NSMutableDictionary *parserDictionary;
@property (nonatomic,copy  ) NSString            *urlString;

@end

@implementation YXDefineURLProtocolParser

-(nullable id)initWithUrlString:(NSString *)urlString{
    
    self = [super init];
    if(self){
        
        self.urlString                    = urlString;
        self.parserDictionary             = [NSMutableDictionary dictionaryWithCapacity:0];
        
        NSRange rangQuestionMark          = [urlString rangeOfString:@"?"];
        if(rangQuestionMark.location!=NSNotFound){
            NSString *baseUrl = [urlString substringToIndex:rangQuestionMark.location];
            NSString *parameters = [urlString substringFromIndex:rangQuestionMark.length+rangQuestionMark.location];
            //        NSArray *tempUrl                  = [urlString componentsSeparatedByString:@"?"];
            
            
            [_parserDictionary setObject:parameters forKey:@"parameterString"];
            [_parserDictionary setObject:baseUrl forKey:@"baseUrl"];
            
            NSArray *baseUrlArray             = [baseUrl componentsSeparatedByString:@"://"];
            
            [_parserDictionary setObject:baseUrlArray.lastObject forKey:@"host"];
            [_parserDictionary setObject:baseUrlArray.firstObject forKey:@"scheme"];
            
            NSMutableDictionary *parameterDic = [NSMutableDictionary dictionaryWithCapacity:0];
            for(NSString *parameterString in  [parameters componentsSeparatedByString:@"&"]){
                NSArray *parameterArray           = [parameterString componentsSeparatedByString:@"="];
                [parameterDic setObject:parameterArray.lastObject forKey:parameterArray.firstObject];
            }
            [_parserDictionary setObject:parameterDic forKey:@"parserDictionary"];
        }else{
            
            NSString *baseUrl = urlString;
            [_parserDictionary setObject:baseUrl forKey:@"baseUrl"];
            
            NSArray *baseUrlArray             = [baseUrl componentsSeparatedByString:@"://"];
            
            [_parserDictionary setObject:baseUrlArray.lastObject forKey:@"host"];
            [_parserDictionary setObject:baseUrlArray.firstObject forKey:@"scheme"];
            
        }
        
        
    }
    return self;
    
}

-(NSString *)host{
    
    return [_parserDictionary objectForKey:@"host"];
    
}

-(NSString *)scheme{
    
    return [_parserDictionary objectForKey:@"scheme"];
}

-(NSString *)baseUrl{
    
    return [_parserDictionary objectForKey:@"baseUrl"];
}

-(NSString *)fullPath{
    
    return self.urlString;
}

-(NSString *)parameterString{
    
    return [_parserDictionary objectForKey:@"parameterString"];
}

-(NSDictionary *)parameterDictionary{
    
    return [_parserDictionary objectForKey:@"parserDictionary"];
}

-(NSString *)description{
    
    return [NSString stringWithFormat:@"\n%@\n%@\n%@\n%@\n%@\n%@",self.host,self.scheme,self.baseUrl,self.fullPath,self.parameterString,self.parserDictionary];
}

@end
