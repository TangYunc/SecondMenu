//
//  DBManager.h
//  KKDictionary
//
//  Created by KungJack on 11/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

#import "NSData+CommonCrypto.h"

NSString *mixUpString();

#define kKKDKey mixUpString()

@class ResultTogetherModel;

@interface YXDBManager : NSObject{
    FMDatabase *dbManager;
    FMDatabaseQueue *dataBaseQueue;
}

@property (nonatomic,strong)FMDatabase *dbManager;
@property (nonatomic,strong)FMDatabaseQueue *dataBaseQueue;

-(id)initWithDBPath:(NSString*)path;
-(id)initWithDBName:(NSString*)name;
-(id)initWithDefaultDB;

+(NSString *)replaceSymbol:(NSString *)str;

//
-(BOOL)creatTableWithSql:(NSString *)sql;


-(NSInteger)getDBVersion;

@end
