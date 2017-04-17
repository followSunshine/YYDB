//
//  DizhiCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/20.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "DizhiCell.h"
#import "UIView+CGSet.h"
@implementation DizhiCell
{
    UILabel *namelabel;
    UILabel *addresslabel;
    UILabel *phonelabel;
    UILabel *region_addresslabel;
    UIButton *delbtn;
    UIButton *editbtn;
    UIButton *defbtn;
    UIImageView *image;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    namelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:13 andWidth:351 andHeight:16]];
    namelabel.font = [UIFont systemFontOfSize:16];
    namelabel.textColor = SF_COLOR(51, 51, 51);
    [self.contentView addSubview:namelabel];
    
    
    
    phonelabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:10 andY:20 andWidth:300 andHeight:15]];
    phonelabel.font = [UIFont systemFontOfSize:14];
    phonelabel.textColor = SF_COLOR(93, 93, 93);
//    [self.contentView addSubview:phonelabel];
    phonelabel.text = @"123123123";
    
    region_addresslabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:10 andY:35 andWidth:300 andHeight:15]];
    region_addresslabel.font = [UIFont systemFontOfSize:14];
    region_addresslabel.textColor = SF_COLOR(93, 93, 93);
//    [self.contentView addSubview:region_addresslabel];
    region_addresslabel.text = @"123 2123 1231223";
    
    addresslabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:40 andWidth:351 andHeight:13]];
    addresslabel.font = [UIFont systemFontOfSize:13];
    addresslabel.textColor = SF_COLOR(102, 102, 102);
    [self.contentView addSubview:addresslabel];
    
    UILabel *linelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:62.5 andWidth:375 andHeight:0.5]];
    linelabel.backgroundColor = SF_COLOR(242, 242, 242);
    [self.contentView addSubview:linelabel];
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:251 andY:70.5 andWidth:22 andHeight:22]];
    image1.image = [UIImage imageNamed:@"编辑"];
    [self.contentView addSubview:image1];
    
    
    
    editbtn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:273 andY:63 andWidth:40 andHeight:37]];
    
    editbtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [editbtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editbtn setTitleColor:SF_COLOR(153, 153, 153) forState:UIControlStateNormal];
    [editbtn addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:editbtn];
    
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:313 andY:70.5 andWidth:22 andHeight:22]];
    image2.image = [UIImage imageNamed:@"地址-垃圾桶"];
    [self.contentView addSubview:image2];
    

    
    
    delbtn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:335 andY:63 andWidth:40 andHeight:37]];
    
    delbtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [delbtn setTitle:@"删除" forState:UIControlStateNormal];
    [delbtn setTitleColor:SF_COLOR(153, 153, 153) forState:UIControlStateNormal];
    [delbtn addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:delbtn];
 
    
    image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:12 andY:71.5 andWidth:20 andHeight:20]];
    [self.contentView addSubview:image];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click3)];
    image.userInteractionEnabled = YES;
    [image addGestureRecognizer:tap];
    
    
    defbtn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:32 andY:63 andWidth:65 andHeight:37]];
    defbtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [defbtn setTitle:@"默认地址" forState:UIControlStateNormal];
    [defbtn setTitleColor:SF_COLOR(153, 153, 153) forState:UIControlStateNormal];
    [defbtn addTarget:self action:@selector(click3) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:defbtn];
    
    UILabel *linelabel1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:99.5 andWidth:375 andHeight:0.5]];
    linelabel1.backgroundColor = SF_COLOR(232, 232, 232);
    [self.contentView addSubview:linelabel1];
    
    UIView *bgview = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:100 andWidth:375 andHeight:10]];
    bgview.backgroundColor = SF_COLOR(242, 242, 242);
    [self.contentView addSubview:bgview];
}
- (void)click1 {
    UITableView *tb = (UITableView *)self.superview.superview;
    NSIndexPath *i = [tb indexPathForCell:self];
    NSNotification *nf = [NSNotification notificationWithName:@"dizhiclick" object:nil userInfo:@{@"num":@"1",@"row":i}];
    [[NSNotificationCenter defaultCenter] postNotification:nf];
}
- (void)click2 {
    UITableView *tb = (UITableView *)self.superview.superview;
    NSIndexPath *i = [tb indexPathForCell:self];
    NSNotification *nf = [NSNotification notificationWithName:@"dizhiclick" object:nil userInfo:@{@"num":@"2",@"row":i}];
    [[NSNotificationCenter defaultCenter] postNotification:nf];

}
- (void)click3 {
    UITableView *tb = (UITableView *)self.superview.superview;
    NSIndexPath *i = [tb indexPathForCell:self];
    NSNotification *nf = [NSNotification notificationWithName:@"dizhiclick" object:nil userInfo:@{@"num":@"3",@"row":i}];
    [[NSNotificationCenter defaultCenter] postNotification:nf];
    defbtn.userInteractionEnabled = NO;
}
- (void)reloadwith:(DizhiModel *)model{
    
    namelabel.text = [NSString stringWithFormat:@"%@   %@",model.consignee,model.mobile];
    addresslabel.text = model.address;
    
    if ([model.is_default isEqualToString:@"1"]) {
        [defbtn setTitle:@"默认地址" forState:UIControlStateNormal];
        defbtn.userInteractionEnabled = NO;
        image.image = [UIImage imageNamed:@"默认地址"];
    }else {
        [defbtn setTitle:@"设为默认" forState:UIControlStateNormal];

        defbtn.userInteractionEnabled = YES;
        image.image = [UIImage imageNamed:@"设为默认"];

        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
