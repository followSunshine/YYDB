//
//  MesageModel.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/18.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "MesageModel.h"

@implementation MesageModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"]){
        self.userid = value;
    };
}
@end
