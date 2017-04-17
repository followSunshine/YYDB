//
//  DuoBaoJLModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/27.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "JSONModel.h"

@interface DuoBaoJLModel : JSONModel
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSString *max_buy;
@property (nonatomic, strong)NSString *less;
@property (nonatomic, strong)NSString *number;
@property (nonatomic, strong)NSString *has_lottery;
@property (nonatomic, strong)NSString *luck_user_name;
@property (nonatomic, strong)NSString *luck_user_total;
@property (nonatomic, strong)NSString *lottery_sn;
@property (nonatomic, strong)NSString *lottery_time;
@property (nonatomic, strong)NSString *luck_user_id;


@end
/*
 id: "100011599",
 name: "卡西欧 CASIO EX-FR100 数码相机",
 icon: "http://192.168.199.155/public/attachment/201601/23/18/56a352b5561fd_300x300.jpg",
 max_buy: "3299",
 less: 3298,
 number: "1",
 success_time: "0",
 has_lottery: "0",
 progress: "0",
 luck_user_id: 0,
 luck_user_name: "--",
 luck_user_total: "--",
 lottery_sn: "--",
 lottery_time: "--"
 */
