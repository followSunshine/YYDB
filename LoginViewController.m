//
//  LoginViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/14.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "JPUSHService.h"
#import "AFHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"
#import "WXApi.h"
#import "UMSocialQQHandler.h"
#import "MainViewController.h"
#import "UIView+CGSet.h"
#define loginHttp http://y.ikaiwan.com/api.php?ctl=user&act=login&user_key=&user_pwd=

@interface LoginViewController ()<UITextFieldDelegate>
@property (nonatomic, strong)UIButton *btn;

@property (nonatomic, strong)NSString *openid;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = SF_COLOR(242, 242, 242);
    self.title = @"登陆";
    [self setNavigationBar];
   
    
    [self setupUI];
}
- (void)setJpushAliasWithNSString:(NSString *)str {
    [JPUSHService setTags:nil alias:str fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"iresCode = %d,iTags= %@,iAlias=%@",iResCode,iTags,iAlias);
    }];

}
- (void)pushtoZhuCe {
    
    ForgetViewController *vc = [[ForgetViewController alloc]init];
    vc.title = @"注册账号";
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"登陆";
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
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH-100, 30, 100, 24)];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn addTarget:self action:@selector(pushtowangji) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];

}
- (void)returnclick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUI {
    
    UIView *view = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:NavHeight+15 andWidth:375 andHeight:88]];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    
    self.nametext = [[UITextField alloc]initWithFrame:[UIView setRectWithX:49 andY:0 andWidth:310 andHeight:44]];
    _nametext.placeholder = @"请输入手机号 / 邮箱 / 用户名";
    self.numtext = [[UITextField alloc]initWithFrame:[UIView setRectWithX:49 andY:44 andWidth:310 andHeight:44]];
    _numtext.placeholder = @"请输入密码";
    self.nametext.adjustsFontSizeToFitWidth = YES;
    self.nametext.keyboardType = UIKeyboardTypeURL;
    self.nametext.font = [UIFont systemFontOfSize:15];
    self.numtext.font = [UIFont systemFontOfSize:15];
    self.numtext.secureTextEntry = YES;
    self.nametext.autocorrectionType = UITextAutocorrectionTypeNo;
    self.numtext.autocorrectionType = UITextAutocorrectionTypeNo;
    self.numtext.clearsOnBeginEditing = YES;
    self.nametext.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.numtext.autocapitalizationType=UITextAutocapitalizationTypeNone;
    self.nametext.delegate=self;
    self.numtext.delegate=self;
    [self.nametext addTarget:self action:@selector(valuechang) forControlEvents:UIControlEventAllEditingEvents];
    [self.numtext addTarget:self action:@selector(valuechang) forControlEvents:UIControlEventAllEditingEvents];
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:12 andY:10 andWidth:24 andHeight:24]];
    image1.image = [UIImage imageNamed:@"用户"];
    [view addSubview:image1];

    UIImageView *image2 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:12 andY:54 andWidth:24 andHeight:24]];
    image2.image = [UIImage imageNamed:@"密码"];
    [view addSubview:image2];

    [view addSubview:self.nametext];
    [view addSubview:self.numtext];

    
    _btn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:12 andY:15+44*3+NavHeight andWidth:351 andHeight:36]];
    
    _btn.backgroundColor = SF_COLOR(247, 167, 184);
    [_btn setTitle:@"登  陆" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btn.layer.cornerRadius=[UIView getHeight:5];
    _btn.clipsToBounds = YES;
    
    _btn.titleLabel.font = [UIFont systemFontOfSize:20];
    
    UILabel *loginLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:140 andY:247+NavHeight andWidth:95 andHeight:16]];
    loginLabel.font = [UIFont systemFontOfSize:16];
    loginLabel.text = @"一键登录";
    loginLabel.textColor = SF_COLOR(153, 153, 153);
    loginLabel.textAlignment = NSTextAlignmentCenter;
    
    
    UIImageView *image11 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:0 andY:255+NavHeight andWidth:140 andHeight:1]];
    image11.image = [UIImage imageNamed:@"分割线左"];
    
    UIImageView *image22 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:235 andY:255+NavHeight andWidth:140 andHeight:1]];
    image22.image = [UIImage imageNamed:@"分割线"];
    
    
    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:90], [UIView setHeight:280+NavHeight], [UIView setWidth:50], [UIView setWidth:50])];
    imageview1.image = [UIImage imageNamed:@"qq登录"];
    imageview1.tag = 901;
    if ([QQApiInterface isQQInstalled]) {
        [self.view addSubview:imageview1];

    }
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:90], CGRectGetMaxY(imageview1.frame)+[UIView setHeight:6], [UIView setWidth:50], [UIView setHeight:14])];
    label1.textColor = SF_COLOR(153, 153, 153);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"QQ";
    label1.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label1];
    
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:235], CGRectGetMaxY(imageview1.frame)+[UIView setHeight:6], [UIView setWidth:50], [UIView setHeight:14])];
    label2.textColor = SF_COLOR(153, 153, 153);
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"微信";
    label2.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label2];
    UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:235], [UIView setHeight:280+NavHeight], [UIView setWidth:50], [UIView setWidth:50])];
    imageview2.image = [UIImage imageNamed:@
                    "微信登录"];
    imageview2.tag = 902;
    if ([WXApi isWXAppInstalled]) {
        [self.view addSubview:imageview2];
    }
    if ([WXApi isWXAppInstalled]||[QQApiInterface isQQInstalled]||1) {
        [self.view addSubview:loginLabel];
        [self.view addSubview:image11];
        [self.view addSubview:image22];

    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick:)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick:)];
    [imageview2 addGestureRecognizer:tap1];
    [imageview1 addGestureRecognizer:tap];
    imageview1.userInteractionEnabled = YES;
    imageview2.userInteractionEnabled = YES;

    [self.view addSubview:_btn];
    
    UILabel *linelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:0.5]];
    linelabel.backgroundColor =SF_COLOR(232, 232, 232);
    [view addSubview:linelabel];
    UILabel *linelabel1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:44 andWidth:375 andHeight:0.5]];
    linelabel1.backgroundColor =SF_COLOR(232, 232, 232);
    [view addSubview:linelabel1];
    UILabel *linelabel2 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:87.5 andWidth:375 andHeight:0.5]];
    linelabel2.backgroundColor =SF_COLOR(232, 232, 232);
    [view addSubview:linelabel2];
    AppDelegate *dek = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (dek.isShenHe) {
        [loginLabel removeFromSuperview];
        [label1 removeFromSuperview];
        [label2 removeFromSuperview];
        [image11 removeFromSuperview];
         [image22 removeFromSuperview];
    }
}
- (void)pushtowangji {
    
    ForgetViewController *forget = [[ForgetViewController alloc]init];
    forget.title=@"忘记密码";
    [self.navigationController pushViewController:forget animated:YES];
    
}
- (void)valuechang {
    if ([self.nametext.text length]&&self.numtext.text.length) {
        
        [_btn addTarget:self action:@selector(btnclikc) forControlEvents:UIControlEventTouchUpInside];
        _btn.backgroundColor = SF_COLOR(255, 54, 93);
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else {
        
        _btn.backgroundColor = SF_COLOR(247, 167, 184);
        
        [_btn removeTarget:self action:@selector(btnclikc) forControlEvents:UIControlEventTouchUpInside];
    }

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder]; return YES;
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.nametext resignFirstResponder];
    [self.numtext resignFirstResponder];
}
- (void)btnclikc{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *str = [NSString stringWithFormat:@"%@?ctl=user&act=dologin&user_key=%@&user_pwd=%@",urlpre,_nametext.text,_numtext.text];
    [manager POST:str parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *message = dic[@"info"];
        NSString *str = dic[@"status"];
        if (str.intValue!=1) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil  message:message preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
            }];
            
            // Add the actions.
            [alertController addAction:otherAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            

        }else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil  message:@"登陆成功" preferredStyle:UIAlertControllerStyleAlert];
            AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
            del.userid = dic[@"id"];
            del.totalMoney = dic[@"money"];
            del.name = dic[@"user_name"];
            del.icon = dic[@"user_logo"];
            [self.navigationController popViewControllerAnimated:YES];

            NSNotification *not = [NSNotification notificationWithName:@"appdelegate" object:nil userInfo:nil];
            [self setJpushAliasWithNSString:dic[@"id"]];
            [[NSNotificationCenter defaultCenter]postNotification:not];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
             
                
                
                
                
                [self.navigationController popToRootViewControllerAnimated:YES];            }];
            
            [alertController addAction:otherAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            
          
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)tapclick:(UITapGestureRecognizer *)tap {
    UIImageView *image = (UIImageView *)[tap view];
    int a = (int)image.tag - 900;
    [self loginWithWeChat:[NSString stringWithFormat:@"%d",a]];
}
- (void)loginWithWeChat:(NSString *)string {
    UMSocialPlatformType type;
    
    if ([string isEqualToString:@"1"]) {
        type = UMSocialPlatformType_QQ;
    }else {
        type = UMSocialPlatformType_WechatSession;
    }
    [[UMSocialManager defaultManager]  authWithPlatform:type currentViewController:self completion:^(id result, NSError *error) {
        NSLog(@"%@",error);
        UMSocialResponse *opem = result;
        self.openid = opem.openid;
        if (self.openid) {
            [self getuserinfowith:string];
        }
    }];
    
    
}
- (void)getuserinfowith:(NSString *)string {
    UMSocialPlatformType type;
    if ([string isEqualToString:@"1"]) {
        type = UMSocialPlatformType_QQ;
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:type currentViewController:self completion:^(id result, NSError *error) {
            UMSocialUserInfoResponse *userinfo =result;
            NSLog(@"\n%@\n%@",userinfo.name,userinfo.iconurl);
            
            UMSocialResponse *re = result;
            NSLog(@"%@",re);
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
            NSString *str = [NSString stringWithFormat:@"%@?ctl=user&act=dol&nickname=%@&openid=%@&headimgurl=%@&type=%@&v=4",urlpre,userinfo.name,self.openid,userinfo.iconurl,string];
            str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dic=(NSDictionary *)responseObject;
                AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
                del.userid = dic[@"id"];
                del.totalMoney = dic[@"money"];
                del.name = userinfo.name;
                del.icon = [NSString stringWithFormat:@"%@%@",urladress,dic[@"avatar"]];
                del.is_new = dic[@"is_new"];
                
                [self setJpushAliasWithNSString:dic[@"id"]];
                [self.navigationController popViewControllerAnimated:YES];

                NSNotification *not = [NSNotification notificationWithName:@"appdelegate" object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter]postNotification:not];
                
                NSNotification *notice = [NSNotification notificationWithName:@"pushtomain" object:nil userInfo:@{@"num":@"1"}];
                
                [[NSNotificationCenter defaultCenter] postNotification:notice];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }];
    }else {
        type = UMSocialPlatformType_WechatSession;
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:type currentViewController:self completion:^(id result, NSError *error) {
            UMSocialUserInfoResponse *userinfo =result;
            NSLog(@"\n%@\n%@",userinfo.name,userinfo.iconurl);
            
            UMSocialResponse *re = result;
            NSLog(@"%@",re);
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
            NSString *str = [NSString stringWithFormat:@"%@?ctl=user&act=dol&nickname=%@&openid=%@&headimgurl=%@&type=%@&v=4",urlpre,userinfo.name,self.openid,userinfo.iconurl,string];
            str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dic=(NSDictionary *)responseObject;

                NSString *stauts = dic[@"status"];
                NSLog(@"%@",responseObject);
                if (stauts.integerValue==-98) {
                    
                    NSDictionary *dica = @{
                                           @"name":userinfo.name,
                                           @"openid":self.openid,
                                           @"iconurl":userinfo.iconurl
                                           };
                    ForgetViewController *forget = [[ForgetViewController alloc]init];
                    forget.isWechat = YES;
                    forget.dataDic = dica;
                    [self.navigationController pushViewController:forget animated:YES];
                    
                    
                }else {
                    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    del.userid = dic[@"id"];
                    del.totalMoney = dic[@"money"];
                    del.name = userinfo.name;
                    del.icon = [NSString stringWithFormat:@"%@%@",urladress,dic[@"avatar"]];
                    del.is_new = dic[@"is_new"];
                    
                    [self setJpushAliasWithNSString:dic[@"id"]];
                    [self.navigationController popViewControllerAnimated:YES];
                    NSNotification *not = [NSNotification notificationWithName:@"appdelegate" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter]postNotification:not];
                    
                    NSNotification *notice = [NSNotification notificationWithName:@"pushtomain" object:nil userInfo:@{@"num":@"1"}];
                    
                    [[NSNotificationCenter defaultCenter] postNotification:notice];

                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSLog(@"%@",error);
                
            }];
        }];
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//?ctl=user&act=dol&nickname=&openid=&headimgurl=&type=
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
