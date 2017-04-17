//
//  MyJiFenViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/25.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "MyJiFenViewController.h"
#import "UIView+CGSet.h"
#import "JFMViewController.h"
#import "AFHTTPSessionManager.h"
#import "MyPersonViewController.h"
#import "DizhiViewController.h"
#import "UMSocialUIManager.h"
@interface MyJiFenViewController ()

@end

@implementation MyJiFenViewController
{
    UIButton *qdbtn;
    int numbers;
    UILabel *jflabel;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self request];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUP];
    self.view.backgroundColor = SF_COLOR(242, 242, 242);
}
- (void)request {
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

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    
    NSString *url = [NSString stringWithFormat:@"%@?v=3&ctl=uc_score&uid=%@",urlpre,dele.userid];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSArray *arr = dic[@"list"];
        NSString *sign_date = [[arr lastObject] objectForKey:@"sign_date"];
        NSString *y_begin_time = dic[@"y_begin_time"];
        NSString *t_begin_time = dic[@"t_begin_time"];
        if (sign_date.intValue < y_begin_time.integerValue) {
                numbers = 0;
        }else {
            numbers = (int)arr.count;
            if (sign_date.intValue < t_begin_time.integerValue) {
            }else {
                qdbtn.backgroundColor = SF_COLOR(102, 102, 102);
                [qdbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [qdbtn setTitle:@"已签到" forState:UIControlStateNormal];
                qdbtn.userInteractionEnabled = NO;
            }
        }
        
        for (int i = 0;i<numbers ; i++) {
            UILabel *label = (UILabel *)[self.view viewWithTag:190+i];
            label.backgroundColor = SF_COLOR(255, 146, 169);
            label.textColor = [UIColor whiteColor];
            
        }
        NSDictionary *dic23 = dic[@"score_status"];
        NSString *str1 = dic23[@"is_share"];
        NSString *str2 = dic23[@"is_address"];
        NSString *str3 = dic23[@"is_info"];
        
        if (str1.integerValue==1) {
            UIButton *btn = (UIButton *)[self.view viewWithTag:951];
            btn.backgroundColor = SF_COLOR(102, 102, 102);
            NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:@"已分享"];
            [mstr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 3)];
            [btn setAttributedTitle:mstr forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            btn.userInteractionEnabled = NO;
        }
        if (str2.integerValue==1) {
            UIButton *btn = (UIButton *)[self.view viewWithTag:953];
            btn.backgroundColor = SF_COLOR(102, 102, 102);
            NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:@"已完善"];
            [mstr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 3)];
            [btn setAttributedTitle:mstr forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            btn.userInteractionEnabled = NO;

        }
        if (str3.integerValue==1) {
            UIButton *btn = (UIButton *)[self.view viewWithTag:952];
            btn.backgroundColor = SF_COLOR(102, 102, 102);
            NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:@"已完善"];
            [mstr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 3)];
            [btn setAttributedTitle:mstr forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            btn.userInteractionEnabled = NO;

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (void)setUP {
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:198]];
    image.image = [UIImage imageNamed:@"矩形-6"];
    [self.view addSubview:image];
    
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:12 andY:30 andWidth:24 andHeight:24]];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"左白箭头"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:36 andY:20 andWidth:303 andHeight:44]];
    titlelabel.text = @"我的积分";
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.font = [UIFont systemFontOfSize:20];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titlelabel];
    
    jflabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:82 andWidth:375 andHeight:55]];
    jflabel.textAlignment = NSTextAlignmentCenter;
    jflabel.textColor = [UIColor whiteColor];
    NSString*str = [NSString stringWithFormat:@"%@分",self.jifenstr];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:str];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:55] range:NSMakeRange(0, self.jifenstr.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(self.jifenstr.length, 1)];
    jflabel.attributedText = str1;
    
    [self.view addSubview:jflabel];
    
    
    UILabel *dhlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:137 andWidth:375 andHeight:12]];
    dhlabel.textColor = [UIColor whiteColor];
    dhlabel.font = [UIFont systemFontOfSize:12];
    dhlabel.textAlignment = NSTextAlignmentCenter;
    dhlabel.text = @"(兑换比例200:1)";
    [self.view addSubview:dhlabel];
    
    UIButton *mxBtn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:72 andY:155 andWidth:80 andHeight:30]];
    mxBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    mxBtn.layer.cornerRadius = [UIView setHeight:4];
    mxBtn.layer.borderWidth = 1;
    mxBtn.clipsToBounds = YES;
    [mxBtn setTitle:@"积分明细" forState:UIControlStateNormal];
    mxBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [mxBtn addTarget:self action:@selector(JFmxClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mxBtn];
    
    UIButton *dhBtn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:223 andY:155 andWidth:80 andHeight:30]];
    dhBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    dhBtn.layer.cornerRadius = [UIView setHeight:4];
    dhBtn.layer.borderWidth = 1;
    dhBtn.clipsToBounds = YES;
    [dhBtn setTitle:@"积分兑换" forState:UIControlStateNormal];
    dhBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [dhBtn addTarget:self action:@selector(dhClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dhBtn];
    
    UIView *zview = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:208 andWidth:375 andHeight:40]];
    zview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:zview];
    
    UIView *bgview = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:248 andWidth:375 andHeight:276]];
    bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgview];
    
    UILabel *slabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:12 andWidth:4 andHeight:16]];
    slabel.backgroundColor = SF_COLOR(255, 54, 93);
    [zview addSubview:slabel];
    
    
    
    UILabel *zqlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:21 andY:0 andWidth:100 andHeight:40]];
    zqlabel.text = @"赚取积分";
    zqlabel.font = [UIFont systemFontOfSize:17];
    zqlabel.textColor = SF_COLOR(51, 51, 51);
    [zview addSubview:zqlabel];
    
    
    UILabel *zlinelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:39.5 andWidth:375 andHeight:0.3]];
    zlinelabel.backgroundColor = SF_COLOR(229, 229, 229);
    [zview addSubview:zlinelabel];
    
    UILabel *qdlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:21 andY:260 andWidth:100 andHeight:15]];
    qdlabel.textColor = SF_COLOR(102, 102, 102);
    qdlabel.text = @"每日签到";
    qdlabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:qdlabel];
    
    UILabel *mrlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:21 andY:283  andWidth:200 andHeight:9]];
    mrlabel.textColor = SF_COLOR(102, 102, 102);
    mrlabel.text = @"每日签到可获得相应积分增长";
    mrlabel.font = [UIFont systemFontOfSize:9];
    [self.view addSubview:mrlabel];
    
    
    qdbtn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:293 andY:267 andWidth:70 andHeight:25]];
    qdbtn.layer.cornerRadius = [UIView setHeight:4];
    qdbtn.clipsToBounds = YES;
    [qdbtn setTitle:@"每日签到" forState:UIControlStateNormal];
    [qdbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    qdbtn.backgroundColor = SF_COLOR(255, 54, 93);
    
    qdbtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [qdbtn addTarget:self action:@selector(QDClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qdbtn];
    
    
    
    for (int i = 0; i < 7; i++) {
        UILabel *qlabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:21+i*48], [UIView setHeight:307],[UIView setHeight:25], [UIView setHeight:25])];
        qlabel.layer.borderColor = SF_COLOR(247, 136, 130).CGColor;
        qlabel.layer.cornerRadius = [UIView setHeight:12.5];
        qlabel.clipsToBounds = YES;
        qlabel.layer.borderWidth = 1;
        qlabel.text = [NSString stringWithFormat:@"%d",10+i*5];
        qlabel.textColor = SF_COLOR(153, 153, 153);
        qlabel.textAlignment = NSTextAlignmentCenter;
        qlabel.font = [UIFont systemFontOfSize:12];
        qlabel.tag = 190+i;
        [self.view addSubview:qlabel];
        
        
        UILabel *linelabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(qlabel.frame), [UIView setHeight:319.5], [UIView setWidth:23], 1)];
        linelabel.backgroundColor = SF_COLOR(255, 146, 169);
        if (i!=6) {
            [self.view addSubview:linelabel];
        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:21+i*48], [UIView setHeight:340],[UIView setHeight:25], [UIView setHeight:25])];
        label.textColor = SF_COLOR(102, 102, 102);
        label.font = [UIFont systemFontOfSize:9];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"第%d天",i+1];
        [self.view addSubview:label];
    }
    NSArray *ar = @[@"参与夺宝",@"每日分享",@"完善资料",@"完善收货地址"];
    NSArray *arr = @[@"立即夺宝",@"+20积分",@"+20积分",@"+20积分"];
    for (int i = 0; i < 4; i++) {
        if (i>0) {
            UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:21 andY:364+i*40 andWidth:120 andHeight:40]];
            label.textColor = SF_COLOR(51, 51, 51);
            label.font = [UIFont systemFontOfSize:15];
            label.text = ar[i];
            [self.view addSubview:label];
            
            
            
        }else {
            UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:21 andY:364 andWidth:120 andHeight:25]];
            UILabel *label1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:21 andY:389 andWidth:220 andHeight:15]];
            label.textColor = SF_COLOR(51, 51, 51);
            label.font = [UIFont systemFontOfSize:15];
            label.text = ar[i];
            [self.view addSubview:label];
            
            label1.text = @"每成功夺宝一人次可获得1积分";
            label1.font = [UIFont systemFontOfSize:9];
            label1.textColor = SF_COLOR(153, 153, 153);
            [self.view addSubview:label1];
        }
        
        UIButton *qdbtn1 = [[UIButton alloc]initWithFrame:[UIView setRectWithX:293 andY:371.5+i*40 andWidth:70 andHeight:25]];
        qdbtn1.layer.cornerRadius = [UIView setHeight:4];
        qdbtn1.clipsToBounds = YES;
        if (i==0) {
            [qdbtn1 setTitle:arr[i] forState:UIControlStateNormal];
        }else {
            NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:@"+20积分"];
            [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(0, 1)];
            [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(1, 2)];
            [str2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(3, 2)];
            [str2 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 5)];
            [qdbtn1 setAttributedTitle:str2 forState:UIControlStateNormal];
        }
        [qdbtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        qdbtn1.backgroundColor = SF_COLOR(255, 54, 93);
        
        qdbtn1.titleLabel.font = [UIFont systemFontOfSize:15];
        [qdbtn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        qdbtn1.tag = 950+i;
        [self.view addSubview:qdbtn1];
        UILabel *linelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:21 andY:364+i*40+39.5 andWidth:375 andHeight:0.5]];
        linelabel.backgroundColor = SF_COLOR(232, 232, 232);
        [self.view addSubview:linelabel];
        
    }
    
    
}
- (void)btnClick:(UIButton *)btn {
    
    if (btn.tag==950) {
        
        NSNotification *notice = [NSNotification notificationWithName:@"pushtomain" object:nil userInfo:@{@"num":@"1"}];
        
        [[NSNotificationCenter defaultCenter] postNotification:notice];
        
    }else if(btn.tag==951){
        [self shareto];
    }else if(btn.tag==952){
        [self.navigationController pushViewController:[[MyPersonViewController alloc]init] animated:YES];
        
    }else if(btn.tag==953){
        [self.navigationController pushViewController:[[DizhiViewController alloc]init] animated:YES];

    }
    
    
    
}
- (void)shareto {
    __weak typeof(self) weakSelf = self;
    [UMSocialUIManager showShareMenuViewInView:nil sharePlatformSelectionBlock:^(UMSocialShareSelectionView *shareSelectionView, NSIndexPath *indexPath, UMSocialPlatformType platformType) {
        [weakSelf shareWebPageToPlatformType:platformType];
    }];
    
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"好友一起，将一元变成惊喜" descr:@"您的好友正在参与一元夺宝，快来看看他的夺宝记录和获得的宝贝吧" thumImage:[UIImage imageNamed:@"qicon"]];
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"http://y.vbokai.com/share.html"];
    //分享消息对象设置分享内容对象3
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"分享失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
            [manager GET:[NSString stringWithFormat:@"%@?v=3&ctl=share&act=callback&uid=%@",urlpre,del.userid] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dic = (NSDictionary *)responseObject;
                NSNumber *na =dic[@"status"];
                if (na.integerValue==1) {
                    UIButton *btn = (UIButton *)[self.view viewWithTag:951];
                    btn.backgroundColor = SF_COLOR(102, 102, 102);
                    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:@"已分享"];
                    [mstr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 3)];
                    [btn setAttributedTitle:mstr forState:UIControlStateNormal];
                    btn.titleLabel.font = [UIFont systemFontOfSize:15];
                    btn.userInteractionEnabled = NO;

                    self.jifenstr = [NSString stringWithFormat:@"%d",self.jifenstr.intValue+20];
                    NSString*str = [NSString stringWithFormat:@"%@分",self.jifenstr];
                    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:str];
                    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:55] range:NSMakeRange(0, self.jifenstr.length)];
                    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(self.jifenstr.length, 1)];
                    jflabel.attributedText = str1;
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"分享成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
    }];
}

- (void)QDClick {
    
    qdbtn.backgroundColor = SF_COLOR(102, 102, 102);
    [qdbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [qdbtn setTitle:@"已签到" forState:UIControlStateNormal];
    qdbtn.userInteractionEnabled = NO;
    UILabel *label = (UILabel *)[self.view viewWithTag:190+numbers];
    label.backgroundColor = SF_COLOR(255, 146, 169);
    label.textColor = [UIColor whiteColor];
    self.jifenstr = [NSString stringWithFormat:@"%d",self.jifenstr.intValue+numbers*5+10];
    NSString*str = [NSString stringWithFormat:@"%@分",self.jifenstr];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:str];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:55] range:NSMakeRange(0, self.jifenstr.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(self.jifenstr.length, 1)];
    jflabel.attributedText = str1;
    
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSString *url = [NSString stringWithFormat:@"%@?v=3&ctl=uc_sign&uid=%@",urlpre,dele.userid];

    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        [self request];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}
- (void)dhClick {
    if (self.jifenstr.integerValue<200) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"积分不足200,无法兑换" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    [manager GET:[NSString stringWithFormat:@"%@?v=3&ctl=uc_score&act=exchange&uid=%@",urlpre,del.userid] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSNumber *num = dic[@"status"];
        if (num.integerValue ==1) {
            NSString *str = [NSString stringWithFormat:@"您用%@积分兑换了%@夺宝币",dic[@"ex_score"],dic[@"money"]];
            NSNumber *fen = dic[@"ex_score"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"兑换成功" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
            self.jifenstr = [NSString stringWithFormat:@"%d",self.jifenstr.intValue-fen.intValue];
            NSString*str2 = [NSString stringWithFormat:@"%@分",self.jifenstr];
            NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:str2];
            [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:55] range:NSMakeRange(0, self.jifenstr.length)];
            [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(self.jifenstr.length, 1)];
            jflabel.attributedText = str1;
            

            
            [self request];
            
            
        }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (void)JFmxClick {
    
    JFMViewController *jf = [[JFMViewController alloc]init];
    jf.jifenstr = self.jifenstr;
    [self.navigationController pushViewController:jf animated:YES];
}
- (void)returnclick {
    [self.navigationController popViewControllerAnimated:YES];
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
