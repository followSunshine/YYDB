//
//  HBModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/12/1.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "JSONModel.h"

@interface HBModel : JSONModel
@property (nonatomic,strong)NSString *child_name;
@property (nonatomic,strong)NSString *make_limit;
@property (nonatomic,strong)NSString *money;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *total_money;
@property (nonatomic,strong)NSString *status;
@property (nonatomic, strong)NSString *id;
@end
