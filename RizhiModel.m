//
//  RizhiModel.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/19.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "RizhiModel.h"

@implementation RizhiModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"return"]){
        self.userid= value;
    };
}@end
