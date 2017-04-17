//
//  shareModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/22.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "JSONModel.h"

@interface shareModel : JSONModel
@property (nonatomic, strong)NSString *id;
@property (nonatomic, strong)NSString *duobao_item_id;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *deal_icon;
@property (nonatomic, strong)NSString *share_id;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *create_time;
@property (nonatomic, strong)NSString *user_name;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSArray *image_list;
@end
/*
id: "339156",
 duobao_item_id: "100011545",
 name: "卡西欧 CASIO EX-FR100 数码相机",
 deal_icon: "./public/attachment/201601/23/18/56a352b5561fd.jpg",
 is_send_share: "1",
 share_id: "4",
 user_id: "235987",
 user_name: "6843_790",
 create_time: "10-21 05:51",
 title: "123123123123",
 content: "123123123123123123123123123123123123",
 image_list: [

 */
