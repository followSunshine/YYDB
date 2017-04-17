//
//  JFMViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/30.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "JFMViewController.h"
#import "UIView+CGSet.h"
#import "AFHTTPSessionManager.h"
#import "MJRefresh.h"
#import "JFMTableViewCell.h"
#import "JFModel.h"
@interface JFMViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UIView *bgview;

@end

@implementation JFMViewController
{
    int page;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self request];
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
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        NSString *url = [NSString stringWithFormat:@"%@?v=3&ctl=uc_score&act=lst&uid=%@&page=%d",urlpre,dele.userid,page];
        
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSelf.dataArray removeAllObjects];
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            NSArray *arr = dic[@"list"];
            for (NSDictionary *dica in arr) {
                JFModel *model = [[JFModel alloc]initWithDictionary:dica error:nil];
                [weakSelf.dataArray addObject:model];
            }
            if (weakSelf.dataArray.count==0) {
                weakSelf.tableView.tableFooterView = weakSelf.bgview;
            }else {
                weakSelf.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
            }
            [weakSelf.tableView reloadData];
            
            [weakSelf.tableView.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [weakSelf.tableView.mj_header endRefreshing];
            
        }];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
}
- (void)setUI {
    page = 1;
    self.view.backgroundColor = SF_COLOR(242, 242, 242);
    
    self.bgview = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:419]];
    UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:120 andWidth:375 andHeight:15]];
    label.text = @"暂无记分纪录哦～";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = SF_COLOR(198, 198, 198);
    [self.bgview addSubview:label];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:137.5 andY:151 andWidth:100 andHeight:32]];
    [btn setTitle:@"马上夺宝" forState:UIControlStateNormal];
    btn.backgroundColor = SF_COLOR(255, 54, 93);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.clipsToBounds = YES;
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
//    [self.bgview addSubview:btn];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:198]];
    image.image = [UIImage imageNamed:@"矩形-6"];
    [self.view addSubview:image];
    
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:12 andY:30 andWidth:24 andHeight:24]];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"左白箭头"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:36 andY:20 andWidth:303 andHeight:44]];
    titlelabel.text = @"我的积分";
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.font = [UIFont systemFontOfSize:20];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titlelabel];
    
    UILabel *jflabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:82 andWidth:375 andHeight:55]];
    jflabel.textAlignment = NSTextAlignmentCenter;
    jflabel.textColor = [UIColor whiteColor];
    NSString*str = [NSString stringWithFormat:@"%@分",self.jifenstr];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:str];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:55] range:NSMakeRange(0, self.jifenstr.length)];
    [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(self.jifenstr.length, 1)];
    jflabel.attributedText = str1;

    
    [self.view addSubview:jflabel];
    
    
    UILabel *dhlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:137 andWidth:375 andHeight:12]];
    dhlabel.textColor = [UIColor whiteColor];
    dhlabel.font = [UIFont systemFontOfSize:12];
    dhlabel.textAlignment = NSTextAlignmentCenter;
    dhlabel.text = @"(兑换比例200:1)";
    [self.view addSubview:dhlabel];
    
    UIView *zview = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:208 andWidth:375 andHeight:40]];
    zview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:zview];
    
    UILabel *slabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:12 andWidth:4 andHeight:16]];
    slabel.backgroundColor = SF_COLOR(255, 54, 93);
    [zview addSubview:slabel];
    
    UILabel *zqlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:21 andY:0 andWidth:100 andHeight:40]];
    zqlabel.text = @"积分明细";
    zqlabel.font = [UIFont systemFontOfSize:17];
    zqlabel.textColor = SF_COLOR(51, 51, 51);
    [zview addSubview:zqlabel];
    UILabel *lina = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:39.5 andWidth:363 andHeight:0.3]];
    lina.backgroundColor = SF_COLOR(204, 204, 204);
    [zview addSubview:lina];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIView setRectWithX:0 andY:248 andWidth:375 andHeight:419] style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.dataArray = [NSMutableArray array];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[JFMTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIView setHeight:44];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JFMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell reloadWithModel:_dataArray[indexPath.row]];
    return cell;
}

- (void)returnclick {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)btnclick {
    
    
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
