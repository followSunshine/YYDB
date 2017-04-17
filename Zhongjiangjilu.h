//
//  Zhongjiangjilu.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/21.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "JSONModel.h"

@interface Zhongjiangjilu : JSONModel
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *duobao_item_id;
@property (nonatomic, strong)NSString *create_time;
@property (nonatomic, strong)NSString *lottery_sn;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *deal_icon;
@property (nonatomic, strong)NSString *region_status;
@property (nonatomic, strong)NSString *delivery_status;
@property (nonatomic, strong)NSString *is_arrival;
@end
/*
 id: "339156",
 duobao_item_id: "100011545",
 create_time: "2016-10-18 17:22:09",
 order_status: "1",
 region_info: "北京北京东城区",
 address: "123",
 mobile: "13923232323",
 zip: "123",
 consignee: "123123",
 delivery_status: "1",
 name: "卡西欧 CASIO EX-FR100 数码相机",
 is_arrival: "1",
 deal_icon: "http://192.168.199.155/public/attachment/201601/23/18/56a352b5561fd_75x75.jpg",
 lottery_sn: "100000096",
 region_status: 1
 */
