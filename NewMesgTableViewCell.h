//
//  NewMesgTableViewCell.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/12/21.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MesageModel.h"
@interface NewMesgTableViewCell : UITableViewCell
- (void)reloadWithModel:(MesageModel *)model;
@end
