//
//  MyshaidanViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/21.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "MyshaidanViewController.h"
#import "luckCell.h"
#import "luckModel.h"
#import "shareCell.h"
#import "shareModel.h"
#import "UITableViewCell+rload.h"
#import "GouwuCollectionViewCell.h"
#import "AFHTTPSessionManager.h"
#import "DizhiWebViewController.h"
#import "UIView+CGSet.h"
#import "DetailDaojishiViewController.h"
#import "DetailViewController.h"

#define TabbarHeght 49*667/[UIScreen mainScreen].bounds.size.height
@interface MyshaidanViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *clDataArray;
@end
#define REUESED_SIZE  100
static NSString *reUsedStr[REUESED_SIZE] = {nil}; // 重用标示
#define REUESED_FLAG  reUsedStr[0]

@implementation MyshaidanViewController
{
    UIView *baview;
}
+ (void)initialize
{
    if (self == [MyshaidanViewController class])
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
    [self setup];
    [self reload];
    [self requestTJData];
    self.automaticallyAdjustsScrollViewInsets = false;
    self.title = @"晒单";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shainow:) name:@"shainow" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push:) name:@"indexno" object:nil];

}
- (void)push:(NSNotification *)n {
    NSIndexPath *index = n.userInfo[@"index"];
    DetailDaojishiViewController *deta = [[DetailDaojishiViewController alloc]init];
    shareModel *model = _dataArray[index.section][index.row];
    deta.userid = model.duobao_item_id;
    [self.navigationController pushViewController:deta animated:YES];
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *selabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    selabel.font = [UIFont systemFontOfSize:18];
    selabel.text = @"我的晒单";
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


- (void)shainow:(NSNotification *)n {
    NSDictionary *dic = n.userInfo;
    NSIndexPath *index = dic[@"index"];
    
    luckModel *model = _dataArray[index.section][index.row];
    DizhiWebViewController *dizhi = [[DizhiWebViewController alloc]init];
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!del.userid.length) {
        
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
    dizhi.urlstring = [NSString stringWithFormat:@"%@?ctl=uc_share&act=add&page_type=app&id=%@&uid=%@",urlpre,model.duobao_item_id,del.userid];
    dizhi.titlestring = @"立即晒单";
    [self.navigationController pushViewController:dizhi animated:YES];
}
- (void)setup {
    self.dataArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
  

    
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
    self.tableView.tableFooterView.backgroundColor = [UIColor whiteColor];

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

    NSString *url = [NSString stringWithFormat:@"%@?ctl=uc_share&uid=%@&page=1&v=4",urlpre,dele.userid];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *arr1 = [NSMutableArray array];
        NSMutableArray *arr2 = [NSMutableArray array];
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSArray *arr3 = dic[@"luck_list"];
        NSArray *arr4 = dic[@"share_list"];
        for (NSDictionary *dica in arr3) {
            luckModel *model = [[luckModel alloc]initWithDictionary:dica error:nil];
            [arr1 addObject:model];
        }
        for (NSDictionary *dica in arr4) {
            shareModel *model = [[shareModel alloc]initWithDictionary:dica error:nil];
            [arr2 addObject:model];
        }
        if (arr1.count==0&&arr2.count==0) {
            self.tableView.tableFooterView = baview;
        }else {
            self.tableView.tableFooterView = nil;
        }
        [self.dataArray addObject:arr1];
        [self.dataArray addObject:arr2];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reUsedStr[indexPath.section]];
    
    // 根据不同的区域对应创建出该区域的cell
    if (cell == nil)
    {
        if (indexPath.section==0)
        {
            cell = [[luckCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:reUsedStr[indexPath.section]];
        }
        else if (indexPath.section== 1)
        {
            cell = [[shareCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:reUsedStr[indexPath.section]];
            
        }
        
    }
    [cell reloadwith:_dataArray[indexPath.section][indexPath.row] ];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return [UIView setHeight:95];
    }else if (indexPath.section == 1){
        return [UIView setHeight:222];
    }return 0;
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
