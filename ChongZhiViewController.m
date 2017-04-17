//
//  ChongZhiViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/4.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "ChongZhiViewController.h"
#import "AFHTTPSessionManager.h"
#import "WXApi.h"
#import "DizhiWebViewController.h"
#import "UIView+CGSet.h"
#define NHeight 64*480/[UIScreen mainScreen].bounds.size.height

@interface ChongZhiViewController ()<UITextFieldDelegate>
@property (nonatomic, strong)NSArray *titleArr;
@end

@implementation ChongZhiViewController
{
    UITextField *text;
    int tmp;
    int tmpbtn;
    UIButton *queding;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self creatUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh:) name:@"chongfinish" object:nil];
    self.view.backgroundColor = SF_COLOR(242, 242, 242);
}
- (void)refresh:(NSNotification *)n {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"充值";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 64)];
    view.backgroundColor = SF_COLOR(255, 54, 93);
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIView setWidth:12], 30, 24, 24)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"左白箭头"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];
    [self.view addSubview:label];
    [self.view addSubview:returnBtn];
    
    self.view.backgroundColor = SF_COLOR(242, 242, 242);
}
- (void)returnclick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)creatUI {
    UIView *zview = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:NavHeight+10 andWidth:375 andHeight:40]];
    zview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:zview];
    UILabel *slabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:12 andWidth:4 andHeight:16]];
    slabel.backgroundColor = SF_COLOR(255, 54, 93);
    [zview addSubview:slabel];
    
    UILabel*line1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:0.3]];
    line1.backgroundColor = SF_COLOR(229, 229, 229);
    [zview addSubview:line1];
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:39.5 andWidth:375 andHeight:0.3]];
    line2.backgroundColor = SF_COLOR(229, 229, 229);
    [zview addSubview:line2];
    
    UILabel *zqlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:21 andY:0 andWidth:300 andHeight:40]];
    zqlabel.text = @"请选择充值金额";
    zqlabel.font = [UIFont systemFontOfSize:17];
    zqlabel.textColor = SF_COLOR(51, 51, 51);
    [zview addSubview:zqlabel];

    [self.view addSubview:zview];

    _titleArr = @[@"20",@"50",@"100",@"200",@"500"];
    
    for (int i = 0; i < _titleArr.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i<3) {
            btn.frame = [UIView setRectWithX:i*(27.5+94)+19 andY:NavHeight+58.5 andWidth:94 andHeight:32];
        }else {
            btn.frame = [UIView setRectWithX:(i-3)*(27.5+94)+19 andY:NavHeight+58.5+54 andWidth:94 andHeight:32];
        }
        [btn setTitle:_titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.showsTouchWhenHighlighted = YES;
        btn.layer.borderWidth = 1;
        if (i==0) {
            btn.layer.borderColor = SF_COLOR(253, 140, 164).CGColor;
        }else {
            btn.layer.borderColor = SF_COLOR(196, 196, 196).CGColor;

        }
        
        //设置tag值
        btn.tag = i + 140;
        btn.selected = NO;
        if (i==0) {
            btn.selected = YES;
        }
        [btn setShowsTouchWhenHighlighted:NO];
        [btn addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:SF_COLOR(51, 51, 51) forState:UIControlStateNormal];
        btn.showsTouchWhenHighlighted = NO;
        [btn setTitleColor:SF_COLOR(51, 51, 51) forState:UIControlStateSelected];

        [self.view addSubview:btn];
    }
    text = [[UITextField alloc]initWithFrame:[UIView setRectWithX:2*(27.5+94)+19 andY:NavHeight+58.5+54 andWidth:94 andHeight:32]];
    
    text.placeholder = @"其余金额(2元起)";
    text.textAlignment = NSTextAlignmentCenter;
    text.textColor = SF_COLOR(51, 51, 51);
    text.delegate = self;
    text.keyboardType = UIKeyboardTypeNumberPad;
    text.borderStyle = UITextBorderStyleLine;
    text.layer.borderColor = SF_COLOR(196, 196, 196).CGColor;
    text.font = [UIFont systemFontOfSize:12];
    text.layer.borderWidth = 1;
    [self.view addSubview:text];
    
    
    UIView *bview = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:NavHeight+179 andWidth:375 andHeight:40]];
    bview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bview];
    UILabel *s1label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:12 andWidth:4 andHeight:16]];
    s1label.backgroundColor = SF_COLOR(255, 54, 93);
    [bview addSubview:s1label];
    
    UILabel*line3 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:0.3]];
    line3.backgroundColor = SF_COLOR(229, 229, 229);
    [bview addSubview:line3];
    
    UILabel *line4 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:39.5 andWidth:375 andHeight:0.3]];
    line4.backgroundColor = SF_COLOR(229, 229, 229);
    [bview addSubview:line4];

    
    UILabel *z1qlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:21 andY:0 andWidth:300 andHeight:40]];
    z1qlabel.text = @"请选择充值方式";
    z1qlabel.font = [UIFont systemFontOfSize:17];
    z1qlabel.textColor = SF_COLOR(51, 51, 51);
    [bview addSubview:z1qlabel];
    
    [self.view addSubview:bview];

    
    
    NSArray *arr = @[@"支付宝支付",@"微信支付",@"银联支付",@"第三方支付"];
    
    for (int i = 0; i < arr.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(SWIDTH-[UIView setHeight:20]-[UIView setWidth:17], [UIView setHeight:229+NavHeight+i*40], [UIView setHeight:20], [UIView setHeight:20]);
        
        btn.frame = [UIView setRectWithX:0 andY:219+NavHeight+i*40 andWidth:375 andHeight:40];
        
        if (i==0) {
            UIImage *image2 = [UIImage imageNamed:@"微信-"];
            [btn setImage:image2 forState:UIControlStateNormal];            [btn setImage:image2 forState:UIControlStateHighlighted];

            
        }else if(i==1){
           
            UIImage *image2 = [UIImage imageNamed:@"支付宝"];
            [btn setImage:image2 forState:UIControlStateNormal];            [btn setImage:image2 forState:UIControlStateHighlighted];
            

        }else if (i==2){
            
            UIImage *image2 = [UIImage imageNamed:@"支付宝"];
            [btn setImage:image2 forState:UIControlStateNormal];            [btn setImage:image2 forState:UIControlStateHighlighted];
        }
        else {

            UIImage *image2 = [UIImage imageNamed:@"银行卡"];
            [btn setImage:image2 forState:UIControlStateNormal];
            [btn setImage:image2 forState:UIControlStateHighlighted];
            
        }
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn2.showsTouchWhenHighlighted = YES;
        //设置tag值
        btn.tag = i + 710;
        btn2.tag = i + 720;
        if (i == 0) {
            btn2.selected = YES;
        }else {
            btn2.selected = NO;
        }
        btn2.backgroundColor = [UIColor whiteColor];
        btn.backgroundColor = [UIColor whiteColor];
        [btn2 addTarget:self action:@selector(choose12:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn addTarget:self action:@selector(choose12:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:SF_COLOR(85, 85, 85) forState:UIControlStateNormal];
        [btn2 setImage:[UIImage imageNamed:@"对号-灰"] forState:UIControlStateNormal];
        [btn2 setImage:[UIImage imageNamed:@"对号-红"] forState:UIControlStateSelected];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UILabel *line4 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:39.5 andWidth:375 andHeight:0.3]];
        line4.backgroundColor = SF_COLOR(229, 229, 229);
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;

        if (i==0&&[del.isWx isEqualToString:@"1"]) {
            [self.view addSubview:btn];
            [self.view addSubview:btn2];
        }else if(i==1&&[del.isAli isEqualToString:@"1"]) {
            [self.view addSubview:btn];
            [self.view addSubview:btn2];
        }else if(i==2&&[del.is_disanfang_shouhuobao isEqualToString:@"1"]) {
            [self.view addSubview:btn];
            [self.view addSubview:btn2];
        }else if(i==3) {
            [self.view addSubview:btn];
            [self.view addSubview:btn2];
        }
        if (![del.isWx isEqualToString:@"1"]) {
            if (i>0) {
                CGRect frame = btn.frame;
                frame.origin.y -=[UIView setHeight:40];
                btn.frame = frame;
                
                CGRect frame1 = btn2.frame;
                frame1.origin.y -=[UIView setHeight:40];
                btn2.frame = frame1;
            }
        }
        if (![del.isAli isEqualToString:@"1"]) {
            if (i>1) {
                CGRect frame = btn.frame;
                frame.origin.y -=[UIView setHeight:40];
                btn.frame = frame;
                
                CGRect frame1 = btn2.frame;
                frame1.origin.y -=[UIView setHeight:40];
                btn2.frame = frame1;
            }
        }

        
        [btn addSubview:line4];
//        if (SWIDTH==320) {
//            [btn2 removeFromSuperview];
//            btn2.frame = CGRectMake(288, 5.85, 17, 17);
//            [btn addSubview:btn2];
//        }
    }
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    int hei ;
    if ([del.is_disanfang_shouhuobao isEqualToString:@"1"]) {
        hei = 40;
    }else {
        hei = 0;
    }
    UILabel *clabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:353+NavHeight+hei andWidth:300 andHeight:12]];
    clabel.backgroundColor = [UIColor clearColor];
    clabel.font = [UIFont systemFontOfSize:12];
    clabel.textColor = SF_COLOR(153, 153, 153);
    clabel.text = @"* 充值说明";
    [self.view addSubview:clabel];
    
    UILabel *xlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:24 andY:372+NavHeight+hei andWidth:327 andHeight:10]];
    xlabel.font = [UIFont systemFontOfSize:10];
    xlabel.backgroundColor = [UIColor clearColor];
    NSString *str = @"充值金额用于购买一元夺宝提供的商品优惠券，1优惠券=1夺宝币";
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:str];
    [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(153, 153, 153) range:NSMakeRange(0, 21)];
    [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(240, 35, 78) range:NSMakeRange(21, str.length-21)];
    xlabel.attributedText = mstr;
    [self.view addSubview:xlabel];
    
    UILabel *x1label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:24 andY:384+NavHeight+hei andWidth:327 andHeight:10]];
    x1label.font = [UIFont systemFontOfSize:10];
    x1label.backgroundColor = [UIColor clearColor];
    x1label.textColor = SF_COLOR(153, 153, 153);
    x1label.text = @"夺宝币用于平台一元夺宝，充值的金额将无法返还";
    [self.view addSubview:x1label];
    queding = [[UIButton alloc]initWithFrame:[UIView setRectWithX:22.5 andY:622 andWidth:320 andHeight:36]];
    
    [queding setTitle:@"立即充值" forState:UIControlStateNormal];
    [queding setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    queding.backgroundColor = SF_COLOR(255, 54, 93);
    queding.layer.cornerRadius = 5;
    queding.clipsToBounds = YES;
    [queding addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:queding];
    
}
- (void)queding {
    
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (del.userid.length<=0) {
        return;
    }
    
    AFHTTPSessionManager *mananger = [[AFHTTPSessionManager alloc]init];
    NSLog(@"tmobtn == %d\ntmp == %d",tmpbtn,tmp);
    NSString *price;
    queding.userInteractionEnabled = NO;
    if (text.text.intValue > 0) {
        price = text.text;
    }else {
        switch (tmpbtn) {
            case 0:
                price = @"20";
                break;
            case 1:
                price = @"50";

                break;
            case 2:
                price = @"100";

                break;
            case 3:
                price = @"200";

                break;
            case 4:
                price = @"500";

                break;
                
            default:
                break;
        }
    }
    
    switch (tmp) {
        case 1:
            
        {
            NSString *str = [NSString stringWithFormat:@"%@?ctl=uc_charge&act=done&money=%@&payment_id=17&uid=%@",urlpre,price,del.userid];
            [mananger GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                queding.userInteractionEnabled = YES;
                NSLog(@"%@",responseObject);
                NSDictionary *dic = (NSDictionary *)responseObject;
                NSString *dict = dic[@"sdk_code"];
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
                }

                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?ctl=pay&type=3&notice_sn=%@",urlpre,dict]]];
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            }];
        }
            
            break;
        case 0:
            
        {
            NSString *str = [NSString stringWithFormat:@"%@?ctl=uc_charge&act=done&money=%@&payment_id=15&uid=%@",urlpre,price,del.userid];
            [mananger GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                del.isPay = YES;
                queding.userInteractionEnabled = YES;

                NSLog(@"%@",responseObject);
                NSDictionary *dic = (NSDictionary *)responseObject;
                NSDictionary *dict = dic[@"sdk_code"];
                NSString *sta = dic[@"status"];
                if (sta.intValue!=1) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"info"] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    
                    [alert addAction:act];
                    [self presentViewController:alert animated:YES completion:nil];
                }else {
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
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            
        }
            
            break;
        case 3:
        {
            {
                //银联 18
                NSString *str = [NSString stringWithFormat:@"%@?ctl=uc_charge&act=done&money=%@&payment_id=18&uid=%@",urlpre,price,del.userid];
                [mananger GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    queding.userInteractionEnabled = YES;

                    NSLog(@"%@",responseObject);
                    NSDictionary *dic = (NSDictionary *)responseObject;
                    NSString *dict = dic[@"sdk_code"];
                    NSString *str = dic[@"status"];
                    if (str.intValue!=1) {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"info"] preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        }];
                        
                        [alert addAction:act];
                        [self presentViewController:alert animated:YES completion:nil];
                    }else {
                    if (dict.length) {
                     
                        DizhiWebViewController *web = [[DizhiWebViewController alloc]init];
                        web.titlestring = @"银联支付";
                        web.urlstring = [NSString stringWithFormat:@"%@?ctl=pay&type=3&payment=18&notice_sn=%@",urlpre,dict];
                        [self.navigationController pushViewController:web animated:YES];
                        }
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                }];
            }
        }
            
            
            break;
        case 2:
        {
            {
                //银联 18
                NSString *str = [NSString stringWithFormat:@"%@?ctl=uc_charge&act=done&money=%@&payment_id=27&uid=%@",urlpre,price,del.userid];
                [mananger GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    queding.userInteractionEnabled = YES;
                    
                    NSLog(@"%@",responseObject);
                    NSDictionary *dic = (NSDictionary *)responseObject;
                    NSString *dict = dic[@"sdk_code"];
                    NSString *str = dic[@"status"];
                    if (str.intValue!=1) {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"info"] preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        }];
                        
                        [alert addAction:act];
                        [self presentViewController:alert animated:YES completion:nil];
                    }else {
                        if (dict.length) {
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?ctl=pay&type=3&payment=27&notice_sn=%@",urlpre,dict]]];
                        }
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                }];
                
                
            }
        }
            
            
            break;

        default:
            break;
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [text resignFirstResponder];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    for (int i = 0; i < _titleArr.count; i++) {
        UIButton *btn = (UIButton *)[self.view viewWithTag:140 + i];
        [btn setSelected:NO];
        btn.layer.borderColor = SF_COLOR(196, 196, 196).CGColor;
    }
    text.layer.borderColor = SF_COLOR(253, 140, 164).CGColor;
    text.textColor = SF_COLOR(51, 51, 51);
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.integerValue <2) {
        textField.text =@"2";
    }
}
- (void)choose:(UIButton *)sender{
    for (int i = 0; i < _titleArr.count; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:140 + i];
        [btn setSelected:NO];
        btn.layer.borderColor = SF_COLOR(196, 196, 196).CGColor;

    }
    UIButton *button = (UIButton *)sender;
    [button setSelected:YES];
    button.layer.borderColor = SF_COLOR(253, 140, 164).CGColor;
    text.layer.borderColor = SF_COLOR(196, 196, 196).CGColor;
    text.textColor = [UIColor grayColor];
    [text endEditing:YES];
    text.placeholder = @"其余金额(2元起)";
    text.text = @"";
    [text resignFirstResponder];
    tmpbtn = (int)button.tag-140;
}
- (void)choose12:(UIButton *)sender{
    for (int i = 0; i < 4; i++) {
        UIButton *btn = (UIButton *)[[sender superview]viewWithTag:720 + i];
        [btn setSelected:NO];

    }
    
    UIButton *button = (UIButton *)sender;
    NSInteger i = button.tag;
    NSInteger a = i%10;

    UIButton *btn = (UIButton *)[[sender superview] viewWithTag:720 +a];
    [btn setSelected:YES];
    tmp = (int)a;
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
