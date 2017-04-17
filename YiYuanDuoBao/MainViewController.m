//
//  MainViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/8/29.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "MainViewController.h"
#import "GouwuController.h"
#import "UIView+CGSet.h"
#define WEIGHT [UIScreen mainScreen].bounds.size.width/5

#define SCREEN_W [UIScreen mainScreen].bounds.size.width

@interface MainViewController ()<UITabBarControllerDelegate>
{
    NSString *_tmpLb;
    NSInteger _buttag;
    
    UINavigationController *_tmpNav;
    
    UILabel * _tmpLabel;
    UIImageView * _tmpImageView;
    UIImageView * _imageView;
    UIButton * _tmpButton;
    //UIView * _tmpView;
    UIView *blackView;
}

@end

@implementation MainViewController

- (void)notice:(NSNotification *)dic {
    
    
    NSLog(@"%@",dic.userInfo[@"num"]);
    if ([dic.userInfo[@"num"] isKindOfClass:[NSNumber class]]) {
        NSNumber *num = dic.userInfo[@"num"];
        if (num.intValue<=0) {
            self.TextLabel.backgroundColor = [UIColor clearColor];
            self.TextLabel.text = @"";
        }else {
            self.TextLabel.text = [NSString stringWithFormat:@"%@",num];
            self.TextLabel.backgroundColor = [UIColor redColor];
        }
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
        del.plistNum = self.TextLabel.text.intValue;
        
    }else {
        NSString *str = dic.userInfo[@"num"];
        if ([str isEqualToString:@"0"]||!str.length||str.intValue<0) {
            self.TextLabel.backgroundColor = [UIColor clearColor];
            self.TextLabel.text = @"";
        }else {
            self.TextLabel.text = dic.userInfo[@"num"];
            self.TextLabel.backgroundColor = [UIColor redColor];
        }
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
        del.plistNum = self.TextLabel.text.intValue;
    }
    
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notice:) name:@"plistNum" object:nil];
    self.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushto:) name:@"pushtomain" object:nil];
    
}

- (void)pushto :(NSNotification *)n {
    
    NSDictionary *dic = n.userInfo;
    
    NSString *str = dic[@"num"];
    
    
    UIButton *btn = (UIButton *)[self.tabBar viewWithTag:500-1+str.intValue];
    
    [self buttonClick:btn];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
    
    NSArray * subViews = self.tabBar.subviews;
    
    for (UIView * view in subViews) {
        
        view.hidden = YES;
        
    }
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    NSArray * arr = self.viewControllers;
    for (int i = 0; i < arr.count ; i++) {
        
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(i*SCREEN_W/arr.count, 0, SCREEN_W/arr.count, 49)];
        
        button.tag = 500 +i;
        
        [self.tabBar addSubview:button];
        
        if (i == 3) {
            
            _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(button.bounds.size.width/2-12,3, 24, 24)];
            
            self.TextLabel=[[UILabel alloc]initWithFrame:CGRectMake(WEIGHT*3/5, 3, 13, 13)];
                        self.TextLabel.layer.cornerRadius = 6.5;
                        self.TextLabel.clipsToBounds = YES;
                        self.TextLabel.textColor = [UIColor whiteColor ];
                        self.TextLabel.text = @"";
                        self.TextLabel.font = [UIFont systemFontOfSize:11];
                        self.TextLabel.textAlignment = NSTextAlignmentCenter;
            [button addSubview:_imageView];
            [button addSubview: self.TextLabel];
        }
        else{

            _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(button.bounds.size.width/2-12,3, 24, 24)];
            
            [button addSubview:_imageView];

        }
        
        _imageView.tag = 100 + i;
        
        UINavigationController * nav = [arr objectAtIndex:i];
        
        
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 31, SCREEN_W/arr.count, 10)];
        label.text = nav.tabBarItem.title;
        label.textColor = SF_COLOR(102, 102, 102);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11];
        [button addSubview:label];
        if (i == 0) {
            _imageView.image = nav.tabBarItem.selectedImage;
            [label setTextColor:SF_COLOR(255, 54, 93)];
            _tmpImageView = _imageView;
            _tmpLabel = label;
            _tmpNav = nav;
            _tmpButton = button;
        }else {
            _imageView.image = nav.tabBarItem.image;

        }
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    }
    
}

- (void)buttonClick:(UIButton *)button{
    
    if (button == _tmpButton) {
        
        return;
    }
    
    UIImageView * imageView = (UIImageView *)[button.subviews firstObject];
    
    UINavigationController * nav = [self.viewControllers objectAtIndex:imageView.tag-100];
    if (imageView.tag == 102) {

    }
    
    if (imageView.tag == 100) {
        NSNotification *no = [[NSNotification alloc]initWithName:@"pushmain" object:nil userInfo:nil];
        
        [[NSNotificationCenter defaultCenter] postNotification:no];
    }
    
    if (imageView.tag == 103) {
        NSNotification *no = [NSNotification notificationWithName:@"jilurefresh" object:nil userInfo:@{@"index":@"0"}];
        [[NSNotificationCenter defaultCenter ]postNotification:no];
    }
    
    
    imageView.image = nav.tabBarItem.selectedImage;
    UILabel * label = (UILabel *)[button.subviews lastObject];
    [label setTextColor:SF_COLOR(255, 54, 93)];
    
    // 设置上一次的按钮为低亮
    _tmpImageView.image = _tmpNav.tabBarItem.image;
    [_tmpLabel setTextColor:SF_COLOR(102, 102, 102)];
    
    // 重新设置高亮的临时变量
    _tmpLabel = label;
    _tmpImageView = imageView;
    _tmpNav = nav;
    _tmpButton = button;
    [nav popToRootViewControllerAnimated:YES];
    
    // 设置界面的切换
    self.selectedIndex = imageView.tag - 100;
    
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
