//
//  PulisTableViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/17.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "PulisTableViewCell.h"
#import "PublishModel.h"
#import "UIImageView+WebCache.h"
#import "UIView+CGSet.h"
@implementation PulisTableViewCell
{
    UIImageView *image;
    UILabel *titlelabel;
    UILabel *pricelabel;
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
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:119 andY:93 andWidth:15 andHeight:15]];
    image1.image = [UIImage imageNamed:@"倒计时"];
    [self.contentView addSubview:image1];
    UILabel *jxlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:139 andY:93 andWidth:70 andHeight:15]];
    jxlabel.text = @"即将揭晓:";
    jxlabel.textColor = SF_COLOR(255, 54, 93);
    jxlabel.font = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:image];
    [self.contentView addSubview:titlelabel];
    [self.contentView addSubview:pricelabel];
    [self.contentView addSubview:jxlabel];
    self.timelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:209 andY:88 andWidth:200 andHeight:25]];
    self.timelabel.textColor = SF_COLOR(255, 54, 93);
    self.timelabel.font = [UIFont systemFontOfSize:25];
    [self.contentView addSubview:self.timelabel];
    UILabel *label123 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:119.5 andWidth:375 andHeight:0.5]];
    label123.backgroundColor = SF_COLOR(232, 232, 232);
    [self.contentView addSubview:label123];
}
- (void)reloadwithmodel:(id)model {
    PublishModel *model1 = (PublishModel *)model;
    [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urladress,model1.icon]]];
    titlelabel.text = model1.duobaoitem_name;
    pricelabel.text = [NSString stringWithFormat:@"价值:%@元",model1.max_buy];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
