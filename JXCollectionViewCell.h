//
//  JXCollectionViewCell.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/16.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DuoBaoModel.h"
#import "UIImageView+WebCache.h"
@interface JXCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UILabel *label2;

- (void)cellwithmodel:(DuoBaoModel *)model;
@end
