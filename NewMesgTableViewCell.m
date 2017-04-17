//
//  NewMesgTableViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/12/21.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "NewMesgTableViewCell.h"
#import "UIView+CGSet.h"
@implementation NewMesgTableViewCell
{
    UILabel *timelabel;
    UILabel *contentLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUP];
    }
    return self;
}
- (void)setUP {
    UIView *view = [[UIView alloc]initWithFrame:[UIView setRectWithX:12 andY:16 andWidth:351 andHeight:100]];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 5;
    view.clipsToBounds = YES;
    [self.contentView addSubview:view];
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:10 andY:0 andWidth:60 andHeight:35]];
    titlelabel.font = [UIFont systemFontOfSize:15];
    titlelabel.textColor = SF_COLOR(51, 51, 51);
    titlelabel.text = @"通知消息";
    
    [view addSubview:titlelabel];
    
    timelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:70 andY:0 andWidth:100 andHeight:35]];
    timelabel.font = [UIFont systemFontOfSize:11];
    timelabel.textColor = SF_COLOR(153, 153, 153);
    [view addSubview:timelabel];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake([UIView setWidth:340]-[UIView setHeight:20], [UIView setHeight:8], [UIView setHeight:20], [UIView setHeight:20])];
    [btn setBackgroundImage:[UIImage imageNamed:@"消息中心-垃圾桶"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    UILabel *line = [[UILabel alloc]initWithFrame:[UIView setRectWithX:10 andY:34.5 andWidth:331 andHeight:0.5]];
    line.backgroundColor = SF_COLOR(229, 229, 229);
    [view addSubview:line];
    
    contentLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:10 andY:43 andWidth:331 andHeight:51]];
    contentLabel.textColor = SF_COLOR(102, 102, 102);
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [view addSubview:contentLabel];
}
- (void)reloadWithModel:(MesageModel *)model {
    timelabel.text = model.create_time;
    contentLabel.text = model.content;
    if (model.icon.length) {
        contentLabel.text = [NSString stringWithFormat:@"%@",model.content];
    }
}
- (void)btnclick {
    
    UITableView *table = (UITableView *)[[self superview]superview];
    NSIndexPath *index = [table indexPathForCell:self];
    
    NSNotification *nf = [NSNotification notificationWithName:@"delcell" object:nil userInfo:@{@"row":index}];
    [[NSNotificationCenter defaultCenter] postNotification:nf];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
