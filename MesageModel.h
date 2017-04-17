//
//  MesageModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/18.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MesageModel : NSObject
@property (nonatomic, strong)NSString *userid;
@property (nonatomic, strong)NSString *content;
@property (nonatomic, strong)NSString *create_time;
@property (nonatomic, strong)NSString *is_read;
@property (nonatomic, strong)NSString *type;
@property (nonatomic, strong)NSString *data_id;
@property (nonatomic, strong)NSString *icon;
@property (nonatomic, strong)NSString *link;
@property (nonatomic, strong)NSString *short_title;
@end
