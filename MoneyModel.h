//
//  MoneyModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/19.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoneyModel : NSObject
@property (nonatomic, strong)NSString *user_login_status;
@property (nonatomic, strong)NSString *money;
@property (nonatomic, strong)NSString *page_title;
@property (nonatomic, strong)NSString *ctl;
@property (nonatomic, strong)NSString *act;
@property (nonatomic, strong)NSString *status;
@property (nonatomic, strong)NSString *info;
@property (nonatomic, strong)NSString *city_name;
@property (nonatomic, strong)NSString *returnvalue;
@property (nonatomic, strong)NSString *sess_id;
@property (nonatomic, strong)NSString *ref_uid;
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
 ref_uid: null*/
