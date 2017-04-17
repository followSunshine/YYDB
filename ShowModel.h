//
//  ShowModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/12/9.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "JSONModel.h"
#import "ShowModle1.h"

#import "ShowModel2.h"

@interface ShowModel : JSONModel

@property (nonatomic, strong)NSString *duobao_item_id;
@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSString *create_time;
@property (nonatomic, strong)NSString *user_name;
@property (nonatomic, strong)NSString *images_count;
@property (nonatomic, strong)NSString *user_avatar;
@property (nonatomic, strong)NSArray<ShowModle1> *image_list;
@property (nonatomic, strong)ShowModel2 *duobao_item;


@end
