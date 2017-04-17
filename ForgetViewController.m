//
//  ForgetViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/14.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "ForgetViewController.h"
#import "AFHTTPSessionManager.h"
#import "JPUSHService.h"
#import "RGBColor.h"
#import "UIView+CGSet.h"
#import "LBProgressHUD.h"
@interface ForgetViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UIButton *label;
@property (nonatomic, strong)UIButton *btn;
@property (nonatomic, strong)AFHTTPSessionManager *manager;
@end

@implementation ForgetViewController
{
    UIButton *imageBtn;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1];
    [self setNavigationBar];
    [self setupUI];
    self.manager = [[AFHTTPSessionManager alloc]init];
    
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    label.font = [UIFont systemFontOfSize:18];
    if (self.isWechat) {
        label.text = @"绑定手机号";
    }else {
    label.text = @"快速注册";
        
    }
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
    
    
    
}
- (void)returnclick {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setupUI {
    
    
    UIView *view = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:NavHeight+15 andWidth:375 andHeight:176]];
    view.backgroundColor = [UIColor whiteColor];
    
    NSArray *imaArr = @[@"用户",@"验证码",@"密码",@"密码"];
    NSArray *plcarr = @[@"请输入手机号",@"请输入语音验证码",@"请输入4个字符或以上的密码",@"请再次输入密码"];
    for (int i = 0; i <4; i++) {
        
        UIImageView *image1 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:12 andY:10+i*44 andWidth:24 andHeight:24]];
        
        image1.image = [UIImage imageNamed:imaArr[i]];
        [view addSubview:image1];
        UITextField *text = [[UITextField alloc]initWithFrame:[UIView setRectWithX:49 andY:i*44 andWidth:310 andHeight:44]];
        
        if (i==0) {
            text.frame = [UIView setRectWithX:49 andY:i*44 andWidth:234 andHeight:44];
        }
        text.autocapitalizationType = UITextAutocapitalizationTypeNone;
        text.autocorrectionType = UITextAutocorrectionTypeNo;
        text.font = [UIFont systemFontOfSize:15];
        text.delegate = self;
        text.tag = 310+i;
        text.placeholder = plcarr[i];
        [text addTarget:self action:@selector(valuechange) forControlEvents:UIControlEventAllEditingEvents];
        [view addSubview:text];
        if (i==0||i==1) {
            text.keyboardType = UIKeyboardTypeNumberPad;
        }
        if (i==2||i==3) {
            text.secureTextEntry = YES;
        }
        
    }
    for (int i = 0; i < 3; i++) {
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:30 andY:i*30-0.5 andWidth:290 andHeight:0.5]];
        lineLabel.backgroundColor =[UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1];
        [view addSubview:lineLabel];
    }
    _label = [UIButton buttonWithType:UIButtonTypeCustom];
    _label.frame = [UIView setRectWithX:283 andY:7 andWidth:80 andHeight:30];
    _label.titleLabel.font=[UIFont systemFontOfSize:14];
    _label.layer.borderWidth = 1;
    _label.layer.cornerRadius = 5;
    _label.clipsToBounds = YES;
    _label.layer.borderColor = SF_COLOR(255, 54,96).CGColor;
    [_label setTitleColor:SF_COLOR(255, 54, 93) forState:UIControlStateNormal];
    [_label setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_label setTitleColor:SF_COLOR(255, 54, 93) forState:UIControlStateNormal];
    [_label addTarget:self action:@selector(openCountdown) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_label];
    [self.view addSubview:view];
    
    _btn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:12 andY:240+NavHeight andWidth:351 andHeight:36]];
    
    if ([self.title isEqualToString:@"忘记密码"]) {
        [_btn setTitle:@"注册账号" forState:UIControlStateNormal];

    }else {
        [_btn setTitle:@"注册账号" forState:UIControlStateNormal];
        
    }
    if (_isWechat) {
        [_btn setTitle:@"绑定手机号" forState:UIControlStateNormal];
    }
    _btn.layer.cornerRadius=[UIView getHeight:5];
    _btn.clipsToBounds = YES;
    
    _btn.backgroundColor = SF_COLOR(247, 167, 184);
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _btn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:_btn];
    
    imageBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIView setWidth:12], [UIView setHeight:NavHeight+196], [UIView setHeight:22], [UIView setHeight:22])];
    [imageBtn setBackgroundImage:[UIImage imageNamed:@"注册-未选中"] forState:0];
    [imageBtn setBackgroundImage:[UIImage imageNamed:@"注册-选中"] forState:UIControlStateSelected];
    imageBtn.selected = YES;
    [self.view addSubview:imageBtn];
    [imageBtn addTarget:self action:@selector(imageBtn:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *imalabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:12]+[UIView setHeight:22], [UIView setHeight:NavHeight+201], [UIView setWidth:300], [UIView setHeight:12])];
    imalabel.text = @"我已阅读并同意《一元夺宝用户协议》";
    imalabel.textColor = SF_COLOR(153, 153, 153);
    imalabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:imalabel];
    
}
- (void)imageBtn:(UIButton *)btn {
    if (btn.selected) {
        _btn.backgroundColor = SF_COLOR(247, 167, 184);
        
        [_btn removeTarget:self action:@selector(btnclikc) forControlEvents:UIControlEventTouchUpInside];
    }else {
        for (int i = 0; i <4; i++) {
            UITextField *tect = [self.view viewWithTag:310+i];
            if (tect.text.length) {
                if (i==3&&!imageBtn.selected) {
                    [_btn addTarget:self action:@selector(btnclikc) forControlEvents:UIControlEventTouchUpInside];
                    _btn.backgroundColor = SF_COLOR(255, 54, 93);
                    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
            }else {
                _btn.backgroundColor = SF_COLOR(247, 167, 184);
                
                [_btn removeTarget:self action:@selector(btnclikc) forControlEvents:UIControlEventTouchUpInside];
            }
        }

    }
    imageBtn.selected = !imageBtn.selected;
}
-(void)openCountdown{
    UITextField *text =(UITextField *)[self.view viewWithTag:310];

    if (text.text.length!=11) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入正确的电话号码" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            return;
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];

    }
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [_label setTitle:@"重新发送" forState:UIControlStateNormal];
                [_label setTitleColor:[RGBColor colorWithHexString:@"FB8557"] forState:UIControlStateNormal];
                _label.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [_label setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [_label setTitleColor:SF_COLOR(153, 153, 153) forState:UIControlStateNormal];
                _label.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
    
    [self labelClick];
}
- (void)labelClick {
    

    UITextField *text =(UITextField *)[self.view viewWithTag:310];
    NSString *phone = text.text;
    NSString *url = [NSString stringWithFormat:@"%@?ctl=ajax&act=send_sms_code&mobile=%@",urlpre,phone];
    [self.manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSLog(@"%@",dic);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:dic[@"info"] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (void)valuechange {
    for (int i = 0; i <4; i++) {
        UITextField *tect = [self.view viewWithTag:310+i];
        if (tect.text.length) {
            if (i==3&&imageBtn.selected) {
                [_btn addTarget:self action:@selector(btnclikc) forControlEvents:UIControlEventTouchUpInside];
                _btn.backgroundColor = SF_COLOR(255, 54, 93);
                [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            
        }else {
            _btn.backgroundColor = SF_COLOR(247, 167, 184);
            
            [_btn removeTarget:self action:@selector(btnclikc) forControlEvents:UIControlEventTouchUpInside];
            return;
        }
    }
    
    
}
- (void )btnclikc {
    
    NSString *phone = [NSString string];
    NSString *yanzheng = [NSString string];
    NSString *pasw = [NSString string];
    for (int i = 0; i < 3; i++) {
        UITextField *text = (UITextField *)[self.view viewWithTag:310 + i ];
        if (i == 0) {
            phone = text.text;
        }else if(i == 1) {
            yanzheng = text.text;
        }else if (i == 2){
            pasw = text.text;
        }
        
    }
    
    
    NSString *url = [NSString stringWithFormat:@"%@?ctl=user&act=dophregister&mobile=%@&user_pwd=%@&sms_verify=%@&nickname=%@&openid=%@&headimgurl=%@&v=4",urlpre,phone,pasw,yanzheng,self.dataDic[@"name"],self.dataDic[@"openid"],self.dataDic[@"iconurl"]];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    if (_isWechat) {
        
    }else {
        url = [NSString stringWithFormat:@"%@?ctl=user&act=dophregister&mobile=%@&user_pwd=%@&sms_verify=%@",urlpre,phone,pasw,yanzheng];
    }
    [LBProgressHUD showHUDto:self.view animated:YES];
    [self.manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSDictionary *dic =(NSDictionary *)responseObject;
        NSString *str = dic[@"status"];
        if (str.intValue!=1) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误信息" message:dic[@"info"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }else {
            
            
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil  message:@"登陆成功" preferredStyle:UIAlertControllerStyleAlert];
            AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
            del.userid = dic[@"id"];
            del.totalMoney = dic[@"money"];
            del.name = dic[@"user_name"];
            del.icon = dic[@"user_logo"];
            
            [JPUSHService setTags:nil alias:dic[@"id"] fetchCompletionHandle:nil];
            
            NSNotification *not = [NSNotification notificationWithName:@"appdelegate" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter]postNotification:not];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }];
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder]; return YES;
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (int i = 0; i < 4; i++) {
        UITextField *text = [self.view viewWithTag:310+i];
        
        [text resignFirstResponder];
    }
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
