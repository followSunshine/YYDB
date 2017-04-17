//
//  DizhiWebViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/20.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "DizhiWebViewController.h"
#import "UIView+CGSet.h"
#import "DetailViewController.h"
@interface DizhiWebViewController ()<UIWebViewDelegate>

@end

@implementation DizhiWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self WebView];
    self.title = self.titlestring;
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *selabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    selabel.font = [UIFont systemFontOfSize:18];
    selabel.text = self.titlestring;
    selabel.textColor = [UIColor whiteColor];
    selabel.textAlignment = NSTextAlignmentCenter;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 64)];
    view.backgroundColor = SF_COLOR(255, 54, 93);
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIView setWidth:12], 30, 24, 24)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"左白箭头"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];
    [self.view addSubview:selabel];
    [self.view addSubview:returnBtn];
    
    self.view.backgroundColor = SF_COLOR(242, 242, 242);
}
- (void)returnclick {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)WebView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64)];
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.delegate = self;
    
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlstring]];
//    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.199.155/h/i.html"]];

    
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
    
}
- (void)paysuccess{
    [self.navigationController popToRootViewControllerAnimated:YES];
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    del.hongbao_id=@"";

    if (del.isPay) {
        NSNotification *no = [NSNotification notificationWithName:@"payre" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter ]postNotification:no];
    }else {
        
    }
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载失败");
    NSLog(@"%@",error);
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    
}
- (void)pushDetail:(NSString *)string {
    
    DetailViewController *de = [[DetailViewController alloc]init];
    de.userid = string;
    
    [self.navigationController pushViewController:de animated:YES];
}
- (void)pushContronllerWith:(NSString *)string {
    Class c = NSClassFromString(string);
    
    UIViewController *controller = [[UIViewController alloc]init];
    controller = [[c alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    
    NSString *absolutePath = request.URL.absoluteString;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
