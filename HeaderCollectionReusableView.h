//
//  HeaderCollectionReusableView.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/9/1.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "AdvsModel.h"
#import "IndexModel.h"
#import "NewestModel.h"
#import "UIImageView+WebCache.h"
#import "DuoBaoModel.h"
#import "RGBColor.h"
#import "JXCollectionViewCell.h"
@interface HeaderCollectionReusableView : UICollectionReusableView<SDCycleScrollViewDelegate,UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
- (void)reloadDatawith:(NSArray *)advsArr and:(NSArray *)indexArr and:(NSArray *)newestArr and:(NSArray *)duoBaoArray and:(NSString *)time;
@property (nonatomic, strong)SDCycleScrollView *scrollview;
@property (nonatomic, strong)UILabel *Scrolabel;
@property (nonatomic, strong)NSTimer *timer;

@property (nonatomic, strong)NSMutableArray *AdvsArray;
@property (nonatomic, strong)NSMutableArray *NewsetArray;

@property (nonatomic, strong)NSMutableArray *labelArray;
@property (nonatomic, strong)NSMutableArray *duobaoArray;
@end
