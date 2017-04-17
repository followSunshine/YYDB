//
//  MyzhongjiangjiluViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/21.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "MyzhongjiangjiluViewController.h"
#import "AFHTTPSessionManager.h"
#import "ZhongjiangCell.h"
#import "Zhongjiangjilu.h"
#import "UIImageView+WebCache.h"
#import "DizhiWebViewController.h"
#import "DizhiViewController.h"
#import "UIView+CGSet.h"
#import "GouwuCollectionViewCell.h"
#import "TJModel.h"
#import "DetailViewController.h"
#define TabbarHeght 49*667/[UIScreen mainScreen].bounds.size.height
@interface MyzhongjiangjiluViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UITableView *table;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UILabel *idlabel;
@property (nonatomic, strong)UILabel *titlelabel;
@property (nonatomic, strong)UIImageView *headimage;
@property (nonatomic, strong)NSMutableArray *clDataArray;
@property (nonatomic, strong)UICollectionView *collectionView;
@end

@implementation MyzhongjiangjiluViewController
{
    UIView *baview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setup];
    [self reload];
    [self requestTJData];
    self.title = @"";
    self.automaticallyAdjustsScrollViewInsets = false;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chuli:) name:@"zhongjiangjilu" object:nil];
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *selabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    selabel.font = [UIFont systemFontOfSize:18];
    selabel.text = @"中奖纪录";
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


- (void)chuli:(NSNotification *)n {
    NSDictionary *dic = n.userInfo;
    NSString *sta = dic[@"status"];
    int a = sta.intValue;
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

    if (a==1) {
        DizhiWebViewController *web = [[DizhiWebViewController alloc]init];
        web.urlstring = [NSString stringWithFormat:@"%@?ctl=uc_order&act=check_delivery&item_id=%@&uid=%@",urlpre,dic[@"woodid"],dele.userid];
        [self.navigationController pushViewController:web animated:YES];
    }else if (a==2){
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        NSString *url = [NSString stringWithFormat:@"%@?ctl=uc_order&act=verify_delivery&item_id=%@&uid=%@",urlpre,dic[@"woodid"],dele.userid];
        
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"%@",responseObject);
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认收货成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            
            [self reload];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }else {
        DizhiViewController *dizhi = [[DizhiViewController alloc]init];
        [self.navigationController pushViewController:dizhi animated:YES];
    }
    
}
- (void)setup {
    self.dataArray = [NSMutableArray array];
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT - 64) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    [self.table registerClass:[ZhongjiangCell class] forCellReuseIdentifier:@"cellid"];
    
    
    baview = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:667-NavHeight]];
    baview.backgroundColor = [UIColor whiteColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:133     andY:129 andWidth:107 andHeight:93]];
    image.image = [UIImage imageNamed:@"无中奖记录"];
    
    [baview addSubview:image];
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:230 andWidth:375 andHeight:14]];
    titlelabel.text = @"您还没有中奖纪录哦~";
    titlelabel.textColor = SF_COLOR(102, 102, 102);
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font = [UIFont systemFontOfSize:14];
    [baview addSubview:titlelabel];
    UIButton *btn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:137.5 andY:260 andWidth:100 andHeight:36]];
    btn.backgroundColor = SF_COLOR(255, 54, 93);
    [btn setTitle:@"马上夺宝" forState:UIControlStateNormal];
    [btn setTitleColor:SF_COLOR(255, 255, 255) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:22];
    btn.layer.cornerRadius = 4;
    
    btn.clipsToBounds = YES;
    [baview addSubview:btn];
    [btn addTarget:self action:@selector(gotoSee) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:0 andY:353+TabbarHeght andWidth:140 andHeight:1]];
    image1.image = [UIImage imageNamed:@"分割线左"];
    [baview addSubview:image1];
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:235 andY:353+TabbarHeght andWidth:140 andHeight:1]];
    image2.image = [UIImage imageNamed:@"分割线"];
    [baview addSubview:image2];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:140 andY:346+TabbarHeght andWidth:95 andHeight:15]];
    label1.textColor = SF_COLOR(102, 102, 102);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"猜您喜欢";
    label1.font = [UIFont systemFontOfSize:17];
    [baview addSubview:label1];
    
    baview.userInteractionEnabled = YES;
    
    self.clDataArray = [NSMutableArray array];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:[UIView setRectWithX:16.5 andY:375+TabbarHeght andWidth:342 andHeight:147] collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[GouwuCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake([UIView setWidth:107], [UIView setHeight:147]);
    [baview addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.table.tableFooterView.backgroundColor = [UIColor whiteColor];
}
- (void)requestTJData {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    [manager GET:[NSString stringWithFormat:@"%@?ctl=cart&act=rec&v=3",urlpre] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic  = (NSDictionary *)responseObject;
        NSArray *arr = dic[@"rec_cart_list"];
        if (self.clDataArray.count) {
            [self.clDataArray removeAllObjects];
        }
        for (NSDictionary *dica in arr) {
            TJModel *model = [[TJModel alloc]initWithDictionary:dica error:nil];
            [self.clDataArray addObject:model];
        }
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)gotoSee {
    NSNotification *notice = [NSNotification notificationWithName:@"pushtomain" object:nil userInfo:@{@"num":@"1"}];
    
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.clDataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GouwuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    [cell reloadWithModel:self.clDataArray[indexPath.row]];
    return cell;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"1");
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TJModel *model = self.clDataArray[indexPath.row];
    DetailViewController *deta = [[DetailViewController alloc]init];
    deta.userid =model.id;
    [self.navigationController pushViewController:deta animated:YES];
    
    
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)reload {
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

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSString *url = [NSString stringWithFormat:@"%@?ctl=uc_winlog&uid=%@",urlpre,dele.userid];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSArray *arr = dic[@"list"];
        
        [_dataArray removeAllObjects];
        for (NSDictionary *dica in arr) {
            NSError *err;
            Zhongjiangjilu *model = [[Zhongjiangjilu alloc]initWithDictionary:dica error:&err];
            NSLog(@"%@",err);
            [_dataArray addObject:model];
        }
        if (_dataArray.count==0) {
            self.table.tableFooterView = baview;
        }else {
            self.table.tableFooterView = nil;
        }
        [self.table reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZhongjiangCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    [cell reloaddataWith:_dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIView setHeight:128];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
