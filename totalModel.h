//
//  totalModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/22.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "JSONModel.h"

@interface totalModel : JSONModel
@property (nonatomic, strong)NSString *total_price;
@property (nonatomic, strong)NSString *return_total_score;
@property (nonatomic, strong)NSString *cart_item_number;
@end
/*
 total_price: 7,
 return_total_score: "0",
 cart_item_number: 3
 },
 */
