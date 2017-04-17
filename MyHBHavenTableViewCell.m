//
//  MyHBHavenTableViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/29.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "MyHBHavenTableViewCell.h"
#import "UIView+CGSet.h"

@implementation MyHBHavenTableViewCell
{
    UILabel *titlelabel;
    UILabel *clabel;
    UILabel *mmlabel;
    UILabel *mlabel;
    UIImageView *havenImageview;
    UIImageView *bgview;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup{
    self.contentView.backgroundColor = SF_COLOR(242, 242, 242);
    UITableView *table = (UITableView *)[self.superview superview];
    NSIndexPath *index = [table indexPathForCell:self];
    NSLog(@"%ld",(long)index.row);
    
    bgview = [[UIImageView alloc]init];
    if (index.row==0) {
        bgview.frame = [UIView setRectWithX:12 andY:16 andWidth:351 andHeight:120];
    }else {
        bgview.frame = [UIView setRectWithX:12 andY:8 andWidth:351 andHeight:120];
    }
    bgview.image = [UIImage imageNamed:@"红包背景"];
    [self.contentView addSubview:bgview];
    titlelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:19 andY:40 andWidth:150 andHeight:18]];
    titlelabel.text = @"邀请好友红包";
    titlelabel.textColor = SF_COLOR(255, 54, 93);
    titlelabel.font = [UIFont systemFontOfSize:18];
    [bgview addSubview:titlelabel];
    
    UILabel *dian = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:19], [UIView setHeight:75.5], [UIView setHeight:4], [UIView setHeight:4])];
    dian.backgroundColor = SF_COLOR(102, 102, 102);
    dian.layer.cornerRadius = [UIView setHeight:2];
    dian.clipsToBounds = YES;
    [bgview addSubview:dian];
    
    clabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dian.frame)+[UIView setWidth:5], 72, 250, 11)];
    clabel.font = [UIFont systemFontOfSize:11];
    clabel.textColor = SF_COLOR(102, 102, 102);
    clabel.text = @"您的好友xxx完成十元充值";
    [bgview addSubview:clabel];
    
    
    UILabel *dian1 = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:19], [UIView setHeight:75.5+17], [UIView setHeight:4], [UIView setHeight:4])];
    dian1.backgroundColor = SF_COLOR(102, 102, 102);
    dian1.layer.cornerRadius = [UIView setHeight:2];
    dian1.clipsToBounds = YES;
    [bgview addSubview:dian1];
    
    UILabel *clabel1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dian.frame)+[UIView setWidth:5], 72+17, 200, 11)];
    clabel1.font = [UIFont systemFontOfSize:11];
    clabel1.textColor = SF_COLOR(102, 102, 102);
    clabel1.text = @"仅适用于在支付环节进行金额抵扣";
    [bgview addSubview:clabel1];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:240 andY:35 andWidth:1 andHeight:70]];
    imageview.image = [self drawLineByImageView:imageview];
    [bgview addSubview:imageview];
    
    mlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:240 andY:35 andWidth:110 andHeight:40]];
    mlabel.textColor = SF_COLOR(255, 54, 93);
    mlabel.textAlignment = NSTextAlignmentCenter;
    
    NSString *str = @"￥2";
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:str];
    [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
    [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:44] range:NSMakeRange(1, 1)];
    mlabel.attributedText = mstr;
    [bgview addSubview:mlabel];
    
    mmlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:240 andY:80 andWidth:110 andHeight:25]];
    mmlabel.text = @"满十元起用";
    mmlabel.font = [UIFont systemFontOfSize:11];
    mmlabel.textColor = SF_COLOR(102, 102, 102);
    mmlabel.textAlignment = NSTextAlignmentCenter;
    [bgview addSubview:mmlabel];
    
    havenImageview = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:199 andY:42 andWidth:70 andHeight:70]];
    havenImageview.image = [UIImage imageNamed:@"已使用"];
    [bgview addSubview:havenImageview];
    
}
- (UIImage *)drawLineByImageView:(UIImageView *)imageView{
    UIGraphicsBeginImageContext(imageView.frame.size); //开始画线 划线的frame
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    //设置线条终点形状
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    // 5是每个虚线的长度 1是高度
    CGFloat lengths[] = {5,2};
    CGContextRef line = UIGraphicsGetCurrentContext();
    // 设置颜色
    CGContextSetStrokeColorWithColor(line, SF_COLOR(153, 153, 153).CGColor);
    CGContextSetLineDash(line, 0, lengths, 2); //画虚线
    CGContextMoveToPoint(line, 0.0, 2.0); //开始画线
    CGContextAddLineToPoint(line, 0.0, [UIView setHeight:70]);
    
    CGContextStrokePath(line);
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}
- (void)reloadwith:(JSONModel *)model {
    HBModel *hbmodel = (HBModel *)model;
    titlelabel.text = hbmodel.name;
    NSString *str = hbmodel.total_money;
    int a = str.intValue;
    clabel.text = [NSString stringWithFormat:@"您的好友%@完成%d元充值",hbmodel.child_name,a];
    NSString *hnmoney = hbmodel.money;
    int b = hnmoney.intValue;
    NSString *str1 = [NSString stringWithFormat:@"￥%d",b];
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:str1];
    [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
    [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:44] range:NSMakeRange(1, str1.length-1)];
    mlabel.attributedText = mstr;
    NSString *limit = hbmodel.make_limit;
    int c = limit.intValue;
    mmlabel.text = [NSString stringWithFormat:@"满%d元起用",c];
    
    NSString *status = hbmodel.status;
    if (status.intValue==0) {
        
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
