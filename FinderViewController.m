//
//  FinderViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/5.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "FinderViewController.h"
#import "FinderModel.h"
#import "FinderTableViewCell.h"
#import "TenViewController.h"
#import "HelpViewController.h"
#import "AFHTTPSessionManager.h"
#import "UIView+CGSet.h"
#import "CateViewController.h"
#import "ContestViewController.h"
#import "DetailViewController.h"
#import "HelpViewController.h"
#import "DizhiWebViewController.h"
#import "TenViewController.h"
#import "MyshaidanViewController.h"
#import "ShowViewController.h"
#import "MyYQViewController.h"
@interface FinderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UITableView *tableview;

@end

@implementation FinderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    [self setNavigationBar];
    [self setupUI];
    [self reuqest];
    self.automaticallyAdjustsScrollViewInsets = false;
    
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"活动";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    UIView *view23 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 64)];
    view23.backgroundColor = SF_COLOR(255, 54, 93);
    [self.view addSubview:view23];
    [self.view addSubview:label];
    
    
    self.view.backgroundColor = SF_COLOR(242, 242, 242);
}


- (void)setupUI {
    self.dataArray = [NSMutableArray array];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64-49) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    [self.tableview registerClass:[FinderTableViewCell class] forCellReuseIdentifier:@"cellid"];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    self.tableview.scrollEnabled = NO;
    self.tableview.backgroundColor = SF_COLOR(242, 242, 242);
}

- (void)reuqest {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    [manager GET:[NSString stringWithFormat:@"%@?ctl=activity&v=3",urlpre] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *dic = (NSArray *)responseObject;
        NSArray *arr = [dic objectAtIndex:0];
        for (NSDictionary *dica in arr) {
            FinderModel *model = [[FinderModel alloc]initWithDictionary:dica error:nil];
            [self.dataArray addObject:model];
        }
        [self.tableview reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FinderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell reloadWith:_dataArray[indexPath.row]];
    return cell;
    
}
/*
 TenViewController *ten = [[TenViewController alloc]init];
 ten.titlestring = @"十元专区";
 ten.urlstring = @"?ctl=duobaost&min_buy=10";
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FinderModel *model = self.dataArray[indexPath.row];
    NSNumber *index = model.type;
    switch (index.integerValue) {
        case 0:
        {
            DizhiWebViewController *di = [[DizhiWebViewController alloc]init];
            
            di.urlstring = model.data[@"url"];
            [self hideTabBar];
            
            [self.navigationController pushViewController:di animated:YES];
        }
            break;
        case 1:
        {
            
            CateViewController *help = [[CateViewController alloc]init];
            [self hideTabBar];
            [self.navigationController pushViewController:help animated:YES];
  
        }
            break;
        case 2:
        {
            NSDictionary *dic = model.data;
            
            TenViewController *ten = [[TenViewController alloc]init];
            ten.titlestring = model.name;
            NSString *str = [NSString stringWithFormat:@"?ctl=duobaos&data_id=%@",dic[@"cate_id"]];
            ten.urlstring = str;
            [self hideTabBar];

            [self.navigationController pushViewController:ten animated:YES];
        }
            break;
        case 3:
        {
            NSNotification *notice = [NSNotification notificationWithName:@"pushtomain" object:nil userInfo:@{@"num":@"3"}];
            [[NSNotificationCenter defaultCenter] postNotification:notice];
        }
            break;
        case 4:
        {
            DetailViewController *de = [[DetailViewController alloc]init];
            de.userid = model.data[@"data_id"];
            
            [self hideTabBar];
            [self.navigationController pushViewController:de animated:YES];

        }
            break;
        case 5:
        {
            
            HelpViewController *help = [[HelpViewController alloc]init];
            [self hideTabBar];
            [self.navigationController pushViewController:help animated:YES];
            
        }
            break;
        case 6:
        {
            
            DizhiWebViewController *di = [[DizhiWebViewController alloc]init];
            
            di.urlstring = [NSString stringWithFormat:@"%@?ctl=helps&act=show&page_type=app&data_id=%@",urlpre,model.data[@"data_id"]];
            [self hideTabBar];
            
            [self.navigationController pushViewController:di animated:YES];
            
        }
            break;
        case 7:
        {
            
            TenViewController *ten = [[TenViewController alloc]init];
            ten.titlestring = @"十元专区";
            ten.urlstring = @"?ctl=duobaost&min_buy=10";
            [self hideTabBar];
            [self.navigationController pushViewController:ten animated:YES];
            
        }
            break;
        case 8:
        {
            
            TenViewController *ten = [[TenViewController alloc]init];
            ten.titlestring = @"百元专区";
            ten.urlstring = @"?ctl=duobaosh";
            [self hideTabBar];
            [self.navigationController pushViewController:ten animated:YES];

        }
            break;
        case 9:
        {
            
            ShowViewController *help = [[ShowViewController alloc]init];
            [self hideTabBar];
            [self.navigationController pushViewController:help animated:YES];
            
        }
            break;
        case 10:
        {
            
            MyYQViewController *help = [[MyYQViewController alloc]init];
            [self hideTabBar];
            [self.navigationController pushViewController:help animated:YES];
            
        }
            break;
        
        default:
            break;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (indexPath.row==0) {
        height = [UIView setHeight:122];
    }else {
        height = [UIView setHeight:90];
    }
    return height;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self showTabBar];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
