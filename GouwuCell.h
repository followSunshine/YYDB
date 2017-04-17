//
//  GouwuCell.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/22.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GouwuModel.h"
@interface GouwuCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *textfield;
- (void)reloadwith:(GouwuModel *)model ;
@end
