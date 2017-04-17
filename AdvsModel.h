//
//  AdvsModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/9/1.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdvsModel : NSObject
@property (nonatomic, strong)NSString *ctl;
@property (nonatomic, strong)NSDictionary *data;
@property (nonatomic, strong)NSString *userid;
@property (nonatomic, strong)NSString *img;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *type;
@property (nonatomic, strong)NSString *url;
@end
/*
 "http_host" = "192.168.199.155/";

 ctl = cate;
 data =             {
 "" = "<null>";
 };
 id = 27;
 img = "http://192.168.199.155/public/attachment/201601/22/22/56a23c98d0fdb.jpg";
 name = banner1;
 type = 1;
 
 */
