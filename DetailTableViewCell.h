//
//  DetailTableViewCell.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/12.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface DetailTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *ipLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UIImageView *headImage;

- (void)reloadWith:(UserModel *)model;
@end
