//
//  DetailDaojishiViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/12.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "DetailDaojishiViewController.h"
#import "SDCycleScrollView.h"
#import "YSProgressView.h"
#import "DetailTableViewCell.h"
#import "AFHTTPSessionManager.h"
#import "MJRefresh.h"
#import "UserModel.h"
#import "DetailViewController.h"
#import "DizhiWebViewController.h"
#import "UIView+CGSet.h"
@interface DetailDaojishiViewController ()<UIWebViewDelegate,UIScrollViewDelegate,SDCycleScrollViewDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong)UIWebView *scrollView;
@property (nonatomic, strong)NSMutableArray *scrlDataArray;
@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UILabel *jxlabel;
@property (nonatomic, strong)UILabel *biaotiLabel;
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
@property (nonatomic, strong)UIImageView *headImageview;
@property (nonatomic, strong)UILabel *zuixinlabel;
@property (nonatomic, strong)NSDictionary *dic;
@property (nonatomic, strong)NSMutableArray *duobaoArray;
@property (nonatomic, strong)NSString *next_id;
@property (nonatomic, strong)NSString *tuwenurl;
@end

@implementation DetailDaojishiViewController
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
    UIView *neiview;
    int page;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self creatUI];
    [self creatTable];
    [self reloadData];
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
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64-[UIView getHeight:30]) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [self.tableview registerClass:[DetailTableViewCell class] forCellReuseIdentifier:@"cellid"];
    self.tableview.tableHeaderView = self.backView;
    [self.view addSubview:self.tableview];
    self.tableview.separatorStyle = NO;
    self.duobaoArray = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    self.tableview.tag = 568;
    UILabel *bottomlabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:0 andY:450 andWidth:320 andHeight:30]];
    bottomlabel.layer.borderColor = SF_COLOR(230, 230, 230).CGColor;
    bottomlabel.layer.borderWidth = 0.5;
    bottomlabel.text = @"   新一期正火热进行";
    bottomlabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:bottomlabel];
    
    UIButton *button = [[UIButton alloc]initWithFrame:[UIView getRectWithX:250 andY:3 andWidth:60 andHeight:24]];
    button.backgroundColor = SF_COLOR(255, 54, 93);
    [button setTitle:@"立即前往" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    button.layer.cornerRadius = 5;
    if (SWIDTH==320) {
        button.titleLabel.font = [UIFont systemFontOfSize:13];
//        bottomlabel.frame = CGRectMake(0, SHEIGHT-[UIView getHeight:30], SWIDTH, [UIView getHeight:30]);
//        button.frame = CGRectMake(250, 6, 60, 24);
    }

    button.clipsToBounds = YES;
    bottomlabel.userInteractionEnabled = YES;
    [button addTarget:self action:@selector(gotoDetail) forControlEvents:UIControlEventTouchUpInside];
    [bottomlabel addSubview:button];
}
- (void)gotoDetail {
    DetailViewController *de = [[DetailViewController alloc]init];
    de.userid = _next_id;
    [self.navigationController pushViewController:de animated:YES];
}
- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableview.mj_footer.hidden = self.dataArray.count == 0;
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
    self.tableview.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        page = 1;
        AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSString *url = [NSString stringWithFormat:@"%@?ctl=duobao&data_id=%@&uid=%@&page=%d&v=3",urlpre,self.userid,dele.userid,page];
        [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSString *info = dic[@"info"];
            NSString *str = dic[@"status"];
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
                _next_id = dic[@"next_id"];
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
    //http://localhost/api.php?ctl=duobao&page_type=app&act=img&deal_gallery=http://localhost/public/attachment/201601/23/14/56a324ec6cd73_600x600.jpg,http://localhost/public/attachment/201601/23/15/56a324f04c89c_600x600.jpg
    NSString *str = [NSString stringWithFormat:@"%@?ctl=duobao&page_type=app&act=img&deal_gallery=",urlpre];
    
    for (int i = 0; i<array.count; i++) {
        if (i==array.count-1) {
            str = [NSString stringWithFormat:@"%@%@",str,array[i]];
        }else{
            str = [NSString stringWithFormat:@"%@%@,",str,array[i]];
        }
    }
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    [self.scrollView loadRequest:request];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载失败");
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
}

#pragma mark - 滚动视图代理方法
/** 滚动停止 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 568) {
        return;
    }else {
        CGPoint point = scrollView.contentOffset;
        if (point.y != 0) {
            scrollView.contentOffset = CGPointMake(point.x, 0);
        }
    }
}


- (void)reload {
    textfield.text = self.dic[@"min_buy"];
    self.biaotiLabel.text = self.dic[@"name"];
    self.fubiaoLabel.text = self.dic[@"brief"];
    self.qihaoLabel.text = [NSString stringWithFormat:@"期号:%@",self.dic[@"id"]];
    self.zongLabel.text = [NSString stringWithFormat:@"总需%@",self.dic[@"max_buy"]];
    self.shengLabel.text = [NSString stringWithFormat:@"剩余%@",self.dic[@"surplus_count"]];
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
        if (num!=1) {
            [self numlabel:text];
        }
        _canLabel.text = [NSString stringWithFormat:@"您参与了%lu次",(unsigned long)_duobaoArray.count];
    }else {
        _canLabel.text = @"您没有参与本期夺宝哦！";
        _canLabel.textAlignment = NSTextAlignmentCenter;
    }
    self.timeLabel.text = [NSString stringWithFormat:@"%@开始",self.dic[@"create_time_format"]];
    redlabel.text = [NSString stringWithFormat:@"参与次数需是%d的倍数",min_buy];
    _zuixinlabel.text = [NSString stringWithFormat:@"幸运号码:%@",self.dic[@"lottery_sn"]];
//    @[@"获奖者：9888_8ee",@"()",@"用户ID：235983（唯一不变标识",@"期    号:100011585",@"本期参与:34人次",@"揭晓时间:2016-10-12 14:22:00"]
    NSString *str11 = [NSString stringWithFormat:@"获奖者:%@",self.dic[@"luck_user_name"]];
    NSString *str12 = [NSString stringWithFormat:@"%@(%@)",self.dic[@"duobao_ip"],self.dic[@"duobao_area"]];
    NSString *str13 = [NSString stringWithFormat:@"用户ID：%@（唯一不变标识)",self.dic[@"luck_user_id"]];
    NSString *str14 = [NSString stringWithFormat:@"本期参与:%@人次",self.dic[@"luck_user_buy_count"]];
    NSString *str15 = [NSString stringWithFormat:@"期号:%@",self.dic[@"id"]];
    NSString *str16 = [NSString stringWithFormat:@"揭晓时间:%@",self.dic[@"lottery_time_format"]];
    NSArray *arr = @[str11,str12,str13,str15,str14,str16];
    for (int i = 0; i < 6; i++) {
        UILabel *label123 = [neiview viewWithTag:260+i];
        label123.text = arr[i];
    }
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
    
    
    self.scrollView = [[UIWebView alloc]initWithFrame:[UIView getRectWithX:0 andY:0 andWidth:320 andHeight:150]];
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.scrollView.delegate = self;
    
    self.jxlabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:10 andY:10 andWidth:40 andHeight:15]];
    _jxlabel.tintColor = [UIColor redColor];
    _jxlabel.textColor = [UIColor colorWithRed:91.0/255 green:1184.0/255 blue:42.0/255 alpha:1];
    _jxlabel.layer.borderWidth = 1;
    _jxlabel.layer.borderColor = [UIColor colorWithRed:91.0/255 green:1184.0/255 blue:42.0/255 alpha:1].CGColor;
    _jxlabel.text = @"已揭晓";
    _jxlabel.font = [UIFont systemFontOfSize:12];
    _jxlabel.layer.cornerRadius = 5;
    _jxlabel.clipsToBounds = YES;
    _jxlabel.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:_scrollView];
    [self.backView addSubview:_jxlabel];
    //    [self.view addSubview:self.backView];
    
    self.biaotiLabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:10 andY:150 andWidth:320-20 andHeight:15]];
    self.biaotiLabel.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:_biaotiLabel];
    
    self.fubiaoLabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:10 andY:165 andWidth:320-20 andHeight:22]];
    self.fubiaoLabel.font = [UIFont systemFontOfSize:12];
    self.fubiaoLabel.textColor = [UIColor redColor];
    self.fubiaoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.fubiaoLabel.numberOfLines = 0;
    [self.backView addSubview:self.fubiaoLabel];
    
    //y 170  h 115
    
    UIView *waiview = [[UIView alloc]initWithFrame:[UIView getRectWithX:5 andY:195 andWidth:310 andHeight:105]];
    waiview.backgroundColor = [UIColor colorWithRed:250.0/255 green:243.0/255 blue:240.0/255 alpha:1];
    [self.backView addSubview:waiview];
    
    UIView *zhongview = [[UIView alloc]initWithFrame:[UIView getRectWithX:6 andY:196 andWidth:308 andHeight:103]];
    zhongview.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:zhongview];
    
    neiview = [[UIView alloc]initWithFrame:[UIView getRectWithX:8 andY:198 andWidth:304 andHeight:99]];
    neiview.backgroundColor = [UIColor colorWithRed:250.0/255 green:243.0/255 blue:240.0/255 alpha:1];
    [self.backView addSubview:neiview];
    
    
    
    UIImageView *image =[[UIImageView alloc]initWithFrame:[UIView getRectWithX:5 andY:195 andWidth:25 andHeight:25]];
    image.image = [UIImage imageNamed:@"announced"];
    [self.backView addSubview:image];
    
    
    self.headImageview = [[UIImageView alloc]initWithFrame:[UIView getRectWithX:30 andY:10 andWidth:20 andHeight:20]];
    self.headImageview.layer.cornerRadius = self.headImageview.frame.size.height*480/SHEIGHT/2;
    self.headImageview.clipsToBounds = YES;
    self.headImageview.image = [UIImage imageNamed:@"guang"];
    [neiview addSubview:self.headImageview];
    
    NSArray *arra = @[@"获奖者：9888_8ee",@"()",@"用户ID：235983（唯一不变标识",@"期    号:100011585",@"本期参与:34人次",@"揭晓时间:2016-10-12 14:22:00"];
    for (int i = 0; i < 6; i++) {
        UILabel *labels = [[UILabel alloc]initWithFrame:[UIView getRectWithX:85 andY:5+i*11 andWidth:200 andHeight:10]];
        labels.backgroundColor = [UIColor clearColor];
        labels.text = arra[i];
        labels.font = [UIFont systemFontOfSize:10];
        labels.textColor = [UIColor colorWithRed:163.0/255 green:163.0/255 blue:163.0/255 alpha:1];
        labels.tag = 260+i;
        [neiview addSubview:labels];
    }
    
    
    UIView *redview = [[UIView alloc]initWithFrame:[UIView getRectWithX:8 andY:272 andWidth:304 andHeight:25]];
    redview.backgroundColor = SF_COLOR(255, 54, 93);
    [self.backView addSubview:redview];
    
    self.zuixinlabel  = [[UILabel alloc]initWithFrame:[UIView getRectWithX:10 andY:0 andWidth:150 andHeight:25]];
    _zuixinlabel.text = @"幸运号码:100000007";
    _zuixinlabel.textColor = [UIColor whiteColor];
    _zuixinlabel.backgroundColor = [UIColor clearColor];
    _zuixinlabel.font = [UIFont systemFontOfSize:16];
    [redview addSubview:_zuixinlabel];
    
    UIButton *detailBtn = [[UIButton alloc]initWithFrame:[UIView getRectWithX:240 andY:3 andWidth:60 andHeight:19]];
    
    detailBtn.backgroundColor = [UIColor clearColor];
    detailBtn.tintColor = [UIColor whiteColor];
    detailBtn.layer.borderWidth = 1;
    detailBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [detailBtn setTitle:@"计算详情" forState:UIControlStateNormal];
    detailBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [detailBtn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    [redview addSubview:detailBtn];
    
    
    
    backview2 = [[UIView alloc]init];
    backview2.backgroundColor  = [UIColor colorWithRed:243.0/255 green:243.0/255 blue:243.0/255 alpha:1];
    self.canLabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:10 andY:10 andWidth:280 andHeight:8]];
    _canLabel.font = [UIFont systemFontOfSize:12];
    _canLabel.textColor = [UIColor colorWithRed:158.0/255 green:158.0/255 blue:158.0/255 alpha:1];
    self.numberlabel = [[UILabel alloc]init];
    UIFont *font = [UIFont systemFontOfSize:12];
    _numberlabel.font = font;
    _numberlabel.numberOfLines = 0;
    _numberlabel.lineBreakMode = NSLineBreakByWordWrapping;
   
    _numberlabel.frame = [UIView getRectWithX:10 andY:20 andWidth:280 andHeight:0];
    _numberlabel.text = @"123";
    _numberlabel.textColor = [UIColor colorWithRed:158.0/255 green:158.0/255 blue:158.0/255 alpha:1];
    backview2.frame = [UIView getRectWithX:10 andY:310 andWidth:300 andHeight:20];
    [backview2 addSubview:_canLabel];
    [backview2 addSubview:_numberlabel];
    [self.backView addSubview:backview2];
    
    self.backviewHeight = backview2.frame.size.height/SHEIGHT*480;
    
    view1 = [[UIView alloc]initWithFrame:[UIView getRectWithX:0 andY:310 + self.backviewHeight + 5 andWidth:320 andHeight:10]];
    view1.backgroundColor = [UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1];
    [self.backView addSubview:view1];
    
    
    view2 = [[UIView alloc]initWithFrame:[UIView getRectWithX:0 andY:385 + self.backviewHeight + 5 andWidth:320 andHeight:10]];
    view2.backgroundColor = [UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1];
    [self.backView addSubview:view2];
    
    
    label = [[UILabel alloc]initWithFrame:[UIView getRectWithX:10 andY:355+self.backviewHeight andWidth:310 andHeight:0.1]];
    label.backgroundColor = [UIColor grayColor];
    [self.backView addSubview:label];
    
    
    
    self.tuwenLabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:10 andY:325+self.backviewHeight andWidth:300 andHeight:30]];
    self.tuwenLabel.text = @"图文详情";
    self.tuwenLabel.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:self.tuwenLabel];
    label2 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:200 andY:325+self.backviewHeight andWidth:100 andHeight:30]];
    label2.font = [UIFont systemFontOfSize:10];
    label2.textColor =[UIColor colorWithRed:158.0/255 green:158.0/255 blue:158.0/255 alpha:1];
    label2.text = @"建议在wifi下观看";
    [self.backView addSubview:label2];
    
    
    self.wangqiLabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:10 andY:355+self.backviewHeight andWidth:300 andHeight:30]];
    self.wangqiLabel.text = @"往期揭晓";
    self.wangqiLabel.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:self.wangqiLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tuwenxiangqing:)];
    tap.delegate = self;
    self.tuwenLabel.userInteractionEnabled = YES;
    [self.tuwenLabel addGestureRecognizer:tap];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wangqi:)];
    [self.wangqiLabel addGestureRecognizer:tap1];
    tap1.delegate = self;
    self.wangqiLabel.userInteractionEnabled = YES;
    
    jiluLabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:10 andY:395+self.backviewHeight andWidth:300 andHeight:30]];
    jiluLabel.text = @"所有参与记录";
    jiluLabel.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:jiluLabel];
    
    
    label3 = [[UILabel alloc]initWithFrame:[UIView getRectWithX:0 andY:425+self.backviewHeight andWidth:320 andHeight:0.1]];
    label3.backgroundColor = [UIColor grayColor];
    [self.backView addSubview:label3];
    
    
    
    self.timeLabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:200 andY:395+self.backviewHeight andWidth:120 andHeight:30]];
    self.timeLabel.textColor = [UIColor colorWithRed:158.0/255 green:158.0/255 blue:158.0/255 alpha:1];
    self.timeLabel.text = @"2016-10-09 09:51:20开始";
    self.timeLabel.font = [UIFont systemFontOfSize:10];
    [self.backView addSubview:self.timeLabel];
    
    self.backView.frame = [UIView getRectWithX:0 andY:0 andWidth:320 andHeight:445+self.backviewHeight];
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
- (void)btnclick:(UIButton *)brn {
    
    DizhiWebViewController *web = [[DizhiWebViewController alloc]init];
    NSString *str = [NSString stringWithFormat:@"%@?ctl=duobao&act=detail&page_type=app&data_id=%@",urlpre,self.dic[@"id"]];
    web.urlstring = str;
    web.titlestring = @"计算详情";
    [self.navigationController pushViewController:web animated:YES];}
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
