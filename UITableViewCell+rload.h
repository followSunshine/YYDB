//
//  UITableViewCell+rload.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/19.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MesageModel.h"
#import "JSONModel.h"
@interface UITableViewCell (rload)
- (void)rloadwith:(MesageModel *)model;
- (void)reloadwith:(JSONModel *)model;
- (void)reloadwithmodel:(id)model;
@end
