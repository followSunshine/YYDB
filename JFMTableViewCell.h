//
//  JFMTableViewCell.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/30.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFModel.h"
@interface JFMTableViewCell : UITableViewCell
- (void)reloadWithModel:(JFModel *)model;

@end
