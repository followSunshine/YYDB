//
//  CollectionViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/9/8.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIImageView+WebCache.h"
#define SELFH ([UIScreen mainScreen].bounds.size.height-49-64)/2

#define SELFW [UIScreen mainScreen].bounds.size.width/2
@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup {
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH/2, SELFH/2)];
    
    [self.contentView addSubview:self.imageView];
    
    self.nmaeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, SELFH/2, SELFW, SELFH/8)];
    
    self.nmaeLabel.font = [UIFont boldSystemFontOfSize:14];
    
    self.nmaeLabel.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(12.0)];

    self.nmaeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    self.nmaeLabel.numberOfLines = 0;
    
    self.nmaeLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:self.nmaeLabel];
    
    NSArray *arr = @[@"期      号:",@"获 奖  者:",@"参与人次:",@"幸运号码:",@"揭晓时间:"];
    for (int i = 0; i < 5; i++) {
        
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(8, SELFH/2 + SELFH/8 + i*SELFH*3/40, SELFW/3, SELFH*3/40)];
        
        
        
        
        NSString *str = arr[i];
        
        NSMutableAttributedString *muAttrString = [[NSMutableAttributedString alloc]initWithString:str];
        
        NSMutableParagraphStyle *paragtaphStyle = [[NSMutableParagraphStyle alloc]init];
        paragtaphStyle.alignment = NSTextAlignmentJustified;
        paragtaphStyle.paragraphSpacing = 10.0;
        paragtaphStyle.paragraphSpacingBefore = 10;
        paragtaphStyle.firstLineHeadIndent = 0.0;
        paragtaphStyle.headIndent = 0.0;
        
        NSDictionary *dic =@{
                             NSForegroundColorAttributeName:[UIColor blackColor],
                             NSParagraphStyleAttributeName:paragtaphStyle,
                             NSFontAttributeName:[UIFont systemFontOfSize:10],
                             NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone]
                             
                             };
        
        [muAttrString setAttributes:dic range:NSMakeRange(0, muAttrString.length)];
        
        NSAttributedString *attrString = [muAttrString copy];
        
        leftLabel.attributedText = attrString;
        
        [self.contentView addSubview:leftLabel];
        
        
        UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftLabel.frame), SELFH/2 +i*SELFH*3/40 +SELFH/8,SELFW - CGRectGetMaxX(leftLabel.frame) - 8, SELFH*3/40)];
        
        rightLabel.tag = 1000+i;
        
        rightLabel.font = [UIFont systemFontOfSize:10];
        
        if (i == 1) {
            rightLabel.textColor = [UIColor blueColor];
        }else if (i == 3){
            
            rightLabel.textColor = [UIColor redColor];
        }
        
        [self.contentView addSubview:rightLabel];
        
    }
    

}
- (void)reloadDataWithModel:(PublishModel *)model {
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    
    for (int i = 0; i < 5; i++) {
        UILabel *label = (UILabel *)[self.contentView viewWithTag:1000+i];
        if (i == 0) {
            label.text = model.userid;
            
        } else if(i==1){
            label.text = model.luck_user_name;
            
        }else if (i==2){
            
            label.text = model.current_buy;
            
        }else if (i == 3){
            
            label.text = model.lottery_sn;
            
            
        }else {
            long long time=[model.lottery_time longLongValue];
            
            NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:time];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            
            [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
            
            NSString*timeString=[formatter stringFromDate:d];
            
            label.text = timeString;
            
        }
            }
    
    self.nmaeLabel.text = model.duobaoitem_name;
    
}
@end
