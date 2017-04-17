//
//  AppDelegate.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/8/29.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "AppDelegate.h"
#import "ContestViewController.h"
#import "PulishViewController.h"

#import "PlistViewController.h"
#import "MainYSViewController.h"
#import "DuoBaoJLViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "LoginViewController.h"
#import "ForgetViewController.h"

#import "GouwuController.h"
#import "FinderViewController.h"
#import "PayViewController.h"
#import "WXApi.h"
#import "SearchViewController.h"
#import "BBLaunchAdMonitor.h"
#import "AFHTTPSessionManager.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<WXApiDelegate>
{
    ContestViewController *_contestViewController;
    UINavigationController *_navContestViewController;
    
    PulishViewController *_pulishViewController;
    UINavigationController *_navPulishViewController;
    
    UINavigationController *_navFindViewController;
    
    PlistViewController *_plistViewController;
    UINavigationController *_navPlistViewController;
    
    
    MainYSViewController *_mainYSViewController;
    UINavigationController *_navMainYsContro;
    
    FinderViewController *_duobaoView;
    UINavigationController *_navduobao;
    
    GouwuController *_gouwuController;
    UINavigationController *_navGouwu;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    self.window.backgroundColor = [UIColor whiteColor];
 
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *str1 = [user valueForKey:@"userid"];
    self.userid = @"";
    if (str1) {
        self.userid = str1;
        self.icon = [user valueForKey:@"usericon"];
        self.name = [user valueForKey:@"username"];
        self.totalMoney = [user valueForKey:@"usermoney"];
        NSString *num = [user valueForKey:@"usernum"];
        self.plistNum = num.intValue;
    }else {
        self.userid = @"";
    }
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window.rootViewController = [self creatRootController];;
    [self.window makeKeyAndVisible];
    [self requestInit];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAdDetail:) name:BBLaunchAdDetailDisplayNotification object:nil];
    NSString *path = @"https://s1.vbokai.com/public/attachment/shanp2x.png";
    [BBLaunchAdMonitor showAdAtPath:path
                             onView:self.window.rootViewController.view
                       timeInterval:3.
                   detailParameters:@{@"carId":@(12345), @"name":@"奥迪-品质生活"}];


    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    

    
    return YES;
    
}
- (void)requestInit {
    
    AFHTTPSessionManager *manger = [[AFHTTPSessionManager alloc]init];
    
    [manger GET:@"https://y.api.ikaiwan.com/main/1.6/conf.php" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSDictionary *dica = dic[@"weixinpay"];
        self.wxAppId = dica[@"appid"];
        self.wxAppScrect = dica[@"appsecret"];
        self.isWx = dic[@"is_weixin"];
        
        self.isAli = dic[@"is_ali"];

        self.is_disanfang_shouhuobao = dic[@"is_disanfang_shouhuobao"];
        

        [self initshare];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)showAdDetail:(NSNotification *)noti
{
    NSLog(@"detail parameters:%@", noti.object);
}

- (void)initshare {
    
    [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5805e8a167e58e8017000cb4"];
    
    // 获取友盟social版本号
//    NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    //各平台的详细配置
    //设置微信的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:self.wxAppId appSecret:self.wxAppScrect redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置分享到QQ互联的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105763148"  appSecret:@"qL2I3PcF8V0F8IxZ" redirectURL:@"http://mobile.umeng.com/social"];
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
    
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    self.isPay = NO;
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (UITabBarController *)creatRootController {
    
    _contestViewController = [[ContestViewController alloc]init];
    _navContestViewController = [[UINavigationController alloc]initWithRootViewController:_contestViewController];
    UITabBarItem *conItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"2首页未点击"] selectedImage:[UIImage imageNamed:@"2首页"]];
    _navContestViewController.tabBarItem = conItem;
    
    _contestViewController.title = @"首页";
    
  
    _pulishViewController = [[PulishViewController alloc]init];
    _navPulishViewController = [[UINavigationController alloc]initWithRootViewController:_pulishViewController];
    UITabBarItem *pulishItem=[[UITabBarItem alloc]initWithTitle:@"幸运" image:[UIImage imageNamed:@"2幸运未点击"] selectedImage:[UIImage imageNamed:@"2幸运"]];
    _navPulishViewController.tabBarItem = pulishItem;
    _pulishViewController.title=@"幸运";
    
    _gouwuController = [[GouwuController alloc]init];
    _navFindViewController = [[UINavigationController alloc]initWithRootViewController:_gouwuController];
    UITabBarItem *findItem=[[UITabBarItem alloc]initWithTitle:@"清单" image:[UIImage imageNamed:@"2清单未点击"] selectedImage:[UIImage imageNamed:@"2清单点击"]];
    _navFindViewController.tabBarItem = findItem;
    _gouwuController.title=@"清单";
    
    _duobaoView = [[FinderViewController alloc]init];
    _navduobao = [[UINavigationController alloc]initWithRootViewController:_duobaoView];
    UITabBarItem *plistItem=[[UITabBarItem alloc]initWithTitle:@"活动" image:[UIImage imageNamed:@"2活动未点击"] selectedImage:[UIImage imageNamed:@"2活动点击"]];
    _navduobao.tabBarItem = plistItem;
    _duobaoView.title=@"活动";
    
    _mainYSViewController = [[MainYSViewController alloc]init];
    
    _navMainYsContro = [[UINavigationController alloc]initWithRootViewController:_mainYSViewController];
    UITabBarItem *MineItem=[[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"2我的未点击"] selectedImage:[UIImage imageNamed:@"2我的点击"]];
    _mainYSViewController.tabBarItem = MineItem;
    _mainYSViewController.title=@"我的";
    UITabBarController *tab=[UITabBarController new];
    tab.viewControllers=@[_navContestViewController,_navduobao,_navPulishViewController,_navFindViewController,_navMainYsContro];
    
    _mainViewcontroller = [[MainViewController alloc]init];
    
    _mainViewcontroller.viewControllers = @[_navContestViewController,_navduobao,_navPulishViewController,_navFindViewController,_navMainYsContro];
    
    return _mainViewcontroller;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
        BOOL result;
        if (self.isPay) {
            result = [WXApi handleOpenURL:url delegate:self];
            self.isPay = NO;
        }else{
            result = [[UMSocialManager defaultManager] handleOpenURL:url];
        }
        if (!result) {
            if ([[url scheme]isEqualToString:@"paysuccess"]) {
                self.hongbao_id=@"";

                NSNotification *no = [NSNotification notificationWithName:@"payfinish" object:nil userInfo:nil];
                NSNotification *no1 = [NSNotification notificationWithName:@"chongfinish" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter]postNotification:no];
                [[NSNotificationCenter defaultCenter]postNotification:no1];
            }
    
        }
        return result;

}


//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
//    BOOL result;
//    if (self.isPay) {
//        result = [WXApi handleOpenURL:url delegate:self];
//        self.isPay = NO;
//    }else{
//        result = [[UMSocialManager defaultManager] handleOpenURL:url];
//    }
//    if (!result) {
//        if ([[url scheme]isEqualToString:@"paysuccess"]) {
//            
//            NSNotification *no = [NSNotification notificationWithName:@"payfinish" object:nil userInfo:nil];
//            NSNotification *no1 = [NSNotification notificationWithName:@"chongfinish" object:nil userInfo:nil];
//            [[NSNotificationCenter defaultCenter]postNotification:no];
//            [[NSNotificationCenter defaultCenter]postNotification:no1];
//        }
//
//    }
//    return result;
//}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
        BOOL result;
        if (self.isPay) {
            result = [WXApi handleOpenURL:url delegate:self];
            self.isPay = NO;
        }else{
            result = [[UMSocialManager defaultManager] handleOpenURL:url];
        }
        if (!result) {
            if ([[url scheme]isEqualToString:@"paysuccess"]) {
                self.hongbao_id=@"";

                NSNotification *no = [NSNotification notificationWithName:@"payfinish" object:nil userInfo:nil];
                NSNotification *no1 = [NSNotification notificationWithName:@"chongfinish" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter]postNotification:no];
                [[NSNotificationCenter defaultCenter]postNotification:no1];
            }
    
        }
        return result;

}

-(void) onResp:(BaseResp*)resp
{
    self.isPay = NO;
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
            {payResoult = @"支付结果：成功！";
                self.hongbao_id=@"";
            }
                break;
            case -1:
                payResoult = @"支付结果：失败！";
            
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
        NSLog(@"%@",payResoult);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:payResoult preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:act];
        NSNotification *no = [NSNotification notificationWithName:@"payre" object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:no];
        [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
        
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:self.userid forKey:@"userid"];
    [user setObject:self.icon forKey:@"usericon"];
    [user setObject:self.name forKey:@"username"];
    [user setObject:self.totalMoney forKey:@"usermoney"];
    
    [user setObject:[NSString stringWithFormat:@"%d",self.plistNum] forKey:@"usernum"];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

   }

- (void)applicationWillTerminate:(UIApplication *)application {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:self.userid forKey:@"userid"];
    [user setObject:self.icon forKey:@"usericon"];
    [user setObject:self.name forKey:@"username"];
    [user setObject:self.totalMoney forKey:@"usermoney"];
    [user setObject:[NSString stringWithFormat:@"%d",self.plistNum] forKey:@"usernum"];

}

@end
