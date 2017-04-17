//
//  HelpViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/26.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "HelpViewController.h"
#import "AFHTTPSessionManager.h"
#import "DizhiWebViewController.h"
#import "UIView+CGSet.h"
@interface HelpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self creatData];
    self.title = @"帮助";
    self.automaticallyAdjustsScrollViewInsets = false;
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *selabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    selabel.font = [UIFont systemFontOfSize:18];
    selabel.text = @"帮助";
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
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64) style:UITableViewStylePlain];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    [self.view addSubview:self.tableview];
    self.dataArray = [NSMutableArray array];
    self.tableview.tableFooterView = [[UIView alloc]init];
    
}
- (void) creatData {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSString *url = [NSString stringWithFormat:@"%@?ctl=helps",urlpre];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject ;
        
        self.dataArray = dic[@"list"];
        [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataArray.count) {
        NSDictionary *dic = _dataArray[section];
        NSArray *arr = dic[@"article_list"];
        return arr.count;

    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    NSDictionary *dic = _dataArray[indexPath.section];
    NSArray *arr = dic[@"article_list"];
    NSDictionary *dica = arr[indexPath.row];
    cell.textLabel.text = dica[@"title"];
    cell.textLabel.textColor = SF_COLOR(112, 124, 138);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc]initWithFrame:[UIView getRectWithX:10 andY:0 andWidth:310 andHeight:30]];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = SF_COLOR(34, 34, 34);
    NSDictionary *dic = _dataArray[section];
    label.text = dic[@"title"];
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIView getHeight:25];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [UIView getHeight:30];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = _dataArray[indexPath.section];
    NSArray *arr = dic[@"article_list"];
    NSDictionary *dica = arr[indexPath.row];
    NSString *url = [NSString stringWithFormat:@"%@%@",urlpre,dica[@"url"]];
    DizhiWebViewController *web = [[DizhiWebViewController alloc]init];
    web.urlstring = url;
    web.titlestring = dica[@"title"];
    [self.navigationController pushViewController:web animated:YES];
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
