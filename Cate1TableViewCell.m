//
//  Cate1TableViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 17/1/3.
//  Copyright © 2017年 chenyu. All rights reserved.
//
#import "Cate1TableViewCell.h"
#import "YSProgressView.h"
#import "UIImageView+WebCache.h"
#import "AFHTTPSessionManager.h"
#import "UIView+CGSet.h"
@implementation Cate1TableViewCell
{
    UIImageView *image;
    UILabel *namelabel;
    YSProgressView *progress;
    UILabel *zonglabel;
    UILabel *shenglabel;
    UIImageView *imageview;
    TenModel *selfmodel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup {
    imageview = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:11 andY:0 andWidth:18 andHeight:20]];
    image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:5 andY:10 andWidth:80 andHeight:80]];
    
    namelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:89 andY:10 andWidth:192 andHeight:39]];
    namelabel.textColor = SF_COLOR(51, 51, 51);
    namelabel.font = [UIFont systemFontOfSize:14];
    namelabel.lineBreakMode = NSLineBreakByWordWrapping;
    namelabel.numberOfLines = 0;
    [self.contentView addSubview:namelabel];
    [self.contentView addSubview:image];
    [self.contentView addSubview:imageview];
    
    progress = [[YSProgressView alloc]initWithFrame:[UIView setRectWithX:89 andY:49 andWidth:113 andHeight:5]];
    
    progress.progressTintColor = SF_COLOR(229, 229, 229);
    progress.trackTintColor = SF_COLOR(255, 196, 126);
    [self.contentView addSubview:progress];
    //    progress.progressValue = progress.frame.size.width/2;
    
    zonglabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:89 andY:60 andWidth:50 andHeight:10]];
    zonglabel.textColor = SF_COLOR(102, 157, 241);
    zonglabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:zonglabel];
    
    UILabel *label23 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:89 andY:75 andWidth:50 andHeight:11]];
    label23.textColor = SF_COLOR(153, 153, 153);
    label23.text = @"总需";
    label23.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:label23];

    
    shenglabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:139 andY:60 andWidth:63 andHeight:10]];
    shenglabel.textAlignment = NSTextAlignmentRight;
    shenglabel.textColor = SF_COLOR(255,54,96);
    shenglabel.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:shenglabel];
    
    UILabel *label231 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:139 andY:75 andWidth:63 andHeight:11]];
    label231.textColor = SF_COLOR(153, 153, 153);
    label231.text = @"剩余";
    label231.textAlignment = NSTextAlignmentRight;
    label231.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:label231];

    UIButton *btn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:215 andY:53 andWidth:67 andHeight:27]];
    [btn setTitle:@"立即参与" forState:UIControlStateNormal];
    btn.layer.borderColor = SF_COLOR(255,54,96).CGColor;
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 5;
    btn.clipsToBounds = YES;
    btn.backgroundColor = SF_COLOR(255, 54, 93);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    if (SWIDTH==320) {
        btn.titleLabel.font = [UIFont systemFontOfSize:12];

    }
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:btn];
    
    UILabel *linelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:10 andY:99.5 andWidth:283 andHeight:0.5]];
    linelabel.backgroundColor = SF_COLOR(238, 238, 238);
    [self.contentView addSubview:linelabel];
    
}
- (void)btnclick {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *str = [NSString stringWithFormat:@"%@?ctl=api&act=addcart&buy_num=%@&data_id=%@&uid=%@",urlpre,selfmodel.min_buy,selfmodel.id,del.userid];
    if (!del.userid.length) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还尚未登陆" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.superView.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
        }];
        UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"再看看" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:act];
        [alert addAction:act1];
        [self.superView presentViewController:alert animated:YES completion:nil];
        
    }else {
    [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *str = dic[@"status"];
        if (str.intValue==1) {
            del.plistNum +=1;
            
            NSNotification *notice = [NSNotification notificationWithName:@"plistNum" object:nil userInfo:@{@"num":dic[@"cart_item_num"]}];
            
            [[NSNotificationCenter defaultCenter] postNotification:notice];
            
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"cart_item_num"] forKey:@"number"];
            
            [self updataWindows];
        }else {
            NSNotification *nt = [NSNotification notificationWithName:@"alert" object:nil userInfo:@{@"info":dic[@"info"]}];
            [[NSNotificationCenter defaultCenter]postNotification:nt];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    }
}
-(void)updataWindows {
    
    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    
    UIView *view = [[UIView alloc]initWithFrame:[UIView setRectWithX:110 andY:275 andWidth:155 andHeight:70]];
    
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.8;
    view.layer.masksToBounds = YES;
    
    view.layer.cornerRadius = 8.0f;
    
    UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:155 andHeight:70]];
    
    
    label.text = @"加入购物车成功";
    
    label.textColor = [UIColor whiteColor];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [windows addSubview:view];
    
    [view addSubview:label];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        [view removeFromSuperview];
    });
}
- (void)reloadwith:(TenModel *)model {
    [image sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    
    namelabel.text = model.name;
    zonglabel.text = [NSString stringWithFormat:@"%@",model.max_buy];
    NSString *str = [NSString stringWithFormat:@"%@",model.surplus_buy];
    shenglabel.text = str;
    progress.progressValue = progress.frame.size.width*model.current_buy.integerValue/model.max_buy.integerValue;
    int a = model.min_buy.intValue*model.unit_price.intValue;
    
    if (a==10) {
        imageview.image = [UIImage imageNamed:@"十元-专区"];
    }else if (a==100) {
        imageview.image = [UIImage imageNamed:@"百元-专区"];
    }
    selfmodel = model;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end


