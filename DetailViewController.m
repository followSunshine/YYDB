//
//  DetailViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/11.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "DetailViewController.h"
#import "SDCycleScrollView.h"
#import "YSProgressView.h"
#import "DetailTableViewCell.h"
#import "MJRefresh.h"
#import "AFHTTPSessionManager.h"
#import "UserModel.h"
#import "UIScrollView+Touch.h"
#import "DizhiWebViewController.h"
#import "UIImageView+WebCache.h"
#import "UIView+CGSet.h"
#import "YYCollectionViewCell.h"
#import "myUILabel.h"
#define YYMaxSections 100

@interface DetailViewController ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong)UIWebView *scrollView;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *scrlDataArray;
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UILabel *jxlabel;
@property (nonatomic, strong)myUILabel *biaotiLabel;
@property (nonatomic, strong)UILabel *fubiaoLabel;
@property (nonatomic, strong)UILabel *qihaoLabel;
@property (nonatomic, strong)UILabel *zongLabel;
@property (nonatomic, strong)UILabel *shengLabel;
@property (nonatomic, strong)UILabel *canLabel;
@property (nonatomic, strong)UILabel *numberlabel;
@property (nonatomic, assign)CGFloat backviewHeight;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, strong)YSProgressView *progress;
@property (nonatomic, strong)UILabel *tuwenLabel;
@property (nonatomic, strong)UILabel *wangqiLabel;
@property (nonatomic, strong)UILabel *timeLabel;
@property (nonatomic, strong)UITableView *tableview;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSDictionary *dic;
@property (nonatomic, strong)NSMutableArray *duobaoArray;
@property (nonatomic, strong)UIView *anview;
@property (nonatomic, strong)UILabel *TextLabel;

@property (nonatomic, strong)NSString *tuwenurl;
@end

@implementation DetailViewController
{
    UIView *view1;
    UIView *view2;
    UILabel *label;
    UILabel *label2;
    UILabel *jiluLabel;
    UILabel *label3;
    UIView *backview2;
    UILabel *addbtn;
    UILabel *detbtn;
    UITextField *textfield;
    UILabel *redlabel;
    int num;
    int max_buy;
    int min_buy;
    int kImageCount;
    int page;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self creatUI];
    [self creatTable];
    [self reloadData];
    self.duobaoArray = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *selabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    selabel.font = [UIFont systemFontOfSize:18];
    selabel.text = @"商品详情";
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


- (void) creatTable {
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64-[UIView setHeight:55]) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.tag = 566;
    [self.tableview registerClass:[DetailTableViewCell class] forCellReuseIdentifier:@"cellid"];
    self.tableview.tableHeaderView = self.backView;
    [self.view addSubview:self.tableview];
    self.tableview.separatorStyle = NO;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, SHEIGHT-[UIView setHeight:55], SWIDTH, [UIView setHeight:55])];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIButton *btn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:227 andY:10 andWidth:120 andHeight:32]];
    btn.layer.cornerRadius = 5;
    btn.tag = 872;
    btn.userInteractionEnabled = NO;
    btn.clipsToBounds = YES;
    btn.backgroundColor = SF_COLOR(255,54,96);
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setTitle:@"立即参与" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addlist:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:btn];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:[UIView setRectWithX:64 andY:10 andWidth:120 andHeight:32]];
    btn2.layer.cornerRadius = 5;
    btn2.clipsToBounds = YES;
    btn2.tag = 873;
    btn2.userInteractionEnabled = NO;
    btn2.layer.borderColor = SF_COLOR(255,54,96).CGColor;
    btn2.layer.borderWidth = 2;
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn2.backgroundColor = SF_COLOR(255,54,96);
    [btn2 setTitle:@"加入购物车" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(addlist:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:btn2];
    
    UILabel *gouwulabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:28 andY:14 andWidth:24 andHeight:24]];
    gouwulabel.font = [UIFont fontWithName:@"iconfont" size:35];
    gouwulabel.textAlignment = NSTextAlignmentCenter;
    gouwulabel.text = @"\ue658";
//    [view addSubview:gouwulabel];
    gouwulabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapga = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotugouwu:)];
    [gouwulabel addGestureRecognizer:tapga];

    UIImageView *image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:28 andY:14 andWidth:24 andHeight:24]];
    image.image = [UIImage imageNamed:@"icon-订单-未点击"];
    [view addSubview:image];
    image.userInteractionEnabled = YES;
    [image addGestureRecognizer:tapga];
    self.TextLabel=[[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:14], [UIView getHeight:0], [UIView setWidth:10], [UIView setWidth:10])];
    self.TextLabel.layer.cornerRadius = [UIView setWidth:5];
    
    self.TextLabel.clipsToBounds = YES;
    self.TextLabel.textColor = [UIColor whiteColor ];
    self.TextLabel.text = @"";
    self.TextLabel.font = [UIFont systemFontOfSize:13];
    self.TextLabel.textAlignment = NSTextAlignmentCenter;
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (del.plistNum>0) {
        self.TextLabel.backgroundColor = [UIColor redColor];
        self.TextLabel.text = [NSString stringWithFormat:@"%d",del.plistNum];
    }
    [image addSubview:self.TextLabel];
    
    UIView *bgview = [[UIView alloc]initWithFrame:[UIView getRectWithX:30 andY:50 andWidth:150 andHeight:30]];
    bgview.layer.borderWidth = 2;
    bgview.layer.borderColor = SF_COLOR(207, 207, 207).CGColor;
    bgview.layer.cornerRadius = [UIView getHeight:5];
    bgview.clipsToBounds = YES;
    
    
    detbtn = [[UILabel alloc]initWithFrame:[UIView getRectWithX:0 andY:0 andWidth:40 andHeight:30]];
    detbtn.font = [UIFont fontWithName:@"iconfont" size:18];
    detbtn.text = @"\ue6d3";
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detbtn:)];
    [detbtn addGestureRecognizer:tap1];
    detbtn.userInteractionEnabled = YES;
    detbtn.textColor = SF_COLOR(207, 207, 207);
    detbtn.textAlignment = NSTextAlignmentCenter;
    addbtn = [[UILabel alloc]initWithFrame:[UIView getRectWithX:110 andY:0 andWidth:40 andHeight:30]];
    addbtn.font = [UIFont fontWithName:@"iconfont" size:18];
    addbtn.text = @"\ue6d1";
    addbtn.textColor = SF_COLOR(207, 207, 207);
    addbtn.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addbtn:)];
    [addbtn addGestureRecognizer:tap];
    addbtn.userInteractionEnabled = YES;
    textfield = [[UITextField alloc]initWithFrame:[UIView getRectWithX:40 andY:0 andWidth:70 andHeight:30]];
    textfield.keyboardType = UIKeyboardTypeNumberPad;
    textfield.textAlignment = NSTextAlignmentCenter;
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    textfield.delegate = self;
    textfield.font = [UIFont systemFontOfSize:13];
    textfield.textColor = [UIColor redColor];
    textfield.userInteractionEnabled = YES;
    [textfield addTarget:self action:@selector(valuechang) forControlEvents:UIControlEventEditingDidEnd];

    [bgview addSubview:detbtn];
    [bgview addSubview:addbtn];
    [bgview addSubview:textfield];
    
    self.anview = [[UIView alloc]initWithFrame:[UIView getRectWithX:0 andY:480 andWidth:320 andHeight:130]];
    self.anview.backgroundColor = [UIColor whiteColor];
    UILabel *renshulabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:0 andY:0 andWidth:310 andHeight:20]];
    renshulabel.backgroundColor = SF_COLOR(230, 230, 230);
    renshulabel.font = [UIFont systemFontOfSize:18];
    renshulabel.text = @"   人数选择";
    [self.anview addSubview:renshulabel];
    
    UILabel *canlabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:30 andY:30 andWidth:80 andHeight:20]];
    canlabel.text = @"参与人次";
    canlabel.font = [UIFont systemFontOfSize:18];
    redlabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:30 andY:80 andWidth:100 andHeight:15]];
    redlabel.textColor = [UIColor redColor];
    redlabel.font = [UIFont systemFontOfSize:10];

    redlabel.textAlignment = NSTextAlignmentCenter;
    [self.anview addSubview:redlabel];
    [self.anview addSubview:canlabel];
    [self.anview addSubview:bgview];
    [self.anview addSubview:renshulabel];
//    [self.view addSubview:self.anview];
    UILabel *linelabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:0 andY:99 andWidth:320 andHeight:0.5]];
    linelabel.backgroundColor = SF_COLOR(230, 230, 230);
    [self.anview addSubview:linelabel];
    
    UIButton *btn3 = [[UIButton alloc]initWithFrame:[UIView getRectWithX:90 andY:102.5 andWidth:140 andHeight:25]];
    [btn3 setTitle:@"加入清单" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn3.backgroundColor = SF_COLOR(82, 165, 251);
    btn3.layer.cornerRadius = 3;
    btn3.clipsToBounds = YES;
    [btn3 addTarget:self action:@selector(addlist) forControlEvents:UIControlEventTouchUpInside];
    [self.anview addSubview:btn3];
    
    UILabel *detlabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:290 andY:0 andWidth:30 andHeight:20]];
    detlabel.backgroundColor = SF_COLOR(230, 230, 230);
    detlabel.font = [UIFont fontWithName:@"iconfont" size:22];
    detlabel.text = @"\ue608";
    [self.anview addSubview:detlabel];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xiajiang:)];
    detlabel.userInteractionEnabled = YES;
    [detlabel addGestureRecognizer:tap2];
}
- (void)xiajiang:(UITapGestureRecognizer *)tap {
    [UIView animateWithDuration:0.4 animations:^{
        self.anview.frame =[UIView getRectWithX:0 andY:480 andWidth:320 andHeight:130];
    }];
}
- (void)gotugouwu:(UITapGestureRecognizer *)tap {
    
    NSNotification *notice = [NSNotification notificationWithName:@"pushtomain" object:nil userInfo:@{@"num":@"4"}];
    
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addlist:(UIButton *)btn {
    
    //?ctl=api&act=addcart&buy_num=1&data_id=&uid=
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
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
    NSNumber *minbuy = self.dic[@"min_buy"];
    if (minbuy.integerValue<5) {
        minbuy = [NSNumber numberWithInt:5];
    }
    NSNumber *surplus_count = self.dic[@"surplus_count"];
    if (minbuy.intValue>surplus_count.intValue) {
        minbuy = [NSNumber numberWithInt:surplus_count.intValue];
    }
    NSString *str = [NSString stringWithFormat:@"%@?ctl=api&act=addcart&buy_num=%@&data_id=%@&uid=%@",urlpre,minbuy,self.dic[@"id"],del.userid];
    [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *str = dic[@"status"];
        
        if (str.intValue==1||str.integerValue==-98) {
            self.TextLabel.backgroundColor = [UIColor redColor];
            if (str.integerValue == 1) {
                del.plistNum +=1;
                self.TextLabel.text = [NSString stringWithFormat:@"%d",del.plistNum];
                
                NSNotification *notice = [NSNotification notificationWithName:@"plistNum" object:nil userInfo:@{@"num":dic[@"cart_item_num"]}];
                
                [[NSNotificationCenter defaultCenter] postNotification:notice];
                
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"cart_item_num"] forKey:@"number"];
            }
            if (btn.tag == 872) {
                NSNotification *notice1 = [NSNotification notificationWithName:@"pushtomain" object:nil userInfo:@{@"num":@"4"}];
                
                [[NSNotificationCenter defaultCenter] postNotification:notice1];
                [self.navigationController popViewControllerAnimated:YES];

            }
            
            
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"info"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"再看看" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:act];
            [alert addAction:act1];
            [self presentViewController:alert animated:YES completion:nil];

        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textfield resignFirstResponder];
    return YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [textfield resignFirstResponder];

}
- (void)valuechang {
    int a = textfield.text.intValue;
    if (max_buy) {
        if (a>max_buy) {
            
            textfield.text = [NSString stringWithFormat:@"%d",max_buy/min_buy*min_buy];
        }else {
            int b = a/min_buy*min_buy;
            if (b==0){
                b = min_buy;
            }
            textfield.text = [NSString stringWithFormat:@"%d",b];
        }
       
    }else {
        return;
    }
    
}
- (BOOL )textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"string====%@",string);
    
    return YES;
}
- (void)detbtn:(UITapGestureRecognizer *)tap {
    
    int a = textfield.text.intValue;
    if (a!=min_buy) {
        a-=min_buy;
    }    textfield.text = [NSString stringWithFormat:@"%d",a];
    
    
    [self valuechang];
}
- (void)addbtn:(UITapGestureRecognizer *)tap {
    int a = textfield.text.intValue;
    if(a!=max_buy){
        a+=min_buy;
    }
    textfield.text = [NSString stringWithFormat:@"%d",a];
    [self valuechang];
    
}

- (void )btnclick {
    [UIView animateWithDuration:0.4 animations:^{
        self.anview.frame =[UIView getRectWithX:0 andY:350 andWidth:320 andHeight:130];
    }];
}
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableview.mj_footer.hidden = self.dataArray.count==0;
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell reloadWith:_dataArray[indexPath.row]];
    return cell;
    
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIView setHeight:55];
}
- (void)reloadData {
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        page=1;
        NSString *url = [NSString stringWithFormat:@"%@?ctl=duobao&data_id=%@&uid=%@&page=%d&v=3",urlpre,self.userid,dele.userid,page];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSString *info = dic[@"info"];
            NSString *str = dic[@"status"];
            NSDictionary *dic1 = dic[@"ry_list"];
            NSDictionary *dica= dic1[@"a"];
            NSDictionary *dicb= dic1[@"b"];
            NSDictionary *dics= dic1[@"s"];
            NSNumber *na = dica[@"status"];
            NSNumber *nb = dicb[@"status"];
            NSNumber *ns = dics[@"status"];
            if (na.integerValue!=0) {
                UIImageView *image = (UIImageView *)[self.view viewWithTag:243];
                NSString *url = [NSString stringWithFormat:@"%@%@",urladress,dica[@"avatar"]];
                [image sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"默认头像"]];
                UILabel *label1 = [self.view viewWithTag:652];
                label1.text = dica[@"user_name"];
            }else {
                UILabel *label1 = [self.view viewWithTag:652];
                label1.text = @"虚位以待";
            }
            
            if (nb.integerValue!=0) {
                UIImageView *image = (UIImageView *)[self.view viewWithTag:242];
                NSString *url = [NSString stringWithFormat:@"%@%@",urladress,dicb[@"avatar"]];
                [image sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"默认头像"]];
                UILabel *label1 = [self.view viewWithTag:651];
                label1.text = dicb[@"user_name"];
            }else {
                UILabel *label1 = [self.view viewWithTag:651];
                label1.text = @"虚位以待";
            }
            
            
            if (ns.integerValue!=0) {
                UIImageView *image = (UIImageView *)[self.view viewWithTag:241];
                NSString *url = [NSString stringWithFormat:@"%@%@",urladress,dics[@"avatar"]];
                [image sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"默认头像"]];
                UILabel *label1 = [self.view viewWithTag:650];
                label1.text = dics[@"user_name"];
                UILabel *label21 = [self.view viewWithTag:653];
                label21.text = [NSString stringWithFormat:@"参与%@次",dics[@"sum"]];
                
            }else {
                UILabel *label1 = [self.view viewWithTag:650];
                label1.text = @"虚位以待";
            }
            

            int a = str.intValue;
            if (a!=1) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:info preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                
                [alert addAction:act];
                [self presentViewController:alert animated:YES completion:nil];
            }else {
                [self.dataArray removeAllObjects];
                self.dic = dic[@"item_data"];
                self.tuwenurl = dic[@"url"];
                self.duobaoArray = dic[@"my_duobao_log"];
                NSArray *arr = dic[@"duobao_order_list"];
                NSString *minstr = self.dic[@"min_buy"];
                
                min_buy = minstr.intValue;
                NSString *maxstr = self.dic[@"surplus_count"];
                max_buy = maxstr.intValue;

                [self setscrollviewwith:self.dic[@"deal_gallery"]];
                for (NSDictionary *dica in arr) {
                    UserModel *model=[[UserModel alloc]initWithDictionary:dica error:nil];
                    [self.dataArray addObject:model];
                    
                }
                
                [self.tableview reloadData];
                
                [self reload];
                
                UIButton *btn = (UIButton *)[self.view viewWithTag:872];
                btn.userInteractionEnabled = YES;
                UIButton *btn2 = (UIButton *)[self.view viewWithTag:873];
                btn2.userInteractionEnabled = YES;
            }
            [self.tableview.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.tableview.mj_header endRefreshing];
        }];
        
    }];
    
    [self.tableview.mj_header beginRefreshing];
    
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        page++;

        NSString *url = [NSString stringWithFormat:@"%@?ctl=duobao&data_id=%@&uid=%@&page=%d&v=3",urlpre,self.userid,dele.userid,page];
        
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = (NSDictionary *)responseObject;

                NSArray *arr = dic[@"duobao_order_list"];
                for (NSDictionary *dica in arr) {
                    UserModel *model=[[UserModel alloc]initWithDictionary:dica error:nil];
                    [self.dataArray addObject:model];
                }
                [self.tableview reloadData];
            if (arr.count<20) {
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
                self.tableview.mj_footer.hidden = YES;
                return ;
            }
            [self.tableview.mj_footer endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.tableview.mj_footer endRefreshing];
        }];
        
    }];
    
    self.tableview.mj_footer.hidden = YES;
}
- (void)setscrollviewwith:(NSArray *)array {
    self.scrlDataArray = [NSMutableArray arrayWithArray:array];
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = self.scrlDataArray.count;
    [self.backView addSubview:self.pageControl];

}
#pragma mark - 滚动视图代理方法


- (void)reload {
    textfield.text = self.dic[@"min_buy"];
    self.biaotiLabel.text = self.dic[@"name"];
    self.fubiaoLabel.text = self.dic[@"brief"];
    self.qihaoLabel.text = [NSString stringWithFormat:@"期号:%@",self.dic[@"id"]];
    self.zongLabel.text = [NSString stringWithFormat:@"总需：%@",self.dic[@"max_buy"]];
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"剩余：%@",self.dic[@"surplus_count"]]];
    NSNumber *str12 = self.dic[@"surplus_count"];
    NSString *numstr = [NSString stringWithFormat:@"%@",str12];
    [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(3, numstr.length)];
    self.shengLabel.attributedText = mstr;
    NSString *str =self.dic[@"max_buy"];
    NSString *str1 = self.dic[@"surplus_count"];
    self.progress.progressValue = self.progress.frame.size.width*(1-str1.floatValue/str.floatValue);
    
    if (_duobaoArray.count) {
        NSString *text = @"夺宝号码:  ";
        for (int i = 0; i<_duobaoArray.count; i++) {
            NSDictionary *dic =_duobaoArray[i];
            NSString *stra = dic[@"lottery_sn"];
            text = [text stringByAppendingString:stra];
            text = [text stringByAppendingString:@"  "];
        }
        _canLabel.text = [NSString stringWithFormat:@"您总共参与了%lu次",(unsigned long)_duobaoArray.count];
    }else {
        _canLabel.text = @"您没有参与本期夺宝哦！";
        _canLabel.textAlignment = NSTextAlignmentCenter;
    }
    self.timeLabel.text = [NSString stringWithFormat:@"%@开始",self.dic[@"create_time_format"]];
    redlabel.text = [NSString stringWithFormat:@"参与次数需是%d的倍数",min_buy];
}
- (void)numlabel:(NSString *)text {
    num = 1;
    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize size = [UIView getSizeWithWidth:290 andHeight:2000];
    CGSize labelsize = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    [self frame:view1 a:labelsize.height];
    [self frame:view2 a:labelsize.height];
    [self frame:self.tuwenLabel a:labelsize.height];
    [self frame:label a:labelsize.height];
    [self frame:label2 a:labelsize.height];
    [self frame:self.wangqiLabel a:labelsize.height];
    [self frame:jiluLabel a:labelsize.height];
    [self frame:label3 a:labelsize.height];
    [self frame:self.timeLabel a:labelsize.height];
    backview2.frame = CGRectMake(backview2.frame.origin.x, backview2.frame.origin.y, backview2.frame.size.width, backview2.frame.size.height+labelsize.height);
    self.backView.frame = CGRectMake(self.backView.frame.origin.x, self.backView.frame.origin.y, self.backView.frame.size.width, self.backView.frame.size.height+labelsize.height);
    self.numberlabel.frame = CGRectMake(self.numberlabel.frame.origin.x, self.numberlabel.frame.origin.y, self.numberlabel.frame.size.width, self.numberlabel.frame.size.height+labelsize.height);
    self.numberlabel.text = text;
    [self.tableview reloadData];
    
}
- (void)frame:(UIView *)view a:(CGFloat)height {
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y+height, view.frame.size.width, view.frame.size.height);
}
- (void)creatUI {
    
    self.backView = [[UIView alloc]init];
    self.scrlDataArray = [NSMutableArray array];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(SWIDTH, [UIView setHeight:160]);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, [UIView setHeight:160]) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor clearColor];
    [self.backView addSubview:collectionView];
    
    _collectionView=collectionView;
    
    [self.collectionView registerClass:[YYCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:YYMaxSections/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, [UIView setHeight:150], SWIDTH, [UIView setHeight:10])];
    
    pageControl.pageIndicatorTintColor = SF_COLOR(255, 215, 223);
    pageControl.currentPageIndicatorTintColor = SF_COLOR(255, 54, 93);
    pageControl.enabled = NO;
    
    
    _pageControl=pageControl;
    
    
    [self addTimer];
    
    
    self.jxlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:168 andWidth:30 andHeight:15]];
    _jxlabel.backgroundColor = SF_COLOR(255, 54, 93);
    _jxlabel.textColor = [UIColor whiteColor];
    
    
    _jxlabel.text = @"进行中";
    _jxlabel.font = [UIFont systemFontOfSize:9];
    _jxlabel.layer.cornerRadius = 2;
    _jxlabel.clipsToBounds = YES;
    _jxlabel.textAlignment = NSTextAlignmentCenter;
    
    [self.backView addSubview:_jxlabel];

    
    self.biaotiLabel = [[myUILabel alloc]initWithFrame:[UIView setRectWithX:50 andY:168 andWidth:301 andHeight:35]];
    self.biaotiLabel.numberOfLines = 0;
    self.biaotiLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.biaotiLabel setVerticalAlignment:VerticalAlignmentTop];
    self.biaotiLabel.font = [UIFont systemFontOfSize:14];
    self.biaotiLabel.textColor = SF_COLOR(51, 51, 51);
    [self.backView addSubview:_biaotiLabel];
    self.progress = [[YSProgressView alloc]initWithFrame:[UIView setRectWithX:12 andY:203 andWidth:351 andHeight:5]];
    self.progress.trackTintColor = SF_COLOR(229, 229, 229);
    self.progress.trackTintColor = SF_COLOR(255, 196, 126);
    [self.backView addSubview:self.progress];
    self.zongLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:208 andWidth:150 andHeight:30]];
    _zongLabel.textColor = SF_COLOR(151, 151, 151);
    _zongLabel.font = [UIFont systemFontOfSize:10];
    [self.backView addSubview:self.zongLabel];
    self.shengLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:187.5 andY:208 andWidth:175.5 andHeight:30]];
    _shengLabel.textColor = SF_COLOR(151, 151, 151);
    _shengLabel.textAlignment = NSTextAlignmentRight;
    _shengLabel.font = [UIFont systemFontOfSize:10];
    [self.backView addSubview:_shengLabel];
    


 
    UILabel *apple =[[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:270 andWidth:375 andHeight:24]];
    apple.textColor = SF_COLOR(153, 153, 153);
    apple.backgroundColor = SF_COLOR(242, 242, 242);
    apple.font = [UIFont systemFontOfSize:9];
    apple.textAlignment = NSTextAlignmentCenter;
    apple.text = @"声明：所有产品抽奖活动与苹果公司（Apple Inc）无关";
    [self.backView addSubview:apple];
    
    
    UILabel *newlinelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:237.5 andWidth:351 andHeight:0.3]];
    newlinelabel.backgroundColor = SF_COLOR(242, 242, 242);
    [self.backView addSubview:newlinelabel];
    
    
   
    self.canLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:238 andWidth:375 andHeight:32]];
    _canLabel.font = [UIFont systemFontOfSize:13];
    _canLabel.textColor = SF_COLOR(102, 102, 102);
    self.canLabel.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:_canLabel];
    UILabel *newlinelabel1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:31.5 andWidth:375 andHeight:0.3]];
    newlinelabel1.backgroundColor = SF_COLOR(232, 232, 232);
    [self.canLabel addSubview:newlinelabel1];
    
    UIView *newbgview = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:294 andWidth:375 andHeight:250]];
    newbgview.layer.borderColor = SF_COLOR(232, 232, 232).CGColor;
    newbgview.layer.borderWidth = 0.3;
    [self.backView addSubview:newbgview];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:12], [UIView setHeight:10], [UIView setHeight:20], [UIView setHeight:20])];
    imageview.image = [UIImage imageNamed:@"图文详情"];
    [newbgview addSubview:imageview];
    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:12], [UIView setHeight:10]+[UIView setHeight:40], [UIView setHeight:20], [UIView setHeight:20])];
    imageview1.image = [UIImage imageNamed:@"往期揭晓"];
    [newbgview addSubview:imageview1];

    
    self.tuwenLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setHeight:20]+[UIView setWidth:17], 0, [UIView setWidth:330], [UIView setHeight:40])];
    self.tuwenLabel.text = @"图文详情";
    self.tuwenLabel.textColor = SF_COLOR(51, 51, 51);
    
    self.tuwenLabel.font = [UIFont systemFontOfSize:14];
    label2 = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:200], 0, [UIView setWidth:175]-[UIView setHeight:12]-[UIView setWidth:17],[UIView setHeight:40] )];
    label2.font = [UIFont systemFontOfSize:10];
    label2.textAlignment = NSTextAlignmentRight;
    label2.textColor =SF_COLOR(153, 153, 153);
    label2.text = @"建议在wifi下观看";
    [newbgview addSubview:label2];
    [newbgview addSubview:self.tuwenLabel];
    
    
    self.wangqiLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setHeight:20]+[UIView setWidth:17], 0+[UIView setHeight:40], [UIView setWidth:330], [UIView setHeight:40])];
    self.wangqiLabel.text = @"往期揭晓";
    self.wangqiLabel.font = [UIFont systemFontOfSize:14];
    self.wangqiLabel.textColor = SF_COLOR(51, 51, 51);
    [newbgview addSubview:self.wangqiLabel];
    
    
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(SWIDTH-[UIView setWidth:12]-[UIView setHeight:12], [UIView setHeight:14], [UIView setHeight:12], [UIView setHeight:12])];
    image2.image = [UIImage imageNamed:@"灰箭头"];
    [newbgview addSubview:image2];
    UIImageView *image3 = [[UIImageView alloc]initWithFrame:CGRectMake(SWIDTH-[UIView setWidth:12]-[UIView setHeight:12], [UIView setHeight:54], [UIView setHeight:12], [UIView setHeight:12])];
    image3.image = [UIImage imageNamed:@"灰箭头"];
    [newbgview addSubview:image3];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tuwenxiangqing:)];
    tap.delegate = self;
    self.tuwenLabel.userInteractionEnabled = YES;
    [self.tuwenLabel addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wangqi:)];
    [self.wangqiLabel addGestureRecognizer:tap1];
    tap1.delegate = self;
    self.wangqiLabel.userInteractionEnabled = YES;
    
    UILabel *newlinelabel2 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:39.5 andWidth:351 andHeight:0.3]];
    newlinelabel2.backgroundColor = SF_COLOR(242, 242, 242);
    [newbgview addSubview:newlinelabel2];

    UILabel *label43 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:80 andWidth:375 andHeight:10]];
    label43.backgroundColor = SF_COLOR(242, 242, 242);
    [newbgview addSubview:label43];
    
    
    UIImageView *imageview3 = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:12], [UIView setHeight:10]+[UIView setHeight:90], [UIView setHeight:20], [UIView setHeight:20])];
    imageview3.image = [UIImage imageNamed:@"荣誉榜"];
    [newbgview addSubview:imageview3];

    UILabel *ronglabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setHeight:20]+[UIView setWidth:17], 0+[UIView setHeight:90], [UIView setWidth:330], [UIView setHeight:40])];
    
    ronglabel.text = @"荣誉榜";
    ronglabel.font = [UIFont systemFontOfSize:14];
    ronglabel.textColor = SF_COLOR(51, 51, 51);
    [newbgview addSubview:ronglabel];
    
    UILabel *newlinelabel3 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:129.5 andWidth:351 andHeight:0.3]];
    newlinelabel3.backgroundColor = SF_COLOR(242, 242, 242);
    [newbgview addSubview:newlinelabel3];
    NSArray *titlearr = @[@"土豪",@"沙发",@"包尾"];
    NSArray *titlearr1 = @[@"参与0次",@"第一个参与",@"最后一个参与"];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *headimage = [[UIImageView alloc ]initWithFrame:CGRectMake([UIView setWidth:40.5+i*125], [UIView setHeight:139], [UIView setWidth:44], [UIView setWidth:44])];
        headimage.clipsToBounds = YES;
        headimage.layer.cornerRadius = [UIView setHeight:22];
        [newbgview addSubview:headimage];
        headimage.tag = 241+i;
        headimage.image = [UIImage imageNamed:@"默认头像"];
        UILabel *label42 = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:46.5+i*125], [UIView setHeight:152]+[UIView setWidth:44], [UIView setWidth:32], [UIView setHeight:14])];
        label42.textAlignment = NSTextAlignmentCenter;
        label42.font = [UIFont systemFontOfSize:14];
        if (SWIDTH==320) {
            label42.font = [UIFont systemFontOfSize:11];

        }
        label42.text = titlearr[i];
        label42.textColor = [UIColor whiteColor];
        UILabel *label41 = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:i*125], [UIView setHeight:174]+[UIView setWidth:44], [UIView setWidth:125], [UIView setHeight:12])];
        label41.textColor = SF_COLOR(54, 134, 255);
        label41.textAlignment = NSTextAlignmentCenter;
        label41.font = [UIFont systemFontOfSize:12];
        label41.tag = 650+i;
        UILabel *label40 = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:i*125], [UIView setHeight:192]+[UIView setWidth:44], [UIView setWidth:125], [UIView setHeight:12])];
        label40.textColor = SF_COLOR(102, 102, 102);
        label40.font = [UIFont systemFontOfSize:12];
        label40.textAlignment = NSTextAlignmentCenter;
        label40.text = titlearr1[i];
        
        if (i == 0) {
            label42.backgroundColor = SF_COLOR(255, 202, 139);
            label40.tag = 653;
        }else if (i==1) {
            label42.backgroundColor = SF_COLOR(255, 202, 139);

        }else {
            label42.backgroundColor = SF_COLOR(212, 212, 212);

        }
        [newbgview addSubview:label42];
        [newbgview addSubview:label41];
        [newbgview addSubview:label40];
    }
    
    UIImageView *image4 = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:12], [UIView setHeight:20]+[UIView setHeight:544], [UIView setHeight:20], [UIView setHeight:20])];
    image4.image = [UIImage imageNamed:@"参与记录"];
    [self.backView addSubview:image4];
    
    UILabel *ronglabel1 = [[UILabel alloc]initWithFrame:CGRectMake([UIView setHeight:20]+[UIView setWidth:17], 0+[UIView setHeight:554], [UIView setWidth:330], [UIView setHeight:40])];
    
    ronglabel1.text = @"本期参与纪录";
    ronglabel1.font = [UIFont systemFontOfSize:14];
    ronglabel1.textColor = SF_COLOR(51, 51, 51);
    [self.backView addSubview:ronglabel1];

    
    UILabel *label45 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:544 andWidth:375 andHeight:10]];
    label45.backgroundColor = SF_COLOR(242, 242, 242);
    if (SWIDTH!=320) {
        [self.backView addSubview:label45];
    }
    
    self.timeLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:200 andY:554 andWidth:146 andHeight:40]];
    self.timeLabel.textColor = SF_COLOR(212, 212, 212);
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.font = [UIFont systemFontOfSize:10];
    [self.backView addSubview:self.timeLabel];
    
    UILabel *newlinelabel4 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:593.5 andWidth:351 andHeight:0.3]];
    newlinelabel4.backgroundColor = SF_COLOR(242, 242, 242);
    [self.backView addSubview:newlinelabel4];

    
    self.backView.frame = [UIView setRectWithX:0 andY:0 andWidth:375 andHeight:594];
}
-(void) addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(nextpage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer ;
    
}

#pragma mark 删除
-(void) removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

-(void) nextpage{

    if (!self.scrlDataArray.count) {
        return;
    }
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:YYMaxSections/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem = currentIndexPathReset.item +1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem==self.scrlDataArray.count) {
        nextItem=0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark- UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return YYMaxSections;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.scrlDataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    YYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    if(!cell){
        cell = [[YYCollectionViewCell alloc] init];
    }
    cell.imge = self.scrlDataArray[indexPath.item];
    return cell;
}


-(void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}

#pragma mark 当用户停止的时候调用
-(void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
    
}

#pragma mark 设置页码
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == 566) {
        return;
    }
    int page = (int) (scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.scrlDataArray.count;
    self.pageControl.currentPage =page;
}
- (void)wangqi:(UITapGestureRecognizer *)tap {
    DizhiWebViewController *web = [[DizhiWebViewController alloc]init];
    web.urlstring = [NSString stringWithFormat:@"%@?ctl=duobao&act=duobao_record&page_type=app&data_id=%@",urlpre,self.dic[@"duobao_id"]];
    web.title = @"往期揭晓";
    [self.navigationController pushViewController:web animated:YES];
}
- (void)tuwenxiangqing:(UITapGestureRecognizer *)tap {
    
    DizhiWebViewController *web = [[DizhiWebViewController alloc]init];
    web.urlstring = self.tuwenurl;
    web.title = @"图文详情";
    [self.navigationController pushViewController:web animated:YES];
    
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
