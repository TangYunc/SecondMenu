//
//  YXBaseWebViewController.h
//  Doctor
//
//  Created by Jack on 15/5/22.
//  Copyright (c) 2015年 YX. All rights reserved.
//

#import "BaseRootViewController.h"
#import <WebKit/WebKit.h>
#import "YXDefineURLProtocolParser.h"
typedef NS_ENUM(NSInteger ,LoadingType) {
    LoadingProgressType,
    LoadingFloatType,
    NoLoadingType,
};

@interface BaseWebViewController : BaseRootViewController
+ (void)removeCookies;

@property (nonatomic, strong) WKWebView *mainWebView;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *refererUrl;
@property (nonatomic, assign) BOOL isHiddenCustomTitle;
@property (nonatomic, assign) LoadingType loadingType;

@property (nonatomic, assign) BOOL hiddenProgress;

- (void)webViewDidStartLoad:(WKWebView *)webView;
- (void)webViewDidFinishLoad:(WKWebView *)webView;
- (void)webViewDidLoadFail:(WKWebView *)webView withError:(NSError *)error;

- (BOOL)webView:(WKWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request;
- (NSArray *)getCookies;

- (void)setWebViewCookiesWithUrl:(NSString *)urlString;
- (void)loadCookies;

- (NSMutableURLRequest *)requestWithURL:(NSString *)urlString;

- (void)hiddenLoading;
@end
