//
//  ShowDetailTableViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/12/9.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "ShowDetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+CGSet.h"
@implementation ShowDetailTableViewCell
{
    UIImageView *imageview;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
    
}
- (void)setUI {
    imageview = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:12 andY:0 andWidth:351 andHeight:500]];
    [self.contentView addSubview:imageview];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)reloadWithModel:(ShowModle1 *)model {
    NSString *str = [NSString stringWithFormat:@"%@%@",urladress,model.o_path];
    [imageview sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"占位图"]];
    
}
@end
