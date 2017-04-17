//
//  PLTableViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/17.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "PLTableViewCell.h"
#import "PublishModel.h"
#import "UIImageView+WebCache.h"
#import "UIView+CGSet.h"
@implementation PLTableViewCell
{
    UIImageView *image;
    UILabel *titlelabel;
    UILabel *pricelabel;
    UILabel *timelabel;
    UILabel *zjlabel;
    UILabel *numlabel;
    UILabel *jiexiaoTimeLabel;
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
    image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:12 andY:15 andWidth:90 andHeight:90]];
    titlelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:17+12+90 andY:12 andWidth:375-119-12 andHeight:35]];
    titlelabel.font = [UIFont systemFontOfSize:14];
    titlelabel.textColor = SF_COLOR(102, 102, 102);
    titlelabel.numberOfLines = 0;
    titlelabel.lineBreakMode = NSLineBreakByWordWrapping;
    pricelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:119 andY:50 andWidth:375-119-12 andHeight:12]];
    pricelabel.font = [UIFont systemFontOfSize:12];
    pricelabel.textColor = SF_COLOR(153, 153, 153);
       [self.contentView addSubview:image];
    [self.contentView addSubview:titlelabel];
    [self.contentView addSubview:pricelabel];
    zjlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:119 andY:67 andWidth:200 andHeight:12]];
    zjlabel.font = [UIFont systemFontOfSize:12];
    zjlabel.textColor = SF_COLOR(153, 153, 153);
    numlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:119 andY:84 andWidth:200 andHeight:12]];
    numlabel.font = [UIFont systemFontOfSize:12];
    numlabel.textColor = SF_COLOR(153, 153, 153);
    jiexiaoTimeLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:119 andY:101 andWidth:200 andHeight:12]];
    jiexiaoTimeLabel.font = [UIFont systemFontOfSize:12];
    jiexiaoTimeLabel.textColor = SF_COLOR(153, 153, 153);
    
    [self.contentView addSubview:zjlabel];
    [self.contentView addSubview:numlabel];
    [self.contentView addSubview:jiexiaoTimeLabel];
   
    UILabel *label123 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:119.5 andWidth:375 andHeight:0.5]];
    label123.backgroundColor = SF_COLOR(232, 232, 232);
    [self.contentView addSubview:label123];

}
- (void)reloadwithmodel:(id)model{
    PublishModel *pmodel = (PublishModel *)model;
    [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urladress,pmodel.icon]]];
    titlelabel.text = pmodel.duobaoitem_name;
    pricelabel.text = [NSString stringWithFormat:@"价值:%@元",pmodel.max_buy];

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"中奖者:%@",pmodel.luck_user_name]];
    
    [str addAttribute:NSForegroundColorAttributeName value:SF_COLOR(123, 191, 249) range:NSMakeRange(4, pmodel.luck_user_name.length)];
    zjlabel.attributedText = str;
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"本期夺宝:%@人次",pmodel.luck_user_buy_count]];
    NSString *strqw = pmodel.luck_user_buy_count;
    [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, strqw.length)];
    numlabel.attributedText = str1;
    jiexiaoTimeLabel.text = [NSString stringWithFormat:@"开奖时间:%@%@",pmodel.date,pmodel.lottery_time_show];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
