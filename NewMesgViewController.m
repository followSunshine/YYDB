//
//  NewMesgViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/12/21.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "NewMesgViewController.h"
#import "NewMesgTableViewCell.h"
#import "AFHTTPSessionManager.h"
#import "UIView+CGSet.h"
#import "MesageModel.h"
@interface NewMesgViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation NewMesgViewController
{
    UIView *baview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    
    [self setUI];
    [self request];
    self.view.backgroundColor = SF_COLOR(242, 242, 242);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delCell:) name:@"delcell" object:nil];
}
- (void)delCell:(NSNotification *)n {
    NSIndexPath *index = n.userInfo[@"row"];
    MesageModel *model = self.dataArray[index.row];
    [self.dataArray removeObjectAtIndex:index.row];
    [self.tableView reloadData];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
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
    NSString *url = [NSString stringWithFormat:@"%@?ctl=uc_msg&act=remove_msg&id=%@&uid=%@",urlpre,model.userid,dele.userid];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSNumber *num = dic[@"status"];
        if (num.integerValue==1) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"删除成功" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            }];
            [alert addAction:otherAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
       
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
- (void)setUI {
    self.dataArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[NewMesgTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.backgroundColor = SF_COLOR(242, 242, 242);
    baview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT-64)];
    baview.backgroundColor = SF_COLOR(242, 242, 242);
    UIImageView *image= [[UIImageView alloc]initWithFrame:[UIView setRectWithX:116.5 andY:135+NavHeight andWidth:142 andHeight:126]];
    image.image = [UIImage imageNamed:@"无消息"];
    
    
    
    [baview addSubview:image];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:143+126+NavHeight andWidth:375 andHeight:18]];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = SF_COLOR(153, 153, 153);
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = @"暂无消息通知";
    [baview addSubview:label];
}
- (void)request {
    AFHTTPSessionManager *manager= [[AFHTTPSessionManager alloc]init];
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
    
    NSString *url = [NSString stringWithFormat:@"%@?ctl=uc_msg&uid=%@",urlpre,dele.userid];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (!responseObject) {
            self.tableView.tableFooterView = baview;
            return ;
        }
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSArray *arr = dic[@"list"];

        for (NSDictionary *dica in arr) {
            MesageModel *model = [[MesageModel alloc]init];
            [model setValuesForKeysWithDictionary:dica];
            
            [self.dataArray addObject:model];
        }
        
        if (self.dataArray.count) {
            self.tableView.tableFooterView = nil;
        }else {
            self.tableView.tableFooterView = baview;
        }
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIView setHeight:116];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewMesgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = SF_COLOR(242, 242, 242);
    [cell reloadWithModel:self.dataArray[indexPath.row]];
    
    return cell;
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *selabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    selabel.font = [UIFont systemFontOfSize:18];
    selabel.text = @"我的消息";
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
