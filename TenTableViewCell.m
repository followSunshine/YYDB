//
//  TenTableViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/26.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "TenTableViewCell.h"
#import "YSProgressView.h"
#import "UIImageView+WebCache.h"
#import "AFHTTPSessionManager.h"
#import "UIView+CGSet.h"
@implementation TenTableViewCell
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
    imageview = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:17 andY:0 andWidth:24 andHeight:29]];
    image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:12 andY:13 andWidth:90 andHeight:90]];
    
    namelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:118 andY:17 andWidth:245 andHeight:51]];
    namelabel.textColor = SF_COLOR(102, 102, 102);
    namelabel.font = [UIFont systemFontOfSize:14];
    namelabel.lineBreakMode = NSLineBreakByWordWrapping;
    namelabel.numberOfLines = 0;
    [self.contentView addSubview:namelabel];
    [self.contentView addSubview:image];
    [self.contentView addSubview:imageview];

    progress = [[YSProgressView alloc]initWithFrame:[UIView setRectWithX:118 andY:80 andWidth:160 andHeight:5]];
    
    progress.progressTintColor = SF_COLOR(229, 229, 229);
    progress.trackTintColor = SF_COLOR(255, 196, 126);
    [self.contentView addSubview:progress];
//    progress.progressValue = progress.frame.size.width/2;
    
    zonglabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:118 andY:95 andWidth:80 andHeight:11]];
    zonglabel.textColor = SF_COLOR(153, 153, 153);
    zonglabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:zonglabel];
    
    
    shenglabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:198 andY:95 andWidth:80 andHeight:11]];
    shenglabel.textColor = SF_COLOR(153, 153, 153);
    shenglabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:shenglabel];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:293 andY:73 andWidth:65 andHeight:28]];
    [btn setTitle:@"立即参与" forState:UIControlStateNormal];
    btn.layer.borderColor = SF_COLOR(255,54,96).CGColor;
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 5;
    btn.clipsToBounds = YES;
    [btn setTitleColor:SF_COLOR(255,54,96) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    if (SWIDTH==320) {
        btn.titleLabel.font = [UIFont systemFontOfSize:11];

    }
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:btn];
    UILabel *linelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:114.5 andWidth:375 andHeight:0.5]];
    linelabel.backgroundColor = SF_COLOR(238, 238, 238);
    [self.contentView addSubview:linelabel];
}
- (void)btnclick {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!app.userid) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"您还尚未登陆" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *str = [NSString stringWithFormat:@"%@?ctl=api&act=addcart&buy_num=%@&data_id=%@&uid=%@",urlpre,selfmodel.min_buy,selfmodel.id,del.userid];
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
    zonglabel.text = [NSString stringWithFormat:@"总需:%@",model.max_buy];
    NSString *str = [NSString stringWithFormat:@"剩余:%@",model.surplus_buy];
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [astr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(3, model.surplus_buy.length)];
    shenglabel.attributedText = astr;
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
