//
//  MoneyModel.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/19.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "MoneyModel.h"

@implementation MoneyModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
    if([key isEqualToString:@"return"]){
        self.returnvalue= value;
    };
}
@end
/*
 user_login_status: 1,
 money: 88207,
 page_title: "我的账户",
 ctl: "uc_money",
 act: "setting",
 status: 1,
 info: "",
 city_name: null,
 return: 1,
 sess_id: "699q2i80bn44p84g7oc3bvftf6",
 ref_uid: null
 */
