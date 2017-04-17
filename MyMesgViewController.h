//
//  MyMesgViewController.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/11.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMesgViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property ( nonatomic,strong)UITableView *tableview;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end
