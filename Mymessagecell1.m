//
//  Mymessagecell1.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/19.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "Mymessagecell1.h"

@implementation Mymessagecell1
{
    UILabel *label2;
    UILabel *label1;
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
    UITableView *table = (UITableView *)[[self superview]superview];
    NSIndexPath *index = [table indexPathForCell:self];
    NSLog(@"%@",index);
    UIView *view = [[UIView alloc]initWithFrame:[UIView getRectWithX:3 andY:3 andWidth:320-6 andHeight:60-3]];
    view.backgroundColor = SF_COLOR(238, 238, 238);
    [self.contentView addSubview:view];
    
        UIImageView *image = [[UIImageView alloc]initWithFrame:[UIView getRectWithX:10 andY:10 andWidth:30 andHeight:30]];
    image.image = [UIImage imageNamed:@"通知消息"];
    [view addSubview:image];
    label1 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:50 andY:0 andWidth:240 andHeight:40]];
    label1.font = [UIFont systemFontOfSize:13];
    label1.lineBreakMode = NSLineBreakByWordWrapping;
    label1.numberOfLines = 0;
    [view addSubview:label1];
    label2=  [[UILabel alloc]initWithFrame:[UIView getRectWithX:50 andY:40 andWidth:100 andHeight:10]];
    label2.font = [UIFont systemFontOfSize:10];
    label2.textColor = SF_COLOR(167, 167, 167);
    [view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:280 andY:30 andWidth:30 andHeight:30]];
    label3.text = @"\ue68d";
    label3.textAlignment = NSTextAlignmentRight;
    label3.font = [UIFont fontWithName:@"iconfont" size:20];
    label3.textColor = SF_COLOR(255, 54, 93);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
    label3.userInteractionEnabled = YES;
    [label3 addGestureRecognizer:tap];
    [view addSubview:label3];
    label1.textColor = SF_COLOR(53, 53, 53);
    
}
- (void)rloadwith:(MesageModel *)model {
    
    label1.text = model.content;
    label2.text = model.create_time;
    
}
- (void)click:(UITapGestureRecognizer *)tap {
    
    UITableView *table = (UITableView *)[[self superview]superview];
    NSIndexPath *index = [table indexPathForCell:self];
    
    NSNotification *nf = [NSNotification notificationWithName:@"deletecell" object:nil userInfo:@{@"row":index}];
    [[NSNotificationCenter defaultCenter] postNotification:nf];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
