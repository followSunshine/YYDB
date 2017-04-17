//
//  DuoBaoModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/9/9.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DuoBaoModel : NSObject
@property (nonatomic, strong)NSString *has_lottery;
@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSString *userid;
@property (nonatomic, strong)NSString *lottery_sn;
@property (nonatomic, strong)NSString *lottery_time;
@property (nonatomic, strong)NSString *luck_user_id;
@property (nonatomic, strong)NSString *luck_user_name;
@end
/*
 "has_lottery" = 1;
 icon = "http://y.maomao.org.cn/public/attachment/201605/31/17/574d5a18d48ec_420x420.jpg";
 id = 100011573;
 "lottery_sn" = 100007874;
 "lottery_time" = 1471377124;
 "luck_user_id" = 228;
 "luck_user_name" = "\U5218\U5c0f\U599e";

 */
