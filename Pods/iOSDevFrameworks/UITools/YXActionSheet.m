//
//  YXActionSheet.m
//  PerfectDoc
//
//  Created by 张良玉 on 2019/12/6.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "YXActionSheet.h"
#import "ToolsHeader.h"
@interface YXActionSheet ()
@end
@implementation YXActionSheet

+(void) shareActionSheetWithTitle:(nullable NSString *)title cancelButtonTitle:(nullable NSString *)cancelButtonTitle  otherButtonTitles:(nullable NSArray *)otherButtonTitles clickedButtonBlock:(void(^)(NSInteger buttonIndex))clickedButtonBlock{
    [YXActionSheet shareActionSheetWithTitle:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:nil otherButtonTitles:otherButtonTitles clickedButtonBlock:clickedButtonBlock];
}

+(void)shareActionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles clickedButtonBlock:(nonnull void (^)(NSInteger))clickedButtonBlock{
    [YXActionSheet shareActionSheetWithTitle:title message:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles clickedButtonBlock:clickedButtonBlock];
}

+(id)shareActionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    va_list args;
    va_start(args, otherButtonTitles); // scan for arguments after firstObject.
      
    // get rest of the objects until nil is found
    NSMutableArray *titles = [NSMutableArray array];
    for (NSString *str = otherButtonTitles; str != nil; str = va_arg(args,NSString*)) {
        [titles addObject:str];
    }
      
    va_end(args);
    YXActionSheet *actionSheet = [[YXActionSheet alloc]initWithTitle:title message:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:titles];
    [[UIApplication sharedApplication].keyWindow addSubview:actionSheet];
    return actionSheet;
}

+(void) shareActionSheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles clickedButtonBlock:(void(^)(NSInteger buttonIndex))clickedButtonBlock{
    YXActionSheet *actionSheet = [[YXActionSheet alloc]initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles];
    actionSheet.clickedButtonBlock = clickedButtonBlock;
    [[UIApplication sharedApplication].keyWindow addSubview:actionSheet];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle otherButtonTitles:(nullable NSArray *)otherButtonTitles
{
    self = [super init];
    if (self) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
        WS(weakSelf);
        if (destructiveButtonTitle) {
            UIAlertAction *destructive = [UIAlertAction actionWithTitle:destructiveButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf clickedButtonAtIndex:-1];
            }];
            [alert addAction:destructive];
        }
        for (int i=0; i<otherButtonTitles.count; i++) {
            NSString *title = [otherButtonTitles objectAtIndex:i];
            UIAlertAction *defaultButton = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf clickedButtonAtIndex:i];
            }];
            [alert addAction:defaultButton];
        }
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    }
    return self;
}

-(void)clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.clickedButtonBlock) {
        self.clickedButtonBlock(buttonIndex);
    }
    [self removeFromSuperview];
}

@end
