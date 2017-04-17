//
//  MyDBBTableViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/30.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "MyDBBTableViewCell.h"
#import "UIView+CGSet.h"
@implementation MyDBBTableViewCell
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
- (void)reloadWithModel:(MyDBBModel *)model {
    NSRange rang;
    rang =[model.log_info rangeOfString:@"充值"];
    
    if (rang.location!=NSNotFound) {
        titlelabel.text = @"充值";
    }
    NSRange rang1;
    rang1 =[model.log_info rangeOfString:@"付款"];
    
    if (rang1.location!=NSNotFound) {
        titlelabel.text = @"消耗";
    }
    NSRange rang2;
    rang2 =[model.log_info rangeOfString:@"兑换"];
    
    if (rang2.location!=NSNotFound) {
        titlelabel.text = @"兑换";
    }
    
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:model.log_time.intValue];
//    NSLog(@"1363948516  = %@",confromTimesp);
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *strDate = [dateFormatter stringFromDate:confromTimesp];
    timelabel.text = model.log_time;
    NSString *str = @"-12";
    NSLog(@"%d",str.intValue);
    if (model.money.intValue >0) {
        moneylabel.textColor = SF_COLOR(255, 54, 93);
        moneylabel.text = [NSString stringWithFormat:@"+%d",model.money.intValue];
    }else {
        moneylabel.textColor = SF_COLOR(153, 153, 153);
        moneylabel.text = [NSString stringWithFormat:@"%d",model.money.intValue];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
