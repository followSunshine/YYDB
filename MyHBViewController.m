//
//  MyHBViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/29.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "MyHBViewController.h"
#import "UIView+CGSet.h"
#import "AFHTTPSessionManager.h"
#import "MJRefresh.h"
#import "MyHBTableViewCell.h"
#import "MyHBHavenTableViewCell.h"
#import "HBModel.h"
#import "UITableViewCell+rload.h"
@interface MyHBViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)BOOL isTake;
@property (nonatomic,strong)UIView *bgview;
@end

@implementation MyHBViewController
{
    UILabel *linelabel;
    UILabel *linelabel1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setUI];
    [self request];
    
}
- (void)request {
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        int a ;
        if (_isTake) {
            a=1;
        }else {
            a=0;
        }
        NSString *url = [NSString stringWithFormat:@"%@?v=3&ctl=uc_hongbao&uid=%@&status=%d",urlpre,del.userid,a];
        
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *arr = dic[@"hongbao_list"];
            [self.dataArray removeAllObjects];

            if (arr.count) {
                self.tableView.tableFooterView = nil;
            }else {
                self.tableView.tableFooterView = self.bgview;
            }
            for (NSDictionary *dica in arr) {
                HBModel *model = [[HBModel alloc]initWithDictionary:dica error:nil];
                [self.dataArray addObject:model];
            }
            if (!self.dataArray.count) {
                self.tableView.alpha = 1;
            }
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.tableView.mj_header endRefreshing];

        }];
        
        
    }];
    [self.tableView.mj_header beginRefreshing];
}
- (void)setUI {
    self.isTake = NO;
    UIButton *btn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:0 andY:NavHeight andWidth:187.5 andHeight:40]];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:@"未使用" forState:UIControlStateNormal];
    [btn setTitleColor:SF_COLOR(51, 51, 51) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(neverTake) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:[UIView setRectWithX:187.5 andY:NavHeight andWidth:187.5 andHeight:40]];
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"历史红包" forState:UIControlStateNormal];
    [btn1 setTitleColor:SF_COLOR(51, 51, 51) forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(haveTake) forControlEvents:UIControlEventTouchUpInside];
    btn1.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:btn1];
    
    linelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:58.5 andY:39+NavHeight andWidth:80 andHeight:1]];
    linelabel.backgroundColor = SF_COLOR(255, 54, 93);
    [self.view addSubview:linelabel];
    
    linelabel1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:241.5 andY:39+NavHeight andWidth:80 andHeight:1]];
    linelabel1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:linelabel1];
    
    self.dataArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc]initWithFrame:[UIView setRectWithX:0 andY:NavHeight +40 andWidth:375 andHeight:667-NavHeight-40] style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = SF_COLOR(242, 242, 242);
    
    
    self.bgview = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:NavHeight +40 andWidth:375 andHeight:667-NavHeight-40]];
    UIImageView *image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:138.5 andY:116 andWidth:98 andHeight:98]];
    image.image = [UIImage imageNamed:@"红包提示"];
    [self.bgview addSubview:image];
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:224 andWidth:375 andHeight:15]];
    titlelabel.font = [UIFont systemFontOfSize:15];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.textColor = SF_COLOR(153, 153, 153);
    titlelabel.text = @"暂无可使用红包哦～";
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.bgview addSubview:titlelabel];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = self.dataArray.count==0;
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arr=@[@"cell1",@"cell2"];
    int a = (int)self.isTake;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:arr[a]];
    if(!_isTake) {
        cell =  [[MyHBTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:arr[a]];
        
    }else {
        cell = [[MyHBHavenTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:arr[a]];
    }
    [cell reloadwith:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [UIView setHeight:144];
    }else {
        return [UIView setHeight:136];
    }
}
- (void)haveTake {
    linelabel1.backgroundColor = SF_COLOR(255, 54, 93);
    linelabel.backgroundColor = [UIColor whiteColor];
    _isTake = YES;
    self.tableView.alpha = 0.3;
    
    [self request];
    
}
- (void)neverTake {
    linelabel.backgroundColor = SF_COLOR(255, 54, 93);
    linelabel1.backgroundColor = [UIColor whiteColor];
    self.tableView.alpha = 1;
    _isTake = NO;
    [self request];
}

- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"我的红包";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 64)];
    view.backgroundColor = SF_COLOR(255, 54, 93);
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIView setWidth:12], 30, 24, 24)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"左白箭头"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];
    [self.view addSubview:label];
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
