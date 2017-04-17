//
//  SetUpViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/12/15.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "SetUpViewController.h"
#import "UIView+CGSet.h"
#import "DizhiWebViewController.h"
@interface SetUpViewController ()

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setUP];
}
- (void)setUP {
    NSArray *arr = @[@"常见问题",@"联系客服",@"商务合作",@"服务协议",@"关于我们"];
 
    self.view.backgroundColor = SF_COLOR(242, 242, 242);
    for (int i = 0; i < 5; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, [UIView setHeight:44]*i+NavHeight, SWIDTH, [UIView setHeight:44])];
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        view.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [view addGestureRecognizer:tap];
        UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:0 andWidth:363 andHeight:44]];
        label.textColor = SF_COLOR(51, 51, 51);
        label.font=[UIFont systemFontOfSize:16];
        label.text = arr[i];
        [view addSubview:label];
        view.tag = 990 + i;
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(SWIDTH-[UIView setHeight:18]-[UIView setWidth:12], [UIView setHeight:13], [UIView setHeight:18], [UIView setHeight:18])];
        image.image = [UIImage imageNamed:@"灰箭头"];
        [view addSubview:image];
        UILabel *line = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:43.5 andWidth:375 andHeight:0.5]];
        line.backgroundColor = SF_COLOR(232, 232, 232);
        [view addSubview:line];
    }
    UIButton *btn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:0 andY:220+NavHeight+46 andWidth:375 andHeight:40]];
    btn.backgroundColor=SF_COLOR(255, 54, 93);
    [btn setTitle:@"退出登陆" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
- (void)btnclick {
    
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
    
    [self.navigationController popViewControllerAnimated:YES];
    
    NSArray*array =  [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:urlpre]];
            for(NSHTTPCookie*cookie in array)
            {
                [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie: cookie];
            }
    

}
- (void)tap:(UITapGestureRecognizer *) tap{
    UIView *view = tap.view;
    
    NSArray *arr = @[@"https://y.api.ikaiwan.com/api.php?ctl=helps&act=info&page_type=app&v=3&data_id=53",@"https://y.api.ikaiwan.com/api.php?ctl=helps&act=info&page_type=app&v=3&data_id=54",@"https://y.api.ikaiwan.com/api.php?ctl=helps&act=info&page_type=app&v=3&data_id=55",@"https://y.api.ikaiwan.com/api.php?ctl=helps&act=info&page_type=app&v=3&data_id=56",@"https://y.api.ikaiwan.com/api.php?ctl=helps&act=info&page_type=app&v=3&data_id=57"];
    NSArray *arr1 = @[@"常见问题",@"联系客服",@"商务合作",@"服务协议",@"关于我们"];

    switch (view.tag-990) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;

            
        default:
            break;
    }
    DizhiWebViewController *web = [[DizhiWebViewController alloc]init];
    web.urlstring = arr[view.tag-990];
    web.titlestring = arr1[view.tag-990];
    [self.navigationController pushViewController:web animated:YES];
    
    
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *selabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    selabel.font = [UIFont systemFontOfSize:18];
    selabel.text = @"设置";
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
