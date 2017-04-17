//
//  WebVIewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/9/2.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "WebVIewController.h"
#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"

@interface WebVIewController ()
@property (nonatomic, strong)NSString *openid;

@end

@implementation WebVIewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationController.navigationBar.hidden = YES;
    
    self.title = self.titleString;
    
    
    [self WebView];
    
    
}
- (void)quxiao{
    
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:UMSocialPlatformType_WechatSession completion:^(id result, NSError *error) {
        if (!error) {
            
        }
    }];
    
}
- (void)loginWithWeChat:(NSString *)string {
    UMSocialPlatformType type;
    if ([string isEqualToString:@"1"]) {
        type = UMSocialPlatformType_QQ;
    }else {
        type = UMSocialPlatformType_WechatSession;
    }
    [[UMSocialManager defaultManager]  authWithPlatform:type currentViewController:self completion:^(id result, NSError *error) {
        
        NSLog(@"%@",error);
        
        
        UMSocialResponse *opem = result;
        
        self.openid = opem.openid;
        
        [self getuserinfowith:string];
    }];
    
}
- (void)getuserinfowith:(NSString *)string {
    UMSocialPlatformType type;
    if ([string isEqualToString:@"1"]) {
        type = UMSocialPlatformType_QQ;
    }else {
        type = UMSocialPlatformType_WechatSession;
    }
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:type currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        NSString *str = [NSString stringWithFormat:@"http://y.ikaiwan.com/ios.php?ctl=user_center&login_type=ios_weixin&nickname=%@&openid=%@&headimgurl=%@",[self encodeString:userinfo.name],[self encodeString:self.openid],[self encodeString:userinfo.iconurl]];
        
        
        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
        
        
        [_webView loadRequest:request];
        
        
    }];
    
}
- (void)islogin:(NSString *)userid {
    
    if([userid isEqualToString:@"0"]){
        
        AppDelegate *dele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        dele.userid = nil;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userid"];
        
    }else{
        
        AppDelegate *dele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        dele.userid = userid;
        
        [[NSUserDefaults standardUserDefaults] setObject:userid forKey:@"userid"];
    }
    
}
- (void)WebView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    float height = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, height, SWIDTH, SHEIGHT-49-height)];
    
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.delegate = self;
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
    
    
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
    
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载失败");
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    NSString *absolutePath = request.URL.absoluteString;
    if ([absolutePath rangeOfString:@"/ios.php?ctl=user&act=loginout"].location !=NSNotFound) {
        [self islogin:@"0"];
        [self plistNum:@"0"];
        return YES;
    }

    NSString *scheme = @"rrcc://";
    
    if ([absolutePath hasPrefix:scheme]) {
        NSString *subPath = [absolutePath substringFromIndex:scheme.length];
        
        if ([subPath containsString:@"?"]) {//1个或多个参数
            
            if ([subPath containsString:@"&"]) {//多个参数
                NSArray *components = [subPath componentsSeparatedByString:@"?"];
                
                NSString *methodName = [components firstObject];
                
                methodName = [methodName stringByReplacingOccurrencesOfString:@"_" withString:@":"];
                SEL sel = NSSelectorFromString(methodName);
                
                NSString *parameter = [components lastObject];
                NSArray *params = [parameter componentsSeparatedByString:@"&"];
                
                if (params.count == 2) {
                    if ([self respondsToSelector:sel]) {
                        [self performSelector:sel withObject:[params firstObject] withObject:[params lastObject]];
                    }
                }
                
                
            } else {//1个参数
                NSArray *components = [subPath componentsSeparatedByString:@"?"];
                
                NSString *methodName = [components firstObject];
                methodName = [methodName stringByReplacingOccurrencesOfString:@"_" withString:@":"];
                SEL sel = NSSelectorFromString(methodName);
                
                NSString *parameter = [components lastObject];
                
                if ([self respondsToSelector:sel]) {
                    [self performSelector:sel withObject:parameter];
                }
                
            }
            
        } else {//没有参数
            NSString *methodName = [subPath stringByReplacingOccurrencesOfString:@"_" withString:@":"];
            SEL sel = NSSelectorFromString(methodName);
            
            if ([self respondsToSelector:sel]) {
                [self performSelector:sel];
            }
        }
    }

    return YES;
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)pushtoMainctr {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self pushtoMainctrWith:@"1"];
}
- (void)pushToPayCtroWith:(NSString *)str {
    
    NSURL *url = [NSURL URLWithString:[self URLDecodedString:str]];
    
    [[UIApplication sharedApplication] openURL:url];
    
}
-(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}
-(NSString*)encodeString:(NSString*)unencodedString{
    
    
    NSString*encodedString=(NSString*)
    
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              
                                                              (CFStringRef)unencodedString,
                                                              
                                                              NULL,
                                                              
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
    
}

- (void)pushtoMainctrWith:(NSString *)str {
    
    
    NSNotification *notice = [NSNotification notificationWithName:@"pushtomain" object:nil userInfo:@{@"num":str}];
    
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
    
}

- (void) plistNum:(NSString *)num {
    
    NSNotification *notice = [NSNotification notificationWithName:@"plistNum" object:nil userInfo:@{@"num":num}];
    
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
    [[NSUserDefaults standardUserDefaults] setObject:num forKey:@"number"];

}
- (void)viewDidDisappear:(BOOL)animated {
    
    
    [super viewDidDisappear:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
