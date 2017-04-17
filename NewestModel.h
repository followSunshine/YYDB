//
//  NewestModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/9/1.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewestModel : NSObject
@property (nonatomic, strong)NSString *userid;
@property (nonatomic, strong)NSString *lottery_time;
@property (nonatomic, strong)NSString *luck_user_id;
@property (nonatomic, strong)NSString *max_buy;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *span_time;
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSString *user_name;

@end
/*
 
 id = 100011625;
 "lottery_time" = 1470091921;
 "luck_user_id" = 224;
 "max_buy" = 13720;
 name = "\U4e2d\U56fd\U9ec4\U91d1";
 "span_time" = "2016-08-02";
 url = "?ctl=duobao&data_id=100011625";
 "user_name" = "\U7a7f\U5c71\U7532";

 
 */
