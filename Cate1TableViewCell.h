//
//  Cate1TableViewCell.h
//  YiYuanDuoBao
//
//  Created by chenyu on 17/1/3.
//  Copyright © 2017年 chenyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TenModel.h"
@interface Cate1TableViewCell : UITableViewCell
@property (nonatomic, strong)UIViewController *superView;
- (void)reloadwith:(TenModel *)model;

@end
