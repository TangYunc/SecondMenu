//
//  YXBaseWKWebViewController.m
//  OnlineHosptial
//
//  Created by 张良玉 on 2019/11/15.
//  Copyright © 2019 zhangliangyu. All rights reserved.
//

#import "BaseWebViewController.h"
#import <AdSupport/AdSupport.h>
#import "NSString+URLEncoded.h"
#import "KKDToolsDefine.h"
#import "ToolsHeader.h"

#define EstimatedProgressKey @"estimatedProgress"

@interface BaseWebViewController ()<WKScriptMessageHandler , WKUIDelegate ,WKNavigationDelegate>
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation BaseWebViewController

+(void)removeCookies{
    if (@available(iOS 9.0, *)) {
        [[WKWebsiteDataStore defaultDataStore] fetchDataRecordsOfTypes:[NSSet setWithObjects:WKWebsiteDataTypeCookies, nil] completionHandler:^(NSArray<WKWebsiteDataRecord *> * _Nonnull records) {
            [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:[NSSet setWithObjects:WKWebsiteDataTypeCookies, nil] forDataRecords:records completionHandler:^{
                
            }];
        }];
    } else {
        NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:nil];
    }
}

-(void)onBackButtonPressed:(id)sender{
    if ([self.mainWebView canGoBack]) {
        [self.mainWebView goBack];
    }else {
        [super onBackButtonPressed:sender];
    }
}

- (WKWebView *)mainWebView{
    if(!_mainWebView){
        //创建网页配置对象
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        // 创建设置对象
        WKPreferences *preference = [[WKPreferences alloc]init];
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preference;
        
        // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        config.allowsInlineMediaPlayback = YES;
        
        //这个类主要用来做native与JavaScript的交互管理
        
        NSArray *cookieArray = [self getCookies];
        NSDictionary *dictCookies = [NSHTTPCookie requestHeaderFieldsWithCookies:cookieArray];//将cookie设置到头中
        NSMutableURLRequest *request = [self requestWithURL:self.urlString];
        [request setValue: [dictCookies objectForKey:@"Cookie"] forHTTPHeaderField: @"Cookie"];
        
        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        NSMutableString *cookieStr=@"".mutableCopy;
        if (cookieArray) {
            for (NSHTTPCookie *cookie in cookieArray) {
                NSString *cookieString = [NSString stringWithFormat:@"document.cookie = '%@=%@';\n",cookie.name,cookie.value];
                if (![cookieStr containsString:cookieString]) {
                    [cookieStr appendFormat:@"%@", cookieString];
                }
            }
        }

        WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource: cookieStr injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [wkUController addUserScript:cookieScript];
        config.userContentController = wkUController;
        
        
        _mainWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) configuration:config];
        if (@available(iOS 11.0, *)) {
            WKHTTPCookieStore *cookieStore = _mainWebView.configuration.websiteDataStore.httpCookieStore;
            for (NSHTTPCookie*cookie in cookieArray) {
                [cookieStore setCookie:cookie completionHandler:nil];
            }
        }
        NSString *urlString = [self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookieArray forURL:[NSURL URLWithString:urlString] mainDocumentURL:nil];
        
        // UI代理
        _mainWebView.UIDelegate = self;
        // 导航代理
        _mainWebView.navigationDelegate = self;
        // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
//        _mainWebView.allowsBackForwardNavigationGestures = YES;
        
        [_mainWebView loadRequest:request];
        _mainWebView.backgroundColor = RGB_COLOR_WITH_0x(BgViewColor);
        
        if (self.loadingType==LoadingProgressType) {
            [_mainWebView addObserver:self forKeyPath:EstimatedProgressKey options:NSKeyValueObservingOptionNew context:nil];
            [_mainWebView addSubview:self.progressView];
        }
    }
    return _mainWebView;
}

#pragma mark - getter and setter
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        _progressView.tintColor = RGB_COLOR_WITH_0x(BlueColor);
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
}

- (NSArray *)getCookies{
    return @[];
}

- (void)setWebViewCookiesWithUrl:(NSString *)urlString{
    NSArray *cookieArray = [self getCookies];
    NSDictionary *dictCookies = [NSHTTPCookie requestHeaderFieldsWithCookies:cookieArray];//将cookie设置到头中
    NSMutableURLRequest *request = [self requestWithURL:urlString];
    [request setValue: [dictCookies objectForKey:@"Cookie"] forHTTPHeaderField: @"Cookie"];
    
    NSMutableString *cookieStr=@"".mutableCopy;
    if (cookieArray) {
        for (NSHTTPCookie *cookie in cookieArray) {
            NSString *cookieString = [NSString stringWithFormat:@"document.cookie = '%@=%@';\n",cookie.name,cookie.value];
            if (![cookieStr containsString:cookieString]) {
                [cookieStr appendFormat:@"%@", cookieString];
            }
        }
    }

    WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource: cookieStr injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [self.mainWebView.configuration.userContentController addUserScript:cookieScript];
    [self.mainWebView reload];

    if (@available(iOS 11.0, *)) {
        WKHTTPCookieStore *cookieStore = _mainWebView.configuration.websiteDataStore.httpCookieStore;
        for (NSHTTPCookie*cookie in cookieArray) {
            [cookieStore setCookie:cookie completionHandler:nil];
        }

    }
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:cookieArray forURL:[NSURL URLWithString:urlString] mainDocumentURL:nil];
    
    [self.mainWebView loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mainWebView];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.mainWebView stopLoading];
    [self hiddenLoading];
}

- (void)hiddenLoading{
    if (self.loadingType == LoadingProgressType) {
        [UIView animateWithDuration:0.3f
             delay:0.3f
           options:UIViewAnimationOptionCurveEaseOut
        animations:^{
            self.progressView.alpha = 0.0f;
        }
        completion:^(BOOL finished) {
            [self.progressView setProgress:0 animated:NO];
        }];
    }else{
        [KKDLoadingViewUtil dismissLoading];
    }
}

-(void)setHiddenProgress:(BOOL)hiddenProgress{
    _hiddenProgress = hiddenProgress;
    if (self.loadingType == LoadingProgressType) {
        self.progressView.hidden = hiddenProgress;
    }
}

- (void)dealloc
{
    if (self.loadingType == LoadingProgressType) {
        [self.mainWebView removeObserver:self forKeyPath:EstimatedProgressKey];
    }
}

#pragma mark - event response
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object == self.mainWebView && [keyPath isEqualToString:EstimatedProgressKey]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        self.progressView.alpha = 1.0f;
        [self.progressView setProgress:newprogress animated:YES];
        if (newprogress >= 1.0f) {
            [UIView animateWithDuration:0.3f
                                  delay:0.3f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.progressView.alpha = 0.0f;
                             }
                             completion:^(BOOL finished) {
                                 [self.progressView setProgress:0 animated:NO];
                             }];
        }
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)webViewDidStartLoad:(WKWebView *)webView{
    if (self.loadingType == LoadingFloatType) {
        [KKDLoadingViewUtil showLoading:YES];
    }
}

-(void)webViewDidFinishLoad:(WKWebView *)webView{

    if (!self.isHiddenCustomTitle) {
        self.title = webView.title;
    }
    [self hiddenLoading];
}

-(void)webViewDidLoadFail:(WKWebView *)webView withError:(NSError *)error{
    [self hiddenLoading];
}

//被自定义的WKScriptMessageHandler在回调方法里通过代理回调回来，绕了一圈就是为了解决内存不释放的问题
//通过接收JS传出消息的name进行捕捉的回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{

}
    
#pragma mark -- WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self webViewDidStartLoad:webView];
}
    
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self webViewDidLoadFail:webView withError:error];
}
    
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
    
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self loadCookies];
    [self webViewDidFinishLoad:webView];
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        
    }];
}

-(void)loadCookies{
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    //js函数
    NSString *JSFuncString =
    @"function setCookie(name,value,expires)\
    {\
    var oDate=new Date();\
    oDate.setDate(oDate.getDate()+expires);\
    document.cookie=name+'='+value+';expires='+oDate+';path=/'\
    }\
    function getCookie(name)\
    {\
    var arr = document.cookie.match(new RegExp('(^| )'+name+'=({FNXX==XXFN}*)(;|$)'));\
    if(arr != null) return unescape(arr[2]); return null;\
    }\
    function delCookie(name)\
    {\
    var exp = new Date();\
    exp.setTime(exp.getTime() - 1);\
    var cval=getCookie(name);\
    if(cval!=null) document.cookie= name + '='+cval+';expires='+exp.toGMTString();\
    }";

    //拼凑js字符串
    NSMutableString *JSCookieString = JSFuncString.mutableCopy;
    for (NSHTTPCookie *cookie in cookieStorage.cookies) {
        NSString *cookieString = [NSString stringWithFormat:@"setCookie('%@', '%@', 1);", cookie.name, cookie.value];
        if (![JSCookieString containsString:cookieString]) {
            [JSCookieString appendString:cookieString];
        }
    }
    //执行js
    [self.mainWebView evaluateJavaScript:JSCookieString completionHandler:^(id obj, NSError * _Nullable error) {
    }];
}
    
//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self hiddenLoading];
}
    
// 接收到服务器跳转请求即服务重定向时之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}

// 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    BOOL isAllow = [self webView:webView shouldStartLoadWithRequest:navigationAction.request];
    if (isAllow) {
        decisionHandler(WKNavigationActionPolicyAllow);
    }else{
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}
    
    // 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)navigationResponse.response;
    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
    for (NSHTTPCookie *cookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
}

//需要响应身份验证时调用 同样在block中需要传入用户身份凭证
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    //用户身份信息
    completionHandler(NSURLSessionAuthChallengeUseCredential,nil);
    
}
    
    //进程被终止时调用
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
}
    
#pragma mark -- WKUIDelegate
    
    /**
     *  web界面中有弹出警告框时调用
     *
     *  @param webView           实现该代理的webview
     *  @param message           警告框中的内容
     *  @param completionHandler 警告框消失调用
     */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    completionHandler();
}
    // 确认框
    //JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    completionHandler(YES);
}
    // 输入框
    //JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    completionHandler(@"");
}
    // 页面是弹出窗口 _blank 处理
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (BOOL)webView:(WKWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request{
    NSString *urlString =[[request.URL absoluteString] stringByRemovingPercentEncoding];
    
    if (urlString&&![urlString isEqualToString:@"about:blank"]&&![urlString isEqualToString:self.urlString]) {
        
    }
   
    return YES;
}

- (NSMutableURLRequest *)requestWithURL:(NSString *)urlString{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [request addValue:self.refererUrl forHTTPHeaderField:@"referer"];
    NSDictionary *cachedHeaders = [[NSUserDefaults standardUserDefaults] objectForKey:self.urlString];
    //设置request headers (带上上次的请求头下面两参数一种就可以，也可以两个都带上)
    if (cachedHeaders) {
        NSString *etag = [cachedHeaders objectForKey:@"Etag"];
        if (etag) {
            [request setValue:etag forHTTPHeaderField:@"If-None-Match"];
        }
        NSString *lastModified = [cachedHeaders objectForKey:@"Last-Modified"];
        if (lastModified) {
            [request setValue:lastModified forHTTPHeaderField:@"If-Modified-Since"];
        }
    }
    return request;
}
@end
