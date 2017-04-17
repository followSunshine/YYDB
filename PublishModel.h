//
//  PublishModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/9/8.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublishModel : NSObject
@property (nonatomic, strong)NSString *current_buy;
@property (nonatomic, strong)NSString *date;
@property (nonatomic, strong)NSString *deal_id;
@property (nonatomic, strong)NSString *duobao_id;
@property (nonatomic, strong)NSString *duobaoitem_name;
@property (nonatomic, strong)NSString *fair_sn;
@property (nonatomic, strong)NSString *has_lottery;
@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSString *userid;
@property (nonatomic, strong)NSString *lottery_sn;
@property (nonatomic, strong)NSString *lottery_time;
@property (nonatomic, strong)NSString *lottery_time_show;
@property (nonatomic, strong)NSString *luck_user_buy_count;
@property (nonatomic, strong)NSString *luck_user_id;
@property (nonatomic, strong)NSString *luck_user_name;
@property (nonatomic, strong)NSString *max_buy;
@property (nonatomic, strong)NSString *min_buy;
@property (nonatomic, strong)NSString *success_time;
@end
/*
 "current_buy" = 13720;
 date = "2016-08-02";
 "deal_id" = 192;
 "duobao_id" = 393;
 "duobaoitem_name" = "\U4e2d\U56fd\U9ec4\U91d1";
 "fair_sn" = 29243;
 "has_lottery" = 1;
 icon = "http://192.168.199.155/public/attachment/201605/27/15/5747f95b3ffd8_300x300.jpg";
 id = 100011625;
 "lottery_sn" = 100001804;
 "lottery_time" = 1470091921;
 "lottery_time_show" = "14:52";
 "luck_user_buy_count" = 2583;
 "luck_user_id" = 224;
 "luck_user_name" = "\U7a7f\U5c71\U7532";
 "max_buy" = 13720;
 "min_buy" = 1;
 "success_time" = 1470091631;

 
 */
