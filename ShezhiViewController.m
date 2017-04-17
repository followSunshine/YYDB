//
//  ShezhiViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/19.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "ShezhiViewController.h"
#import "DizhiViewController.h"
#import "UIImageView+WebCache.h"
@interface ShezhiViewController ()

@end

@implementation ShezhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    self.view.backgroundColor = SF_COLOR(248, 248, 248);
    self.title = @"设置";
}

- (void)setup{
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIView *backview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT/6)];
    
    backview1.backgroundColor = [UIColor colorWithRed:202.0/255 green:70.0/255 blue:86.0/255 alpha:1];
    [self.view addSubview:backview1];
    
    UILabel *DBlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(backview1.frame), SWIDTH, SHEIGHT/18)];
    
    DBlabel.backgroundColor = [UIColor colorWithRed:193.0/255 green:63.0/255 blue:78.0/255 alpha:1];
    [self.view addSubview:DBlabel];
    
    UIImageView *headImage = [[UIImageView alloc]initWithFrame:CGRectMake(SWIDTH/40, SHEIGHT/36, SHEIGHT/9, SHEIGHT/9)];
    [headImage sd_setImageWithURL:[NSURL URLWithString:del.icon]];
    
    [backview1 addSubview:headImage];
    headImage.layer.cornerRadius = SHEIGHT/18;
    headImage.clipsToBounds=YES;
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImage.frame)+SWIDTH/40, SHEIGHT/15, SWIDTH - CGRectGetMaxX(headImage.frame)-SWIDTH/40, SHEIGHT/30)];
    
    nameLabel.text = del.name;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:22];
    [backview1 addSubview:nameLabel];
    if (!del.name.length) {
        nameLabel.text = @"请登录";
        headImage.image = [UIImage imageNamed:@"default.jpg"];
    }
    NSString *str = [NSString stringWithFormat:@"  夺宝币: %@",del.totalMoney];
    
  
    DBlabel.text = str;
    DBlabel.font = [UIFont systemFontOfSize:18];

    
    UIView *shezhiView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(DBlabel.frame)+5, SWIDTH, SHEIGHT/13)];
    shezhiView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:shezhiView];
    UILabel *imageLabel = [[UILabel alloc]initWithFrame:CGRectMake(SWIDTH/30,0, SHEIGHT*3/65,  SHEIGHT/13)];
    imageLabel.text = @"\ue6cd";
      imageLabel.font = [UIFont fontWithName:@"iconfont" size:22];
    imageLabel.textColor = SF_COLOR(174, 222, 71);
    [shezhiView addSubview:imageLabel];
    
    UILabel *peisonglabel = [[UILabel alloc]initWithFrame:CGRectMake(SWIDTH/7, 0, SWIDTH*6/7, SHEIGHT/13)];
    peisonglabel.textColor = SF_COLOR(125, 125, 125);
    peisonglabel.text = @"配送地址";
    peisonglabel.font = [UIFont systemFontOfSize:18];
    [shezhiView addSubview:peisonglabel];
    
    
    shezhiView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    [shezhiView addGestureRecognizer:tap];
    
    
    
    
    UIView *shezhiView1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(shezhiView.frame)+5, SWIDTH, SHEIGHT/13)];
    shezhiView1.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:shezhiView1];
    UILabel *imageLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(SWIDTH/30,0, SHEIGHT*3/65,  SHEIGHT/13)];
    imageLabel1.text = @"\ue613";
    imageLabel1.font = [UIFont fontWithName:@"iconfont" size:22];
    imageLabel1.textColor = SF_COLOR(174, 222, 71);
    [shezhiView1 addSubview:imageLabel1];
    
    UILabel *peisonglabel1 = [[UILabel alloc]initWithFrame:CGRectMake(SWIDTH/7, 0, SWIDTH*6/7, SHEIGHT/13)];
    peisonglabel1.textColor = SF_COLOR(125, 125, 125);
    peisonglabel1.text = @"退出登录";
    peisonglabel1.font = [UIFont systemFontOfSize:18];
    [shezhiView1 addSubview:peisonglabel1];
    
    
    shezhiView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click1:)];
    [shezhiView1 addGestureRecognizer:tap1];
    
    

}
- (void )click1:(UITapGestureRecognizer *)tap{
    {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确定退出" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
            NSNotification *nt = [NSNotification notificationWithName:@"tuichu" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter]postNotification:nt];
        }];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:ac];
        [alert addAction:act];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
- (void )click:(UITapGestureRecognizer *)tap{
    
    [self.navigationController pushViewController:[[DizhiViewController alloc]init] animated:YES];
    
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
