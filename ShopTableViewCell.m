//
//  ShopTableViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/11.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "ShopTableViewCell.h"
#import "DuoBaoJLModel.h"
#import "UIImageView+WebCache.h"
#import "UIView+CGSet.h"
@implementation ShopTableViewCell
{
    UIImageView *image;
    UILabel *namelabel;
    UILabel *qihaolabel;
    UILabel*zongxulabel;
    UILabel *benlabel;
    UIButton *benlabel1;
    UILabel *shenglabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIView *view = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:10 andWidth:375 andHeight:138]];
    view.backgroundColor = [UIColor whiteColor];
  //  view.layer.backgroundColor = SF_COLOR(232, 232, 232).CGColor;
    //view.layer.borderWidth = 0.5;
    [self.contentView addSubview:view];
    //self.contentView.backgroundColor = SF_COLOR(242, 242, 242);
    
    image = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:12], [UIView setHeight:25], [UIView setHeight:100], [UIView setHeight:100])];
    
    image.image = [UIImage imageNamed:@"123123"];
    [view addSubview:image];
    namelabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:30]+[UIView setHeight:100], [UIView setHeight:15], SWIDTH-[UIView setWidth:42]-[UIView setHeight:100], [UIView setHeight:31])];
    namelabel.font = [UIFont systemFontOfSize:14];
    namelabel.textColor = SF_COLOR(102, 102, 102);
    namelabel.lineBreakMode = NSLineBreakByWordWrapping;
    namelabel.numberOfLines = 0;
    [view addSubview:namelabel];
    
    
    qihaolabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:90 andY:50 andWidth:100 andHeight:10]];
    qihaolabel.font = [UIFont systemFontOfSize:10];
    qihaolabel.textColor = [UIColor grayColor];
    qihaolabel.text = @"期号 : 100000046";
//    [view addSubview:qihaolabel];
    
    
    
    
    
    self.progress = [[YSProgressView alloc]initWithFrame:CGRectMake([UIView setWidth:30]+[UIView setHeight:100], [UIView setHeight:60], [UIView setWidth:160], [UIView setHeight:5])];
    self.progress.progressTintColor = SF_COLOR(229, 229, 229);
    self.progress.trackTintColor = SF_COLOR(255, 196, 126);
    
    [view addSubview:self.progress];
    
//设置进度条长度
    
    zongxulabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:30]+[UIView setHeight:100], [UIView setHeight:75], [UIView setWidth:80], [UIView setHeight:11])];
    zongxulabel.font = [UIFont systemFontOfSize:11];
    zongxulabel.textColor = SF_COLOR(153, 153, 153);
    [view addSubview:zongxulabel];
    
    
    
    shenglabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:30]+[UIView setHeight:100]+[UIView setWidth:80], [UIView setHeight:75], [UIView setWidth:80], [UIView setHeight:11])];
    shenglabel.font = [UIFont systemFontOfSize:11];
    shenglabel.textColor = SF_COLOR(153, 153, 153);
    shenglabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:shenglabel];
    
    
    
    
    UIButton *addbtn = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH-[UIView setWidth:62], [UIView setHeight:60], [UIView setWidth:50], [UIView setHeight:28])];
    addbtn.backgroundColor = SF_COLOR(255, 54, 93);
    [addbtn setTitle:@"追加" forState:UIControlStateNormal];
    [addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addbtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [addbtn addTarget:self action:@selector(addclick:) forControlEvents:UIControlEventTouchUpInside];
    addbtn.layer.cornerRadius = 4;
    addbtn.clipsToBounds = YES;
    [view addSubview:addbtn];
    
    
    benlabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:30]+[UIView setHeight:100], [UIView setHeight:102], [UIView setWidth:80], [UIView setHeight:12])];
    benlabel.font = [UIFont systemFontOfSize:12];
    benlabel.textColor = SF_COLOR(153, 153, 153);
    
    [view addSubview:benlabel];

    benlabel1 = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH-[UIView setWidth:116]-[UIView setHeight:10], [UIView setHeight:102], [UIView setWidth:100], [UIView setHeight:12])];
    [benlabel1 setTitle:@"查看我的号码" forState:0];
    benlabel1.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [benlabel1 setTitleColor:SF_COLOR(107, 166, 255) forState:UIControlStateNormal];
    
    [benlabel1 addTarget:self action:@selector(tapsend) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:benlabel1];
    
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(SWIDTH-[UIView setHeight:10]-[UIView setWidth:12], [UIView setHeight:103], [UIView setHeight:10], [UIView setHeight:10])];
    imageview.image = [UIImage imageNamed:@"蓝箭头"];
    [view addSubview:imageview];
    
    UILabel *line = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:0.3]];
    line.backgroundColor = SF_COLOR(232, 232, 232);
    [view addSubview:line];
    UILabel *line1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:137.5 andWidth:375 andHeight:0.3]];
    line1.backgroundColor = SF_COLOR(232, 232, 232);
    [view addSubview:line1];
}
- (void)tapsend{
    UITableView *table = (UITableView *)[self.superview superview];
    NSIndexPath *index = [table indexPathForCell:self];
    NSNotification *n = [NSNotification notificationWithName:@"seeNo" object:nil userInfo:@{@"index":index}];
    [[NSNotificationCenter defaultCenter]postNotification:n];
    
    
}
- (void)addclick:(UIButton *)sender {
    UITableView *table = (UITableView *)[self.superview superview];
    NSIndexPath *index = [table indexPathForCell:self];
    NSLog(@"%ld",(long)index.row);
    NSNotification *no = [NSNotification notificationWithName:@"zhuijia" object:nil userInfo:@{@"index":index}];
    [[NSNotificationCenter defaultCenter]postNotification:no];
}
- (void)reloadwith:(DuoBaoJLModel *)model {

    namelabel.text = model.name;
    
    qihaolabel.text = [NSString stringWithFormat:@"期号 : %@",model.id];
    zongxulabel.text = [NSString stringWithFormat:@"总需 : %@",model.max_buy];
    [image sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    NSString *str = [NSString stringWithFormat:@"本期参与%@次",model.number];
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:str];
    [astr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(4, model.number.length)];
    benlabel.attributedText = astr;
    NSString *lesstr = [NSString stringWithFormat:@"剩余 : %@",model.less];
    NSMutableAttributedString *lessmstr = [[NSMutableAttributedString alloc]initWithString:lesstr];
    [lessmstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(5, model.less.length)];
    shenglabel.attributedText = lessmstr;
    
    self.progress.progressValue = self.progress.frame.size.width*(1-model.less.floatValue/model.max_buy.floatValue);

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
