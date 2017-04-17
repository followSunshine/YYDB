//
//  PayViewController.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/24.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayCell.h"
#import "PayTableViewCell.h"
@interface PayViewController : UIViewController
@property (nonatomic,strong)NSArray *dic;
@property (nonatomic, strong)NSString *price;
@property (nonatomic, strong)NSArray *arr;
@property (nonatomic, assign)NSInteger num;
@end
