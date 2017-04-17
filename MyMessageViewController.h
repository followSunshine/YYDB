//
//  MyMessageViewController.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/18.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMessageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end
