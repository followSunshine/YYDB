//
//  DuoBaoModel.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/9/9.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "DuoBaoModel.h"

@implementation DuoBaoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"]){
        self.userid = value;
    };
}

@end
