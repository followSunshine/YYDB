//
//  MyMessageViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/18.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "MyMessageViewController.h"
#import "Mymessagecell1.h"
#import "MesageModel.h"
#import "AFHTTPSessionManager.h"
#import "MyMessageCell.h"
#import "UITableViewCell+rload.h"
#import "UIView+CGSet.h"
@interface MyMessageViewController ()

@end
#define REUESED_SIZE  100
static NSString *reUsedStr[REUESED_SIZE] = {nil}; // 重用标示
#define REUESED_FLAG  reUsedStr[0]
@implementation MyMessageViewController
{
    UIView *baview;
}
+ (void)initialize
{
    if (self == [MyMessageViewController class])
    {
        for (int i = 0; i < REUESED_SIZE; i++)
        {
            reUsedStr[i] = [NSString stringWithFormat:@"cell%d", i];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setUI];
    [self reload];
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(delete:) name:@"deletecell" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    
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

- (void)delete:(NSNotification *)n {
    NSIndexPath* index = n.userInfo[@"row"];
    
    NSMutableArray *arr = self.dataArray[index.section];
    MesageModel *model = [arr objectAtIndex:index.row];
    [arr removeObjectAtIndex:index.row];
    [self.dataArray replaceObjectAtIndex:index.section withObject:arr];
    
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
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"删除成功" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
        }];
        [alert addAction:otherAction];
        [self presentViewController:alert animated:YES completion:nil];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)reload {
    
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
            [self.tableView removeFromSuperview];
            return ;
        }
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSArray *arr = dic[@"list"];
        NSMutableArray *arr1 = [NSMutableArray array];
        NSMutableArray *arr2 = [NSMutableArray array];
        for (NSDictionary *dica in arr) {
            MesageModel *model = [[MesageModel alloc]init];
            [model setValuesForKeysWithDictionary:dica];
            
            NSString *iconstr = dica[@"icon"];
            if (iconstr.length) {
                [arr1 addObject:model];
            }else{
                [arr2 addObject:model];
            }
        }
        if (arr1.count||arr2.count) {
            self.tableView.tableFooterView = nil;
        }else {
            self.tableView.tableFooterView = baview;
        }
        [self.dataArray addObject:arr1];
        [self.dataArray addObject:arr2];
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
}
- (void) setUI {
    self.dataArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = NO;
    baview = [[UIView alloc]initWithFrame:[UIView getRectWithX:0 andY:0 andWidth:320 andHeight:40]];
    baview.backgroundColor = [UIColor whiteColor];
    UILabel *label13 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:0 andY:0 andWidth:320 andHeight:40]];
    label13.text = @"暂无数据";
    label13.textAlignment = NSTextAlignmentCenter;
    label13.font = [UIFont systemFontOfSize:25];
    [baview addSubview:label13];
    
}
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_dataArray count]) {
        return [_dataArray[section] count];

    }else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UIView getHeight:60];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reUsedStr[indexPath.section]];
    
    // 根据不同的区域对应创建出该区域的cell
    if (cell == nil)
    {
        if (indexPath.section==0)
        {
            cell = [[MyMessageCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:reUsedStr[indexPath.section]];
        }
        else if (indexPath.section== 1)
        {
            cell = [[Mymessagecell1 alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:reUsedStr[indexPath.section]];
            
        }
        
           }
    [cell rloadwith:_dataArray[indexPath.section][indexPath.row] ];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);
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
