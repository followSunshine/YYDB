//
//  WebVIewController.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/9/2.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebVIewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic, strong)NSString *titleString;
@property (nonatomic, strong)NSString *urlString;
@end
