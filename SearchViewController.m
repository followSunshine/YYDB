//
//  SearchViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/23.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "SearchViewController.h"
#import "AFHTTPSessionManager.h"
#import "SearchDetailViewController.h"
@interface SearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, strong)UIButton *returnBtn;
@property (nonatomic, strong)UIButton *cancelBtn;
@end


@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = false;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 64)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    [self setupUI];
    [self requestData];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)setupUI {
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(50, 15, SWIDTH-50, 44)];
    [self.searchBar setPlaceholder:@"搜索感兴趣的商品"];
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = NO;
    [self.view addSubview:self.searchBar];
    
    self.returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 15, 40, 34)];
    self.returnBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    for (UIView *view in self.searchBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    
    [self.returnBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.returnBtn addTarget:self action:@selector(returnBtnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.returnBtn];
    self.cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH, 10, 70, 44)];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelBtn];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = [UIView getHeight:30];
    self.tableView.backgroundColor = SF_COLOR(248, 248, 248);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor blueColor];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *bgview = [[UILabel alloc]initWithFrame:[UIView getRectWithX:0 andY:0 andWidth:320 andHeight:25]];
    bgview.backgroundColor = [UIColor whiteColor];
    bgview.textColor = [UIColor redColor];
    bgview.text = @"    热门搜索";
    return bgview;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [UIView getHeight:25];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SearchDetailViewController *seat = [[SearchDetailViewController alloc]init];
    seat.searchStr = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:seat animated:YES];
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
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [UIView animateWithDuration:0.5 animations:^{
        self.searchBar.frame = CGRectMake(0, 15, SWIDTH-50, 44);
        self.cancelBtn.frame = CGRectMake(SWIDTH-70, 10, 70, 44);
        [self.returnBtn removeFromSuperview];
    }];
    

}

// UISearchBarDelegate定义的方法，用户单击虚拟键盘上Search按键时激发该方法
- (void)filterBySubstring:(NSString *)str {
    
    SearchDetailViewController *seat = [[SearchDetailViewController alloc]init];
    seat.searchStr = str;
    [self.navigationController pushViewController:seat animated:YES];
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"----searchBarSearchButtonClicked------");
    // 调用filterBySubstring:方法执行搜索
    [self filterBySubstring:searchBar.text];
    // 放弃作为第一个响应者，关闭键盘
    [self.searchBar resignFirstResponder];
}


- (void)requestData {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSString *str = [NSString stringWithFormat:@"%@?v=3&ctl=search",urlpre];
    [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSLog(@"%@",responseObject);
        self.dataArray = dic[@"hot_kw"];
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
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
