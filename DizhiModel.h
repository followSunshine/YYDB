//
//  DizhiModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/20.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "JSONModel.h"

@interface DizhiModel : JSONModel
@property (nonatomic ,strong)NSString *address;
@property (nonatomic ,strong)NSString *mobile;
@property (nonatomic ,strong)NSString *region_lv2_name;
@property (nonatomic ,strong)NSString *region_lv3_name;
@property (nonatomic ,strong)NSString *region_lv4_name;
@property (nonatomic ,strong)NSString *consignee;
@property (nonatomic ,strong)NSString *addurl;
@property (nonatomic ,strong)NSString *edit_url;
@property (nonatomic ,strong)NSString *del_url;
@property (nonatomic ,strong)NSString *dfurl;
@property (nonatomic ,strong)NSString *is_default;
@end
/*
 id: "21",
 user_id: "235987",
 region_lv1: "1",
 region_lv2: "2",
 region_lv3: "52",
 region_lv4: "500",
 address: "123",
 mobile: "13923232323",
 zip: "123",
 consignee: "123123",
 is_default: "1",
 xpoint: "",
 ypoint: "",
 id_card: null,
 region_lv1_name: "中国",
 region_lv2_name: "北京",
 region_lv3_name: "北京",
 region_lv4_name: "东城区",
 addurl: "?ctl=uc_address&act=add&uid=235987&page_type=app",
 edit_url: "?ctl=uc_address&act=add&uid=235987&page_type=app&id=21",
 del_url: "?ctl=uc_address&act=del&uid=235987&page_type=app&id=21",
 dfurl: "?ctl=uc_address&act=set_default&uid=235987&page_type=app&id=21"
 */
