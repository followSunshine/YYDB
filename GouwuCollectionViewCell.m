//
//  GouwuCollectionViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/16.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "GouwuCollectionViewCell.h"
#import "YSProgressView.h"
#import "UIView+CGSet.h"
#import "UIImageView+WebCache.h"
@implementation GouwuCollectionViewCell
{
    UIImageView *imageview;
    UILabel *label;
    YSProgressView *progress;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        [self setUp];
    }
    
    return self;
}
- (void)setUp {
    
    imageview= [[UIImageView alloc]initWithFrame:[UIView setRectWithX:0 andY:6.5 andWidth:107 andHeight:107]];
    
    label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:125 andWidth:107 andHeight:12]];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:imageview];
    [self addSubview:label];
    progress = [[YSProgressView alloc]initWithFrame:[UIView setRectWithX:0 andY:142 andWidth:107 andHeight:5]];
    [self addSubview:progress];
    progress.progressTintColor = SF_COLOR(229, 229, 229);
    progress.trackTintColor = SF_COLOR(255, 196, 126);
    
    
}
- (void)reloadWithModel:(TJModel *)model {
    label.text= model.name;
    progress.progressValue = progress.frame.size.width*(model.progress.intValue/100.0);
    NSString *str = [NSString stringWithFormat:@"%@%@",urladress,model.icon];
    [imageview sd_setImageWithURL:[NSURL URLWithString:str]];
}
@end
