//
//  rizhiViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/19.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "rizhiViewController.h"
#import "rizhicell.h"
#import "AFHTTPSessionManager.h"
#import "RizhiModel.h"
@interface rizhiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableview;
@property (nonatomic , strong)NSMutableArray *dataArray;

@end

@implementation rizhiViewController

{
    UIView *baview;
    int page;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self reload];
    self.title = @"资金日志";
    self.automaticallyAdjustsScrollViewInsets = false;
}
- (void)setup {
    self.dataArray = [NSMutableArray array];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, SWIDTH, SHEIGHT - 70) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[rizhicell class] forCellReuseIdentifier:@"cellid"];
    [self.view addSubview:_tableview];
    self.tableview.separatorStyle = NO;
    page = 1;
    baview = [[UIView alloc]initWithFrame:[UIView getRectWithX:0 andY:0 andWidth:320 andHeight:40]];
    baview.backgroundColor = [UIColor whiteColor];
    UILabel *label13 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:0 andY:0 andWidth:320 andHeight:40]];
    label13.text = @"暂无数据";
    label13.textAlignment = NSTextAlignmentCenter;
    label13.font = [UIFont systemFontOfSize:25];
    [baview addSubview:label13];
}
- (void)reload {
    AFHTTPSessionManager *maanger = [[AFHTTPSessionManager alloc]init];
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!dele.userid.length) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还尚未登陆" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
        }];
        UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"再看看" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:act];
        [alert addAction:act1];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }

    NSString *url = [NSString stringWithFormat:@"%@?ctl=uc_money&uid=%@&page=%d",urlpre,dele.userid,page];
    [maanger GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSArray *dica = dic[@"list"];
        for (NSDictionary *dicb in dica) {
            RizhiModel *model = [[RizhiModel alloc]init];
            [model setValuesForKeysWithDictionary:dicb];
            [_dataArray addObject:model];
        }
        [self.tableview reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    rizhicell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    RizhiModel *model = (RizhiModel *)_dataArray[indexPath.row];
    [cell reloadwith:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UIView getHeight:60];
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
