//
//  luckCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/22.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "luckCell.h"
#import "luckModel.h"
#import "UIImageView+WebCache.h"
#import "UIView+CGSet.h"
@implementation luckCell
{
    UIImageView *imageview;
    UILabel *titlelabel;
    UILabel *qihaolabel;
    UIButton *shaidanBtn;
    UILabel *timelabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void) setup{
    imageview = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:12 andY:9 andWidth:77 andHeight:77]];
    
    [self.contentView addSubview:imageview];
    
    titlelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:100 andY:9 andWidth:263 andHeight:35]];
    titlelabel.lineBreakMode = NSLineBreakByWordWrapping;
    titlelabel.numberOfLines = 0;
    titlelabel.font = [UIFont systemFontOfSize:14];
    titlelabel.textColor = SF_COLOR(102, 102, 102);
    
    [self.contentView addSubview:titlelabel];
    
    qihaolabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:100 andY:53 andWidth:190 andHeight:12]];
    qihaolabel.font = [UIFont systemFontOfSize:12];
    qihaolabel.textColor = SF_COLOR(153, 153, 153);
    
    [self.contentView addSubview:qihaolabel];
    timelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:100 andY:74 andWidth:190 andHeight:12]];
    timelabel.textColor = SF_COLOR(153, 153, 153);
    timelabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:timelabel];
    
    
    shaidanBtn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:298 andY:53 andWidth:65 andHeight:28]];
    shaidanBtn.backgroundColor = SF_COLOR(255, 54, 93);
    [shaidanBtn setTitle:@"我要晒单" forState:UIControlStateNormal];
    shaidanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [shaidanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shaidanBtn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:shaidanBtn];
    shaidanBtn.clipsToBounds = YES;
    shaidanBtn.layer.cornerRadius = 4;
    
}
- (void)btnclick {
    
    UITableView *table = (UITableView *)[self.superview superview];
    
    NSIndexPath *index = [table indexPathForCell:self];
    
    NSNotification *no = [NSNotification notificationWithName:@"shainow" object:nil userInfo:@{@"index":index}];
    [[NSNotificationCenter defaultCenter] postNotification:no];
}
- (void)reloadwith:(luckModel *)model {
    titlelabel.text = model.name;
    NSString *str =[NSString stringWithFormat:@"幸运号码：%@",model.lottery_sn];
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:str];
    [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(5, model.lottery_sn.length)];
    qihaolabel.attributedText = mstr;
    NSDateFormatter *matter = [[NSDateFormatter alloc]init];
    matter.dateFormat =@"YYYY-MM-dd HH:mm";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.create_time intValue]];
    NSString*timeStr = [matter stringFromDate:date];
    
    timelabel.text =timeStr;
    
    NSString *url = [NSString stringWithFormat:@"%@%@",urladress,model.deal_icon];
    [imageview sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"%@",error);
    }];
}
/*
 struct utsname systemInfo;
 uname(&systemInfo);
 [getTime deleteCharactersInRange:NSMakeRange(10,3)];
 
 NSDateFormatter *matter = [[NSDateFormatteralloc]init];
 matter.dateFormat =@"YYYY-MM-dd HH:mm";
 NSDate *date = [NSDatedateWithTimeIntervalSince1970:[getTime intValue]];
 NSString*timeStr = [matter stringFromDate:date];
 NSLog(@"%@",timeStr);//2016-04-29 10:23

 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
