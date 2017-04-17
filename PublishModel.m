//
//  PublishModel.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/9/8.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "PublishModel.h"

@implementation PublishModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"]){
        self.userid = value;
    };

}
@end
