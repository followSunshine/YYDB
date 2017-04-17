//
//  PayViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/24.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "PayViewController.h"
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"
#import "WXApi.h"
#import "DizhiWebViewController.h"
#import "UIView+CGSet.h"
#import "HBDKViewController.h"
@interface PayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation PayViewController
{
    BOOL isSelect;
    NSInteger tmp;
    UILabel *zhifufangshilabel;
    UILabel *hbdlabel;
    UILabel *valueNumLabel;
    UIImageView *zhanKaiImage;
    UIButton *button;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dic = [NSArray array];
        self.arr = [NSArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isSelect = 1;
    [self setNavigationBar];
    [self setup];
    [self reloadData];
    self.automaticallyAdjustsScrollViewInsets = false;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh:) name:@"payfinish" object:nil];
    
}
- (void)refresh:(NSNotification *)n {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *selabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    selabel.font = [UIFont systemFontOfSize:18];
    selabel.text = @"支付方式";
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

- (void)setup {
    self.dataArray = [NSMutableArray array];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[PayTableViewCell class] forCellReuseIdentifier:@"cellid"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:584]];
    view.backgroundColor = SF_COLOR(242, 242, 242);
    
        UIView *view12 = [[UIView alloc]init];
        view12.frame = [UIView setRectWithX:0 andY:74 andWidth:375 andHeight:44];
        view12.backgroundColor = [UIColor whiteColor];
        [view addSubview:view12];

    UILabel *xuanzelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:74 andWidth:300 andHeight:44]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:@"选择支付方式"];
    xuanzelabel.textColor = SF_COLOR(51, 51, 51);
    xuanzelabel.font = [UIFont systemFontOfSize:16];
    xuanzelabel.attributedText = attributedString;
    xuanzelabel.backgroundColor = [UIColor whiteColor];
    self.tableview.tableFooterView = view;

//    UILabel *linelabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:0 andY:39 andWidth:SWIDTH andHeight:0.5]];
//    linelabel.backgroundColor =SF_COLOR(227, 227, 227);
//    [view addSubview:linelabel];
//    UILabel *linelabel1 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:17 andY:79 andWidth:SWIDTH andHeight:0.5]];
//    linelabel1.backgroundColor =SF_COLOR(227, 227, 227);
//    [view addSubview:linelabel1];
//    
    UILabel *yuelabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:0 andY:0 andWidth:320 andHeight:40]];
    yuelabel.backgroundColor = [UIColor whiteColor];
    yuelabel.textColor = SF_COLOR(85, 85, 85);
    NSMutableParagraphStyle *paragraphStyle3 = [[NSMutableParagraphStyle alloc] init];
    NSMutableAttributedString *attributedString3 = [[NSMutableAttributedString alloc]initWithString:@"余额支付"];
    yuelabel.font = [UIFont systemFontOfSize:18];
    
    [paragraphStyle3 setLineSpacing:7];
    paragraphStyle3.firstLineHeadIndent=8;
    [attributedString3 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle3 range:NSMakeRange(0, 4)];
    yuelabel.attributedText = attributedString3;
//    [view addSubview:yuelabel];
//    UILabel *linelabel2 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:0 andY:164 andWidth:SWIDTH andHeight:0.5]];
//    linelabel2.backgroundColor =SF_COLOR(227, 227, 227);
//    [view addSubview:linelabel2];
//    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *str;
    if (app.totalMoney.intValue > 0) {
        if (self.price.intValue <app.totalMoney.intValue) {
            str = [NSString stringWithFormat:@"账户余额:%d夺宝币",app.totalMoney.intValue];
        }else {
                str = [NSString stringWithFormat:@"账户余额为:%d元,余额不足",app.totalMoney.intValue];
}
    }else {
        str = @"余额不足请充值";
        
    }
    NSArray *_titleArr = @[@"微信支付",@"支付宝支付",str,@"银联支付",@"第三方"];
    for (int i = 0; i < _titleArr.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;

        if (i==0) {
            btn2.frame = CGRectMake(SWIDTH-[UIView setHeight:20]-[UIView setWidth:12], [UIView setHeight:130], [UIView setHeight:20], [UIView setHeight:20]);
            btn.frame =[UIView setRectWithX:0 andY:118 andWidth:375 andHeight:44];
            
            UILabel *label32 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:32 andY:43.5 andWidth:375 andHeight:0.3]];
            label32.backgroundColor = SF_COLOR(242, 242, 242);
            [btn addSubview:label32];
            UIImage *image2 = [UIImage imageNamed:@"结算-微信"];
            [btn setImage:image2 forState:UIControlStateNormal];
        }else if(i==1){
            if (del.isShenHe) {
                btn2.frame = CGRectMake(SWIDTH-[UIView setHeight:20]-[UIView setWidth:12], [UIView setHeight:130], [UIView setHeight:20], [UIView setHeight:20]);
                btn.frame = [UIView setRectWithX:0 andY:118 andWidth:375 andHeight:44];

            }else {
                btn2.frame = CGRectMake(SWIDTH-[UIView setHeight:20]-[UIView setWidth:12], [UIView setHeight:174], [UIView setHeight:20], [UIView setHeight:20]);
                
                btn.frame = [UIView setRectWithX:0 andY:162 andWidth:375 andHeight:44];
            }
            UIImage *image2 = [UIImage imageNamed:@"结算-支付宝"];
            UILabel *label32 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:32 andY:43.5 andWidth:375 andHeight:0.3]];
            label32.backgroundColor = SF_COLOR(242, 242, 242);
            [btn addSubview:label32];
            
            [btn setImage:image2 forState:UIControlStateNormal];
        }else if(i==2) {
            btn2.frame = CGRectMake(SWIDTH-[UIView setHeight:20]-[UIView setWidth:12], [UIView setHeight:27], [UIView setHeight:20], [UIView setHeight:20]);
            UIImage *image2 = [UIImage imageNamed:@"结算-余额"];
            [btn setImage:image2 forState:UIControlStateNormal];
            btn.frame = [UIView setRectWithX:0 andY:15 andWidth:375 andHeight:44];
            btn.backgroundColor = [UIColor redColor];
            
            UILabel *moneylabel = [[UILabel alloc]initWithFrame:CGRectMake(SWIDTH-[UIView setHeight:20]-[UIView setWidth:12]-[UIView setWidth:208], 0, [UIView setWidth:200], [UIView setHeight:44])];
            moneylabel.textColor = SF_COLOR(153, 153, 153);
            moneylabel.textAlignment = NSTextAlignmentRight;
            moneylabel.font = [UIFont systemFontOfSize:12];
            NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:str];
            NSString *toto = app.totalMoney;
            
            if (app.totalMoney.integerValue>0) {
                [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(5, toto.length)];
            }
            moneylabel.attributedText  = mstr;
            [btn addSubview:moneylabel];
      
        }else if(i==4){
            btn2.frame = CGRectMake(SWIDTH-[UIView setHeight:20]-[UIView setWidth:12], [UIView setHeight:218], [UIView setHeight:20], [UIView setHeight:20]);
            UIImage *image2 = [UIImage imageNamed:@"结算-支付宝"];

            btn.frame = [UIView setRectWithX:0 andY:206 andWidth:375 andHeight:44];
            UILabel *label32 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:32 andY:43.5 andWidth:375 andHeight:0.3]];
            label32.backgroundColor = SF_COLOR(242, 242, 242);
            [btn addSubview:label32];
            
            [btn setImage:image2 forState:UIControlStateNormal];
            
        }
        else {
            CGFloat heia;
            if (![del.is_disanfang_shouhuobao isEqualToString:@"1"]) {
                heia = 44;
            }else {
                heia = 0;
            }
            if (del.isShenHe) {
                btn2.frame = CGRectMake(SWIDTH-[UIView setHeight:20]-[UIView setWidth:12], [UIView setHeight:130], [UIView setHeight:20], [UIView setHeight:20]);
                btn.frame = [UIView setRectWithX:0 andY:118 andWidth:375 andHeight:44];
                
            }else {
                btn2.frame = CGRectMake(SWIDTH-[UIView setHeight:20]-[UIView setWidth:12], [UIView setHeight:262-heia], [UIView setHeight:20], [UIView setHeight:20]);
                btn.frame = [UIView setRectWithX:0 andY:250-heia andWidth:375 andHeight:44];
            }
            
            UIImage *image2 = [UIImage imageNamed:@"结算-银行卡"];
            
            
            
            btn.backgroundColor = [UIColor redColor];
            UILabel *label32 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:32 andY:43.5 andWidth:375 andHeight:0.3]];
            label32.backgroundColor = SF_COLOR(242, 242, 242);
            [btn addSubview:label32];
            [btn setImage:image2 forState:UIControlStateNormal];
        }
        if ([_titleArr[i] isEqualToString:@"   余额不足请充值"]) {
            btn.userInteractionEnabled = NO;
            btn2.userInteractionEnabled = NO;
        }
        
        btn2.showsTouchWhenHighlighted = YES;
        //设置tag值
        btn.tag = i + 700;
        btn2.tag = i + 780;
        if (i == 0) {
            btn2.selected = YES;
        }else {
            btn.selected = NO;
        }
        btn2.backgroundColor = [UIColor whiteColor];
        btn.backgroundColor = [UIColor whiteColor];
        [btn2 addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:SF_COLOR(85, 85, 85) forState:UIControlStateNormal];
        [btn2 setImage:[UIImage imageNamed:@"结算-check-灰"] forState:UIControlStateNormal];
        [btn2 setImage:[UIImage imageNamed:@"结算-check-红"] forState:UIControlStateSelected];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        if (del.isShenHe&&i==3) {
            btn2.selected = YES;       [view addSubview:btn];
            [view addSubview:btn2];
        }
        
       
        if (del.isShenHe&&(i==0||i==2||i==1||i==4)) {
            
        }else {
            if (i==0) {
                if ([del.isWx isEqualToString:@"1"]) {
                    [view addSubview:btn];
                    [view addSubview:btn2];
                }
            }else if(i==1) {
                if ([del.isAli isEqualToString:@"1"]) {
                    [view addSubview:btn];
                    [view addSubview:btn2];
                }
            }else if(i==3) {
                    [view addSubview:btn];
                    [view addSubview:btn2];
            }else if(i==4) {
                if ([del.is_disanfang_shouhuobao isEqualToString:@"1"]) {
                    [view addSubview:btn];
                    [view addSubview:btn2];
                }
            }
            else {
                [view addSubview:btn];
                [view addSubview:btn2];
            }
            
            
            if (!del.isShenHe) {
                if (![del.isWx isEqualToString:@"1"]) {
                    if (i!=0&&i!=2) {
                        CGRect frame = btn.frame;
                        frame.origin.y -= [UIView setHeight:44];
                        btn.frame = frame;
                        CGRect frame1 = btn2.frame;
                        frame1.origin.y -= [UIView setHeight:44];
                        btn2.frame = frame1;
                    }
                }
                if (![del.isAli isEqualToString:@"1"]) {
                    if (i!=0&&i!=2&&i!=1) {
                        CGRect frame = btn.frame;
                        frame.origin.y -= [UIView setHeight:44];
                        btn.frame = frame;
                        CGRect frame1 = btn2.frame;
                        frame1.origin.y -= [UIView setHeight:44];
                        btn2.frame = frame1;
                    }
                }
            }
        }
        if (SWIDTH==320) {
            btn2.frame = CGRectMake(292.72, 7.3, 17, 17);
            [btn2 removeFromSuperview];
            [btn addSubview:btn2];
        }
    }
    [view addSubview:xuanzelabel];

    UIView *bview = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:309 andWidth:375 andHeight:88]];
    bview.backgroundColor = [UIColor whiteColor];
    UILabel *valuelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:44 andWidth:300 andHeight:44]];
    valuelabel.backgroundColor = [UIColor whiteColor];
    valuelabel.textColor = SF_COLOR(51, 51, 51);
    valuelabel.font = [UIFont systemFontOfSize:16];
    valuelabel.text = @"商品总价";
    [bview addSubview:valuelabel];
    valueNumLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:263 andY:44 andWidth:100 andHeight:44]];
    valueNumLabel.font = [UIFont systemFontOfSize:17];
    valueNumLabel.textColor = SF_COLOR(255, 44, 76);
    valueNumLabel.textAlignment = NSTextAlignmentRight;
    valueNumLabel.text = [NSString stringWithFormat:@"%@元",self.price];
    [bview addSubview:valueNumLabel];
    valuelabel.tag = 743;
    zhifufangshilabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:220 andY:200 andWidth:90 andHeight:40]];
    zhifufangshilabel.font = [UIFont systemFontOfSize:16];
    zhifufangshilabel.textColor = SF_COLOR(85, 85, 85);
    zhifufangshilabel.textAlignment = NSTextAlignmentRight;
//    [view addSubview:zhifufangshilabel];
    zhifufangshilabel.backgroundColor = [UIColor whiteColor];
    zhifufangshilabel.text = @"";
    
    button = [[UIButton alloc]initWithFrame:[UIView setRectWithX:12 andY:442 andWidth:351 andHeight:40]];
    button.backgroundColor = SF_COLOR(255, 54, 93);
    [button setTitle:@"去支付" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
    [button addTarget:self action:@selector(topay) forControlEvents:UIControlEventTouchUpInside];
//    if (SWIDTH==320) {
//        button.titleLabel.font = [UIFont systemFontOfSize:18];
//    }
    UILabel *hblabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:0 andWidth:375 andHeight:44]];
    hblabel.backgroundColor = [UIColor whiteColor];
    hblabel.textColor = SF_COLOR(51, 51, 51);
    NSString *namestr ;
    if (self.arr.count) {
        namestr = @"请选择抵扣红包";
        hblabel.userInteractionEnabled = YES;
    }else {
        namestr = @"暂无可用红包";
    }
    UITapGestureRecognizer *hbtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hbtap:)];
    [hblabel addGestureRecognizer:hbtap];
    NSMutableParagraphStyle *paragraphStyle16 = [[NSMutableParagraphStyle alloc] init];
    NSMutableAttributedString *attributedString16 = [[NSMutableAttributedString alloc]initWithString:@"红包抵扣"];
    hblabel.font = [UIFont systemFontOfSize:16];
    [paragraphStyle16 setLineSpacing:7];
    paragraphStyle16.firstLineHeadIndent=8;
    [attributedString16 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle16 range:NSMakeRange(0, 4)];
    hblabel.text = @"红包抵扣";
    [bview addSubview:hblabel];
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (del.isShenHe) {
        bview.frame = [UIView setRectWithX:0 andY:177 andWidth:375 andHeight:88];
        button.frame = [UIView setRectWithX:12 andY:310 andWidth:351 andHeight:40];
    }
    if (![del.is_disanfang_shouhuobao isEqualToString:@"1"]) {
        bview.frame = [UIView setRectWithX:0 andY:265 andWidth:375 andHeight:88];
        button.frame = [UIView setRectWithX:12 andY:398 andWidth:351 andHeight:40];
    }
    hbdlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:243 andY:0 andWidth:100 andHeight:44]];
    hbdlabel.font = [UIFont systemFontOfSize:13];
    hbdlabel.textColor = SF_COLOR(153, 153, 153);
    hbdlabel.textAlignment = NSTextAlignmentRight;
    [bview addSubview:hbdlabel];
    hbdlabel.backgroundColor = [UIColor whiteColor];
    hbdlabel.text = namestr;
    
    hblabel.tag = 742;
    UILabel *linelabel12 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:117.5 andWidth:375 andHeight:0.5]];
    linelabel12.backgroundColor = SF_COLOR(242, 242, 242);
    [view addSubview:linelabel12];
    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:343 andY:12 andWidth:20 andHeight:20]];
    imageview1.image = [UIImage imageNamed:@"灰箭头"];
    [bview addSubview:imageview1];
    UILabel *linelabel123 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:87.5 andWidth:375 andHeight:0.5]];
    linelabel123.backgroundColor = SF_COLOR(242, 242, 242);
    [bview addSubview:linelabel123];
    UILabel *linelabel122 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:43.5 andWidth:375 andHeight:0.5]];
    linelabel122.backgroundColor = SF_COLOR(242, 242, 242);
    [bview addSubview:linelabel122];

    [view addSubview:bview];
    
    [view addSubview:button];
}
- (void)hbtap:(UITapGestureRecognizer *)tap {
    NSLog(@"%@",self.arr);
    HBDKViewController *vc = [[HBDKViewController alloc]init];
    vc.arr = self.arr;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)topay {
    button.userInteractionEnabled = NO;
    NSString *num = @"0";
    NSNotification *notice = [NSNotification notificationWithName:@"plistNum" object:nil userInfo:@{@"num":num}];
    
    [[NSNotificationCenter defaultCenter] postNotification:notice];

    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (del.isShenHe&&tmp!=2) {
        tmp=3;
    }
    
    if (!del.userid.length) {
        
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
    
    AFHTTPSessionManager *mananger = [[AFHTTPSessionManager alloc]init];
    int pay;
    if (tmp==0||tmp==1) {
        if (tmp==1) {
            pay = 17;
            NSString *str = [NSString stringWithFormat:@"%@?ctl=cart&act=done&r_type=1&payment=%d&uid=%@",urlpre,pay,del.userid];

            if (del.hongbao_id.length) {
                str = [NSString stringWithFormat:@"%@?ctl=cart&act=done&r_type=1&payment=%d&uid=%@&hongbao_id=%@&v=3",urlpre,pay,del.userid,del.hongbao_id];
                

            }
            [mananger GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                button.userInteractionEnabled = YES;
                NSLog(@"%@",responseObject);
                NSDictionary *dic = (NSDictionary *)responseObject;
                NSString *dict = dic[@"notice_sn"];
                
                NSString *sta = dic[@"status"];
                if (sta.intValue!=1) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"info"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self.navigationController popViewControllerAnimated:YES];
                        NSNotification *no = [NSNotification notificationWithName:@"payre" object:nil userInfo:nil];
                        [[NSNotificationCenter defaultCenter ]postNotification:no];
                        
                    }];
                    
                    [alert addAction:act];
                    [self presentViewController:alert animated:YES completion:nil];
                    return ;
                }
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?ctl=pay&type=1&payment=17&notice_sn=%@",urlpre,dict]]];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                button.userInteractionEnabled = YES;
            }];

            
        }else if (tmp == 0){
            pay= 15;
            if (![WXApi isWXAppInstalled]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您尚未安装微信!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                
                [alert addAction:act];
                [self presentViewController:alert animated:YES completion:nil];

            }else {
                NSString *str = [NSString stringWithFormat:@"%@?ctl=cart&act=done&r_type=1&payment=%d&uid=%@",urlpre,pay,del.userid];
        
                if (del.hongbao_id.length) {
                    str = [NSString stringWithFormat:@"%@?ctl=cart&act=done&r_type=1&payment=%d&uid=%@&hongbao_id=%@&v=3",urlpre,pay,del.userid,del.hongbao_id];
                    
                    
                }
                [mananger GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                button.userInteractionEnabled = YES;

                del.isPay = YES;
                NSLog(@"%@",responseObject);
                NSDictionary *dic = (NSDictionary *)responseObject;
                NSDictionary *dict = dic[@"notice_sn"];
                NSString *sta = dic[@"status"];
                if (sta.intValue!=1) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"info"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self.navigationController popViewControllerAnimated:YES];
                        NSNotification *no = [NSNotification notificationWithName:@"payre" object:nil userInfo:nil];
                        [[NSNotificationCenter defaultCenter ]postNotification:no];

                    }];
                    
                    [alert addAction:act];
                    [self presentViewController:alert animated:YES completion:nil];
                    return ;
                }
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                PayReq* req             = [[PayReq alloc] init];
                req.openID = del.wxAppId;
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                button.userInteractionEnabled = YES;

            }];

        }
        }
        }else if(tmp==3){
      //银联 18
        pay=18;
        NSString *str = [NSString stringWithFormat:@"%@?ctl=cart&act=done&r_type=1&payment=%d&uid=%@&v=3",urlpre,pay,del.userid];
            if (del.hongbao_id.length) {
                str = [NSString stringWithFormat:@"%@?ctl=cart&act=done&r_type=1&payment=%d&uid=%@&hongbao_id=%@",urlpre,pay,del.userid,del.hongbao_id];
            }
        [mananger GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            button.userInteractionEnabled = YES;

            NSLog(@"%@",responseObject);
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSString *dict = dic[@"notice_sn"];
            
            if (!dict.length) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"info"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                    NSNotification *no = [NSNotification notificationWithName:@"payre" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter ]postNotification:no];

                }];
                
                [alert addAction:act];
                [self presentViewController:alert animated:YES completion:nil];
            }
            if (del.isShenHe) {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?ctl=pay&type=1&payment=18&notice_sn=%@",urlpre,dict]]];
                
                NSLog(@"%@",[NSString stringWithFormat:@"%@?ctl=pay&type=1&payment=18&notice_sn=%@",urlpre,dict]);
            }else {
            DizhiWebViewController *web = [[DizhiWebViewController alloc]init];
            web.titlestring = @"银联支付";
            web.urlstring = [NSString stringWithFormat:@"%@?ctl=pay&type=1&payment=18&notice_sn=%@",urlpre,dict];
            [self.navigationController pushViewController:web animated:YES];
            
            NSLog(@"%@",[NSString stringWithFormat:@"%@?ctl=pay&type=1&payment=17&notice_sn=%@",urlpre,dict]);
            }
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?ctl=pay&type=1&payment=17&notice_sn=%@",urlpre,dict]] options:@{} completionHandler:nil];

            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            button.userInteractionEnabled = YES;

        }];

        
        }else if(tmp == 4){
            pay=27;
            NSString *str = [NSString stringWithFormat:@"%@?ctl=cart&act=done&r_type=1&payment=%d&uid=%@&v=3",urlpre,pay,del.userid];
            if (del.hongbao_id.length) {
                str = [NSString stringWithFormat:@"%@?ctl=cart&act=done&r_type=1&payment=%d&uid=%@&hongbao_id=%@",urlpre,pay,del.userid,del.hongbao_id];
            }
            [mananger GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                button.userInteractionEnabled = YES;

                NSLog(@"%@",responseObject);
                NSDictionary *dic = (NSDictionary *)responseObject;
                NSString *dict = dic[@"notice_sn"];
                NSNumber *number = dic[@"status"];

                if (!dict.length) {
                    if (number.integerValue==-98) {
                        [self.navigationController popViewControllerAnimated:YES];
                        NSNotification *no = [NSNotification notificationWithName:@"payre" object:nil userInfo:nil];
                        [[NSNotificationCenter defaultCenter ]postNotification:no];
                        return ;
                    }
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"info"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self.navigationController popViewControllerAnimated:YES];
                        NSNotification *no = [NSNotification notificationWithName:@"payre" object:nil userInfo:nil];
                        [[NSNotificationCenter defaultCenter ]postNotification:no];
                        
                    }];
                    
                    [alert addAction:act];
                    [self presentViewController:alert animated:YES completion:nil];
                }
//                DizhiWebViewController *web = [[DizhiWebViewController alloc]init];
//                web.titlestring = @"支付宝支付";
//                web.urlstring = [NSString stringWithFormat:@"%@?ctl=pay&type=1&payment=27&notice_sn=%@",urlpre,dict];
//                [self.navigationController pushViewController:web animated:YES];
                
                
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?ctl=pay&type=1&payment=27&notice_sn=%@",urlpre,dict]] options:@{} completionHandler:nil];
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?ctl=pay&type=1&payment=27&notice_sn=%@",urlpre,dict]]];

                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                button.userInteractionEnabled = YES;
 
            }];
        }
        else {
        //余额 ?ctl=cart&act=done&r_type=1&all_account_money=1&uid=
        NSString *str = [NSString stringWithFormat:@"%@?ctl=cart&act=done&r_type=1&all_account_money=1&uid=%@&v=3",urlpre,del.userid];
        if (del.hongbao_id.length) {
            str = [NSString stringWithFormat:@"%@?ctl=cart&act=done&r_type=1&all_account_money=1&uid=%@&hongbao_id=%@&v=3",urlpre,del.userid,del.hongbao_id];
            NSLog(@"%@",str);
            
        }
        
        [mananger GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            button.userInteractionEnabled = YES;

            NSLog(@"%@",responseObject);
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSString *str = dic[@"status"];
            
            if (str.integerValue == 1) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付成功" preferredStyle:UIAlertControllerStyleAlert];
                del.hongbao_id=@"";

                UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                    del.totalMoney = [NSString stringWithFormat:@"%ld",del.totalMoney.integerValue-self.price.integerValue];
                    NSNotification *no = [NSNotification notificationWithName:@"appdelegate" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter]postNotification:no];
                }];
                
                [alert addAction:act1];
                [self presentViewController:alert animated:YES completion:nil];
            }else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"info"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"选择其它支付方式" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                    [self.navigationController popViewControllerAnimated:YES];
                 
                }];
                
                [alert addAction:act1];
                [self presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            button.userInteractionEnabled = YES;

        }];
    }
}
- (void)choose:(UIButton *)sender{
    for (int i = 0; i < 5; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:700 + i];
        [btn setSelected:NO];
        UIButton *btn2 =(UIButton *)[[sender superview]viewWithTag:780 + i];
        [btn2 setSelected:NO];
    }
    
    UIButton *button1 = (UIButton *)sender;
    NSInteger i = button1.tag;
    NSInteger a = i%10;
    UIButton *btn = (UIButton *)[[sender superview] viewWithTag:780 +a];
    [btn setSelected:YES];
    tmp = a;
    
}
- (void)labelclick:(UITapGestureRecognizer *)tap {
    
}
- (void)reloadData {
    for (NSDictionary *dic in self.dic) {
        PayCell *model = [[PayCell alloc]initWithDictionary:dic error:nil];
        [_dataArray addObject:model];
    }
    [self.tableview reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSelect && section==0) {
        return _dataArray.count;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:55]];
    view.backgroundColor = SF_COLOR(242, 242, 242);
    
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeSystem];
    bt.backgroundColor = [UIColor whiteColor];
    bt.titleLabel.font = [UIFont systemFontOfSize:18];
    bt.frame = CGRectMake(0, [UIView setHeight:11], SWIDTH,[UIView setHeight:44]);
    [bt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:0 andWidth:363 andHeight:44]];
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = SF_COLOR(153, 153, 153);
    
    NSString *str = [NSString stringWithFormat:@"商品明细 (共%ld件 %@夺宝币)",self.num,self.price];
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:str];
    NSString *numa = [NSString stringWithFormat:@"%ld",self.num];
    [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(51, 51, 51) range:NSMakeRange(0, 4)];
    NSString *str1 = [NSString stringWithFormat:@"%@",self.price];
    [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(7, numa.length)];
    [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(9+numa.length, str1.length)];
    
    [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, 4)];
    label.attributedText = mstr;
    [bt addSubview:label];
    zhanKaiImage  = [[UIImageView alloc]initWithFrame:CGRectMake(SWIDTH-[UIView setWidth:12]-[UIView setHeight:20], [UIView setHeight:12], [UIView setHeight:20], [UIView setHeight:20])];
    if (isSelect) {
        zhanKaiImage.image = [UIImage imageNamed:@"结算-展开"];
    }else {
        zhanKaiImage.image = [UIImage imageNamed:@"结算-收起"];
    }

    [bt addSubview:zhanKaiImage];
    [view addSubview:bt];
    return view;
}
- (void)clickAction:(UIButton *)bt
{
    isSelect = !isSelect;
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:0];
    [self.tableview reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [UIView setHeight:55];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIView setHeight:25];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    cell.index = indexPath;
    [cell reloadwith:_dataArray[indexPath.row]];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (del.hongbao_id.length) {
        
        hbdlabel.text = @"已选择";
        
        valueNumLabel.text = [NSString stringWithFormat:@"%d元",self.price.intValue-del.hongbao_money.intValue];
        
    }
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
