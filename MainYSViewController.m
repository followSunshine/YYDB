//
//  MainYSViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/10.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "MainYSViewController.h"
#import "MyMessageViewController.h"
#import "MyzijinViewController.h"
#import "SetUpViewController.h"
#import "ShezhiViewController.h"
#import "MyzhongjiangjiluViewController.h"
#import "MyshaidanViewController.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "DuoBaoJLViewController.h"
#import "ChongZhiViewController.h"
#import "AFHTTPSessionManager.h"
#import "UIView+CGSet.h"
#import "DizhiViewController.h"
#import "MyJiFenViewController.h"
#import "MyPersonViewController.h"
#import "MyHBViewController.h"
#import "MyDBBViewController.h"
#import "MyYQViewController.h"
@interface MainYSViewController ()

@end

@implementation MainYSViewController
{
    UILabel *nameLabel;
    UIImageView *headImage;
    UILabel *DBlabel;
    UILabel *yuelabel;
    UIImageView *view2;
    UILabel *label;
    UILabel *label2;
    UILabel *jifenlabel;
    UILabel *honglabel;
    UILabel *yelabel;
    NSString *jifenstrtr;
    UILabel *loginlabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.hidden = YES;
//    [self creatUI];
    [self setUPUI];
    self.view.backgroundColor = [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(change:) name:@"appdelegate" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tuichu:) name:@"tuichu" object:nil];
}

- (void)request {
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    
    NSString *url =[NSString stringWithFormat:@"%@?ctl=user_center&v=3&uid=%@",urlpre,del.userid];
    if (del.userid.length) {
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"%@",responseObject);
            
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSString *a = dic[@"status"];
            if (a.intValue==1) {
                
                [view2 sd_setImageWithURL:[NSURL URLWithString:dic[@"user_avatar"]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
                loginlabel.text = @"";
                label.text = dic[@"user_name"];
                label2.text = dic[@"mobile"];
                if (!label2.text.length) {
                    label2.text = @"手机号未设置";
                }
                NSNumber *jifennum =dic[@"user_score"];
                NSString *jifen = [NSString stringWithFormat:@"%@",jifennum];
                NSString *str = [NSString stringWithFormat:@"%@分",jifen];
                jifenstrtr = jifen;
                NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:str];
                [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, jifen.length)];
                [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(jifen.length, 1)];
                jifenlabel.attributedText = str1;
                NSString *hb = dic[@"hongbao_count"];
                NSString *str2 = [NSString stringWithFormat:@"%@个",hb];
                NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc]initWithString:str2];
                [str3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, hb.length)];
                [str3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(hb.length, 1)];
                honglabel.attributedText = str3;
                NSNumber *binum = dic[@"user_money_int"];
                NSString *bi = [NSString stringWithFormat:@"%@",binum];
                del.totalMoney = bi;
                
                NSString *str4 = [NSString stringWithFormat:@"%@币",bi];
                
                NSMutableAttributedString *str5 = [[NSMutableAttributedString alloc]initWithString:str4];
                [str5 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, bi.length)];
                [str5 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(bi.length, 1)];
                yelabel.attributedText = str5;
//                label2.text = 
                
                
            }else {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"信息错误" message:dic[@"info"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];

    }else {
        view2.image = [UIImage imageNamed:@"默认头像"];
        loginlabel.text = @"请点击登陆";
        label.text = @"";
        label2.text =@"";
        NSString *str2 = @"0个";
        
        NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc]initWithString:str2];
        [str3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 1)];
        [str3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(1, 1)];
        honglabel.attributedText = str3;
        
        
        NSString *str = [NSString stringWithFormat:@"0分"];
        
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:str];
        [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 1)];
        [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(1, 1)];
        jifenlabel.attributedText = str1;
        
        NSString *str4 = [NSString stringWithFormat:@"0币"];
        
        NSMutableAttributedString *str5 = [[NSMutableAttributedString alloc]initWithString:str4];
        [str5 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 1)];
        [str5 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(1, 1)];
        yelabel.attributedText = str5;

    }
   }
- (void)setUPUI {
    
    UIView *headview = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:160]];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[ (__bridge id)SF_COLOR(255, 54, 93).CGColor, (__bridge id)SF_COLOR(255, 54, 93).CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = [UIView setRectWithX:0 andY:0 andWidth:375 andHeight:160];
    [headview.layer addSublayer:gradientLayer];
    [self.view addSubview:headview];
    
    
    headview.userInteractionEnabled = YES;
    UIImageView *image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:17 andY:36 andWidth:24 andHeight:24]];
    
    image.image = [UIImage imageNamed:@"icon-通知"];
//    [self.view addSubview:image];
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:334 andY:36 andWidth:24 andHeight:24]];
    image1.image = [UIImage imageNamed:@"icon--设置"];
    [self.view addSubview:image1];

    UIButton *btn23 = [[UIButton alloc]initWithFrame:[UIView setRectWithX:334 andY:36 andWidth:24 andHeight:24]];
    [btn23 addTarget:self action:@selector(tap123:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn23];
    
    self.view.userInteractionEnabled = YES;
    UILabel *mineLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:41 andY:36 andWidth:293 andHeight:24]];
    mineLabel.font = [UIFont systemFontOfSize:20];
    mineLabel.text = @"我的";
    mineLabel.textAlignment = NSTextAlignmentCenter;
    mineLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:mineLabel];
    
    UITapGestureRecognizer *tapl = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shezhi:)];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake([UIView setWidth:17], [UIView setHeight:86], [UIView setWidth:60], [UIView setWidth:60])];
    view1.layer.cornerRadius = [UIView setWidth:30];
    view1.clipsToBounds = YES;
    view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view1];
    view1.userInteractionEnabled = YES;
    [view1 addGestureRecognizer:tapl];
    
    view2 = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:18], [UIView setHeight:87], [UIView setWidth:58], [UIView setWidth:58])];
    view2.layer.cornerRadius = [UIView setWidth:29];
    view2.clipsToBounds = YES;
    view2.backgroundColor = [UIColor whiteColor];
    view2.image = [UIImage imageNamed:@"默认头像"];
    [self.view addSubview:view2];
    view2.userInteractionEnabled = YES;
    [view2 addGestureRecognizer:tapl];
    loginlabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view1.frame)+[UIView setWidth:10], [UIView setHeight:109], [UIView setWidth:260], [UIView setHeight:15])];
    loginlabel.font = [UIFont systemFontOfSize:14];
    loginlabel.textColor = [UIColor whiteColor];
    [self.view addSubview:loginlabel];
    label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view1.frame)+[UIView setWidth:10], [UIView setHeight:92], [UIView setWidth:260], [UIView setHeight:15])];
    label.textColor = SF_COLOR(249, 249, 249);
    label.font = [UIFont systemFontOfSize:14];
//    label.text = @"岂有此女";

    [self.view addSubview:label];
    label.userInteractionEnabled = YES;
    [label addGestureRecognizer:tapl];
    label2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(view1.frame)+[UIView setWidth:10], [UIView setHeight:122], [UIView setWidth:100], [UIView setHeight:15])];
    label2.textColor = SF_COLOR(249, 249, 249);
    label2.font = [UIFont systemFontOfSize:14];
    label2.text = @"";
    [self.view addSubview:label2];
    label2.userInteractionEnabled = YES;
    [label2 addGestureRecognizer:tapl];
    
    UIButton *button = [[UIButton alloc]initWithFrame:[UIView setRectWithX:17 andY:86 andWidth:160 andHeight:60]];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    if (SWIDTH==320) {
//        view1.frame = CGRectMake([UIView setWidth:17], [UIView setHeight:71], [UIView setWidth:60], [UIView setWidth:60]);
//        view2.frame = CGRectMake([UIView setWidth:18], [UIView setHeight:72], [UIView setWidth:58], [UIView setWidth:58]);
//        label.frame = CGRectMake(CGRectGetMaxX(view1.frame)+[UIView setWidth:10], [UIView setHeight:77], [UIView setWidth:100], [UIView setHeight:15]);
//        label2.frame=CGRectMake(CGRectGetMaxX(view1.frame)+[UIView setWidth:10], [UIView setHeight:107], [UIView setWidth:100], [UIView setHeight:15]);
    }

    
    UILabel *label3 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:240 andY:111 andWidth:100 andHeight:10]];
    label3.font = [UIFont systemFontOfSize:13];
    label3.textColor = SF_COLOR(249, 249, 249);
    label3.text = @"个人资料";
    label3.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:label3];
    label3.userInteractionEnabled = YES;
    [label3 addGestureRecognizer:tapl];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:347 andY:111 andWidth:10 andHeight:10]];
    imageview.image = [UIImage imageNamed:@"白箭头"];
    [self.view addSubview:imageview];
    
    UIView *view3= [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:160 andWidth:375 andHeight:70]];
    view3.backgroundColor = SF_COLOR(255, 255, 255);
    [self.view addSubview:view3];
    jifenlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:15 andWidth:79 andHeight:20]];
    NSString *str = @"0分";
    jifenlabel.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:str];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 1)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(1, 1)];
    jifenlabel.attributedText = str1;
    jifenlabel.textColor = SF_COLOR(255, 124, 78);
    [view3 addSubview:jifenlabel];
    UILabel *jlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:35 andWidth:79 andHeight:20]];
    jlabel.text = @"积分";
    jlabel.textColor = SF_COLOR(102, 102, 102);
    jlabel.font = [UIFont systemFontOfSize:14];
    jlabel.textAlignment = NSTextAlignmentCenter;
    [view3 addSubview:jlabel];
    
    UILabel *linelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:102 andY:15 andWidth:0.3 andHeight:40]];
    linelabel.backgroundColor = SF_COLOR(204, 204, 204);
    [view3 addSubview:linelabel];
    
    UILabel *linlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:69.5 andWidth:375 andHeight:0.3]];
    linlabel.backgroundColor = SF_COLOR(232, 232, 232);
    [view3 addSubview:linlabel];
    
    
    honglabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:103 andY:15 andWidth:79 andHeight:20]];
    NSString *str2 = @"0个";
    
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc]initWithString:str2];
    [str3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 1)];
    [str3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(1, 1)];
    honglabel.attributedText = str3;
    honglabel.textColor = SF_COLOR(255, 171, 71);
    [view3 addSubview:honglabel];
    honglabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *hblabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:103 andY:35 andWidth:79 andHeight:20]];
    hblabel.text = @"红包";
    hblabel.textColor = SF_COLOR(102, 102, 102);
    hblabel.font = [UIFont systemFontOfSize:14];
    hblabel.textAlignment = NSTextAlignmentCenter;
    [view3 addSubview:hblabel];
     AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UILabel *linelabel1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:181 andY:15 andWidth:0.3 andHeight:40]];
    linelabel1.backgroundColor = SF_COLOR(204, 204, 204);
    
    yelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:182 andY:15 andWidth:79 andHeight:20]];
    NSString *str4 = @"0币";
    
    NSMutableAttributedString *str5 = [[NSMutableAttributedString alloc]initWithString:str4];
    [str5 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 1)];
    [str5 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:NSMakeRange(1, 1)];
    yelabel.attributedText = str5;
    yelabel.textColor = SF_COLOR(255, 55, 97);
    yelabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *ylabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:182 andY:35 andWidth:79 andHeight:20]];
    ylabel.text = @"余额";
    ylabel.textColor = SF_COLOR(102, 102, 102);
    ylabel.font = [UIFont systemFontOfSize:14];
    ylabel.textAlignment = NSTextAlignmentCenter;
    
    UIButton *brn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:267 andY:19 andWidth:80 andHeight:32]];
    
    [brn setBackgroundImage:[UIImage imageNamed:@"充值按钮"] forState:UIControlStateNormal];
    [brn addTarget:self action:@selector(chongzhi) forControlEvents:UIControlEventTouchUpInside];
    
   
    if (!del.isShenHe) {
        [view3 addSubview:brn];
        [view3 addSubview:ylabel];
        [view3 addSubview:yelabel];
        [view3 addSubview:linelabel1];
        
    }

    UIButton *btn1 = [[UIButton alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:103 andHeight:70]];
    btn1.backgroundColor = [UIColor clearColor];
    [btn1 addTarget:self action:@selector(jifenClick) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:[UIView setRectWithX:103 andY:0 andWidth:79 andHeight:70]];
    btn2.backgroundColor = [UIColor clearColor];
    [btn2 addTarget:self action:@selector(hongbaoClick) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:btn2];
    UIButton *btn3 = [[UIButton alloc]initWithFrame:[UIView setRectWithX:182 andY:0 andWidth:85 andHeight:70]];
    btn3.backgroundColor = [UIColor clearColor];
    [btn3 addTarget:self action:@selector(yueClick) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:btn3];
    NSArray *imageArray = @[@"icon-夺宝记录",@"icon-中奖记录",@"icon-晒单分享",@"icon-邀请好友",@"icon-收货地址"];
    NSArray *labelArray = @[@"夺宝记录",@"中奖纪录",@"晒单分享",@"邀请好友",@"收货地址"];
    if(del.isShenHe) {
        labelArray = @[@"夺宝箱",@"幸运的纪录",@"晒单",@"快来邀请",@"你的收货"];
        imageArray = @[@"新夺宝记录",@"新中奖记录",@"新晒单分享",@"新邀请好友",@"新收货地址"];
//        imageArray = @[@"2夺宝记录",@"2中奖记录",@"2晒单分享",@"2邀请好友",@"2收货地址"];

    }
    
    for (int i = 0; i < 5; i++) {
        UIView *view = [[UIView alloc]init];
        if (i<3) {
            view.frame = [UIView setRectWithX:0 andY:246+i*40 andWidth:375 andHeight:40];
            
        }else {
             view.frame = [UIView setRectWithX:0 andY:262+i*40 andWidth:375 andHeight:40];
        }
        view.backgroundColor = [UIColor whiteColor];
        UIImageView *image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:12 andY:10 andWidth:20 andHeight:20]];
        image.image = [UIImage imageNamed:imageArray[i]];
        UILabel *label32 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:45 andY:0 andWidth:340 andHeight:40]];
        label32.font = [UIFont systemFontOfSize:16];
        label32.textColor = SF_COLOR(102, 102, 102);
        label32.text = labelArray[i];
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:347 andY:15 andWidth:10 andHeight:10]];
        imageview.image = [UIImage imageNamed:@"灰箭头"];
        [view addSubview:label32];
        [view addSubview:imageview];
        [view addSubview:image];
        UILabel *linelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:46 andY:39.5 andWidth:375-46 andHeight:0.3]];
        linelabel.backgroundColor = SF_COLOR(229, 229, 229);
        
        
        if (i==0||i==1||i==3) {
            [view addSubview:linelabel];
        }
        if (i==0||i==3) {
            UILabel *linelabel2 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:0.3]];
            linelabel2.backgroundColor = SF_COLOR(232, 232, 232);
            [view addSubview:linelabel2];
        }
        if (i==2||i==4) {
            UILabel *linelabel2 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:39.5 andWidth:375 andHeight:0.3]];
            linelabel2.backgroundColor = SF_COLOR(232, 232, 232);
            [view addSubview:linelabel2];

        }
        
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDian:)];
        [view addGestureRecognizer:tap];
        view.tag = 132+i;
        [self.view addSubview:view];
    }
    
}
- (void)tap123:(UIButton *)tap {
    
    [self.navigationController pushViewController:[[SetUpViewController alloc]init] animated:YES];
    [self hideTabBar];
}
- (void)shezhi:(UITapGestureRecognizer *)tap {
    
    [self.navigationController pushViewController:[[MyPersonViewController alloc]init] animated:YES];
    
    [self hideTabBar];
}
- (void)tapDian:(UITapGestureRecognizer *)tap {
    int a = (int)tap.view.tag;
    if (a==132) {
     

        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if (del.userid.length) {
            DuoBaoJLViewController *duo = [[DuoBaoJLViewController alloc]init];
            self.navigationController.navigationBar.hidden = NO;
            [self hideTabBar];
            [self.navigationController pushViewController:duo animated:YES];
        }else {
            LoginViewController *login = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
            [self hideTabBar];
            
        }
    }else if (a==133) {
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if (del.userid.length) {
            
            MyzhongjiangjiluViewController *mu = [[MyzhongjiangjiluViewController alloc]init];
            [self hideTabBar];
            [self.navigationController pushViewController:mu animated:YES];
            
        }else {
            LoginViewController *login = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
            [self hideTabBar];
            
        }

    }else if (a==134) {
        
        
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if (del.userid.length) {
            MyshaidanViewController *mu = [[MyshaidanViewController alloc]init];
            [self hideTabBar];
            self.navigationController.navigationBar.hidden = NO;
            [self.navigationController pushViewController:mu animated:YES];
        }else {
            LoginViewController *login = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
            [self hideTabBar];
            
        }

    }else if (a==135) {

        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if (del.userid.length) {
            MyYQViewController *mu = [[MyYQViewController alloc]init];
            [self hideTabBar];
            [self.navigationController pushViewController:mu animated:YES];
            
        }else {
            LoginViewController *login = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
            [self hideTabBar];
            
        }

    }else if (a==136) {
  
        
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if (del.userid.length) {
            [self.navigationController pushViewController:[[DizhiViewController alloc]init] animated:YES];
            [self hideTabBar];
            self.navigationController.navigationBar.hidden = NO;
            
        }else {
            LoginViewController *login = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
            [self hideTabBar];
            
        }

    }
    
}
- (void)buttonClick {
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (del.userid.length) {
        [self.navigationController pushViewController:[[MyPersonViewController alloc]init] animated:YES];
        [self hideTabBar];
    }else {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        [self hideTabBar];
    }
}

- (void)change:(NSNotification *)n {
  
    [self request];
    
}
- (void)creatUI {
    CGRect frame = [[UIApplication sharedApplication] statusBarFrame];
    UIView *backview1 = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height, SWIDTH, SHEIGHT/6-frame.size.height+SHEIGHT/18+SHEIGHT/90)];
    
    backview1.backgroundColor = [UIColor colorWithRed:202.0/255 green:70.0/255 blue:86.0/255 alpha:1];
    [self.view addSubview:backview1];
    
    DBlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(backview1.frame), SWIDTH, SHEIGHT/18)];
    
    DBlabel.backgroundColor = [UIColor colorWithRed:193.0/255 green:63.0/255 blue:78.0/255 alpha:1];
//    [self.view addSubview:DBlabel];
    
    headImage = [[UIImageView alloc]initWithFrame:CGRectMake(SWIDTH/20, SHEIGHT/20, SHEIGHT/12, SHEIGHT/12)];
    [backview1 addSubview:headImage];
    headImage.layer.cornerRadius = SHEIGHT/24;
    headImage.clipsToBounds=YES;
    headImage.image = [UIImage imageNamed:@"default.jpg"];
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+SWIDTH/40, SHEIGHT/12, SWIDTH - CGRectGetMaxX(headImage.frame)-SWIDTH/40, SHEIGHT/30)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:22];
    [backview1 addSubview:nameLabel];
    
    NSString *duoba = @"0";
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (app.userid.length) {
        if (app.icon.length) {
        [headImage sd_setImageWithURL:[NSURL URLWithString:app.icon]];

        }else {
        headImage.image = [UIImage imageNamed:@"default.jpg"];
 
        }
                nameLabel.text = app.name;
        duoba = app.totalMoney;
        nameLabel.userInteractionEnabled = NO;
        headImage.userInteractionEnabled = NO;
    }else {
        duoba = @"0";
        nameLabel.text = @"请您登录";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Login)];
        nameLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Login)];
        nameLabel.userInteractionEnabled = YES;
        [headImage addGestureRecognizer:tap1];
        [nameLabel addGestureRecognizer:tap];
        
    }
    NSString *yuestr = [NSString stringWithFormat:@"账户余额:%@元",duoba];
    
    UIView *backview2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(backview1.frame), SWIDTH, SHEIGHT/10)];
    UILabel *linelabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(backview2.frame), SWIDTH, 0.2)];
    linelabel1.backgroundColor = SF_COLOR(248, 248, 248);
    
    [self.view addSubview:backview2];
    [self.view addSubview:linelabel1];
    NSArray *arr = @[@"正在进行",@"已经揭晓",@"中奖纪录"];
    NSArray *imgarr = @[@"\ue6e0",@"\ue6f6",@"\ue6e1"];
    
    for (int i = 0; i < 3 ; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(i*SWIDTH/3,0, SWIDTH/3, SHEIGHT/9)];
        [button addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        button.tag = 330+i;
        UILabel *imageview = [[UILabel alloc]initWithFrame:CGRectMake(SWIDTH/3*i + SWIDTH*7/60, SHEIGHT/160, SWIDTH/10, SWIDTH/10)];
        imageview.font = [UIFont fontWithName:@"iconfont" size:24];
        imageview.textColor = [UIColor colorWithRed:160.0/255 green:160.0/255 blue:160.0/255 alpha:1];
        imageview.text = imgarr[i];
        [backview2 addSubview:imageview];
        imageview.textAlignment = NSTextAlignmentCenter;
        imageview.clipsToBounds = YES;
        imageview.layer.cornerRadius = SWIDTH/20;
        
        UILabel *chlabel = [[UILabel alloc]initWithFrame:CGRectMake(SWIDTH/3*i +SWIDTH/15, CGRectGetMaxY(imageview.frame)+1, SWIDTH/5, SHEIGHT/30)];
        chlabel.textColor = [UIColor colorWithRed:160.0/255 green:160.0/255 blue:160.0/255 alpha:1];
        [backview2 addSubview:chlabel];
        chlabel.text = arr[i];
        chlabel.textAlignment = NSTextAlignmentCenter;
        chlabel.font = [UIFont systemFontOfSize:14];
        [backview2 addSubview:button];
    }
    NSArray *namearr = @[yuestr,@"夺宝记录",@"我的消息",@"中奖纪录",@"晒单分享",@"设置"];
    NSArray *imagelabel = @[@"\ue6ff",@"\ue6fb",@"\ue6c9",@"\ue6fe",@"\ue6ce",@"\ue6cf",@"\ue613"];
    int colorarr[7][3] = {{100,181,127},{178,178,178},{196,124,242},{174,222,171},{178,240,220},{112,124,138},{198,88,73}};
    
    CGFloat heigt =CGRectGetMaxY(linelabel1.frame);
    for (int i = 0; i < 6; i++) {
        
      
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor clearColor];
        if (i == 0||i==1||i==4) {
            view.frame = CGRectMake(0, heigt, SWIDTH, SHEIGHT/13 + SHEIGHT/60);
        }else {
            view.frame =CGRectMake(0, heigt, SWIDTH, SHEIGHT/13);
        }
        view.userInteractionEnabled = YES;
        view.tag = 340 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick:)];
        if (i==0) {
            
        }else {
            [view addGestureRecognizer:tap];
        }
        UILabel *linlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame)-0.5, SWIDTH, 0.2)];
        linlabel.backgroundColor = SF_COLOR(248, 248, 248);
        UIView *canView = [[UIView alloc]initWithFrame: CGRectMake(0, 0, SWIDTH, SHEIGHT/13)];
        
        canView.backgroundColor = [UIColor whiteColor];
        [view addSubview:canView];
        
        
        UILabel *imageLabel = [[UILabel alloc]initWithFrame:CGRectMake(SWIDTH/30, SHEIGHT*1/65, SHEIGHT*3/65,  SHEIGHT*3/65)];
        imageLabel.text = imagelabel[i];
        imageLabel.font = [UIFont fontWithName:@"iconfont" size:22];
        imageLabel.layer.cornerRadius = SHEIGHT*1.5/65;
        imageLabel.clipsToBounds = YES;
        imageLabel.textColor = SF_COLOR(colorarr[i][0], colorarr[i][1], colorarr[i][2]);
        
        [canView addSubview:imageLabel];
        
      
        
        if (i == 0) {
            UIButton *btn = [[UIButton alloc]initWithFrame:[UIView getRectWithX:205 andY:7 andWidth:100 andHeight:22]];
            btn.backgroundColor = [UIColor colorWithRed:202.0/255 green:70.0/255 blue:86.0/255 alpha:1];
            [btn setTitle:@"立即充值" forState:UIControlStateNormal];
            btn.layer.cornerRadius = 5;
            btn.clipsToBounds = YES;
            [btn addTarget:self action:@selector(chongzhi) forControlEvents:UIControlEventTouchUpInside];
            AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
            if (!del.isShenHe) {
                [canView addSubview:btn];
            }
            yuelabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageLabel.frame)+SWIDTH/30, 0, SWIDTH*2/3, SHEIGHT/13)];
            yuelabel.text = namearr[i];
            [canView addSubview:yuelabel];
            
        }else {
            
            UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageLabel.frame)+SWIDTH/30, 0, SWIDTH*2/3, SHEIGHT/13)];
            namelabel.text = namearr[i];
            [canView addSubview:namelabel];
            
        }

        [self.view addSubview:view];
        if (i==2||i==3) {
            [self.view addSubview:linlabel];
        }
        
        heigt = CGRectGetMaxY(view.frame);
    }
}
- (void)yueClick {

    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (del.userid.length) {
        [self hideTabBar];
        
        [self.navigationController pushViewController:[[MyDBBViewController alloc]init] animated:YES];
        
    }else {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        [self hideTabBar];
        
    }

    
}
- (void)hongbaoClick {

    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (del.userid.length) {
        [self hideTabBar];
        
        [self.navigationController pushViewController:[[MyHBViewController alloc]init] animated:YES];
        
    }else {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        [self hideTabBar];
        
    }

}
- (void)jifenClick {
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (del.userid.length) {
        [self hideTabBar];
        MyJiFenViewController *mu = [[MyJiFenViewController alloc]init];
        mu.jifenstr = jifenstrtr;
        [self.navigationController pushViewController:mu animated:YES];
        
        
    }else {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        [self hideTabBar];

        
    }
}

- (void)tuichu:(NSNotification *)n {
    
        headImage.image = [UIImage imageNamed:@"default.jpg"];
        nameLabel.text = @"请您登录";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Login)];
        nameLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Login)];
        nameLabel.userInteractionEnabled = YES;
        [headImage addGestureRecognizer:tap1];
        [nameLabel addGestureRecognizer:tap];
        
        NSString *duoba = [NSString stringWithFormat:@"0"];
        NSString *str = [NSString stringWithFormat:@"  夺宝币: %@",duoba];
        
        NSMutableAttributedString *duobao = [[NSMutableAttributedString alloc]initWithString:str];
        [duobao addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 6)];
        [duobao addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(7, duoba.length)];
        DBlabel.attributedText = duobao;
        
        AppDelegate *dele =(AppDelegate *)[UIApplication sharedApplication].delegate;
        dele.userid = @"";
        dele.totalMoney = @"0";
        dele.name = @"";
        dele.icon = @"";
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:@"" forKey:@"userid"];
        [user setObject:@"" forKey:@"username"];
        [user setObject:@"" forKey:@"usericon"];
        [user setObject:@"" forKey:@"usermoney"];

}
- (void)chongzhi {

    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (del.userid.length) {
        ChongZhiViewController *chong = [[ChongZhiViewController alloc]init];
        [self hideTabBar];
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController pushViewController:chong animated:YES];
    }else {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        [self hideTabBar];
        
    }

    
}
- (void)tapclick:(UITapGestureRecognizer *)tap {
    UIView *view = tap.view;
    NSLog(@"view.tag = %ld",(long)view.tag);
    int a=(int)view.tag - 340;

    if (a==1) {
        DuoBaoJLViewController *duo = [[DuoBaoJLViewController alloc]init];
        
        [self hideTabBar];
        [self.navigationController pushViewController:duo animated:YES];

    }else if (a==2){
        MyMessageViewController *mu = [[MyMessageViewController alloc]init];
        [self hideTabBar];
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController pushViewController:mu animated:YES];
        
        
    }else if (a==0){
        MyzijinViewController *mu = [[MyzijinViewController alloc]init];
        [self hideTabBar];
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController pushViewController:mu animated:YES];
        
    }else if (a==3){
        MyzhongjiangjiluViewController *mu = [[MyzhongjiangjiluViewController alloc]init];
        [self hideTabBar];
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController pushViewController:mu animated:YES];
    }else if (a==4){
        MyshaidanViewController *mu = [[MyshaidanViewController alloc]init];
        [self hideTabBar];
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController pushViewController:mu animated:YES];

        
        
    }else if (a==5){
        
        ShezhiViewController *mu = [[ShezhiViewController alloc]init];
        [self hideTabBar];
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController pushViewController:mu animated:YES];
        
    }else if (a==6) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            headImage.image = [UIImage imageNamed:@"default.jpg"];
            nameLabel.text = @"请您登录";
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Login)];
            nameLabel.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Login)];
            nameLabel.userInteractionEnabled = YES;
            [headImage addGestureRecognizer:tap1];
            [nameLabel addGestureRecognizer:tap];
            
            NSString *duoba = [NSString stringWithFormat:@"0"];
            NSString *str = [NSString stringWithFormat:@"  夺宝币: %@",duoba];
            
            NSMutableAttributedString *duobao = [[NSMutableAttributedString alloc]initWithString:str];
            [duobao addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 6)];
            [duobao addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(7, duoba.length)];
            DBlabel.attributedText = duobao;
            
            AppDelegate *dele =(AppDelegate *)[UIApplication sharedApplication].delegate;
            dele.userid = @"";
            dele.totalMoney = @"0";
            dele.name = @"";
            dele.icon = @"";
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:@"" forKey:@"userid"];
            [user setObject:@"" forKey:@"username"];
            [user setObject:@"" forKey:@"usericon"];
            [user setObject:@"" forKey:@"usermoney"];

        }];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:ac];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
- (void)btnclick:(UIButton *)btn {
    
    DuoBaoJLViewController *duobap = [[DuoBaoJLViewController alloc]init];
    
    [self.navigationController pushViewController:duobap animated:YES];

    [duobap requestwith:btn.tag-330];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)Login {
    LoginViewController *login = [[LoginViewController alloc]init];
    self.navigationController.navigationBar.hidden = NO;
    [self hideTabBar];
    [self.navigationController pushViewController:login animated:YES];
}
- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)showTabBar

{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self request];

    self.navigationController.navigationBar.hidden = YES;
    [self showTabBar];
}
@end
