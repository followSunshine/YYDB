//
//  SearchDetailViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/23.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "SearchDetailViewController.h"
#import "AFHTTPSessionManager.h"
#import "TenModel.h"
#import "TenTableViewCell.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "UIView+CGSet.h"
@interface SearchDetailViewController ()<UITableViewDelegate,UISearchBarDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, strong)UIButton *returnBtn;
@property (nonatomic, strong)UIButton *cancelBtn;
@end


@implementation SearchDetailViewController
{
    int _page;
    UIView *baview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.automaticallyAdjustsScrollViewInsets = false;
    [self setNavigition];
    [self setup];
    [self request];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(alert:) name:@"alert" object:nil];
}
- (void)alert:(NSNotification *)n {
    NSDictionary *dic = n.userInfo;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"info"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:act];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)setNavigition {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"夺宝";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationController.navigationBar.hidden = YES;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 64)];
    view.backgroundColor = SF_COLOR(255, 54, 93);
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIView setWidth:12], 30, 24, 24)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"左白箭头"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnclick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:view];
    [self.view addSubview:returnBtn];
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake((1-250/375.)/2*SWIDTH, 28,250/375.*SWIDTH, 28)];
    [self.searchBar setPlaceholder:@"搜索"];
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = NO;
    for (UIView *view in self.searchBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    [self.view addSubview:self.searchBar];
    
    UITextField *text = [self.searchBar valueForKey:@"_searchField"];
    text.backgroundColor = SF_COLOR(197, 47, 71);
    text.textColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"icon--搜索"];
    UIImageView *imagevoew = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    imagevoew.image = image;
    text.leftView = imagevoew;
}

- (void)setup {
    

    baview = [[UIView alloc]initWithFrame:[UIView getRectWithX:0 andY:0 andWidth:320 andHeight:40]];
    baview.backgroundColor = [UIColor whiteColor];
    UILabel *label13 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:0 andY:0 andWidth:320 andHeight:40]];
    label13.text = @"暂无数据";
    label13.textAlignment = NSTextAlignmentCenter;
    label13.font = [UIFont systemFontOfSize:25];
    [baview addSubview:label13];
//    [self.returnBtn setTitle:@"返回" forState:UIControlStateNormal];
//    [self.returnBtn addTarget:self action:@selector(returnBtnclick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.returnBtn];
//    self.cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH, 10, 70, 44)];
//    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [self.cancelBtn addTarget:self action:@selector(cancelBtnclick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.cancelBtn];
    
    
    self.dataArray = [NSMutableArray array];
    _page = 1;
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT - 64) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource  =self;
    [self.view addSubview:self.tableview];
    [self.tableview registerClass:[TenTableViewCell class] forCellReuseIdentifier:@"cellid"];
    
}
- (void)cancelBtnclick {
    
    [self.searchBar resignFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.searchBar.frame = CGRectMake(50, 15, SWIDTH-50, 44);
        self.cancelBtn.frame = CGRectMake(SWIDTH, 10, 70, 44);
        [self.view addSubview:self.returnBtn];
    }];
    
    
}
- (void)returnBtnclick {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

// UISearchBarDelegate定义的方法，用户单击虚拟键盘上Search按键时激发该方法
- (void)filterBySubstring:(NSString *)str {
    
    self.searchStr = str;
    
    [self.tableview.mj_header beginRefreshing];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"----searchBarSearchButtonClicked------");
    // 调用filterBySubstring:方法执行搜索
    [self filterBySubstring:searchBar.text];
    // 放弃作为第一个响应者，关闭键盘
    [self.searchBar resignFirstResponder];
}
- (void)request {
    AFHTTPSessionManager*manager = [[AFHTTPSessionManager alloc]init];
    
    

    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSString *str = [NSString stringWithFormat:@"%@?ctl=duobaos&v=3&keyword=%@&page=%d",urlpre,self.searchStr,_page];
        
        str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

        [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [_dataArray removeAllObjects];
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *arr = dic[@"list"];
            if (arr.count) {
                for (NSDictionary *dica in arr) {
                    TenModel *model = [[TenModel alloc]initWithDictionary:dica error:nil];
                    [self.dataArray addObject:model];
                }
                [self.tableview reloadData];
                
                self.tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
            }else {
                self.tableview.tableFooterView = baview;
                [self.tableview reloadData];
            }
                [self.tableview.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
            [self.tableview.mj_header endRefreshing];
            
            
        }];
        
    }];
    [self.tableview.mj_header beginRefreshing];
    
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        AFHTTPSessionManager*manager = [[AFHTTPSessionManager alloc]init];
        _page ++;
        NSString *str = [NSString stringWithFormat:@"%@ctl=duobaos&v=3keyword=%@&page=%d",urlpre,self.searchStr,_page];
        str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

        [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *arr = dic[@"list"];
            if (arr.count==0) {
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
            }
            for (NSDictionary *dica in arr) {
                TenModel *model = [[TenModel alloc]initWithDictionary:dica error:nil];
                [self.dataArray addObject:model];
            }
            [self.tableview reloadData];
            [self.tableview.mj_footer endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.tableview.mj_footer endRefreshing];
            
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
    return [UIView getHeight:90];
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
