//
//  CollectionViewCell.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/9/8.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublishModel.h"
@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *nmaeLabel;
- (void)reloadDataWithModel:(PublishModel *)model;
@end
