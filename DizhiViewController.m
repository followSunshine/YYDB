//
//  DizhiViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/19.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "DizhiViewController.h"
#import "DizhiCell.h"
#import "AFHTTPSessionManager.h"
#import "DizhiModel.h"
#import "DizhiWebViewController.h"
#import "UIView+CGSet.h"

@interface DizhiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSString *addurl;
@property (nonatomic, strong)UIView *bgview;
@property (nonatomic, assign)NSInteger page;
@property (nonatomic, strong)UIButton *addButton;
@end

@implementation DizhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setupUI];
    [self reloadData];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(btnclick:) name:@"dizhiclick" object:nil];
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *selabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    selabel.font = [UIFont systemFontOfSize:18];
    selabel.text = @"配送地址";
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


- (void)btnclick:(NSNotification *)n {
    NSDictionary *dic = n.userInfo;
    DizhiWebViewController *web = [[DizhiWebViewController alloc]init];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSIndexPath *index = dic[@"row"];
    DizhiModel *model = _dataArray[index.row];
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
    
  
    if ([dic[@"num"]isEqualToString:@"1"]) {

        web.urlstring = [NSString stringWithFormat:@"%@%@&uid=%@&v=5",urlpre,model.edit_url,dele.userid];
        [self.navigationController pushViewController:web animated:YES];
        
        
    }else if ([dic[@"num"]isEqualToString:@"2"]) {
        [_dataArray removeObjectAtIndex:index.row];
        [self.tableview reloadData];
        [manager GET:[NSString stringWithFormat:@"%@%@&uid=%@",urlpre,model.del_url,dele.userid] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
    }else{
        
        [manager GET:[NSString stringWithFormat:@"%@%@&uid=%@",urlpre,model.dfurl,dele.userid] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
        
        
    }
}
- (void)setupUI{
    self.dataArray = [NSMutableArray array];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT - 64) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[DizhiCell class] forCellReuseIdentifier:@"cellid"];
    [self.view addSubview:self.tableview];
    self.tableview.backgroundColor = SF_COLOR(242, 242, 242);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT-64)];
    _bgview.backgroundColor = SF_COLOR(232, 232, 232);
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:115 andY:109 andWidth:145 andHeight:120]];
    imageview.image = [UIImage imageNamed:@"地址-无"];
    [_bgview addSubview:imageview];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:242 andWidth:375 andHeight:16]];
    titleLabel.textColor = SF_COLOR(102, 102, 102);
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"您还没有添加收货地址哦";
    [_bgview addSubview:titleLabel];
    
    UILabel *titleLabel1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:268 andWidth:375 andHeight:16]];
    titleLabel1.textColor = SF_COLOR(102, 102, 102);
    titleLabel1.font = [UIFont systemFontOfSize:16];
    titleLabel1.textAlignment = NSTextAlignmentCenter;
    titleLabel1.text = @"快去添加吧";
    [_bgview addSubview:titleLabel1];
    
    UIButton *addBtn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:112.5 andY:316 andWidth:150 andHeight:40]];
    addBtn.backgroundColor = SF_COLOR(255, 54, 93);
    [addBtn setTitle:@"新建地址" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.layer.cornerRadius = 4;
    addBtn.clipsToBounds = YES;
    addBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [addBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    [_bgview addSubview:addBtn];
    
    
//    UIView *view = [[UIView alloc]initWithFrame:[UIView getRectWithX:0 andY:0 andWidth:320 andHeight:35]];
//    UIButton *addbtn = [[UIButton alloc]initWithFrame:[UIView getRectWithX:5 andY:5 andWidth:310 andHeight:20]];
//    addbtn.backgroundColor = SF_COLOR(255, 54, 93);
//    [addbtn setTitle:@"新增地址" forState:UIControlStateNormal];
//    [addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    addbtn.layer.cornerRadius = [UIView getWidth:20]/2;
//    addbtn.clipsToBounds = YES;
//    addbtn.titleLabel.font = [UIFont systemFontOfSize:14];
//
//    [addbtn addTarget:self action:@selector(addclick) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:addbtn];
//    self.tableview.tableHeaderView = view;
    
    self.addButton=[[UIButton alloc]initWithFrame:[UIView setRectWithX:12 andY:607 andWidth:351 andHeight:40]];
    self.addButton.backgroundColor = SF_COLOR(255, 54, 93);
    [self.addButton setTitle:@"＋新增地址" forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addButton.clipsToBounds = YES;
    self.addButton.layer.cornerRadius = 4;
    
    [self.addButton addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
}
- (void)addAddress {
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
    self.addurl = [NSString stringWithFormat:@"?ctl=uc_address&act=add&uid=%@&page_type=app",dele.userid];
    DizhiWebViewController *web = [[DizhiWebViewController alloc]init];
    web.urlstring = [NSString stringWithFormat:@"%@%@&v=5",urlpre,self.addurl];
    web.titlestring = @"地址管理";
    [self.navigationController pushViewController:web animated:YES];
    
}
- (void)addclick {
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
    self.addurl = [NSString stringWithFormat:@"?ctl=uc_address&act=add&uid=%@&page_type=app",dele.userid];
    DizhiWebViewController *web = [[DizhiWebViewController alloc]init];
    web.urlstring = [NSString stringWithFormat:@"%@%@",urlpre,self.addurl];
    web.titlestring = @"地址管理";
    [self.navigationController pushViewController:web animated:YES];
}
- (void)reloadData {
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
 
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSString *url = [NSString stringWithFormat:@"%@?ctl=uc_address&uid=%@",urlpre,dele.userid];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.dataArray removeAllObjects];
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSArray *arr = dic[@"list"];

        for (int i = 0; i<arr.count; i++) {
            NSDictionary *dica = arr[i];
            
            DizhiModel *model = [[DizhiModel alloc]initWithDictionary:dica error:nil];
            [_dataArray addObject:model];
            if (model.addurl.length) {
                self.addurl = model.addurl;
            }
            if ([model.is_default isEqualToString:@"1"])
            {
                self.page = i;
            }
        }
        if (self.dataArray.count>0) {
            self.tableview.tableFooterView = nil;
            
            [self.view addSubview:self.addButton];
        }else {
            self.tableview.tableFooterView = self.bgview;
            [self.addButton removeFromSuperview];
        }
        [self.tableview reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error-------%@",error);
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (self.tableview) {
        [self reloadData];
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DizhiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    [cell reloadwith:_dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UIView setHeight:110];
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
