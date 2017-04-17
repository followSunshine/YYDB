//
//  ShowTableViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/12/9.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "ShowTableViewCell.h"
#import "UIView+CGSet.h"
#import "UIImageView+WebCache.h"
@implementation ShowTableViewCell
{
    UIImageView *headImage;
    UILabel *titleLabel;
    UILabel *namelabel;
    UILabel *woodsLabel;
    UILabel *contentLabel;
    UILabel *timelabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        [self setUP];
    }
    return self;
}
- (void)setUP {
    headImage = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:12], [UIView setHeight:16], [UIView setWidth:44], [UIView setWidth:44])];
    headImage.layer.cornerRadius = [UIView setWidth:22];
    headImage.clipsToBounds = YES;
    headImage.image = [UIImage imageNamed:@"qicon"];
    [self.contentView addSubview:headImage];
    
    namelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:64 andY:21 andWidth:300 andHeight:15]];
    namelabel.textColor = SF_COLOR(102, 154, 241);
    namelabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:namelabel];
    
    timelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:200 andY:21 andWidth:163 andHeight:15]];
    timelabel.textColor = SF_COLOR(153, 153, 153);
    timelabel.font = [UIFont systemFontOfSize:12];
    timelabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:timelabel];
    
    
    titleLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:64 andY:49 andWidth:300 andHeight:14]];
    titleLabel.textColor = SF_COLOR(51, 51, 51);
    titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:titleLabel];
    
    woodsLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:64 andY:71 andWidth:300 andHeight:12]];
    woodsLabel.textColor = SF_COLOR(153, 153, 153);
    woodsLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:woodsLabel];
    
    contentLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:64 andY:88 andWidth:300 andHeight:30]];
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.textColor = SF_COLOR(51, 51, 51);
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:contentLabel];
    
    for (int i = 0; i < 4; i++) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:64]+i*[UIView setWidth:76], [UIView setHeight:126], [UIView setWidth:70], [UIView setWidth:70])];
        imageview.tag = 800+i;
        
        [self.contentView addSubview:imageview];
    }
    
    UIImageView *jiantou = [[UIImageView alloc]initWithFrame:CGRectMake(SWIDTH-[UIView setWidth:16]-[UIView setHeight:10], [UIView setHeight:137]+[UIView setWidth:70], [UIView setHeight:10], [UIView setHeight:10])];
    jiantou.image = [UIImage imageNamed:@"红箭头"];
    [self.contentView addSubview:jiantou];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, [UIView setHeight:136]+[UIView setWidth:70], SWIDTH-[UIView setHeight:10]-[UIView setWidth:16], [UIView setHeight:12])];
    label.textColor = SF_COLOR(255, 54, 93);
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentRight;
    label.userInteractionEnabled = YES;
    label.text = @"试试手气";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick:)];
    [label addGestureRecognizer:tap];
    [self.contentView addSubview:label];
    UILabel *linelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:221.5 andWidth:375 andHeight:0.3]];
    linelabel.backgroundColor = SF_COLOR(242, 242, 242);
    [self.contentView addSubview:linelabel];
}
- (void)tapclick:(UITapGestureRecognizer *)tap {
    UITableView *table = (UITableView *)[self.superview superview];
    NSIndexPath *index = [table indexPathForCell:self];
    NSLog(@"%@",index);
    NSNotification *n = [NSNotification notificationWithName:@"indexno" object:nil userInfo:@{@"index":index}];
    [[NSNotificationCenter defaultCenter] postNotification:n];
    
}
- (void)reloadWithModel:(ShowModel *)model {
    [headImage sd_setImageWithURL:[NSURL URLWithString:model.user_avatar]];
    titleLabel.text = model.title;
    namelabel.text = model.user_name;
    timelabel.text = model.create_time;
    contentLabel.text = model.content;
    ShowModel2 *str = model.duobao_item;
    woodsLabel.text =str.name;
    for (int i = 0; i < model.image_list.count; i++) {
        UIImageView *imageview = (UIImageView *)[self.contentView viewWithTag:800+i];
        ShowModle1 *model1 = model.image_list[i];
        NSString *url = model1.o_path;
        NSString *str = [NSString stringWithFormat:@"%@%@",urladress,url];
        [imageview sd_setImageWithURL:[NSURL URLWithString:str]];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
