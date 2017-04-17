//
//  MyYQViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/12/6.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "MyYQViewController.h"
#import "UIView+CGSet.h"
#import "myUILabel.h"
#import "UMSocialUIManager.h"
#import "AFHTTPSessionManager.h"
@interface MyYQViewController ()

@end

@implementation MyYQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setUP];
    self.view.backgroundColor=SF_COLOR(242, 242, 242);
}
- (void)setUP {
    UIImageView *image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:0 andY:NavHeight-3 andWidth:375 andHeight:185]];
    image.image = [UIImage imageNamed:@"banner"];
    [self.view addSubview:image];
    
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:60 andY:NavHeight +237 andWidth:65 andHeight:65]];
    image1.image = [UIImage imageNamed:@"2元"];
    [self.view addSubview:image1];
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:60 andY:NavHeight +341 andWidth:65 andHeight:65]];
    image2.image = [UIImage imageNamed:@"10元"];
    [self.view addSubview:image2];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:152 andY:NavHeight+246 andWidth:200 andHeight:15]];
    label1.textColor = SF_COLOR(102, 102, 102);
    label1.font = [UIFont systemFontOfSize:15];
    label1.text = @"当您的好友充值累计10元";
    [self.view addSubview:label1];
    UILabel *label2 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:152 andY:350+NavHeight andWidth:200 andHeight:15]];
    label2.textColor = SF_COLOR(102, 102, 102);
    label2.font = [UIFont systemFontOfSize:15];
    label2.text = @"当您的好友充值累计110元";
    [self.view addSubview:label2];

    myUILabel *label3=  [[myUILabel alloc]initWithFrame:[UIView setRectWithX:152 andY:NavHeight+263 andWidth:200 andHeight:30]];
    label3.textColor = SF_COLOR(102, 102, 102);
    label3.font = [UIFont systemFontOfSize:15];
    NSString *str = @"返2元红包";
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:str];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(1, 1)];
    [str1 addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 109, 59) range:NSMakeRange(1, 2)];
    label3.attributedText = str1;
    [label3 setVerticalAlignment:VerticalAlignmentBottom];
    
    [self.view addSubview:label3];
    
    myUILabel *label4=  [[myUILabel alloc]initWithFrame:[UIView setRectWithX:152 andY:NavHeight+367 andWidth:200 andHeight:30]];
    label4.textColor = SF_COLOR(102, 102, 102);
    label4.font = [UIFont systemFontOfSize:15];
    NSString *str2 = @"返10元红包";
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc]initWithString:str2];
    [str3 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(1, 2)];
    [str3 addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 109, 59) range:NSMakeRange(1, 3)];
    label4.attributedText = str3;
    [label4 setVerticalAlignment:VerticalAlignmentBottom];
    
    [self.view addSubview:label4];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:77 andY:546 andWidth:221 andHeight:50]];
    [btn setBackgroundImage:[UIImage imageNamed:@"立即邀请"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    

}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"邀请好友";
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

- (void)btnclick {
    __weak typeof(self) weakSelf = self;
    [UMSocialUIManager showShareMenuViewInView:nil sharePlatformSelectionBlock:^(UMSocialShareSelectionView *shareSelectionView, NSIndexPath *indexPath, UMSocialPlatformType platformType) {
        [weakSelf shareWebPageToPlatformType:platformType];
    }];
    
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"好友一起，将一元变成惊喜" descr:@"您的好友正在参与一元夺宝，快来看看他的夺宝记录和获得的宝贝吧" thumImage:[UIImage imageNamed:@"180.png"]];
    //设置网页地址
    NSString *str  = del.userid;
    NSArray *arr = @[@"j",@"a",@"z",@"c",@"m",@"e",@"f",@"u",@"w",@"i"];
    for (int i = 0; i < 10; i++) {
        str = [str stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%d",i] withString:arr[i]];
    }
    
    shareObject.webpageUrl = [NSString stringWithFormat:@"http://y.vbokai.com/share1.html?code=%@",str];
    //分享消息对象设置分享内容对象3
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"分享成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
            AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
            
            NSString *url = [NSString stringWithFormat:@"%@?v=3&ctl=share&act=callback%@",urlpre,del.userid];
            [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSLog(@"%@",responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
        }
    }];
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
