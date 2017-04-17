//
//  PulisTableViewCell.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/17.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublishModel.h"
@interface PulisTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *timelabel;

- (void)reloadwithmodel:(id)model;
@end
