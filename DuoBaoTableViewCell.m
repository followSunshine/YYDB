//
//  DuoBaoTableViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/27.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "DuoBaoTableViewCell.h"
#import "DuoBaoJLModel.h"
#import "UIImageView+WebCache.h"
#import "UIView+CGSet.h"
#import "DizhiWebViewController.h"
@implementation DuoBaoTableViewCell
{
    UIImageView *image;
    UILabel *namelabel;
    UILabel *qihaolabel;
    UILabel*zongxulabel;
    UILabel *benlabel;
    UIButton *benlabel1;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup {
    UIView *view = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:10 andWidth:375 andHeight:150]];
    view.backgroundColor = [UIColor whiteColor];
    //view.layer.backgroundColor = SF_COLOR(232, 232, 232).CGColor;
    //view.layer.borderWidth = 0.5;
    [self.contentView addSubview:view];
    
    image = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:12], [UIView setHeight:25], [UIView setHeight:100], [UIView setHeight:100])];
    
    [view addSubview:image];
    namelabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:30]+[UIView setHeight:100], [UIView setHeight:15], SWIDTH-[UIView setWidth:42]-[UIView setHeight:100], [UIView setHeight:31])];
    namelabel.font = [UIFont systemFontOfSize:14];
    namelabel.textColor = SF_COLOR(102, 102, 102);
    namelabel.lineBreakMode = NSLineBreakByWordWrapping;
    namelabel.numberOfLines = 0;
    [view addSubview:namelabel];
    
    
    qihaolabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:90 andY:50 andWidth:100 andHeight:10]];
    qihaolabel.font = [UIFont systemFontOfSize:10];
    qihaolabel.textColor = [UIColor grayColor];
    qihaolabel.text = @"期号 : 100000046";
   // [view addSubview:qihaolabel];

    zongxulabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:90 andY:75 andWidth:60 andHeight:10]];
    zongxulabel.font = [UIFont systemFontOfSize:10];
    zongxulabel.textColor = [UIColor grayColor];
    zongxulabel.text = @"总需 : 2999";
   // [view addSubview:zongxulabel];
    
    benlabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:30]+[UIView setHeight:100], [UIView setHeight:71], [UIView setWidth:250], [UIView setHeight:12])];
    benlabel.text = @"本期参与 : 3人次";
    benlabel.font = [UIFont systemFontOfSize:12];
    benlabel.textColor = SF_COLOR(153, 153, 153);
    [view addSubview:benlabel];
    
    
    
    benlabel1 = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH-[UIView setWidth:116]-[UIView setHeight:10], [UIView setHeight:130], [UIView setWidth:100], [UIView setHeight:12])];
    [benlabel1 setTitle:@"查看我的号码" forState:0];
    benlabel1.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [benlabel1 setTitleColor:SF_COLOR(107, 166, 255) forState:UIControlStateNormal];
    [view addSubview:benlabel1];
    
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(SWIDTH-[UIView setHeight:10]-[UIView setWidth:12], [UIView setHeight:131], [UIView setHeight:10], [UIView setHeight:10])];
    imageview.image = [UIImage imageNamed:@"蓝箭头"];
    [view addSubview:imageview];
    
    
    
    
    
    [benlabel1 addTarget:self action:@selector(tapsend) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bgview = [[UIView alloc]initWithFrame:[UIView setRectWithX:90 andY:115 andWidth:210 andHeight:80]];
    bgview.backgroundColor = SF_COLOR(246, 246, 246);
   // [view addSubview:bgview];
    
    label1 = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:30]+[UIView setHeight:100], [UIView setHeight:54], [UIView setWidth:250], [UIView setHeight:12])];
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = SF_COLOR(153, 153, 153);
    [view addSubview:label1];
 //   label2 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:5 andY:30 andWidth:200 andHeight:20]];
   // label2.font = [UIFont systemFontOfSize:13];
    //label2.textColor = [UIColor grayColor];
    //[bgview addSubview:label2];
    label3 = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:30]+[UIView setHeight:100], [UIView setHeight:88], [UIView setWidth:250], [UIView setHeight:12])];
    label3.font = [UIFont systemFontOfSize:12];
    label3.textColor = SF_COLOR(153, 153, 153);
    [view addSubview:label3];
    label4 = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:30]+[UIView setHeight:100], [UIView setHeight:105], [UIView setWidth:250], [UIView setHeight:12])];
    label4.font = [UIFont systemFontOfSize:12];
    label4.textColor = SF_COLOR(153, 153, 153);
    [view addSubview:label4];
    UILabel *line = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:0.3]];
    line.backgroundColor = SF_COLOR(232, 232, 232);
    [view addSubview:line];
    UILabel *line1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:149.5 andWidth:375 andHeight:0.3]];
    line1.backgroundColor = SF_COLOR(232, 232, 232);
    [view addSubview:line1];

}
- (void)tapsend{
    UITableView *table = (UITableView *)[self.superview superview];
    NSIndexPath *index = [table indexPathForCell:self];
    NSNotification *n = [NSNotification notificationWithName:@"seeNo" object:nil userInfo:@{@"index":index}];
    [[NSNotificationCenter defaultCenter]postNotification:n];
    
    
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
    
    NSString *str1 = [NSString stringWithFormat:@"获奖者 : %@",model.luck_user_name];
    NSMutableAttributedString *astr1 = [[NSMutableAttributedString alloc]initWithString:str1];
    [astr1 addAttribute:NSForegroundColorAttributeName value:SF_COLOR(107,166,255) range:NSMakeRange(6, model.luck_user_name.length)];
    label1.attributedText = astr1;
    label2.attributedText = astr;
    NSString *str2 = [NSString stringWithFormat:@"幸运号码 : %@",model.lottery_sn];
    NSMutableAttributedString *astr2 = [[NSMutableAttributedString alloc]initWithString:str2];
    [astr2 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7, model.lottery_sn.length)];
    label3.attributedText = astr2;
    label4.text = [NSString stringWithFormat:@"开奖时间 : %@",model.lottery_time];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
