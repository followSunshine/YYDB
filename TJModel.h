//
//  TJModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/12/8.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "JSONModel.h"

@interface TJModel : JSONModel
@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *icon;


@property (nonatomic,strong)NSString *progress;


@end
/*\
 id: "100011679",
 deal_id: "202",
 duobao_id: "403",
 name: "珠江钢琴Pearl River里特米勒立式88键 MZ-123",
 brief: "抢券减100元！全套配齐!品质豫华,物流保全险,15天无条件退换货！",
 icon: "./public/attachment/201605/31/17/574d5a18d48ec.jpg",
 create_time: "1470615514",
 max_buy: "16900",
 min_buy: "1",
 current_buy: "0",
 progress: "0",
 success_time: "0",
 lottery_time: "0",
 fair_sn: "0",
 fair_sn_local: "",
 fair_period: "",
 luck_user_id: "0",
 luck_user_name: "",
 duobao_ip: "",
 origin_price: "19800.0000",
 success_time_50: "0.0000"
 */
