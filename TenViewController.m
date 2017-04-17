//
//  TenViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/26.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "TenViewController.h"
#import "AFHTTPSessionManager.h"
#import "TenModel.h"
#import "TenTableViewCell.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "UIView+CGSet.h"
@interface TenViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation TenViewController
{
    int _page;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setup];
    [self request];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.title = self.titlestring;
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(alert:) name:@"alert" object:nil];
}
- (void)alert:(NSNotification *)n {
    NSDictionary *dic = n.userInfo;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"info"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:act];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *selabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    selabel.font = [UIFont systemFontOfSize:18];
    selabel.text = self.titlestring;
    selabel.textColor = [UIColor whiteColor];
    selabel.textAlignment = NSTextAlignmentCenter;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 64)];
    view.backgroundColor = SF_COLOR(255, 54, 93);
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIView setWidth:12], 30, 24, 24)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"左白箭头"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];
    [self.view addSubview:selabel];
    [self.view addSubview:returnBtn];
    
    self.view.backgroundColor = SF_COLOR(242, 242, 242);
}
- (void)returnclick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setup {
    self.dataArray = [NSMutableArray array];
    _page = 1;
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT - 64) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource  =self;
    [self.view addSubview:self.tableview];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerClass:[TenTableViewCell class] forCellReuseIdentifier:@"cellid"];

}
- (void)request {
    __weak __typeof(self) weakSelf = self;

    AFHTTPSessionManager*manager = [[AFHTTPSessionManager alloc]init];
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;

    NSString *str = [NSString stringWithFormat:@"%@%@&uid=%@&page=%d&v=3",urlpre,self.urlstring,dele.userid,_page];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSelf.dataArray removeAllObjects];
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *arr = dic[@"list"];
            for (NSDictionary *dica in arr) {
                TenModel *model = [[TenModel alloc]initWithDictionary:dica error:nil];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }];
    [self.tableview.mj_header beginRefreshing];
    
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        AFHTTPSessionManager*manager = [[AFHTTPSessionManager alloc]init];
        _page ++;
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;

        NSString *str = [NSString stringWithFormat:@"%@%@&uid=%@&page=%d&v=3",urlpre,self.urlstring,dele.userid,_page];
        
        
        [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *arr = dic[@"list"];
            if (arr.count==0) {
                [weakSelf.tableview.mj_footer endRefreshingWithNoMoreData];
                _page--;
            }
            for (NSDictionary *dica in arr) {
                TenModel *model = [[TenModel alloc]initWithDictionary:dica error:nil];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableview reloadData];
            [weakSelf.tableview.mj_footer endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf.tableview.mj_footer endRefreshing];
            
        }];
        
    }];
    
    self.tableview.mj_footer.hidden = YES;
}
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableview.mj_footer.hidden = _dataArray.count == 0;
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TenTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellStyleDefault;
    [cell reloadwith:_dataArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewController *detai = [[DetailViewController alloc]init];
    TenModel *model = _dataArray[indexPath.row];
    detai.userid = model.id;
    [self.navigationController pushViewController:detai animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIView setHeight:115];
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
