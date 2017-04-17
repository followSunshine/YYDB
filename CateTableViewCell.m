//
//  CateTableViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/25.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "CateTableViewCell.h"
#import "RGBColor.h"
#import "UIImageView+WebCache.h"
#import "UIView+CGSet.h"

@implementation CateTableViewCell
{
    UILabel *label;
    UILabel *label1;
    UIView *bgview;
    UILabel *linelabel;
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
    bgview = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:82 andHeight:50]];
    [self.contentView addSubview:bgview];
    
    label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:3 andHeight:50]];
    
    [bgview addSubview:label];
    
    label1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:82 andHeight:50]];
    label1.font = [UIFont systemFontOfSize:14];
    label1.textAlignment = NSTextAlignmentCenter;
    linelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:49.5 andWidth:82 andHeight:0.5]];
    linelabel.backgroundColor = SF_COLOR(194, 194, 194);
    [bgview addSubview:linelabel];
    [bgview addSubview:label1];
    
}
- (void)reloadwith:(CateModel *)model {
    label1.text = model.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        label1.textColor = SF_COLOR(255, 54, 93);
        bgview.backgroundColor = [UIColor whiteColor];
        label.backgroundColor = SF_COLOR(255, 54, 93);
        linelabel.backgroundColor = [UIColor clearColor];
        
    }else {
        label1.textColor = SF_COLOR(51, 51, 51);
        bgview.backgroundColor = SF_COLOR(238, 238, 238);
        label.backgroundColor = [UIColor clearColor];
        linelabel.backgroundColor = SF_COLOR(194, 194, 194);

    }
    
}
@end
