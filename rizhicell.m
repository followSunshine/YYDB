//
//  rizhicell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/19.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "rizhicell.h"

@implementation rizhicell
{
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UILabel *label5;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return  self;
}
- (void)setup {
    label1 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:5 andY:0 andWidth:250 andHeight:17]];
    label1.text = @"资金记录";
    label1.textColor = SF_COLOR(96, 96, 96);
    label1.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:label1];
    label2 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:5 andY:17 andWidth:250 andHeight:30]];
    label2.textColor = SF_COLOR(163, 163, 163);
    label2.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:label2];
    label2.lineBreakMode = NSLineBreakByWordWrapping;
    label2.numberOfLines = 0;
    label3 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:5 andY:47 andWidth:250 andHeight:13]];
    label3.textColor = SF_COLOR(163, 163, 163);
    label3.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:label3];
    
    label4 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:220 andY:20 andWidth:110 andHeight:20]];
    label4.textColor = [UIColor redColor];
    label4.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:label4];
    label5 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:0 andY:59 andWidth:320 andHeight:0.5]];
    label5.backgroundColor = SF_COLOR(200, 200, 200);
    [self.contentView addSubview:label5];
}
- (void)reloadwith:(RizhiModel *)model {
    label2.text = model.log_info;
    label3.text = model.log_time;
    label4.text = model.money;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
