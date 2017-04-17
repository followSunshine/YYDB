//
//  GouwuController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/22.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "GouwuController.h"
#import "GouwuCell.h"
#import "GouwuModel.h"
#import "AFHTTPSessionManager.h"
#import "PayViewController.h"
#import "MJRefresh.h"
#import "GouwuCollectionViewCell.h"
#import "UIView+CGSet.h"
#import "TJModel.h"
#import "myUILabel.h"
#import "DetailViewController.h"
#import "LBProgressHUD.h"
@interface GouwuController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UITableView *tabel;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UIButton *addbtn;
@property (nonatomic, strong)myUILabel *label;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *clDataArray;
@property (nonatomic,strong)UILabel *numlabel;
@end

@implementation GouwuController
{
    UIView *baview;
    int isrefresh;
    NSIndexPath *text;
    BOOL isText;
    UIView *view;
    UIView *tuijianview;
    UITapGestureRecognizer *tap;
    BOOL isFrame;
    BOOL isDown;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    [self setNavigationBar];
    [self setup];
    [self refresh];
    [self requestTJData];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self addKeyBoardNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(valuechange:) name:@"valuechange" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deletecell:) name:@"gouwudel" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payre:) name:@"payre" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textregist:) name:@"textpost" object:nil];

}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"清单";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    UIView *view23 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 64)];
    view23.backgroundColor = SF_COLOR(255, 54, 93);
       [self.view addSubview:view23];
    [self.view addSubview:label];
    
    
    self.view.backgroundColor = SF_COLOR(242, 242, 242);
}

- (void)textregist:(NSNotification *)n {
    NSIndexPath *index = n.userInfo[@"index"];
    
    text = index;
    if (index.row>1) {
    self.tabel.contentOffset = CGPointMake(0, [UIView getHeight:120]);
    }
    isText = YES;
    
}
- (void)textre:(UITapGestureRecognizer *)tap {
    
        GouwuCell *cell = [self.tabel cellForRowAtIndexPath:text];
        
        [cell.textfield resignFirstResponder];
        if (isText == YES) {
            self.tabel.contentOffset = CGPointMake(0, 0);
    }
    
}
- (void)payre:(NSNotification *)n {
    if (isrefresh == 1) {
        [self refresh];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}
- (void)refresh {
    
    self.tabel.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
        NSString *url = [NSString stringWithFormat:@"%@?ctl=cart&r_type=1&uid=%@&v=4",urlpre,dele.userid];
//        NSArray*array =  [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookiesForURL:[NSURL URLWithString:url]];
//        for(NSHTTPCookie*cookie in array)
//        {
//            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie: cookie];
//        }
        

        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self.dataArray removeAllObjects];
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSArray *arr = dic[@"cart_list"];
            for (NSDictionary *dica in arr) {
                GouwuModel *model = [[GouwuModel alloc]initWithDictionary:dica error:nil];
                [self.dataArray addObject:model];
            }
            NSDictionary *dicb = dic[@"total_data"];
            NSNotification *notice = [NSNotification notificationWithName:@"plistNum" object:nil userInfo:@{@"num":[NSString stringWithFormat:@"%d",(int)arr.count]}];
            
            [[NSNotificationCenter defaultCenter] postNotification:notice];
            dele.plistNum = (int)arr.count;
            
            NSString *str = [NSString stringWithFormat:@"共%@件商品",dicb[@"cart_item_number"]];
            NSString *jian = dicb[@"cart_item_number"];
            NSString *price = [NSString stringWithFormat:@"总计:%@夺宝币",dicb[@"total_price"]];
            NSString *zong = dicb[@"total_price"];
        
            NSMutableAttributedString *pricestr = [[NSMutableAttributedString alloc]initWithString:price];
    
            [pricestr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(3, zong.length)];
            [pricestr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(3, zong.length)];

            self.label.attributedText = pricestr;
            NSMutableAttributedString *jianmstr = [[NSMutableAttributedString alloc]initWithString:str];
            [jianmstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(1, jian.length)];
            self.numlabel.attributedText = jianmstr;
            if (_dataArray.count) {
                self.tabel.tableFooterView = nil;
                [self.view addSubview:view];
                view.frame = CGRectMake(0, SHEIGHT-49-[UIView setHeight:49], SWIDTH, [UIView setHeight:49]);
                
                [self.tabel addGestureRecognizer:tap];
                
            }else {
                self.tabel.tableFooterView = baview;
                [self.tabel removeGestureRecognizer:tap];
                [self requestTJData];
                [view removeFromSuperview];
            }

            [self.tabel reloadData];
            [self.tabel.mj_header endRefreshing];
            isrefresh = 1;

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.tabel.mj_header endRefreshing];
        }];
        

    }];
    [self.tabel.mj_header beginRefreshing];
    
    
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
- (void)viewWillDisappear:(BOOL)animated {
    [self.tabel.mj_header endRefreshing];
    
    [super viewWillDisappear:YES];
}
- (void)deletecell:(NSNotification *)n {
    [LBProgressHUD showHUDto:self.view animated:YES];
    NSDictionary *dic = n.userInfo;
    NSIndexPath *index = dic[@"row"];
    GouwuModel *model = _dataArray[index.row];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *url = [NSString stringWithFormat:@"%@?ctl=cart&act=del_cart&r_type=1&id=%@&uid=%@",urlpre,model.id,dele.userid];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *str = dic[@"status"];
        if (str.integerValue==1) {
            if (_dataArray.count <index.row||_dataArray.count==0) {
                return ;
            }
            [_dataArray removeObjectAtIndex:index.row];
            if (_dataArray.count) {
                self.tabel.tableFooterView = nil;
                [self.view addSubview:view];
                if (!self.tabel.gestureRecognizers.count) {
                    [self.tabel addGestureRecognizer:tap];
                }
                
            }else {
                self.tabel.tableFooterView = baview;
                [self.tabel removeGestureRecognizer:tap];
                [self requestTJData];
                [view removeFromSuperview];
            }
            [self.tabel reloadData];

            [self jiesuan];
            NSString *str = [NSString stringWithFormat:@"%d",dele.plistNum-1];
            NSNotification *notice = [NSNotification notificationWithName:@"plistNum" object:nil userInfo:@{@"num":str}];
            
            [[NSNotificationCenter defaultCenter] postNotification:notice];

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    [self jiesuan];
    
}
-(void)addKeyBoardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillDisappear:(NSNotification *)notification {
    
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float height = frame.size.height;//键盘height的值
    NSLog(@"height = %f",height);
    CGRect newFrame = view.frame;
    NSLog(@"nx1 = %f,ny1 = %f",newFrame.origin.x,newFrame.origin.y);
    newFrame.origin.y += height-49;
    if (isDown) {
        if(view.frame.origin.y==SHEIGHT-49-[UIView setHeight:49]){
            return;
        }
        view.frame = newFrame;
        isFrame = YES;
        isDown = NO;
    }
    NSLog(@"nx2 = %f,ny2 = %f",newFrame.origin.x,newFrame.origin.y);
    
}
-(void)keyboardWillShow:(NSNotification *)notification
{
    //键盘frame信息
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float height = frame.size.height;//键盘height的值
    NSLog(@"height = %f",height);
    CGRect newFrame = view.frame;
    NSLog(@"nx1 = %f,ny1 = %f",newFrame.origin.x,newFrame.origin.y);
    newFrame.origin.y -= height-49;
    
    if (isFrame) {
        view.frame = newFrame;
        isDown = YES;
        isFrame = NO;
    }
    NSLog(@"nx2 = %f,ny2 = %f",newFrame.origin.x,newFrame.origin.y);
}
- (void)valuechange:(NSNotification *)n{
    NSDictionary *dic = n.userInfo;
    NSString *a = dic[@"cell"];
    GouwuModel *model = _dataArray[a.integerValue];
    model.number = dic[@"value"];
    NSLog(@"%@",dic[@"value"]);
    [self jiesuan];
    
}
- (void)jiesuan {
    
    int total = 0;
        if (_dataArray.count) {
            for (int i = 0;i<_dataArray.count ; i++) {
                GouwuModel *model = _dataArray[i];
                NSInteger value=model.number.integerValue*model.unit_price.integerValue;
                NSLog(@"%ld",(long)value);
                total +=value;
            }
        }
    NSString *str1 = [NSString stringWithFormat:@"%lu",(unsigned long)_dataArray.count];
    NSString *str2 = [NSString stringWithFormat:@"%d",total];
    
    
    NSString *price = [NSString stringWithFormat:@"总计:%@夺宝币",str2];
    NSMutableAttributedString *pricestr = [[NSMutableAttributedString alloc]initWithString:price];
    
    [pricestr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(3, str2.length)];
    [pricestr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24] range:NSMakeRange(3, str2.length)];
     self.label.attributedText = pricestr;
    NSString *string = [NSString stringWithFormat:@"共%@件商品",str1];
    NSMutableAttributedString *jianmstr = [[NSMutableAttributedString alloc]initWithString:string];
    [jianmstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(1, str1.length)];
    self.numlabel.attributedText = jianmstr;
}
- (void)setup {
    self.dataArray = [NSMutableArray array];
    isFrame = YES;
    isDown = YES;
    self.tabel = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64-49) style:UITableViewStylePlain];
    self.tabel.delegate = self;
    self.tabel.dataSource = self;
    
    tap =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textre:)];
    [self.tabel addGestureRecognizer:tap];
    
    [self.tabel registerClass:[GouwuCell class] forCellReuseIdentifier:@"cellid"];
    [self.view addSubview:self.tabel];
    self.tabel.separatorStyle = UITableViewCellSeparatorStyleNone;
    view = [[UIView alloc]initWithFrame:CGRectMake(0, SHEIGHT-49-[UIView setHeight:49], SWIDTH, [UIView setHeight:49])];
    
    
    self.label = [[myUILabel alloc]initWithFrame:[UIView setRectWithX:20 andY:0 andWidth:200 andHeight:27]];
    [self.label setVerticalAlignment:VerticalAlignmentBottom];
    self.label.font = [UIFont systemFontOfSize:15];
    self.label.textColor = [UIColor whiteColor];
    [view addSubview:self.label];
    view.backgroundColor = [UIColor colorWithRed:58/255.0 green:63/255.0 blue:68/255.0 alpha:0.9];
   
    self.numlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:20 andY:30 andWidth:200 andHeight:12]];
    self.numlabel.font = [UIFont systemFontOfSize:12];
    self.numlabel.textColor = SF_COLOR(153, 153, 153);
    [view addSubview:self.numlabel];

    
    self.addbtn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:275 andY:0 andWidth:100 andHeight:49]];
    self.addbtn.backgroundColor = SF_COLOR(255, 54, 93);
//    [self.addbtn setTitle:@"去结算" forState:UIControlStateNormal];
    [self.addbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    

    self.addbtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [self.addbtn addTarget:self action:@selector(addbtnclick) forControlEvents:UIControlEventTouchUpInside];
    UILabel *btnlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:68 andHeight:49]];
    btnlabel.backgroundColor = [UIColor clearColor];
    btnlabel.text = @"去结算";
    btnlabel.textColor = [UIColor whiteColor];
    btnlabel.textAlignment = NSTextAlignmentRight;
    btnlabel.font = [UIFont systemFontOfSize:19];
    if (SWIDTH==320) {
        btnlabel.font = [UIFont systemFontOfSize:16];
    }
    [self.addbtn addSubview:btnlabel];
    UIImageView *jianimage = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:73 andY:19.5 andWidth:12 andHeight:10]];
    jianimage.image = [UIImage imageNamed:@"白箭头-拷贝-2"];
    [self.addbtn addSubview:jianimage];
    [view addSubview:self.addbtn];
    
    
    baview = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:667-NavHeight-49*667/[UIScreen mainScreen].bounds.size.height]];
    baview.backgroundColor = [UIColor whiteColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:125 andY:63 andWidth:125 andHeight:125]];
    image.image = [UIImage imageNamed:@"新购物车空"];
    [baview addSubview:image];
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:200 andWidth:375 andHeight:14]];
    titlelabel.text = @"这里什么都没有，快去往清单里添东西吧!";
    titlelabel.textColor = SF_COLOR(153, 153, 153);
    titlelabel.textAlignment = NSTextAlignmentCenter;
    
    titlelabel.font = [UIFont systemFontOfSize:16];
    [baview addSubview:titlelabel];
    UIButton *btn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:137.5 andY:224 andWidth:100 andHeight:36]];
    btn.backgroundColor = SF_COLOR(255, 54, 93);
    [btn setTitle:@"立即夺宝" forState:UIControlStateNormal];
    [btn setTitleColor:SF_COLOR(255, 255, 255) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:22];
    if (SWIDTH==320) {
        btn.titleLabel.font = [UIFont systemFontOfSize:19];

    }
    btn.layer.cornerRadius = 4;
    
    btn.clipsToBounds = YES;
    [baview addSubview:btn];
    [btn addTarget:self action:@selector(gotoSee) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:0 andY:353 andWidth:140 andHeight:1]];
    image1.image = [UIImage imageNamed:@"分割线左"];
    [baview addSubview:image1];
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:235 andY:353 andWidth:140 andHeight:1]];
    image2.image = [UIImage imageNamed:@"分割线"];
    [baview addSubview:image2];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:140 andY:346 andWidth:95 andHeight:15]];
    label1.textColor = SF_COLOR(102, 102, 102);
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"猜您喜欢";
    label1.font = [UIFont systemFontOfSize:17];
    [baview addSubview:label1];
    
    baview.userInteractionEnabled = YES;
    
    self.clDataArray = [NSMutableArray array];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:[UIView setRectWithX:16.5 andY:375 andWidth:342 andHeight:147] collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[GouwuCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake([UIView setWidth:107], [UIView setHeight:147]);
    [baview addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = false;
    self.tabel.tableFooterView.backgroundColor = [UIColor whiteColor];
    
    
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
    [self hideTabBar];
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)addbtnclick {
    NSString *key;
    for (int i = 0; i<_dataArray.count; i++) {
        GouwuModel *model = _dataArray[i];
        if (key.length) {
            key = [NSString stringWithFormat:@"%@&num[%@]=%@",key,model.id,model.number];
        }else {
            key = [NSString stringWithFormat:@"&num[%@]=%@",model.id,model.number];
        }
    }
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (!key) {
        key=@"";
    }
    NSString *url = [NSString stringWithFormat:@"%@?ctl=cart&act=check_all&r_type=1&uid=%@%@&v=3",urlpre,dele.userid,key];
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSArray *dica = dic[@"cart_list"];
        NSLog(@"%@",dic[@"status"]);
        NSString *str = dic[@"status"];
        NSDictionary *d = dic[@"total_data"];
        NSArray *arrarar = dic[@"hongbao"];
        if (str.integerValue == 1) {
            PayViewController *pay = [[PayViewController alloc]init];
            pay.dic = dica;
            pay.price = d[@"total_price"];
            pay.arr = arrarar;
            pay.num = self.dataArray.count;
            [self hideTabBar];
            [self.navigationController pushViewController:pay animated:YES];
         
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:dic[@"info"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ac];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GouwuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    
    [cell reloadwith:_dataArray[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UIView setHeight:140];
}
- (void)request {
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
        
//        self.label.text = @"暂无商品,请去登录";
        [self.tabel reloadData];
        return;
    }
    NSString *url = [NSString stringWithFormat:@"%@?ctl=cart&r_type=1&uid=%@",urlpre,dele.userid];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.dataArray removeAllObjects];
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSArray *arr = dic[@"cart_list"];
        for (NSDictionary *dica in arr) {
            GouwuModel *model = [[GouwuModel alloc]initWithDictionary:dica error:nil];
            [self.dataArray addObject:model];
        }
        NSDictionary *dicb = dic[@"total_data"];
        
        NSString *str = [NSString stringWithFormat:@"共%@件商品,总计%@元",dicb[@"cart_item_number"],dicb[@"total_price"]];
        
        self.label.text = str;
        if (_dataArray.count) {
            self.tabel.tableFooterView = nil;
        }else {
            self.tabel.tableFooterView = baview;
        }
        [self.tabel reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self showTabBar];
    
    [self payre:nil];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
