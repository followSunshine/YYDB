//
//  ContestViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/8/29.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "ContestViewController.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "AFURLRequestSerialization.h"
#import "WoodsModle.h"
#import "AdvsModel.h"
#import "IndexModel.h"
#import "NewestModel.h"
#import "GoodsCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "WebVIewController.h"

#import "DuoBaoModel.h"
#import "AppDelegate.h"
#import "HelpViewController.h"
#import "MyYQViewController.h"
#import "DizhiWebViewController.h"
#import "MJRefresh.h"
#import "DetailViewController.h"
#import "DetailDaojishiViewController.h"
#import "DetailJXiaoViewController.h"
#import "CateViewController.h"
#import "ShowViewController.h"
#import "MyMessageViewController.h"
#import "NewMesgViewController.h"
#import "TenViewController.h"
#import "LBProgressHUD.h"
#import "UMSocialUIManager.h"
#import "SearchViewController.h"
#import "UIView+CGSet.h"
#import "SearchDetailViewController.h"
#import <AdSupport/AdSupport.h>
static int a = 0;
@interface ContestViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate,UIWebViewDelegate>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UIView *backBtnView;
@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)NSString *nowtime;
@property (nonatomic, strong)UIWebView *webview;
@property (nonatomic, strong)UIButton *alertBtn;
@end

@implementation ContestViewController
{
    UIButton *btn321;
    NSInteger _page;
    
    UICollectionView *_clview;
    
    NSMutableArray *_dataScrollArray;
    
    NSMutableArray *_dataBtnArray;
    
    NSMutableArray *_dataLabelArray;
    
    NSMutableArray *_duoBaoArray;
    
    NSString *_httpString;
    NSInteger tmp;
    CGFloat labelheight;
    int _lastPosition;
    BOOL isBut;
    BOOL isHead;
    UIView *blackView;
    BOOL isPush;
}

+ (ContestViewController *)sharedManager
{
    static ContestViewController *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}
- (void)viewDidLoad {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    [super viewDidLoad];
    //    UIButton *leftbut = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    //
    //    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftbut];
    //    self.navigationItem.rightBarButtonItem = left;
    //    [leftbut setBackgroundImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    //    [leftbut addTarget:self action:@selector(shareto) forControlEvents:UIControlEventTouchUpInside];
    [self postIDfa];
    [self setNavigition];
    [self creatCV];
    [self InputYQM];
    [self example21];

    //    [self showView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi23:) name:@"tongzhi23" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushtongzhi:) name:@"tongzhi2" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addPlist:) name:@"addplist" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushto:) name:@"pushmain" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(relod:) name:@"refreshindex" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getlabelheigt:) name:@"labelheight" object:nil];
    
}
- (void)postIDfa {
    NSString *str =  [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSString *str1 = [NSString stringWithFormat:@"%@?act=send&v=4&idfa=%@&un=liweijia",urlpre,str];
    [manager POST:str1 parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (void)InputYQM {
    blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT)];
    blackView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:42.5 andY:160 andWidth:290 andHeight:415]];
    image.image = [UIImage imageNamed:@"背景"];
    [blackView addSubview:image];
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:290]-[UIView setHeight:29]-[UIView setWidth:19], [UIView setHeight:93], [UIView setHeight:20], [UIView setHeight:20])];
    image1.image = [UIImage imageNamed:@"取消"];
    [image addSubview:image1];
    
    image1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick:)];
    [image1 addGestureRecognizer:tap];
    self.textField = [[UITextField alloc]initWithFrame:[UIView setRectWithX:52.5 andY:181 andWidth:185 andHeight:40]];
    self.textField.layer.cornerRadius = 5;
    self.textField.layer.borderColor = SF_COLOR(255, 54, 93).CGColor;
    
    self.textField.layer.borderWidth=1;
    self.textField.clipsToBounds = YES;
    self.textField.placeholder = @"请输入邀请码";
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.textField.font = [UIFont systemFontOfSize:18];
    [image addSubview:self.textField];
    image.userInteractionEnabled = YES;
    btn321 = [[UIButton alloc]initWithFrame:[UIView setRectWithX:52.5 andY:245 andWidth:185 andHeight:40]];
    btn321.backgroundColor = SF_COLOR(255, 54, 93);
    [btn321 setTitle:@"确认" forState:UIControlStateNormal];
    [btn321 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn321.layer.cornerRadius = 5;
    btn321.clipsToBounds = YES;
    btn321.titleLabel.font = [UIFont systemFontOfSize:24];
    [btn321 addTarget:self action:@selector(MakeSure) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:btn321];
    
    UILabel *label32 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:55 andY:297 andWidth:180 andHeight:40]];
    label32.textColor = SF_COLOR(205, 205, 205);
    label32.font = [UIFont systemFontOfSize:11];
    NSString *strma = @"新用户登陆即可获得一夺宝币，快去消费吧！";
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString: @"新用户登陆即可获得一夺宝币，快去消费吧！输入邀请码，您的好友根据相应规则获得红包"];
    [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(0, strma.length)];
    label32.attributedText = mstr;
//    label32.text = @"输入邀请码，您的好友根据相应规则获得红包";
    label32.numberOfLines = 0;
    [image addSubview:label32];
    
//    [self.view addSubview:blackView];
}
- (void)tapclick:(UITapGestureRecognizer *)tap {
    [blackView removeFromSuperview];
    
}
- (void)showView {
    
    [self.view addSubview:blackView];
    
}
- (void)MakeSure {
    btn321.userInteractionEnabled = NO;
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    [manager GET:[NSString stringWithFormat:@"%@?v=3&ctl=share&act=prentice&code=%@&uid=%@",urlpre,self.textField.text,del.userid] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        UIAlertView *aler = [[UIAlertView alloc]initWithTitle:nil message:@"邀请成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aler show];
        btn321.userInteractionEnabled = YES;
        NSNumber *num = dic[@"status"];
        if (num.integerValue==1) {
            [blackView removeFromSuperview];
        }
        if (num.integerValue!=-5) {
            btn321.userInteractionEnabled = NO;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}



- (void)setNavigition {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"夺宝";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationController.navigationBar.hidden = YES;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 64)];
    view.backgroundColor = SF_COLOR(255, 54, 93);
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIView setWidth:12], 30, 24, 24)];
    [returnBtn setBackgroundImage:[UIImage imageNamed:@"icon消息"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(MyMesClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH-12-24, 30, 24, 24)];
    
    
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"icon分享"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(shareto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:view];
    [self.view addSubview:returnBtn];
    [self.view addSubview:rightBtn];
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake((1-250/375.)/2*SWIDTH, 28,250/375.*SWIDTH, 28)];
    self.searchBar.text = @"汽车";
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = NO;
    
    for (UIView *view in self.searchBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    
    [self.view addSubview:self.searchBar];
    
    
    UITextField *text = [self.searchBar valueForKey:@"_searchField"];
    text.backgroundColor = SF_COLOR(197, 42, 93);
    text.textColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"icon--搜索"];
    UIImageView *imagevoew = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    imagevoew.image = image;
    text.leftView = imagevoew;
}
- (void)filterBySubstring:(NSString *)str {
    
    SearchDetailViewController *seat = [[SearchDetailViewController alloc]init];
    seat.searchStr = str;
    [self hideTabBar];
    [self.navigationController pushViewController:seat animated:YES];
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"----searchBarSearchButtonClicked------");
    // 调用filterBySubstring:方法执行搜索
    [self filterBySubstring:searchBar.text];
    // 放弃作为第一个响应者，关闭键盘
    [self.searchBar resignFirstResponder];
}

- (void)MyMesClick {
    
    NewMesgViewController *mu = [[NewMesgViewController alloc]init];
    [self hideTabBar];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController pushViewController:mu animated:YES];
    
}
- (void)getlabelheigt:(NSNotification *)n {
    
    NSString *height = [n.userInfo objectForKey:@"height"];
    labelheight = height.floatValue;
}
- (void)shareto {
    __weak typeof(self) weakSelf = self;
    [UMSocialUIManager showShareMenuViewInView:nil sharePlatformSelectionBlock:^(UMSocialShareSelectionView *shareSelectionView, NSIndexPath *indexPath, UMSocialPlatformType platformType) {
        [weakSelf shareWebPageToPlatformType:platformType];
    }];
    
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"好友一起，将一元变成惊喜" descr:@"您的好友正在参与一元夺宝，快来看看他的夺宝记录和获得的宝贝吧" thumImage:[UIImage imageNamed:@"180.png"]];
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"http://y.vbokai.com/share.html"];
    //分享消息对象设置分享内容对象3
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"分享成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    
    UITouch *touch = [touches anyObject];
    CGPoint position = [touch locationInView:_clview];
    
    NSIndexPath *indexPath = [_clview indexPathForItemAtPoint:position];
    
    NSLog(@"%@",indexPath);
    if (indexPath!=NULL) {
        
        DetailViewController *detail = [[DetailViewController alloc]init];
        WoodsModle *moodle = _dataArray[indexPath.row];
        detail.userid =moodle.userid;
        [self hideTabBar];
        if (isPush) {
            [self.navigationController pushViewController:detail animated:YES];
        }
        isPush = NO;
    }
    
    [self.textField resignFirstResponder];
    [self.searchBar resignFirstResponder];
}
- (void)relod:(NSNotification *)n {
    
    NSString *index = n.userInfo[@"index"];
    tmp = index.intValue;
    if (!isHead) {
        switch (index.intValue) {
            case 0:
                [self selectReloadWithIndex:@"1"];
                break;
            case 1:
                [self selectReloadWithIndex:@"2"];
                
                break;
            case 2:
                [self selectReloadWithIndex:@"3"];
                
                break;
            case 3:
                [self selectReloadWithIndex:@"4"];
                break;
            case 4:
                [self selectReloadWithIndex:@"5"];
                break;
            default:
                break;
        }
        
    }
    isHead = NO;
}
- (void)selectReloadWithIndex:(NSString *)str {
    [LBProgressHUD showHUDto:self.view animated:YES];
    _clview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page++;
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?&page=%ld&act=index_duobao_list&order=%@&v=3",urlpre,(long)_page,str]];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSDictionary *dic= (NSDictionary *)responseObject;
                
                NSLog(@"%@",responseObject);
                
                NSArray *arr = dic[@"index_duobao_list"];
                
                for (NSDictionary *dica in arr) {
                    
                    WoodsModle *model = [[WoodsModle alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dica];
                    
                    [_dataArray addObject:model];
                    
                }
                [_clview reloadData];
                [_clview.mj_footer endRefreshing];
                
            }
        }];
        [dataTask resume];
    }];
    // 默认先隐藏footer
    _clview.mj_footer.hidden = YES;
    
    // 下拉刷新
    _clview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSString *str2 = [NSString stringWithFormat:@"%@?act=index_duobao_list&v=3&order=%@",urlpre,str];
        NSURL *URL = [NSURL URLWithString:str2];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSDictionary *dic= (NSDictionary *)responseObject;
                [_dataArray removeAllObjects];
                NSArray *arr = dic[@"index_duobao_list"];
                
                for (NSDictionary *dica in arr) {
                    
                    WoodsModle *model = [[WoodsModle alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dica];
                    
                    [_dataArray addObject:model];
                    
                }
                [_clview reloadData];
                [_clview.mj_header endRefreshing];
                
            }
        }];
        [dataTask resume];
        
        _dataScrollArray = [NSMutableArray array];
        
        _dataBtnArray = [NSMutableArray array];
        
        _dataLabelArray = [NSMutableArray array];
        
        _duoBaoArray = [NSMutableArray array];
        
        NSURLSessionConfiguration *configuration1 = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration1];
        NSString *str1 = [NSString stringWithFormat:@"%@?v=4",urlpre];
        NSURL *URL1 = [NSURL URLWithString:str1];
        NSURLRequest *request1 = [NSURLRequest requestWithURL:URL1];
        
        NSURLSessionDataTask *dataTask1 = [manager1 dataTaskWithRequest:request1 completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                
                NSDictionary *dic = (NSDictionary *)responseObject;
                
                NSLog(@"%@",responseObject);
                
                AppDelegate *deleget = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                deleget.hostUrl =dic[@"http_host"];
                _httpString = dic[@"http_host"];
                
                self.nowtime = dic[@"now_time"];
                if ([dic[@"status"] isEqualToString:@"-1"]) {
                    deleget.isShenHe = YES;
                }
                deleget.pay_data = dic[@"pay_status"];
                for (NSDictionary *dic1 in dic[@"advs"]) {
                    AdvsModel *model = [[AdvsModel alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dic1];
                    
                    [_dataScrollArray addObject:model];
                    
                }
                for (NSDictionary *dic2 in dic[@"indexs"]) {
                    IndexModel *model = [[IndexModel alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dic2];
                    
                    [_dataBtnArray addObject:model];
                    
                    
                }
                for (NSDictionary *dic3 in dic[@"newest_lottery_list"]) {
                    NewestModel *model = [[NewestModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic3];
                    [_dataLabelArray addObject:model];
                }
                for (NSDictionary *dic4 in dic[@"newest_doubao_list"]) {
                    DuoBaoModel *model = [[DuoBaoModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic4];
                    [_duoBaoArray addObject:model];
                }
                [_clview reloadData];
            }
        }];
        [dataTask1 resume];
        
        
    }];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    
    NSString *url = [NSString stringWithFormat:@"%@?act=index_duobao_list&v=3&order=%@",urlpre,str];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic= (NSDictionary *)responseObject;
        [_dataArray removeAllObjects];
        NSArray *arr = dic[@"index_duobao_list"];
        
        for (NSDictionary *dica in arr) {
            WoodsModle *model = [[WoodsModle alloc]init];
            [model setValuesForKeysWithDictionary:dica];
            [_dataArray addObject:model];
        }
        [_clview reloadData];
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [LBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
-(void) pushto:(NSNotification *)n {
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([del.is_new isEqualToString:@"1"]) {
        [self showView];
        del.is_new =@"";
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    AppDelegate *dele = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (dele.userid.length>0) {
        [self.alertBtn removeFromSuperview];
    }else {
        [self.view addSubview:self.alertBtn];
    }
    if ([dele.is_new isEqualToString:@"1"]) {
        [self showView];
        dele.is_new =@"0";
    }
    [self showTabBar];
    isPush = YES;
    self.navigationController.navigationBar.hidden = YES;
    
    for(UIView *subView in self.searchBar.subviews.firstObject.subviews) {
        if([subView isKindOfClass: [UITextField class]]){
            UITextField *searchField = (UITextField *)subView;
            
            searchField.clearButtonMode = UITextFieldViewModeNever;
        }
    }
}
- (void)addPlist :(NSNotification *)n {
    
    
    
    AppDelegate *dele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    NSString *index = n.userInfo[@"index"];
    WoodsModle *model = _dataArray[index.intValue];
    
    if (!dele.userid.length) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还尚未登陆" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self hideTabBar];
            [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
        }];
        UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"再看看" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:act];
        [alert addAction:act1];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else {
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        int b ;
        if (model.min_buy.integerValue>=5) {
            b=model.min_buy.intValue;
        }else {
            b=5;
        }
        if (b>(model.max_buy.intValue - model.current_buy.intValue)) {
            b=model.max_buy.intValue - model.current_buy.intValue;
        }
        
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSString *str = [NSString stringWithFormat:@"%@?ctl=api&act=addcart&buy_num=%d&data_id=%@&uid=%@",urlpre,b,model.userid,del.userid];
        [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSString *str = dic[@"status"];
            if (str.intValue==1) {
                [self updataWindows];
                del.plistNum +=1;
                
                NSNotification *notice = [NSNotification notificationWithName:@"plistNum" object:nil userInfo:@{@"num":[NSString stringWithFormat:@"%d",del.plistNum]}];
                
                [[NSNotificationCenter defaultCenter] postNotification:notice];
                
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"cart_item_num"] forKey:@"number"];
                
            }else {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:dic[@"info"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }
    
    
    
}
- (void)pushtongzhi:(NSNotification *)n {
    NSString *str = n.userInfo[@"index"];
    NSString *status = n.userInfo[@"status"];
    NSLog(@"%@",str);
    
    DetailDaojishiViewController *deta = [[DetailDaojishiViewController alloc]init];
    DetailJXiaoViewController *dd = [[DetailJXiaoViewController alloc]init];
    
    [self hideTabBar];
    if (status.intValue==0) {
        dd.userid = str;
        [self.navigationController pushViewController:dd animated:YES];
    }else {
        deta.userid = str;
        [self.navigationController pushViewController:deta animated:YES];
    }
    
    
    
}
-(void)updataWindows {
    
    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    
    UIView *view = [[UIView alloc]initWithFrame:[UIView setRectWithX:110 andY:275 andWidth:155 andHeight:70]];
    
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.8;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 8.0f;
    UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:155 andHeight:70]];
    label.text = @"加入购物车成功";
    
    label.textColor = [UIColor whiteColor];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [windows addSubview:view];
    
    [view addSubview:label];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        [view removeFromSuperview];
    });
}
- (void)example21
{
    _dataArray = [NSMutableArray array];
    _page = 1;
    _clview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSString *str = [NSString stringWithFormat:@"%@?act=index_duobao_list&v=3&order=%ld",urlpre,tmp+1];
        NSURL *URL = [NSURL URLWithString:str];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                
                NSLog(@"Error: %@", error);
                
                
            } else {
                NSDictionary *dic= (NSDictionary *)responseObject;
                [_dataArray removeAllObjects];
                NSArray *arr = dic[@"index_duobao_list"];
                
                for (NSDictionary *dica in arr) {
                    
                    WoodsModle *model = [[WoodsModle alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dica];
                    
                    [_dataArray addObject:model];
                    
                }
                [_clview reloadData];
                [_clview.mj_header endRefreshing];
                
            }
        }];
        [dataTask resume];
        
        _dataScrollArray = [NSMutableArray array];
        
        _dataBtnArray = [NSMutableArray array];
        
        _dataLabelArray = [NSMutableArray array];
        
        _duoBaoArray = [NSMutableArray array];
        
        NSURLSessionConfiguration *configuration1 = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration1];
        NSString *str1 = [NSString stringWithFormat:@"%@?v=4",urlpre];
        NSURL *URL1 = [NSURL URLWithString:str1];
        NSURLRequest *request1 = [NSURLRequest requestWithURL:URL1];
        
        NSURLSessionDataTask *dataTask1 = [manager1 dataTaskWithRequest:request1 completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                
                NSDictionary *dic = (NSDictionary *)responseObject;
                
                NSLog(@"%@",responseObject);
                
                AppDelegate *deleget = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                deleget.hostUrl =dic[@"http_host"];
                _httpString = dic[@"http_host"];
                
                self.nowtime = dic[@"now_time"];
                if ([dic[@"status"] isEqualToString:@"-1"]) {
                    deleget.isShenHe = YES;
                }
                [self creatButton];
//                NSString *urlString = dic[@"url"];
//                if (urlString.length>1) {
//                    [self AlertMesgWithMesg:urlString];
//                }
                
                deleget.pay_data = dic[@"pay_status"];
                for (NSDictionary *dic1 in dic[@"advs"]) {
                    AdvsModel *model = [[AdvsModel alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dic1];
                    
                    [_dataScrollArray addObject:model];
                    
                }
                for (NSDictionary *dic2 in dic[@"indexs"]) {
                    IndexModel *model = [[IndexModel alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dic2];
                    
                    [_dataBtnArray addObject:model];
                    
                    
                }
                for (NSDictionary *dic3 in dic[@"newest_lottery_list"]) {
                    NewestModel *model = [[NewestModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic3];
                    [_dataLabelArray addObject:model];
                }
                for (NSDictionary *dic4 in dic[@"newest_doubao_list"]) {
                    DuoBaoModel *model = [[DuoBaoModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic4];
                    [_duoBaoArray addObject:model];
                }
                [_clview reloadData];
            }
        }];
        [dataTask1 resume];
        
        
    }];
    [_clview.mj_header beginRefreshing];
    
    // 上拉刷新
    _clview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page++;
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        NSString *preurl ;
        switch (tmp) {
            case 0:
                preurl = @"1";
                break;
            case 1:
                preurl = @"2";
                
                break;
            case 2:
                preurl = @"3";
                
                break;
            case 3:
                preurl = @"4";
                break;
            case 4:
                preurl = @"5";
                break;
            default:
                break;
        }
        
        NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?ctl=api&page=%ld&act=index_duobao_list&order=%@&v=4",urlpre,(long)_page,preurl]];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                NSDictionary *dic= (NSDictionary *)responseObject;
                
                NSLog(@"%@",responseObject);
                
                NSArray *arr = dic[@"index_duobao_list"];
                
                for (NSDictionary *dica in arr) {
                    
                    WoodsModle *model = [[WoodsModle alloc]init];
                    
                    [model setValuesForKeysWithDictionary:dica];
                    
                    [_dataArray addObject:model];
                    
                }
                [_clview reloadData];
                [_clview.mj_footer endRefreshing];
                
            }
        }];
        [dataTask resume];
        
        
    }];
    // 默认先隐藏footer
    _clview.mj_footer.hidden = YES;
}
- (void) AlertMesgWithMesg:(NSString *)string {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:string]];
    [self.webview loadRequest:request];
    if (!self.webview.superview) {
        [self.view addSubview:self.webview];
    }
}
- (void) requestData {
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString *str = [NSString stringWithFormat:@"%@?ctl=api&page=1&act=index_duobao_list",urlpre];
    NSURL *URL = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSDictionary *dic= (NSDictionary *)responseObject;
            
            NSLog(@"%@",responseObject);
            
            NSArray *arr = dic[@"index_duobao_list"];
            
            for (NSDictionary *dica in arr) {
                
                WoodsModle *model = [[WoodsModle alloc]init];
                
                [model setValuesForKeysWithDictionary:dica];
                
                [_dataArray addObject:model];
                
                [_clview reloadData];
            }
        }
    }];
    [dataTask resume];
}
#pragma mark  分类跳转
- (void)tongzhi23:(NSNotification *)n {
    
    NSString *str = n.userInfo[@"index"];
    
    NSLog(@"%@",str);
    if ([str isEqualToString:@"0"]) {
        CateViewController *cate = [[CateViewController alloc]init];
        [self hideTabBar];
        [self.navigationController pushViewController:cate animated:YES];
    }else if ([str isEqualToString:@"3"]){
        ShowViewController *help = [[ShowViewController alloc]init];
        [self hideTabBar];
        
        [self.navigationController pushViewController:help animated:YES];
    }else if([str isEqualToString:@"1"]) {
        TenViewController *ten = [[TenViewController alloc]init];
        ten.titlestring = @"十元专区";
        ten.urlstring = @"?ctl=duobaost&min_buy=10";
        [self hideTabBar];
        
        [self.navigationController pushViewController:ten animated:YES];
    }

}
- (void)tongzhi:(NSNotification *)n {
    
    AdvsModel *model = n.userInfo[@"index"];
    
    NSString *index = model.type;
    switch (index.integerValue) {
        case 0:
        {
            DizhiWebViewController *di = [[DizhiWebViewController alloc]init];
            di.urlstring = model.data[@"url"];
            [self hideTabBar];
            [self.navigationController pushViewController:di animated:YES];
        }
            break;
        case 1:
        {
            CateViewController *help = [[CateViewController alloc]init];
            [self hideTabBar];
            [self.navigationController pushViewController:help animated:YES];
        }
            break;
        case 2:
        {
            NSDictionary *dic = model.data;
            
            TenViewController *ten = [[TenViewController alloc]init];
            ten.titlestring = model.name;
            NSString *str = [NSString stringWithFormat:@"?ctl=duobaos&data_id=%@",dic[@"cate_id"]];
            ten.urlstring = str;
            
            [self.navigationController pushViewController:ten animated:YES];
        }
            break;
        case 3:
        {
            
            
            NSNotification *notice = [NSNotification notificationWithName:@"pushtomain" object:nil userInfo:@{@"num":@"3"}];
            
            [[NSNotificationCenter defaultCenter] postNotification:notice];
            
        }
            break;
        case 4:
        {
            DetailViewController *de = [[DetailViewController alloc]init];
            de.userid = model.data[@"data_id"];
            
            [self hideTabBar];
            [self.navigationController pushViewController:de animated:YES];
            
        }
            break;
        case 5:
        {
            
            HelpViewController *help = [[HelpViewController alloc]init];
            [self hideTabBar];
            [self.navigationController pushViewController:help animated:YES];
            
        }
            break;
        case 6:
        {
            
            DizhiWebViewController *di = [[DizhiWebViewController alloc]init];
            
            di.urlstring = [NSString stringWithFormat:@"%@?ctl=helps&act=show&page_type=app&data_id=%@",urlpre,model.data[@"data_id"]];
            [self hideTabBar];
            
            [self.navigationController pushViewController:di animated:YES];
            
        }
            break;
        case 7:
        {
            
            TenViewController *ten = [[TenViewController alloc]init];
            ten.titlestring = @"十元专区";
            ten.urlstring = @"?ctl=duobaost&min_buy=10";
            [self hideTabBar];
            [self.navigationController pushViewController:ten animated:YES];
            
        }
            break;
        case 8:
        {
            
            TenViewController *ten = [[TenViewController alloc]init];
            ten.titlestring = @"百元专区";
            ten.urlstring = @"?ctl=duobaosh";
            [self hideTabBar];
            [self.navigationController pushViewController:ten animated:YES];
            
        }
            break;
        case 9:
        {
            
            ShowViewController *help = [[ShowViewController alloc]init];
            [self hideTabBar];
            [self.navigationController pushViewController:help animated:YES];
            
            
        }
            break;
        case 10:
        {
            
            MyYQViewController *help = [[MyYQViewController alloc]init];
            [self hideTabBar];
            [self.navigationController pushViewController:help animated:YES];
            
        }
            break;
            
        
            
        default:
            break;
    }

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int currentPostion = scrollView.contentOffset.y;
    if (currentPostion - _lastPosition > 0) {
        _lastPosition = currentPostion;
        
        if (currentPostion >= labelheight) {
            if (!isBut) {
                [self.view addSubview:self.backBtnView];
                UIButton *brn = (UIButton *)[self.backBtnView viewWithTag:740+tmp];
                isHead = YES;
                isBut = YES;
                [self btnclick12:brn];
            }
        }
        
    }
    else if (_lastPosition - currentPostion > 0)
    {
        _lastPosition = currentPostion;
        
        if (currentPostion <= labelheight) {
            
            if (isBut == YES) {
                [self.backBtnView removeFromSuperview];
                
                NSNotification *no = [NSNotification notificationWithName:@"tmpindex" object:nil userInfo:@{@"tmp":[NSString stringWithFormat:@"%ld",(long)tmp],@"isbtn":@"1"}];
                [[NSNotificationCenter defaultCenter] postNotification:no];
                isBut=NO;
            }
        }
        
    }
    
}
- (void)requestdata {
    
    _dataScrollArray = [NSMutableArray array];
    
    _dataBtnArray = [NSMutableArray array];
    
    _dataLabelArray = [NSMutableArray array];
    
    _duoBaoArray = [NSMutableArray array];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString *str = [NSString stringWithFormat:@"%@?v=3",urlpre];
    NSURL *URL = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            NSDictionary *dic = (NSDictionary *)responseObject;
            
            NSLog(@"%@",responseObject);
            
            AppDelegate *deleget = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            deleget.hostUrl =dic[@"http_host"];
            _httpString = dic[@"http_host"];
            
            if ([dic[@"status"] isEqualToString:@"-1"]) {
                deleget.isShenHe = YES;
            }
            
            for (NSDictionary *dic1 in dic[@"advs"]) {
                AdvsModel *model = [[AdvsModel alloc]init];
            
                [model setValuesForKeysWithDictionary:dic1];
                [_dataScrollArray addObject:model];
            }
            for (NSDictionary *dic2 in dic[@"indexs"]) {
                IndexModel *model = [[IndexModel alloc]init];
                
                [model setValuesForKeysWithDictionary:dic2];
                
                [_dataBtnArray addObject:model];
                
                
            }
            for (NSDictionary *dic3 in dic[@"newest_lottery_list"]) {
                NewestModel *model = [[NewestModel alloc]init];
                [model setValuesForKeysWithDictionary:dic3];
                [_dataLabelArray addObject:model];
            }
            for (NSDictionary *dic4 in dic[@"newest_doubao_list"]) {
                DuoBaoModel *model = [[DuoBaoModel alloc]init];
                [model setValuesForKeysWithDictionary:dic4];
                [_duoBaoArray addObject:model];
            }
            [_clview reloadData];
            
        }
    }];
    [dataTask resume];
}
- (void )creatCV {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _clview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-49-64)collectionViewLayout:layout];;
    
    _clview.dataSource = self;
    
    _clview.delegate = self;
    
    _clview.backgroundColor = [UIColor whiteColor];
    
    //设置滚动方向锤子滚动（flowLayout）
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置间距
    layout.minimumInteritemSpacing = 0;
    //最小列间距
    layout.minimumLineSpacing = 0;
    //最小行间距
    
    [_clview registerClass:[GoodsCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    [_clview registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self.view addSubview:_clview];
    
    
    layout.headerReferenceSize = CGSizeMake(SWIDTH, [UIView setHeight:465]);
    
    self.alertBtn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:300 andY:667-28-49-60 andWidth:60 andHeight:60]];
    [self.alertBtn setBackgroundImage:[UIImage imageNamed:@"福利"] forState:UIControlStateNormal];
    [self.alertBtn addTarget:self action:@selector(alertBtnClick) forControlEvents:UIControlEventTouchUpInside];
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (del.userid.length>0) {
        
    }else {
        [self.view addSubview:self.alertBtn];
    }
//    _webview.scrollView.showsVerticalScrollIndicator = NO;
//    _webview.scrollView.showsHorizontalScrollIndicator = NO;
//    self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT-49)];

////    [self.view addSubview:self.webview];
//    self.webview.delegate = self;
//    self.webview.backgroundColor = [UIColor lightGrayColor];
//    self.webview.alpha = 0.9;

}
- (void)alertBtnClick {
    
    [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
//    [self.navigationController pushViewController:[[DizhiWebViewController alloc]init] animated:YES];

}
//返回对应网格的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake([UIView setWidth:187.4], [UIView setHeight:205]);
    
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    _clview.mj_footer.hidden = self.dataArray.count == 0;
    return _dataArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell = @"cellid";
    GoodsCollectionViewCell *goodscell = [collectionView dequeueReusableCellWithReuseIdentifier: cell
                                                                                   forIndexPath:indexPath];
    if (!goodscell){
        
        goodscell = [[GoodsCollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, [UIView setWidth:187.4], [UIView setHeight:205])];
    }

    goodscell.backgroundColor = [UIColor whiteColor];
    
    [goodscell addDataWithModel:_dataArray[indexPath.row]];
    goodscell.layer.borderWidth = 0.3;
    goodscell.layer.borderColor = SF_COLOR(242, 242, 242).CGColor;
    
    return goodscell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
    UICollectionReusableView *rv = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        HeaderCollectionReusableView *header = (HeaderCollectionReusableView *)[_clview dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        if (_dataBtnArray.count) {
            [header reloadDatawith:_dataScrollArray and:_dataBtnArray and:_dataLabelArray and:_duoBaoArray and:self.nowtime];
            
        }
        rv = header;
        NSLog(@"%lu",(unsigned long)header.subviews.count);
        if (header.subviews.count<=9) {
            
            self.Scrolabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:21]+[UIView setHeight:20], [UIView setHeight:229], [UIView setWidth:350], [UIView setHeight:32])];
            if (SWIDTH==320) {
                
//                self.Scrolabel.frame =CGRectMake([UIView setWidth:21]+[UIView setHeight:20], [UIView setHeight:189], [UIView setWidth:300], [UIView setHeight:32]);
            }
            self.Scrolabel.font = [UIFont systemFontOfSize:12];
            [rv addSubview:self.Scrolabel];
        }
        
        if (_dataLabelArray.count) {
            if (!_timer) {
                
                self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeLabelText) userInfo:nil repeats:YES];
                [[NSRunLoop mainRunLoop] addTimer:_timer  forMode:NSRunLoopCommonModes];
                
            }
        }
        
    }
    
    
    return rv;
}
- (void)changeLabelText {
    
    if (!_dataLabelArray.count) {
        return;
    }
    NewestModel *model = (NewestModel *)_dataLabelArray[a];
    
    NSString *str1 = [NSString stringWithFormat:@"恭喜%@%@获得%@",model.user_name,model.span_time,model.name];
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:str1];
    
    NSInteger length = model.user_name.length;
    NSInteger length1 = model.span_time.length;
    [str addAttribute:NSForegroundColorAttributeName value:SF_COLOR(102, 102, 102) range:NSMakeRange(0, 2)];
    [str addAttribute:NSForegroundColorAttributeName value:SF_COLOR(54, 149, 255) range:NSMakeRange(2,length)];
    
    [str addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(4+length+length1, model.name.length)];
    
    
    self.Scrolabel.attributedText = nil;
    
    self.Scrolabel.attributedText = str;
    
    a++;
    
    if (a == _dataLabelArray.count) {
        a = 0;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (SWIDTH==320) {
//        return CGSizeMake(SWIDTH, [UIView setHeight:400]);
    }
    
    return CGSizeMake(SWIDTH, [UIView setHeight:465]);
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
- (void)creatButton {
    self.backBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, [UIView setHeight:32])];
    self.backBtnView.backgroundColor = [UIColor whiteColor];
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSArray *arr = @[@"最热",@"最新",@"最快",@"高价",@"低价"];

    if (del.isShenHe) {
        arr = @[@"热度",@"新奇",@"快速"];
    }
    for (int i = 0; i < arr.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:375/arr.count*i andY:0 andWidth:375/arr.count andHeight:32]];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:SF_COLOR(51, 51, 51) forState:UIControlStateNormal];
        [btn setTitleColor:SF_COLOR(255, 54, 93) forState:UIControlStateSelected];
        if (i==0){
            [btn setSelected:YES];
        }else {
            [btn setSelected:NO];
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(btnclick12:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 740+i;
        [self.backBtnView addSubview:btn];
        
        UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:17.5 andY:31 andWidth:40 andHeight:1.8]];
        if (del.isShenHe) {
            label.frame = [UIView setRectWithX:24 andY:31 andWidth:76 andHeight:1.8];
        }
        if (i==0) {
            label.backgroundColor = SF_COLOR(255, 54, 93);
        }
        label.tag = 750+i;
        [btn addSubview:label];
    }
}
- (void)btnclick12:(id)sender {
    UIButton *brn = (UIButton *)sender;
    
    //    NSLog(@"%ld",(long)brn.tag);
    for (int i = 0; i < 5; i++) {
        if (i == brn.tag - 740) {
            UILabel *label = [self.view viewWithTag:750+i];
            label.backgroundColor=SF_COLOR(255, 54, 93);
            
        }else {
            UILabel *label = [self.view viewWithTag:750+i];
            label.backgroundColor=[UIColor clearColor];
        }
    }
    for (int i = 0; i<5; i++) {
        UIButton *but = [self.view viewWithTag:740+i];
        [but setSelected:NO];
    }
    [brn setSelected:YES];
    
    NSDictionary *dic = @{@"index":[NSString stringWithFormat:@"%ld",brn.tag-740]};
    NSNotification *no = [NSNotification notificationWithName:@"refreshindex" object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter]postNotification:no];
    
    
}

@end



















