//
//  GoodsCollectionViewCell.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/8/30.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WoodsModle.h"
#import "UIImageView+WebCache.h"
#import "YSProgressView.h"

@interface GoodsCollectionViewCell : UICollectionViewCell

- (void)addDataWithModel:(WoodsModle *)model;
@property (nonatomic, strong)YSProgressView *prog;
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *need_num_label;
@property (nonatomic, strong)UILabel *left_num_label;
@property (nonatomic, strong)UIButton *addPlistBtn;
@property (nonatomic, strong)UIProgressView *progress;
@property (nonatomic, strong)UIImageView *tenImage;
@end
