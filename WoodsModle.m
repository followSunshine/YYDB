//
//  WoodsModle.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/8/30.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "WoodsModle.h"

@implementation WoodsModle
- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"]){
        self.userid = value;
    };    
}
@end
