//
//  UserModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/31.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "JSONModel.h"

@interface UserModel : JSONModel
@property (nonatomic, strong)NSString *duobao_area;
@property (nonatomic, strong)NSString *user_name;
@property (nonatomic, strong)NSString *number;
@property (nonatomic, strong)NSString *f_create_time;
@property (nonatomic, strong)NSString *duobao_ip;
@property (nonatomic, strong)NSString *avatar;
@end
