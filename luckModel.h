//
//  luckModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/22.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "JSONModel.h"

@interface luckModel : JSONModel
@property (nonatomic, strong)NSString*id;
@property (nonatomic, strong)NSString*duobao_item_id;
@property (nonatomic, strong)NSString*name;
@property (nonatomic, strong)NSString*deal_icon;
@property (nonatomic, strong)NSString*create_time;
@property (nonatomic, strong)NSString*lottery_sn;
@end
/*
 {
 id: "339150",
 duobao_item_id: "100011556",
 name: "海购商品 MICHAEL KORS 迈克高仕 镶钻石英机芯超薄女士腕表 玫瑰金",
 deal_icon: "./public/attachment/201601/23/15/56a32578f1ff4.jpg",
 is_send_share: "0"
 }
 */
