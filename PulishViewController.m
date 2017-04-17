//
//  PulishViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/8/29.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "PulishViewController.h"
#import "AFNetworking.h"

#import "AFHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"
#import "PublishModel.h"
#import "CollectionViewCell.h"
#import "WebVIewController.h"
#import "AppDelegate.h"
#import "UIView+CGSet.h"
#import "MJRefresh.h"
#import "DetailDaojishiViewController.h"
#import "PulisTableViewCell.h"
#import "PLTableViewCell.h"
#import "UITableViewCell+rload.h"
#import "DetailDaojishiViewController.h"
#import "DetailJXiaoViewController.h"
@interface PulishViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSTimer *timer;
//时间数组
@property (nonatomic, strong)NSMutableArray *timeArray;
@property (nonatomic, strong)UITableView *tableView;
//页数
@property (nonatomic, assign)NSInteger page;
//分页数据量
@property (nonatomic, assign)NSInteger pagenum;

@end
static NSString *cell1=@"cell1";
static NSString *cell2=@"cell2";
@implementation PulishViewController

- (void)example21
{
       [self.tableView.mj_header beginRefreshing];
    


}
- (void)setupTableViewRefresh {
    __weak __typeof(self) weakSelf = self;
    
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        NSString *URL = [NSString stringWithFormat:@"%@?ctl=anno&v=3&page=%ld",urlpre,weakSelf.page];
        
        [manager GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSelf.dataArray removeAllObjects];
            [weakSelf.timeArray removeAllObjects];
            NSDictionary *dic = (NSDictionary*)responseObject;
            
            NSArray *arr = dic[@"list"];
            weakSelf.pagenum = arr.count;
            NSMutableArray *arr1 = [NSMutableArray array];
            NSMutableArray *arr2 = [NSMutableArray array];
            for (NSDictionary *dica in arr) {
                if ([dica[@"has_lottery"] isEqualToString:@"0"]) {
                    
                    PublishModel *model = [[PublishModel alloc]init];
                    [model setValuesForKeysWithDictionary:dica];
                    [arr1 addObject:model];
                    NSString *str = dic[@"now_time"];
                    NSString *str1 = model.lottery_time;
                    NSString *time = [NSString stringWithFormat:@"%d",(str1.intValue-str.intValue)*100];
                    [weakSelf.timeArray addObject:time];
                }else {
                    PublishModel *model = [[PublishModel alloc]init];
                    [model setValuesForKeysWithDictionary:dica];
                    [arr2 addObject:model];
                }
            }
            if (!weakSelf.timer) {
                weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(refresjtime) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:UITrackingRunLoopMode];
            }

            [weakSelf.dataArray addObject:arr1];
            [weakSelf.dataArray addObject:arr2];
            [self.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadFoot)];
//    self.tableView.mj_footer.hidden = YES;

}

- (void)reloadFoot {
    _page++;
    __weak __typeof(self) weakSelf = self;
    [self.tableView.mj_footer endRefreshing];

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSString *URL = [NSString stringWithFormat:@"%@?ctl=anno&v=3&page=%ld",urlpre,weakSelf.page];
    
    [manager GET:URL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary*)responseObject;
        
        NSArray *arr = dic[@"list"];
        weakSelf.pagenum = arr.count;
        NSMutableArray *arr1 = [NSMutableArray array];
        NSMutableArray *arr2 = [NSMutableArray array];
        
        if (arr.count < 20) {
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_footer.hidden = NO;
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        self.page++;
        for (NSDictionary *dica in arr) {
            if ([dica[@"has_lottery"] isEqualToString:@"0"]) {
                
                PublishModel *model = [[PublishModel alloc]init];
                [model setValuesForKeysWithDictionary:dica];
                [arr1 addObject:model];
                NSString *str = dic[@"now_time"];
                NSString *str1 = model.lottery_time;
                NSString *time = [NSString stringWithFormat:@"%d",(str1.intValue-str.intValue)*100];
                [weakSelf.timeArray addObject:time];
            }else {
                PublishModel *model = [[PublishModel alloc]init];
                [model setValuesForKeysWithDictionary:dica];
                [arr2 addObject:model];
            }
        }
        if (!weakSelf.timer) {
            weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(refresjtime) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:weakSelf.timer forMode:UITrackingRunLoopMode];
        }

        [weakSelf.dataArray addObject:arr1];
        [weakSelf.dataArray addObject:arr2];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    

}
- (NSString *)timeFormatted:(int)totalSeconds
{
    int seconds = totalSeconds % 100;
    int minutes = (totalSeconds / 100) % 60;
    int hours = (totalSeconds / 6000)%60;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}
- (void)refresjtime {
    int time;
    for (int i = 0; i < self.timeArray.count; i++) {
        time = [self.timeArray[i] intValue];
        PulisTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.timelabel.text = [self timeFormatted:--time];
        if (time<=0) {
            [self.timer invalidate];
            self.timer = nil;
            cell.timelabel.text = @"开奖计算中";
            [NSThread sleepForTimeInterval:3];
            [self.tableView.mj_header beginRefreshing];
        }
        [self.timeArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",time]];
    }
}

- (void)viewDidLoad {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    [super viewDidLoad];
    [self setNavigationBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatCV];
    [self setupTableViewRefresh];
    [self example21];

}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"幸运";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    UIView *view23 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 64)];
    view23.backgroundColor = SF_COLOR(255, 54, 93);
    [self.view addSubview:view23];
    [self.view addSubview:label];
    
    
    self.view.backgroundColor = SF_COLOR(242, 242, 242);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        DetailJXiaoViewController *deat = [[DetailJXiaoViewController alloc]init];
        PublishModel *model=_dataArray[indexPath.section][indexPath.row];
        deat.userid = model.userid;
        [self.navigationController pushViewController:deat animated:YES];
        
    }else {
      DetailDaojishiViewController *deat = [[DetailDaojishiViewController alloc]init];
        PublishModel *model=_dataArray[indexPath.section][indexPath.row];
        deat.userid = model.userid;
        [self.navigationController pushViewController:deat animated:YES];
    }
    [self hideTabBar];
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }        return _dataArray;
}
- (void) creatCV {
    self.page = 1;
    self.timeArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64-49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    self.tableView.mj_footer.hidden = [self.dataArray[section] count] == 0;
    
    return [self.dataArray[section] count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = indexPath.section==0?[tableView dequeueReusableCellWithIdentifier:cell1]:[tableView dequeueReusableCellWithIdentifier:cell2];
    
    if (cell==nil) {
        if (indexPath.section==0) {
            cell = [[PulisTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell1];
        }else if(indexPath.section==1){
            
            cell = [[PLTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2];
        }
    }
    [cell reloadwithmodel:_dataArray[indexPath.section][indexPath.row] ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIView setHeight:120];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
}
- (void)showTabBar
{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    [self showTabBar];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
