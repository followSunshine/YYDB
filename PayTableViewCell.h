//
//  PayTableViewCell.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/25.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayCell.h"
@interface PayTableViewCell : UITableViewCell
@property (nonatomic, strong)NSIndexPath *index;
- (void)reloadwith:(PayCell *)model;

@end