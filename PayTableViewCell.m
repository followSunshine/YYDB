//
//  PayTableViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/25.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "PayTableViewCell.h"
#import "UIView+CGSet.h"
@implementation PayTableViewCell
{
    UILabel *namelabel;
    UILabel *numlabel;
    
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
- (void)reloadwith:(PayCell *)model{
    namelabel.text = model.name;
    NSString *str = [NSString stringWithFormat:@"%@次",model.number];
    NSMutableAttributedString *astr=  [[NSMutableAttributedString alloc]initWithString:str];
    [astr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(0, model.number.length)];
    
    numlabel.attributedText = astr;
    
}

- (void) setup {
    UIView *view = [[UIView alloc]init];
    namelabel = [[UILabel alloc]init];
    numlabel = [[UILabel alloc]init];
    
    if (self.index.row==0) {
        view.frame = [UIView setRectWithX:0 andY:0 andWidth:375 andHeight:25];
        namelabel.frame =[UIView setRectWithX:12 andY:6 andWidth:286 andHeight:13];
        numlabel.frame =[UIView setRectWithX:298 andY:6 andWidth:65 andHeight:13];
    }
    view.backgroundColor = SF_COLOR(234, 234, 234);
    [self.contentView addSubview:view];
    
    namelabel.backgroundColor = [UIColor clearColor];
    namelabel.font = [UIFont systemFontOfSize:13];
    namelabel.textColor =SF_COLOR(153,153,153);
    
    numlabel.font = [UIFont systemFontOfSize:13];
    numlabel.backgroundColor = [UIColor clearColor];
    numlabel.textColor = SF_COLOR(163, 163, 163);
    numlabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:namelabel];
    [view addSubview:numlabel];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
