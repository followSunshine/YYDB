//
//  FinderTableViewCell.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/5.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinderModel.h"
@interface FinderTableViewCell : UITableViewCell
- (void)reloadWith:(FinderModel *)model;
@end
