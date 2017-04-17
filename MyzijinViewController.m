//
//  MyzijinViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/19.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "MyzijinViewController.h"
#import "MoneyModel.h"
#import "AFHTTPSessionManager.h"
#import "rizhiViewController.h"
#import "ChongZhiViewController.h"
@interface MyzijinViewController ()

@end

@implementation MyzijinViewController
{
    UILabel *label3;
    int a;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self request];
    self.title = @"我的账户";
    self.view.backgroundColor = SF_COLOR(248, 248, 248);
}
- (void)setup {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64 +[UIView getHeight:10], SWIDTH, [UIView getHeight:36])];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label1 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:0 andY:3 andWidth:30 andHeight:30]];
    label1.text = @"\ue6f3";
    label1.font = [UIFont fontWithName:@"iconfont" size:22];
    label1.textColor = SF_COLOR(174, 222, 71);
    label1.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label1];
    UILabel *label2 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:30 andY:0 andWidth:290 andHeight:36]];
    label2.text = @"账户余额";
    label2.textColor = SF_COLOR(125, 135, 148);
    [view addSubview:label2];
    label3 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:200 andY:0 andWidth:80 andHeight:36]];
    label3.textColor = SF_COLOR(125, 135, 148);
    label3.font = [UIFont systemFontOfSize:14];
    [view addSubview:label3];
    
    [self.view addSubview:view];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 64+[UIView getHeight:10]+[UIView getHeight:36]+1, SWIDTH, [UIView getHeight:36])];
    view1.backgroundColor = [UIColor whiteColor];
    UILabel *label4 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:0 andY:3 andWidth:30 andHeight:30]];
    label4.text = @"\ue6f2";
    label4.font = [UIFont fontWithName:@"iconfont" size:22];
    label4.textColor = SF_COLOR(196, 124, 242);
    label4.textAlignment = NSTextAlignmentCenter;
    [view1 addSubview:label4];
    UILabel *label5 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:30 andY:0 andWidth:290 andHeight:36]];
    label5.text = @"充值";
    label5.textColor = SF_COLOR(125, 135, 148);
    [view1 addSubview:label5];
 
    [self.view addSubview:view1];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click1:)];
    view1.userInteractionEnabled = YES;
    [view1 addGestureRecognizer:tap1];

}
- (void)request {
    a = 1;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!dele.userid.length) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还尚未登陆" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
        }];
        UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"再看看" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:act];
        [alert addAction:act1];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }

    NSString *url = [NSString stringWithFormat:@"%@?ctl=uc_money&act=setting&uid=%@",urlpre,dele.userid];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        label3.text = [NSString stringWithFormat:@"%@ 夺宝币",dic[@"money"]];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (a==1) {
        [self request];
    }
    
}
- (void)click:(UITapGestureRecognizer *)tap {
    
    [self.navigationController pushViewController:[[rizhiViewController alloc]init] animated:YES];
}
- (void)click1:(UITapGestureRecognizer *)tap {
    [self.navigationController pushViewController:[[ChongZhiViewController alloc]init] animated:YES];
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
