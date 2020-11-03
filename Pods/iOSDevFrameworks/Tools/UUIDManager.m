//
//  UUIDManager.m
//  DevFrameworks
//
//  Created by 张良玉 on 2020/10/13.
//  Copyright © 2020 zhangliangyu. All rights reserved.
//

#import "UUIDManager.h"
#import "KKKeychain.h"

@implementation UUIDManager

+(NSString *)getUUID
{
    NSString *KCUUIDKey = @"YX_PERFECT_UUIDKEY";
    NSString *KCUUID =[KKKeychain getStringForKey:KCUUIDKey];
    if (!KCUUID) {
        NSString *uuid = [NSUUID UUID].UUIDString;
        [KKKeychain setString:uuid forKey:KCUUIDKey];
        KCUUID =uuid;
    }
    return KCUUID;
}
@end
