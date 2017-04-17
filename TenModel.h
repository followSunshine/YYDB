//
//  TenModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/26.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "JSONModel.h"

@interface TenModel : JSONModel
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *max_buy;
@property (nonatomic, strong)NSString *min_buy;
@property (nonatomic, strong)NSString *current_buy;
@property (nonatomic, strong)NSString *surplus_buy;
@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSString *unit_price;
@end
/*
 id: "100011661",
 name: "佳能（Canon） EOS 700D 单反套机",
 max_buy: "38990",unit_price
 min_buy: "10",
 current_buy: "0",
 surplus_buy: "38990",
 icon: "http://192.168.199.155/public/attachment/201601/23/17/56a34ef3c7439_300x300.jpg"
 },
 */
