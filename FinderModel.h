//
//  FinderModel.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/5.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "JSONModel.h"

@interface FinderModel : JSONModel
@property (nonatomic ,strong)NSDictionary *data;
@property (nonatomic ,strong)NSString *img;
@property (nonatomic ,strong)NSString *name;
@property (nonatomic ,strong)NSNumber *type;
@property (nonatomic ,strong)NSString *descriptions;



@end
