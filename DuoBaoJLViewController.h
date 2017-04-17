//
//  DuoBaoJLViewController.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/11.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DuoBaoJLViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic ,strong) UITableView *tableView;
- (void)requestwith:(NSInteger)index ;
@end
