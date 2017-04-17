//
//  GoodsCollectionViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/8/30.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "GoodsCollectionViewCell.h"
#import "UIView+CGSet.h"
@implementation GoodsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup {
    self.tenImage = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:17 andY:0 andWidth:24 andHeight:29]];
    
    
    self.imageView = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:33.25 andY:10 andWidth:120 andHeight:120]];
    [self.contentView addSubview:self.imageView];
    
    self.need_num_label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:11.25 andY:138 andWidth:165 andHeight:30]];
    
    self.left_num_label =[[UILabel alloc]initWithFrame:[UIView setRectWithX:11.25 andY:171 andWidth:100 andHeight:12]];
    
//    self.left_num_label.backgroundColor = [UIColor redColor];
    
    self.need_num_label.font = [UIFont systemFontOfSize:11];
    self.need_num_label.textColor = SF_COLOR(51, 51, 51);
    self.need_num_label.numberOfLines = 0;
    self.need_num_label.lineBreakMode = NSLineBreakByWordWrapping;
    self.left_num_label.font = [UIFont systemFontOfSize:12];

    
    self.addPlistBtn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:121.25 andY:169 andWidth:55 andHeight:24]];
    
    [self.addPlistBtn.layer setBorderColor:SF_COLOR(255, 54, 93).CGColor];//边框颜色
    
    [self.addPlistBtn setTitleColor:SF_COLOR(255, 54, 93) forState:UIControlStateNormal];
    UICollectionView *cv =(UICollectionView *)[self superview];
    NSIndexPath *indexpath = [cv indexPathForCell:self];
    
    self.addPlistBtn.tag = indexpath.row + 593;
    [self.addPlistBtn addTarget:self action:@selector(addplist) forControlEvents:UIControlEventTouchUpInside];

    
    self.addPlistBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.addPlistBtn.layer setMasksToBounds:YES];
    [self.addPlistBtn.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [self.addPlistBtn.layer setBorderWidth:1.0]; //边框宽度
    
    [self.addPlistBtn setTitle:@"加入清单" forState:UIControlStateNormal];
    
    [self.contentView addSubview:self.need_num_label];
    
    [self.contentView addSubview:self.left_num_label];
    
    [self.contentView addSubview:self.addPlistBtn];
    
    self.prog = [[YSProgressView alloc]initWithFrame:[UIView setRectWithX:11.25 andY:191 andWidth:100 andHeight:5]];
    self.prog.progressTintColor = SF_COLOR(229, 229, 229);
    self.prog.trackTintColor = SF_COLOR(255, 196, 126);
    [self.contentView addSubview:self.prog];
}
- (void)addplist {
    
    UICollectionView *cv =(UICollectionView *)[self superview];
    NSIndexPath *indexpath = [cv indexPathForCell:self];
    
    NSString *str = [NSString stringWithFormat:@"%ld",(long)indexpath.row];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:str,@"index",nil];
    
    NSNotification *nf = [NSNotification notificationWithName:@"addplist" object:nil userInfo:dic];
    
    [[NSNotificationCenter defaultCenter] postNotification:nf];
}

- (void)addDataWithModel:(WoodsModle *)model{
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urladress,model.icon]]];
    int b =  model.price.intValue * model.min_buy.intValue;
    if (b==10) {
        self.tenImage.image = [UIImage imageNamed:@"十元-专区"];
        [self.contentView addSubview:self.tenImage];

    }else if (b==100) {
        [self.contentView addSubview:self.tenImage];

        self.tenImage.image = [UIImage imageNamed:@"百元-专区"];
    }else {
        [self.tenImage removeFromSuperview];
    }
    
    self.need_num_label.text = model.name;
    
    NSString *str = [NSString stringWithFormat:@"%@%%",model.progress];
    
    NSString *str1 = [NSString stringWithFormat:@"开奖进度%@",str];
    
    NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:str1];
    [str2 addAttribute:NSForegroundColorAttributeName value:SF_COLOR(102, 102, 102) range:NSMakeRange(0, 4)];

    [str2 addAttribute:NSForegroundColorAttributeName value:SF_COLOR(102, 154, 241) range:NSMakeRange(4, str.length)];
    
    self.left_num_label.attributedText = str2;
    
    float a = model.progress.floatValue/100;
    
    
    [self.prog setProgressValue:a*self.prog.frame.size.width ];
}
@end
