//
//  DBManager.m
//  KKDictionary
//
//  Created by KungJack on 11/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import "YXDBManager.h"
#import "ToolsHeader.h"
NSString *mixUpString(){
    
    int array[] = {49,26,24,2,49,51,102,52,51,57,55,50,54,100,50,100,52,53,50,50,49,32,45,132,5843,74};
    Byte byte[16];
    for(NSInteger i=4; i<20;i++){
        byte[i-4] = array[i];
    }
    return [[NSString alloc]initWithBytes:byte length:16 encoding:NSUTF8StringEncoding];
    
}

//@"13f439726d2d4522"
//byte[] bytes = new byte[4];
//bytes[0] = 0;
//bytes[1] = 0;
//bytes[2] = 0;
//bytes[3] = 0;
//String md5 = getMD5(bytes);
//取md5字段中的奇数位再重新组合成新的字符串。
//这样可以随用随取，0是很容易取到的（比如弄个看似有Bug的代码，就是为了生成一个0值）
#define MixUpKey 0xBB

void xorString(unsigned char *str, unsigned char key)
{
    unsigned char *p = str;
    while( ((*p) ^=  key) != '\0')  p++;
}

@interface YXDBManager ()

@end

@implementation YXDBManager

@synthesize dbManager;
@synthesize dataBaseQueue;

-(id)init{
    
    self = [super init];
    if(self){
    }
    return self;
}

-(id)initWithDBPath:(NSString*)path{
    
    self = [super init];
    if(self){
        self.dbManager = [FMDatabase databaseWithPath:path];
        self.dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:path];
    }
    return self;
    
}

-(id)initWithDBName:(NSString*)name{
    
    self = [super init];
    if(self){
        NSString *path = [NSString stringWithFormat:@"%@/%@",DOCUMENTS_PATH,name];
        if([[NSFileManager defaultManager]fileExistsAtPath:path]){
            self.dbManager = [FMDatabase databaseWithPath:path];
            self.dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:path];
        }else{
//            [KKDLoadingViewUtil toast:@"使用的数据库文件不存在" time:kToastTimeShort];
            if([name isEqualToString:@"c.db"]){
                self.dbManager = [FMDatabase databaseWithPath:path];
                self.dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:path];
            }else{
                self.dbManager=[FMDatabase databaseWithPath:path];
                self.dataBaseQueue = [FMDatabaseQueue databaseQueueWithPath:path];
            }
        }
        
    }
    return self;
}

-(id)initWithDefaultDB{
    
    self = [self initWithDBName:@""];
    if(self){
    }
    return self;
    
}

-(BOOL)creatTableWithSql:(NSString *)sql{
    
    if([dbManager open]){
        BOOL flag = [dbManager executeUpdate:sql];
        [dbManager close];
        return flag;
    }
    return NO;
    
}

+(NSString *)replaceSymbol:(NSString *)str{
    
    NSString *resultString = nil;
    NSString *tempString =[[str stringByReplacingOccurrencesOfString:@"#" withString:@","] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if(str.length>2){
        resultString = [tempString substringWithRange:NSMakeRange(1, str.length-2)];
    }
    return resultString;
}

-(NSInteger)getDBVersion{
    
    NSInteger version = 0;
    if([dbManager open]){
        version = dbManager.userVersion;
        [dbManager close];
    }
    
    return version;
    
}

@end
