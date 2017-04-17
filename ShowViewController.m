//
//  ShowViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/12/9.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "ShowViewController.h"
#import "AFHTTPSessionManager.h"
#import "ShowTableViewCell.h"
#import "MJRefresh.h"
#import "ShowModel.h"
#import "UIView+CGSet.h"
#import "ShowDeatilViewController.h"
#import "DetailDaojishiViewController.h"
@interface ShowViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *table;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation ShowViewController
{
    int page;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self creatUI];
    [self refresh];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push:) name:@"indexno" object:nil];
}
- (void)push:(NSNotification *)n {
    NSIndexPath *index = n.userInfo[@"index"];
    DetailDaojishiViewController *deta = [[DetailDaojishiViewController alloc]init];
    ShowModel *model = _dataArray[index.row];
    deta.userid = model.duobao_item_id;
    [self.navigationController pushViewController:deta animated:YES];
}
- (void)refresh {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        [manager GET:[NSString stringWithFormat:@"%@?ctl=share&page=1&v=3",urlpre] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            if (_dataArray.count) {
                [self.dataArray removeAllObjects];
            }
            NSArray *arr = dic[@"list"];
            for (NSDictionary *dica in arr) {
                ShowModel *model = [[ShowModel alloc]initWithDictionary:dica error:nil];
                [self.dataArray addObject:model];
            }
            [self.table reloadData];
            [self.table.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.table.mj_header endRefreshing];
        }];
    }];
    [self.table.mj_header beginRefreshing];
    
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page++;
       [manager GET:[NSString stringWithFormat:@"%@?ctl=share&page=%d&v=3",urlpre,page] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           NSDictionary *dic = (NSDictionary *)responseObject;
           if (dic) {
               NSArray *arr = dic[@"list"];
               for (NSDictionary *dica in arr) {
                   ShowModel *model = [[ShowModel alloc]initWithDictionary:dica error:nil];
                   [self.dataArray addObject:model];
//                   [ShowModel dictionaryOfModelsFromDictionary:dica error:nil];
               }
               [self.table reloadData];
               [self.table.mj_footer endRefreshing];
           }else {
               [self.table.mj_footer endRefreshingWithNoMoreData];
           }
          
           
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           [self.table.mj_footer endRefreshing];
       }];
        
    }];
    self.table.mj_footer.hidden = YES;
}
- (void)creatUI {
    page=1;
    self.dataArray = [NSMutableArray array];
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[ShowTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.table];
    self.table.separatorStyle = UITableViewCellStyleDefault;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.table.mj_footer.hidden = self.dataArray.count==0;
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowDeatilViewController *deta = [[ShowDeatilViewController alloc]init];
    deta.model = _dataArray[indexPath.row];
    [self.navigationController pushViewController:deta animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIView setHeight:222];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell reloadWithModel:_dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"晒单";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 64)];
    view.backgroundColor = SF_COLOR(255, 54, 93);
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIView setWidth:12], 30, 24, 24)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"左白箭头"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];
    [self.view addSubview:label];
    [self.view addSubview:returnBtn];
    
    self.view.backgroundColor = SF_COLOR(242, 242, 242);
}
- (void)returnclick {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
