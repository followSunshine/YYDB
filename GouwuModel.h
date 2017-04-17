//
//  GouwuModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/22.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "JSONModel.h"

@interface GouwuModel : JSONModel
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *deal_icon;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *number;
@property (nonatomic, strong)NSString *residue_count;//剩余
@property (nonatomic, strong)NSString *max_buy;//总需
@property (nonatomic, strong)NSString *current_buy;//
@property (nonatomic, strong)NSString *min_buy;//需是这个的倍数
@property (nonatomic, strong)NSString *unit_price;
@property (nonatomic, strong)NSString *total_price;
@property (nonatomic, strong)NSString *duobao_item_id;
@end
/*
 id: "768",
 session_id: "699q2i80bn44p84g7oc3bvftf6",
 user_id: "235987",
 deal_id: "152",
 duobao_id: "363",
 duobao_item_id: "100011666",
 name: "海购商品 MICHAEL KORS 迈克高仕 镶钻石英机芯超薄女士腕表 玫瑰金",
 unit_price: "1.0000",
 number: "5",
 total_price: "5.0000",
 create_time: "1477102102",
 update_time: "1477102108",
 return_score: "0",
 return_total_score: "0",
 deal_icon: "http://192.168.199.155/public/attachment/201601/23/15/56a32578f1ff4_279x279.jpg",
 is_effect: "1",
 max_buy: "1499",
 current_buy: "0",
 min_buy: "1",
 origin_price: "1199.0000",
 url: "/index.php?ctl=duobao&act=100011666",
 residue_count: 1499
 */
