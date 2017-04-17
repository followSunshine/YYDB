//
//  ZhongjiangCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/21.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "ZhongjiangCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+CGSet.h"
@implementation ZhongjiangCell
{
    UIImageView *image;
    UILabel *titlelabel;
    UILabel *qihaolabel;
    UILabel *lucklabell;
    UILabel *timelabel;
    UILabel *stautslabel;
    UIButton *chakanBtn;
    UIButton *querenBtn;
    UIButton *wanshanBtn;
    NSString *woodid;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup {
    
    image = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:12], [UIView setHeight:31], [UIView setHeight:90], [UIView setHeight:90])];
    [self.contentView addSubview:image];
    titlelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:21 andWidth:351 andHeight:14]];
    titlelabel.textColor = SF_COLOR(102, 102, 102);
    
    titlelabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:titlelabel];
    
    qihaolabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setHeight:90]+[UIView setWidth:38], [UIView setHeight:40], [UIView setWidth:200], [UIView setHeight:12])];
    qihaolabel.textColor = SF_COLOR(153, 153, 153);
    qihaolabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:qihaolabel];
    lucklabell = [[UILabel alloc]initWithFrame:CGRectMake([UIView setHeight:90]+[UIView setWidth:38], [UIView setHeight:60], [UIView setWidth:200], [UIView setHeight:12])];
    lucklabell.textColor = SF_COLOR(153, 153, 153);
    lucklabell.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:lucklabell];
    timelabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setHeight:90]+[UIView setWidth:38], [UIView setHeight:80], [UIView setWidth:200], [UIView setHeight:12])];
    timelabel.textColor = SF_COLOR(153, 153, 153);
    timelabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:timelabel];
    stautslabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setHeight:90]+[UIView setWidth:38], [UIView setHeight:100], [UIView setWidth:200], [UIView setHeight:12])];
    stautslabel.textColor = SF_COLOR(153, 153, 153);
    stautslabel.font = [UIFont systemFontOfSize:12];
    stautslabel.text = @"奖品状态:";
    [self.contentView addSubview:stautslabel];
    
    chakanBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIView setHeight:90]+[UIView setWidth:38]+60, [UIView setHeight:100], [UIView setWidth:50], [UIView setHeight:12])];
    [chakanBtn setTitle:@"查看物流" forState:UIControlStateNormal];
    [chakanBtn addTarget:self action:@selector(chakan) forControlEvents:UIControlEventTouchUpInside];
    chakanBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [chakanBtn setTitleColor:SF_COLOR(102, 157, 241) forState:UIControlStateNormal];
    
    querenBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIView setHeight:90]+[UIView setWidth:38]+60+[UIView setWidth:50], [UIView setHeight:100], [UIView setWidth:50], [UIView setHeight:12])];
    [querenBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    [querenBtn addTarget:self action:@selector(queren) forControlEvents:UIControlEventTouchUpInside];
    querenBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [querenBtn setTitleColor:SF_COLOR(102, 157, 241) forState:UIControlStateNormal];
    
    wanshanBtn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:303 andY:80 andWidth:60 andHeight:10]];
    [wanshanBtn setTitle:@"完善地址" forState:UIControlStateNormal];
    [wanshanBtn addTarget:self action:@selector(wanshan) forControlEvents:UIControlEventTouchUpInside];
    wanshanBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [wanshanBtn setTitleColor:SF_COLOR(102, 157, 241) forState:UIControlStateNormal];
    
    UILabel *line = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:127.5 andWidth:375 andHeight:0.5]];
    line.backgroundColor = SF_COLOR(232, 232, 232);
    [self.contentView addSubview:line];
}
- (void)chakan {
    NSNotification *noti = [[NSNotification alloc]initWithName:@"zhongjiangjilu" object:nil userInfo:@{@"status":@"1",@"woodid":woodid}];
    [[NSNotificationCenter defaultCenter] postNotification:noti];
}
- (void)wanshan {
    NSNotification *noti = [[NSNotification alloc]initWithName:@"zhongjiangjilu" object:nil userInfo:@{@"status":@"3",@"woodid":woodid}];
    [[NSNotificationCenter defaultCenter] postNotification:noti];
}
- (void)queren {
    NSNotification *noti = [[NSNotification alloc]initWithName:@"zhongjiangjilu" object:nil userInfo:@{@"status":@"2",@"woodid":woodid}];
    [[NSNotificationCenter defaultCenter] postNotification:noti];
    
    [querenBtn removeFromSuperview ];
    [chakanBtn removeFromSuperview];
}
- (void)reloaddataWith:(Zhongjiangjilu *)model {
    woodid = model.id;
    titlelabel.text = model.name;
    qihaolabel.text = [NSString stringWithFormat:@"参与期号：%@",model.duobao_item_id];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"幸运号码：%@",model.lottery_sn]];
    [image sd_setImageWithURL:[NSURL URLWithString:model.deal_icon]];

    [str addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255,54,96) range:NSMakeRange(5,model.lottery_sn.length)];
    
    lucklabell.attributedText = str;
    
    timelabel.text = [NSString stringWithFormat:@"下单时间：%@",model.create_time];

    if ([model.delivery_status isEqualToString:@"5"]) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"状态：无需发货"];
        [str addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255,54,96) range:NSMakeRange(3,4)];
        stautslabel.attributedText = str;
    }
    if ([model.delivery_status isEqualToString:@"0"]) {
        if ([model.region_status isEqualToString:@"0"]) {  NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"状态：请完善收货地址，否则奖品在7天后失效"];
            [str addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255,54,96) range:NSMakeRange(3,18)];
            stautslabel.attributedText = str;
            [self.contentView addSubview:wanshanBtn];
        }else {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"状态：未发货"];
            [str addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255,54,96) range:NSMakeRange(3,3)];
            stautslabel.attributedText = str;
        }
    }
    if ([model.is_arrival isEqualToString:@"0"]&&[model.delivery_status isEqualToString:@"1"]) {
        [self.contentView addSubview:querenBtn];
        [self.contentView addSubview:chakanBtn];
    }
    if ([model.is_arrival isEqualToString:@"1"]) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"状态：已收货"];
        [str addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255,54,96) range:NSMakeRange(3,3)];
        stautslabel.attributedText = str;

    }if ([model.is_arrival isEqualToString:@"2"]) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:@"状态：维权中"];
        [str addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255,54,96) range:NSMakeRange(3,3)];
        stautslabel.attributedText = str;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
