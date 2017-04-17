//
//  CateViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/25.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "CateViewController.h"
#import "AFHTTPSessionManager.h"
#import "CateTableViewCell.h"
#import "CateModel.h"
#import "UIView+CGSet.h"
#import "TenViewController.h"
#import "Cate1TableViewCell.h"
#import "TenModel.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
@interface CateViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)NSMutableArray *dataArray1;
@property (nonatomic, strong)UITableView *tableview1;



@end
@implementation CateViewController
{
    int _page;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setup];
    [self request];
    self.automaticallyAdjustsScrollViewInsets = false;
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
    selabel.text = @"商品分类";
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
    self.view.backgroundColor = [UIColor whiteColor];
    
}
- (void)returnclick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setup {
    _page=1;
    self.dataArray = [NSMutableArray array];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIView setWidth:82], SHEIGHT-64) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    [self.tableview registerClass:[CateTableViewCell class] forCellReuseIdentifier:@"cellid"];
    self.tableview.tag = 325;
    self.tableview.backgroundColor = SF_COLOR(238, 238, 238);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.dataArray1 = [NSMutableArray array];
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake([UIView setWidth:82], 64, [UIView setWidth:375-82], SHEIGHT-64) style:UITableViewStylePlain];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    [self.view addSubview:self.tableview1];
    [self.tableview1 registerClass:[Cate1TableViewCell class] forCellReuseIdentifier:@"cellid1"];

    self.tableview1.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}
- (void)request {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSString *url = [NSString stringWithFormat:@"%@?ctl=cate&v=1",urlpre];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSArray *arr =dic[@"list"];
        [_dataArray removeAllObjects];
        for (NSDictionary *dica in arr) {
            CateModel *model = [[CateModel alloc]initWithDictionary:dica error:nil];
            [_dataArray addObject:model];
        }
        CateModel *model = [_dataArray firstObject];
        NSString *str = [NSString stringWithFormat:@"?ctl=duobaos&data_id=%@",model.id];
        [self requestWithStr:str];

        [self.tableview reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)quanbuclick:(UITapGestureRecognizer *)tap {
    TenViewController *ten = [[TenViewController alloc]init];
    NSString *str = [NSString stringWithFormat:@"?ctl=duobaos&data_id="];
    ten.urlstring = str;
    
    [self.navigationController pushViewController:ten animated:YES];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag==325) {
        return self.dataArray.count;

    }else {
        self.tableview1.mj_footer.hidden = self.dataArray1.count==0;
        return self.dataArray1.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag==325) {
        CateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
        [cell reloadwith:_dataArray[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        Cate1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.superView = self;
        [cell reloadwith:self.dataArray1[indexPath.row]];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag==325) {
        return [UIView setHeight:50];

    }else {
        return [UIView setHeight:100];
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag ==325) {
        CateModel *model = _dataArray[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"?ctl=duobaos&data_id=%@",model.id];
        [self requestWithStr:str];
    }else {
        TenModel *model = self.dataArray1[indexPath.row];
        DetailViewController *deta = [[DetailViewController alloc]init];
        deta.userid = model.id;
        [self.navigationController pushViewController:deta animated:YES];
    }
    
}
- (void)requestWithStr:(NSString *)str {
    __weak __typeof(self) weakSelf = self;
    
    AFHTTPSessionManager*manager = [[AFHTTPSessionManager alloc]init];
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    self.tableview1.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page=1;
        NSString *url = [NSString stringWithFormat:@"%@%@&uid=%@&page=%d&v=3",urlpre,str,dele.userid,_page];

        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSelf.dataArray1 removeAllObjects];
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *arr = dic[@"list"];
            for (NSDictionary *dica in arr) {
                TenModel *model = [[TenModel alloc]initWithDictionary:dica error:nil];
                [weakSelf.dataArray1 addObject:model];
            }
            [weakSelf.tableview1 reloadData];
            [weakSelf.tableview1.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }];
    [self.tableview1.mj_header beginRefreshing];
    
    self.tableview1.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        AFHTTPSessionManager*manager = [[AFHTTPSessionManager alloc]init];
        _page ++;
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        NSString *url = [NSString stringWithFormat:@"%@%@&uid=%@&page=%d&v=3",urlpre,str,dele.userid,_page];
        
        
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *arr = dic[@"list"];
            if (arr.count==0) {
                [weakSelf.tableview1.mj_footer endRefreshingWithNoMoreData];
            }
            for (NSDictionary *dica in arr) {
                TenModel *model = [[TenModel alloc]initWithDictionary:dica error:nil];
                [weakSelf.dataArray1 addObject:model];
            }
            [weakSelf.tableview1 reloadData];
            [weakSelf.tableview1.mj_footer endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf.tableview1.mj_footer endRefreshing];
            
        }];
        
    }];
    
    self.tableview1.mj_footer.hidden = YES;

}
-(void)viewDidAppear:(BOOL)animated
{
    NSInteger selectedIndex = 0;
    
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    
    [self.tableview selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    [super viewDidAppear:animated];
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
