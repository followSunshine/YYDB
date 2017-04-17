//
//  FinderTableViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/5.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "FinderTableViewCell.h"
#import "UIView+CGSet.h"
#import "UIImageView+WebCache.h"

@implementation FinderTableViewCell
{
    UILabel *biaolabel;
    UILabel *strlabel;
    UIImageView *icon;
    UIView *view;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}
- (void)setUp {
    view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    
        view.frame = [UIView setRectWithX:0 andY:0 andWidth:375 andHeight:90];
    
    self.contentView.backgroundColor = SF_COLOR(242, 242, 242);
    biaolabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:111 andY:25 andWidth:200 andHeight:17]];
    biaolabel.font = [UIFont systemFontOfSize:17];
    biaolabel.textColor = SF_COLOR(34, 34, 34);
    
    [view addSubview:biaolabel];
    strlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:111 andY:52 andWidth:200 andHeight:13]];
    strlabel.font = [UIFont systemFontOfSize:13];
    
    strlabel.textColor = SF_COLOR(102, 102, 102);
    [view addSubview:strlabel];
    icon = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:11 andY:10 andWidth:84 andHeight:68]];
    icon.clipsToBounds = YES;
    icon.layer.cornerRadius = 4;
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(SWIDTH-[UIView setHeight:20]-[UIView setWidth:12], [UIView setHeight:30], [UIView setHeight:20], [UIView setHeight:20])];
    image.image = [UIImage imageNamed:@"灰箭头"];
    [view addSubview:image];
    [view addSubview:icon];
    UILabel *linlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:0.5]];
    linlabel.backgroundColor = SF_COLOR(232, 232, 232);

    [view addSubview:linlabel];
    UILabel *linlabel1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:89.5 andWidth:375 andHeight:0.5]];
    linlabel1.backgroundColor = SF_COLOR(232, 232, 232);
    [view addSubview:linlabel1];
    [self.contentView addSubview:view];
}
- (void)reloadWith:(FinderModel *)model {
    NSString *url = [NSString stringWithFormat:@"%@%@",urladress,model.img];
    [icon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"占位图"]];
    biaolabel.text = model.name;
    strlabel.text = model.descriptions;
    UITableView *table = (UITableView *)[self.superview superview];

    if ([table indexPathForCell:self].row == 0) {
        view.frame = [UIView setRectWithX:0 andY:16 andWidth:375 andHeight:90];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
