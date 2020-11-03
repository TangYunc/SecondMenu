//
//  KKDToolsDefine.h
//  KKDictionary
//
//  Created by KungJack on 7/8/14.
//  Copyright (c) 2014 YY. All rights reserved.
//

#ifndef KKDictionary_KKDToolsDefine_h
#define KKDictionary_KKDToolsDefine_h

#define DEBUG_NET_DATA_LOG

/////////////////////////////////////////////////////////////////////////////////
/// 颜色
///////////////////////////////////////////////////////////////////////////////

#define RGB(A,B,C) [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]
#define RGBA(A,B,C,D) [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:D]

// 随机色
#define RandomColor RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

/////////////////////////////////////////////////////////////////////////////////
/// 使用十六进制设置颜色
/////////////////////////////////////////////////////////////////////////////////
#define RGB_COLOR_WITH_0x(__color0x16__)  [UIColor colorWithRed:((float)((0xFF0000&__color0x16__)>>16)/255.0) green:((float)((0xFF00&__color0x16__)>>8)/255.0) blue:((float)(0xFF&__color0x16__)/255.0) alpha:1.0]
#define RGB_COLOR_WITH_0x_alpha(__color0x16__,__alpha)  [UIColor colorWithRed:((float)((0xFF0000&__color0x16__)>>16)/255.0) green:((float)((0xFF00&__color0x16__)>>8)/255.0) blue:((float)(0xFF&__color0x16__)/255.0) alpha:__alpha]

/////////////////////////////////////////////////////////////////////////////////
/// 字体
/////////////////////////////////////////////////////////////////////////////////
#define kSystemFont(__arg__)[UIFont systemFontOfSize:__arg__]
#define kSystemBordFont(__arg__)[UIFont boldSystemFontOfSize:__arg__]
#define kSystemFitFont(__arg__) kSystemFont(isiPhone4||isiPhone5?__arg__-1:(isiPhoneXMax||isiPhone6Plus?__arg__+1:__arg__))
#define kSystemFitBordFont(__arg__) kSystemBordFont(isiPhone4||isiPhone5?__arg__-1:__arg__)

#define kSystemFitFontHeight(__arg__) (kSystemFitFont(__arg__).pointSize)
#define kSystemFitBordFontHeight(__arg__) (kSystemFitBordFont(__arg__).pointSize)
/////////////////////////////////////////////////////////////////////////////////
/// 测试专用输出
/////////////////////////////////////////////////////////////////////////////////
#ifdef DEBUG
#define DEBUG_LOG(format, ...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)//NSLog(format, ## __VA_ARGS__)//[iConsole info:format, ## __VA_ARGS__]//NSLog(format, ## __VA_ARGS__)
#else
#define DEBUG_LOG(format, ...) //NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)// [iConsole info:format, ## __VA_ARGS__]
#endif
/////////////////////////////////////////////////////////////////////////////////
/// 获取当前时间戳的文字
/////////////////////////////////////////////////////////////////////////////////
#define TIME_STRING_SINCE_1970 [NSString stringWithFormat:@"%0.0f",[[NSDate date] timeIntervalSince1970]]
/////////////////////////////////////////////////////////////////////////////////
/// 获取document 文件夹地址
/////////////////////////////////////////////////////////////////////////////////
#define DOCUMENTS_PATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
/////////////////////////////////////////////////////////////////////////////////
/// 获取App的版本号 CFBundleShortVersionString  kCFBundleVersionKey build版本号
/////////////////////////////////////////////////////////////////////////////////
#define GET_APP_VERSION  ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
/////////////////////////////////////////////////////////////////////////////////
/// 获取App build版本号
/////////////////////////////////////////////////////////////////////////////////
#define GET_APP_BUILD_VERSION  ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])
/////////////////////////////////////////////////////////////////////////////////
/// 获取App的版本号去掉点
/////////////////////////////////////////////////////////////////////////////////
#define GET_APP_VERSION_WITHOUT_DOT  ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@"." withString:@""])
/////////////////////////////////////////////////////////////////////////////////
/// FullVersion
/////////////////////////////////////////////////////////////////////////////////
#define GET_FULL_VERSION [NSString stringWithFormat:@"%@.%@",GET_APP_VERSION,GET_APP_BUILD_VERSION]
/////////////////////////////////////////////////////////////////////////////////
/// 获取当前文件名字
/////////////////////////////////////////////////////////////////////////////////
#define FILE_NAME [[[[[NSString stringWithFormat:@"%s",__FILE__] componentsSeparatedByString:@"/"] lastObject] componentsSeparatedByString:@"."] firstObject]
/////////////////////////////////////////////////////////////////////////////////
/// 判断是否是iPhone4
/////////////////////////////////////////////////////////////////////////////////
#define isiPhone4 CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size)
/////////////////////////////////////////////////////////////////////////////////
/// 判断是否是iPhone5
/////////////////////////////////////////////////////////////////////////////////
#define isiPhone5 CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)
/////////////////////////////////////////////////////////////////////////////////
/// 判断是否是iPhone6 {750, 1334},{{0, 20}, {375, 647}},{{0, 0}, {375, 667}}
/////////////////////////////////////////////////////////////////////////////////
#define isiPhone6 CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)
/////////////////////////////////////////////////////////////////////////////////
/// 判断是否是iPhone6+ {1242, 2208},{{0, 20}, {414, 716}},{{0, 0}, {414, 736}}
/////////////////////////////////////////////////////////////////////////////////
#define isiPhone6Plus CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)
/////////////////////////////////////////////////////////////////////////////////
#define isiPhoneX kStatusBarHeigth>20
#define isiPhoneXMax (isiPhoneX&&[[UIScreen mainScreen] currentMode].size.width>1125)
/////////////////////////////////////////////////////////////////////////////////
/// 当前操作系统版本是不是iOS6
/////////////////////////////////////////////////////////////////////////////////
#define isIOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
#define isIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define isIOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define isIOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define isIOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#define isIOS13 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13.0)
/////////////////////////////////////////////////////////////////////////////////
/// 屏幕宽度
/////////////////////////////////////////////////////////////////////////////////
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
/////////////////////////////////////////////////////////////////////////////////
/// 起始Y坐标
/////////////////////////////////////////////////////////////////////////////////
#define kStartY (isIOS6?0:0)
#define kStartX 10//(kScreenWidth/32)
/////////////////////////////////////////////////////////////////////////////////

///状态栏高度
/////////////////////////////////////////////////////////////////////////////////
#define kStatusBarHeigth ([UIApplication sharedApplication].statusBarFrame.size.height)
/////////////////////////////////////////////////////////////////////////////////
///导航高度
/////////////////////////////////////////////////////////////////////////////////
#define kNavigationBarHeight ([[UINavigationController alloc]init].navigationBar.height)

//TabBar高度
#define kTabBar_HEIGHT (isiPhoneX?83:49)
/////////////////////////////////////////////////////////////////////////////////
///iPhoneX类型手机安全区域高度34,iPhone为0
#define kSafeAreaHeight (isiPhoneX?29:0)
#define kSafeAreaBasisHeight(__arg__) (isiPhoneX?34-__arg__:0)
/// 可操作区域高度
/////////////////////////////////////////////////////////////////////////////////
#define kScreenHeight ([[UIScreen mainScreen] bounds].size.height - kNavigationBarHeight - kStatusBarHeigth)

/// 屏幕高度
/////////////////////////////////////////////////////////////////////////////////
#define kMainScreenHeight [[UIScreen mainScreen] bounds].size.height

/////////////////////////////////////////////////////////////////////////////////
/// 当前操作系统版本是不是iOS6
/////////////////////////////////////////////////////////////////////////////////
#define kFullScreenCGRect ((CGRect){CGPointMake(0,kStartY),CGSizeMake(kScreenWidth, kScreenHeight)})
#define kFullScreenNoTitleCGRect ((CGRect){CGPointMake(0,((isIOS6)?0:20)),CGSizeMake(kScreenWidth, ([[UIScreen mainScreen] bounds].size.height - ((isIOS6)?0:20)))}) //CGRectMake(0,(isIOS6)?0:20, 320, (isiPhone5)?548:460)
/////////////////////////////////////////////////////////////////////////////////
///
/////////////////////////////////////////////////////////////////////////////////
#define KKD_CMD_NAME NSStringFromSelector(_cmd)
/////////////////////////////////////////////////////////////////////////////////
/// 根据总数及每行个数，获取总共多少行
/////////////////////////////////////////////////////////////////////////////////
#define GET_ROW_NUM_WITH_ROW_COUNT(__Count,__rowCount) (__Count/__rowCount + ( __Count%__rowCount == 0?0:1 ))
/////////////////////////////////////////////////////////////////////////////////
/// 根据总数及每行个数，获取总共多少行
/////////////////////////////////////////////////////////////////////////////////
//#define KKD_NSINETGER_2_NSSTRING(__value) ((isIOS6)?[NSString stringWithFormat:@"%d",__value]:[NSString stringWithFormat:@"%ld",__value])

#if __LP64__ || (TARGET_OS_EMBEDDED && !TARGET_OS_IPHONE) || TARGET_OS_WIN32 || NS_BUILD_32_LIKE_64
#define KKD_NSINETGER_2_NSSTRING(__value) [NSString stringWithFormat:@"%ld",__value]
#define KKD_INT(__value) ((NSInteger)__value)
#else
#define KKD_NSINETGER_2_NSSTRING(__value) [NSString stringWithFormat:@"%d",__value]
#define KKD_INT(__value) (__value)

#endif

#define kGetLong(iPhone4,iPhone5,iPhone6,iPhone6Plus) (isiPhone5? (iPhone5):isiPhone6?(iPhone6):isiPhone6Plus?(iPhone6Plus):(iPhone4))

//竖屏
#define kIsOrientationPortrait [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait

#define kGetWidth(__A) (__A* ((kIsOrientationPortrait) ? kScreenWidth : kMainScreenHeight) /375)

//有导航栏的高度
//#define kGetHeight(__A) (__A*kScreenHeight/667)

//没有导航栏的时候的高度
#define kGetHeightWithoutNavi(__A) (__A*(kScreenHeight+65)/667)

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

#define KUserDefault [NSUserDefaults standardUserDefaults]

// 防止多次调用
#define kPreventRepeatClickTime(_seconds_) \
static BOOL shouldPrevent; \
if (shouldPrevent) return; \
shouldPrevent = YES; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((_seconds_) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
shouldPrevent = NO; \
}); \

//
#endif
