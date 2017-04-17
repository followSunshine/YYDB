//
//  CateTableViewCell.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/25.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CateModel.h"
@interface CateTableViewCell : UITableViewCell
- (void)reloadwith:(CateModel *)model;
@end
