//
//  JXCollectionViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/16.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "JXCollectionViewCell.h"
#import "UIView+CGSet.h"
@implementation JXCollectionViewCell
{
    UIImageView *imageview;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)setup {
    
    imageview = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:21 andY:10 andWidth:75 andHeight:75]];
    [self addSubview:imageview];
    
    _label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:5 andY:90 andWidth:107 andHeight:9]];
    _label.font = [UIFont systemFontOfSize:11];
    _label.textAlignment = NSTextAlignmentCenter;
    
    _label2 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:5 andY:103 andWidth:107 andHeight:9]];
    _label2.textAlignment = NSTextAlignmentLeft;
    _label2.font = [UIFont systemFontOfSize:9];
    
    [self addSubview:_label];
    [self addSubview:_label2];
    
}
- (void)cellwithmodel:(DuoBaoModel *)model {
    [imageview sd_setImageWithURL:[NSURL URLWithString:model.icon]];

    NSString *str = model.has_lottery;

    if (str.integerValue==0) {
        
        _label.text = @"";
        _label2.frame = [UIView setRectWithX:20 andY:90 andWidth:77 andHeight:26];
        _label2.font = [UIFont systemFontOfSize:16];
        if (SWIDTH==320) {
            _label2.font = [UIFont systemFontOfSize:13];
        }
    }else{
        _label2.frame = [UIView setRectWithX:5 andY:103 andWidth:107 andHeight:9];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"恭喜%@中奖",model.luck_user_name]];
        _label2.textAlignment = NSTextAlignmentCenter;
        NSInteger length = model.luck_user_name.length;
        [str addAttribute:NSForegroundColorAttributeName value:SF_COLOR(102, 102, 102) range:NSMakeRange(0, 2)];
        [str addAttribute:NSForegroundColorAttributeName value:SF_COLOR(76, 157, 255) range:NSMakeRange(2,length)];
        
        [str addAttribute:NSForegroundColorAttributeName value:SF_COLOR(102, 102, 102) range:NSMakeRange(2+length, 2)];
        
        _label.attributedText = str;
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"中奖号码%@",model.lottery_sn]];
        _label2.frame = [UIView setRectWithX:5 andY:103 andWidth:107 andHeight:9];
        _label2.font = [UIFont systemFontOfSize:9];
        NSInteger length1 = model.lottery_sn.length;
        [str1 addAttribute:NSForegroundColorAttributeName value:SF_COLOR(102, 102, 102) range:NSMakeRange(0, 4)];
        [str1 addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(4,length1)];
        _label2.attributedText = str1;
        
    }

}
@end
