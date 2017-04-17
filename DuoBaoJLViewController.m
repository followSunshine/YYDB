//
//  DuoBaoJLViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/11.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "DuoBaoJLViewController.h"
#import "UIView+CGGetRect.h"
#import "ShopTableViewCell.h"
#import "MJRefresh.h"
#import "AFHTTPSessionManager.h"
#import "DuoBaoJLModel.h"
#import "DuoBaoTableViewCell.h"
#import "UITableViewCell+rload.h"
#import "DetailViewController.h"
#import "DetailDaojishiViewController.h"
#import "DetailViewController.h"
#import "UIView+CGSet.h"
#import "DizhiWebViewController.h"
@interface DuoBaoJLViewController ()

@end

@implementation DuoBaoJLViewController
{
    NSInteger _page;
    UIView *baview;
    int isrefresh;
    int tmp;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    self.automaticallyAdjustsScrollViewInsets = false;
    [self setNavigationBar];
    [self creat];
    [self requestwith:0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zhuijia:) name:@"zhuijia" object:nil];
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(jilurefresh:) name:@"jilurefresh" object:nil];
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(seeNo:) name:@"seeNo" object:nil];
    
}
- (void)seeNo:(NSNotification *)n {
    NSIndexPath *index = n.userInfo[@"index"];
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    DuoBaoJLModel *model = _dataArray[index.section][index.row];
    DizhiWebViewController *wen = [[DizhiWebViewController alloc]init];
    wen.urlstring = [NSString stringWithFormat:@"%@?v=3&ctl=uc_duobao_record&act=my_no&page_type=app&id=%@&uid=%@",urlpre,model.id,app.userid];
    wen.titlestring = @"我的号码";
    [self.navigationController pushViewController:wen animated:YES];
    
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *selabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    selabel.font = [UIFont systemFontOfSize:18];
    selabel.text = @"夺宝记录";
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



- (void)jilurefresh:(NSNotification *)n {
    NSString *str = n.userInfo[@"index"];
    [self requestwith:str.intValue];
    
}
- (void)zhuijia:(NSNotification *)n {
    NSIndexPath *index = n.userInfo[@"index"];
    DuoBaoJLModel *model = _dataArray[index.section][index.row];
    DetailViewController *det = [[DetailViewController alloc]init];
    det.userid = model.id;
    [self hideTabBar];
    [self.navigationController pushViewController:det animated:YES];
    
}
- (void)requestwith:(NSInteger)index {
    tmp = (int)index;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
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
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
            self.tableView.tableFooterView = baview;
            return;
        }
        
        NSString *str = [NSString stringWithFormat:@"%@?ctl=uc_duobao_record&log_type=%d&page=%ld&uid=%@",urlpre,tmp,(long)_page,dele.userid];
        
        [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [_dataArray removeAllObjects];
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *arr = dic[@"list"];
            NSMutableArray *arr1 = [NSMutableArray array];
            NSMutableArray *arr2 = [NSMutableArray array];
            for (int i = 0; i < arr.count; i++) {
                NSDictionary *dica = arr[i];
                NSString *str1 = dica[@"luck_user_id"];
                if (str1.integerValue>0){
                    DuoBaoJLModel *model = [[DuoBaoJLModel alloc]initWithDictionary:dica error:nil];
                    [arr2 addObject:model];
                }else{
                    DuoBaoJLModel *model = [[DuoBaoJLModel alloc]initWithDictionary:dica error:nil];
                    [arr1 addObject:model];
                }
            }
            [_dataArray addObject:arr1];
            [_dataArray addObject:arr2];
            
            if (arr1.count||arr2.count) {
                self.tableView.tableFooterView = nil;
            }else {
                self.tableView.tableFooterView = baview;
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.tableView.mj_header endRefreshing];
        }];
        
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        
        NSString *str = [NSString stringWithFormat:@"%@?ctl=uc_duobao_record&log_type=%ld&page=%ld",urlpre,(long)index,(long)_page];
        
        [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *arr = dic[@"list"];
            if (arr.count==0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                return ;
            }
            NSMutableArray *arr1 = _dataArray[0];
            NSMutableArray *arr2 = _dataArray[1];
            for (int i = 0; i < self.dataArray.count; i++) {
                NSDictionary *dica = arr[i];
                NSString *str1 = dica[@"luck_user_id"];
                if (str1.integerValue>0){
                    DuoBaoJLModel *model = [[DuoBaoJLModel alloc]initWithDictionary:dica error:nil];
                    [arr2 addObject:model];
                }else{
                    DuoBaoJLModel *model = [[DuoBaoJLModel alloc]initWithDictionary:dica error:nil];
                    [arr1 addObject:model];
                }
            }
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.tableView.mj_footer endRefreshing];
        }];

        
    }];
    self.tableView.mj_footer.hidden = YES;
}
- (void)creat {
    NSArray *arr = @[@"全部",@"进行中",@"已揭晓"];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:i*125 andY:NavHeight andWidth:125 andHeight:40]];
        
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:SF_COLOR(51, 51, 51) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 610+i;
        [self.view addSubview:btn];
        
        UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:i*125 andY:NavHeight+39 andWidth:125 andHeight:1]];
        
        if (i==0) {
            label.backgroundColor = SF_COLOR(255, 54, 93);
        }
        label.tag = 620+i;
        [self.view addSubview:label];
    }
    UILabel *line = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:NavHeight+39.5 andWidth:375 andHeight:0.3]];
    line.backgroundColor = SF_COLOR(232, 232, 232);
    [self.view addSubview:line];
    self.tableView = [[UITableView alloc]initWithFrame:[UIView setRectWithX:0 andY:NavHeight+40 andWidth:375 andHeight:667-NavHeight-40] style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.dataArray = [NSMutableArray array];
    baview = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375    andHeight:667-NavHeight-40]];
    baview.backgroundColor = SF_COLOR(242, 242, 242);
    self.tableView.backgroundColor = SF_COLOR(242, 242, 242);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIImageView *image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:121.5 andY:128 andWidth:132 andHeight:108]];
    image.image = [UIImage imageNamed:@"无记录"];
    [baview addSubview:image];
    
    UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:244 andWidth:375 andHeight:17]];
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = SF_COLOR(153, 153, 153);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"暂时没有记录";
    [baview addSubview:label];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:127.5 andY:277 andWidth:120 andHeight:36]];
    [btn setTitle:@"马上夺宝" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = SF_COLOR(255, 54, 93);
    btn.layer.cornerRadius = 4;
    btn.clipsToBounds = YES;
    [btn addTarget:self action:@selector(btntap) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    [baview addSubview:btn];
    
    
}
- (void)btntap {
    NSNotification *notice = [NSNotification notificationWithName:@"pushtomain" object:nil userInfo:@{@"num":@"1"}];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = [self.dataArray[section] count] == 0;
    
    return [self.dataArray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arr = @[@"cell1",@"cell2"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:arr[indexPath.section]];
    if (indexPath.section == 0) {
        cell = [[ShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:arr[indexPath.section]];
    }else {
        cell = [[DuoBaoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:arr[indexPath.section]];
    }
    [ cell reloadwith:_dataArray[indexPath.section][indexPath.row]];
    cell.backgroundColor = SF_COLOR(242, 242, 242);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return [UIView setHeight:148];
    }else{
    return [UIView setHeight:160];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *det = [[DetailViewController alloc]init];
    DuoBaoJLModel *model = _dataArray[indexPath.section][indexPath.row];
    DetailDaojishiViewController *dao = [[DetailDaojishiViewController alloc]init];
    if (indexPath.section==0) {
        det.userid = model.id;
        [self.navigationController pushViewController:det animated:YES];
    }else {
        dao.userid = model.id;
        [self.navigationController pushViewController:dao animated:YES];
    }
    [self hideTabBar];
    
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

- (void)btnclick:(id)sender {
    UIButton *brn = (UIButton *)sender;
    
    NSLog(@"%ld",(long)brn.tag);
    if (brn.tag == 610) {
        [self requestwith:0];
    }else if(brn.tag == 611){
        [self requestwith:1];
    }else {
        [self requestwith:2];
    }
    for (int i = 0; i < 3; i++) {
        if (i == brn.tag - 610) {
            UILabel *label = [self.view viewWithTag:620+i];
            label.backgroundColor=SF_COLOR(255, 54, 93);
            
        }else {
            UILabel *label = [self.view viewWithTag:620+i];
            label.backgroundColor=[UIColor whiteColor];
        }
    }
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
