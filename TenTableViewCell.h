//
//  TenTableViewCell.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/26.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TenModel.h"
@interface TenTableViewCell : UITableViewCell
- (void)reloadwith:(TenModel *)model;
@end
