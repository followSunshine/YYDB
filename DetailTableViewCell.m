//
//  DetailTableViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/12.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "UIView+CGSet.h"
#import "UIImageView+WebCache.h"
@implementation DetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:12], [UIView setHeight:7.5], [UIView setHeight:40], [UIView setHeight:40])];
    
    [self.contentView addSubview:self.headImage];
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setHeight:40]+[UIView setWidth:17], [UIView setHeight:8], [UIView setWidth:300], [UIView setHeight:12])];
    self.nameLabel.textColor = SF_COLOR(54, 134, 255) ;
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.nameLabel];
    
    
    self.ipLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setHeight:40]+[UIView setWidth:17], [UIView setHeight:28], [UIView setWidth:300], [UIView setHeight:9])];
    self.ipLabel.textColor = SF_COLOR(102, 102, 102);
    self.ipLabel.font = [UIFont systemFontOfSize:9];
    [self.contentView addSubview:self.ipLabel];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setHeight:40]+[UIView setWidth:17], [UIView setHeight:42], [UIView setWidth:300], [UIView setHeight:9])];
    self.timeLabel.textColor =SF_COLOR(102, 102, 102);
    self.timeLabel.font = [UIFont systemFontOfSize:9];
    [self.contentView addSubview:self.timeLabel];
    
    
    UILabel *newlinelabel3 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:54.5 andWidth:351 andHeight:0.5]];
    newlinelabel3.backgroundColor = SF_COLOR(242, 242, 242);
    [self.contentView addSubview:newlinelabel3];
}
- (void)reloadWith:(UserModel *)model {
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    self.ipLabel.text = [NSString stringWithFormat:@"(%@ IP:%@)",model.duobao_area,model.duobao_ip];
    self.nameLabel.text = model.user_name;
    NSString *str = [NSString stringWithFormat:@"参与了%@人次 %@",model.number,model.f_create_time];
    NSMutableAttributedString *sta = [[NSMutableAttributedString alloc]initWithString:str];
    [sta addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(3, model.number.length)];
    
    self.timeLabel.attributedText = sta;


    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
