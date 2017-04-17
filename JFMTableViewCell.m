//
//  JFMTableViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/30.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "JFMTableViewCell.h"
#import "UIView+CGSet.h"

@implementation JFMTableViewCell
{
    UILabel *titlelabel;
    UILabel *timelabel;
    UILabel *moneylabel;
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
- (void)setup {
    titlelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:15 andY:8 andWidth:100 andHeight:15]];
    titlelabel.font = [UIFont systemFontOfSize:15];
    titlelabel.textColor = SF_COLOR(102, 102, 102);
    [self.contentView addSubview:titlelabel];
    timelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:15 andY:28 andWidth:200 andHeight:9]];
    timelabel.textColor = SF_COLOR(153, 153, 153);
    timelabel.font = [UIFont systemFontOfSize:9];
    
    moneylabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:259 andY:0 andWidth:100 andHeight:44]];
    moneylabel.font = [UIFont systemFontOfSize:15];
    moneylabel.textAlignment = NSTextAlignmentRight;
    UILabel *linelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:43.5 andWidth:363 andHeight:0.5]];
    linelabel.backgroundColor = SF_COLOR(204, 204, 204);
    [self.contentView addSubview:linelabel];
    [self.contentView addSubview:timelabel];
    [self.contentView addSubview:moneylabel];
    
    
}

- (void)reloadWithModel:(JFModel *)model {
    NSRange rang;
    rang =[model.log_info rangeOfString:@"夺宝活动"];
    
    if (rang.location!=NSNotFound) {
        titlelabel.text = @"参与夺宝活动";
    }
    NSRange rang1;
    rang1 =[model.log_info rangeOfString:@"完善个人信息"];
    
    if (rang1.location!=NSNotFound) {
        titlelabel.text = @"完善个人信息";
    }
    NSRange rang2;
    rang2 =[model.log_info rangeOfString:@"夺宝币"];
    
    if (rang2.location!=NSNotFound) {
        titlelabel.text = @"兑换夺宝币";
    }
    NSRange rang3;
    rang3 =[model.log_info rangeOfString:@"完善收货地址"];
    
    if (rang3.location!=NSNotFound) {
        titlelabel.text = @"完善收货地址";
    }
    NSRange rang4;
    rang4 =[model.log_info rangeOfString:@"兑换"];
    
    if (rang4.location!=NSNotFound) {
        titlelabel.text = @"兑换";
    }
    NSRange rang5;
    rang5 =[model.log_info rangeOfString:@"完成分享"];
    
    if (rang5.location!=NSNotFound) {
        titlelabel.text = @"完成分享";
    }
    
    NSRange rang6;
    rang6 =[model.log_info rangeOfString:@"签到成功"];
    
    if (rang6.location!=NSNotFound) {
        titlelabel.text = @"签到成功";
    }
//    
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.log_time.intValue];
//    NSLog(@"1363948516  = %@",confromTimesp);
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *strDate = [dateFormatter stringFromDate:confromTimesp];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy:MM:dd HH:mm"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[model.log_time doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];

    timelabel.text = dateString;
    if (model.score.intValue >0) {
        moneylabel.textColor = SF_COLOR(255, 54, 93);
        moneylabel.text = [NSString stringWithFormat:@"+%d",model.score.intValue];
    }else {
        moneylabel.textColor = SF_COLOR(153, 153, 153);
        moneylabel.text = [NSString stringWithFormat:@"%d",model.score.intValue];
    }
    
}
@end
