//
//  ShowTableViewCell.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/12/9.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowModel.h"
@interface ShowTableViewCell : UITableViewCell
- (void)reloadWithModel:(ShowModel *)model;
@end
