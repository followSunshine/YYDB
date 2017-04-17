//
//  IndexModel.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/9/1.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "IndexModel.h"

@implementation IndexModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"id"]){
        self.userid = value;
    };
  
}
@end
