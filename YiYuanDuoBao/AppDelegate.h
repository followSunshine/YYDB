//
//  AppDelegate.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/8/29.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
static NSString *appKey = @"ad705a59c4c3e46e88ce78bb";
static NSString *channel = @"Publish channel";
static BOOL isProduction = YES;
#import "JPUSHService.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,JPUSHRegisterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainViewcontroller;

@property (nonatomic, strong) NSString *hostUrl;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *totalMoney;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) BOOL isPay;
@property (nonatomic, assign) int plistNum;
@property (nonatomic, assign) BOOL isShenHe;
@property (nonatomic, strong) NSString *is_new;
@property (nonatomic, strong) NSString *hongbao_id;
@property (nonatomic, strong)NSString *hongbao_money;
@property (nonatomic, strong)NSDictionary *pay_data;
@property (nonatomic, strong)UIImageView *splashImageView;
@property (nonatomic, strong)NSString *wxAppId;
@property (nonatomic, strong)NSString *wxAppScrect;
@property (nonatomic, strong)NSString *isWx;
@property (nonatomic, strong)NSString *isAli;
@property (nonatomic, strong)NSString *is_disanfang_shouhuobao;
@end

