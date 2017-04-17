//
//  ShowDeatilViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/12/9.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "ShowDeatilViewController.h"
#import "AFHTTPSessionManager.h"
#import "UIView+CGSet.h"
#import "ShowDetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ShowModel2.h"
#import "DetailDaojishiViewController.h"
@interface ShowDeatilViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *table;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UIView *bgview;

@end

@implementation ShowDeatilViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = [[ShowModel alloc]init];
        self.dataArray = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setUP];
    [self data];
}
- (void)data {
    self.dataArray = [NSMutableArray arrayWithArray:self.model.image_list];
    [self.table reloadData];
}
- (void)setNavigationBar {
    self.navigationController.navigationBar.hidden = YES;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"晒单详情";
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


- (void)setUP {
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[ShowDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.table];
    
    self.bgview = [[UIView alloc]init];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:12], [UIView setHeight:9], [UIView setHeight:50], [UIView setHeight:50])];
    [image sd_setImageWithURL:[NSURL URLWithString:self.model.user_avatar]];
    [self.bgview addSubview:image];
    
    UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setHeight:50]+[UIView setWidth:22], [UIView setHeight:18], [UIView setWidth:150], 15)];
    namelabel.text = self.model.user_name;
    namelabel.textColor = SF_COLOR(102, 154, 241);
    namelabel.font = [UIFont systemFontOfSize:15];
    [self.bgview addSubview:namelabel];
    
    UILabel *timelabel = [[UILabel alloc]initWithFrame:CGRectMake([UIView setHeight:50]+[UIView setWidth:22], [UIView setHeight:38], [UIView setWidth:150], 12)];
    timelabel.text = self.model.create_time;
    timelabel.textColor = SF_COLOR(153, 153, 153);
    timelabel.font = [UIFont systemFontOfSize:12];
    [self.bgview addSubview:timelabel];
    
    UIImageView *jiantou = [[UIImageView alloc]initWithFrame:CGRectMake(SWIDTH-[UIView setWidth:16]-[UIView setHeight:10], [UIView setHeight:28], [UIView setHeight:10], [UIView setHeight:10])];
    jiantou.image = [UIImage imageNamed:@"红箭头"];
    [self.bgview addSubview:jiantou];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:250], [UIView setHeight:26.5],[UIView setWidth:109]-[UIView setHeight:10], [UIView setHeight:13])];
    label.textColor = SF_COLOR(255, 54, 93);
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentRight;
    label.userInteractionEnabled = YES;
    label.text = @"试试手气";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapclick:)];
    [label addGestureRecognizer:tap];
    [self.bgview addSubview:label];
    
    UIView *view = [[UIView alloc]initWithFrame:[UIView setRectWithX:12 andY:66 andWidth:351 andHeight:100]];
    view.backgroundColor = SF_COLOR(232, 232, 232);
    [self.bgview addSubview:view];
    
    UILabel *woodslabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:5 andY:8 andWidth:341 andHeight:16.8]];
    woodslabel.font = [UIFont systemFontOfSize:12];
    ShowModel2 *model2 = self.model.duobao_item;
    woodslabel.textColor = SF_COLOR(153, 153, 153);
    NSString *woodsnamestr = [NSString stringWithFormat:@"获奖商品：%@",model2.name];
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:woodsnamestr];
    [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(102, 154, 241) range:NSMakeRange(5, model2.name.length)];
    woodslabel.attributedText = mstr;
    [view addSubview:woodslabel];
    
    UILabel *qilabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:5 andY:8+16.8*1 andWidth:241 andHeight:16.8]];
    qilabel.textColor = SF_COLOR(153, 153, 153);
    qilabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:qilabel];
    qilabel.text = [NSString stringWithFormat:@"商品期数：%@",model2.id];
    
    UILabel *benlabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:5 andY:8+16.8*2 andWidth:341 andHeight:16.8]];
    benlabel.font = [UIFont systemFontOfSize:12];
    
    benlabel.textColor = SF_COLOR(153, 153, 153);
    NSString *bennamestr = [NSString stringWithFormat:@"本期参与：%@人次",model2.luck_user_buy_count];
    NSMutableAttributedString *mstr1 = [[NSMutableAttributedString alloc]initWithString:bennamestr];
    [mstr1 addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(5, model2.luck_user_buy_count.length)];
    benlabel.attributedText = mstr1;
    [view addSubview:benlabel];

    UILabel *luckLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:5 andY:8+16.8*3 andWidth:341 andHeight:16.8]];
    luckLabel.font = [UIFont systemFontOfSize:12];
    
    luckLabel.textColor = SF_COLOR(153, 153, 153);
    NSString *luckstr = [NSString stringWithFormat:@"幸运号码：%@",model2.lottery_sn];
    NSMutableAttributedString *mstr2 = [[NSMutableAttributedString alloc]initWithString:luckstr];
    [mstr2 addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(5, model2.lottery_sn.length)];
    luckLabel.attributedText = mstr2;
    [view addSubview:luckLabel];
    
    UILabel *lotteryLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:5 andY:8+16.8*4 andWidth:241 andHeight:16.8]];
    lotteryLabel.textColor = SF_COLOR(153, 153, 153);
    lotteryLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:lotteryLabel];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy:MM:dd HH:mm"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[model2.lottery_time doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    
    lotteryLabel.text = [NSString stringWithFormat:@"揭晓时间：%@",dateString];
    
    UILabel *titlelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:181 andWidth:200 andHeight:16]];
    titlelabel.font = [UIFont systemFontOfSize:16];
    titlelabel.text = self.model.title;
    titlelabel.textColor = SF_COLOR(17, 17, 17);
    [self.bgview addSubview:titlelabel];
    
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.frame = [UIView setRectWithX:12 andY:204 andWidth:351 andHeight:0];
    contentLabel.font = [UIFont systemFontOfSize:12];
    contentLabel.numberOfLines = 0;
    contentLabel.textColor = SF_COLOR(51, 51, 51);
    contentLabel.text = self.model.content;
    [contentLabel sizeToFit];
    [self.bgview addSubview:contentLabel];
    
    self.bgview.frame = CGRectMake(0, 0, SWIDTH, [UIView setHeight:219]+contentLabel.frame.size.height);
    self.table.tableHeaderView = self.bgview;
    
    
}
- (void)tapclick:(UITapGestureRecognizer *)tap {
    DetailDaojishiViewController *deta = [[DetailDaojishiViewController alloc]init];
    deta.userid = _model.duobao_item_id;
    [self.navigationController pushViewController:deta animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShowDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell reloadWithModel:_dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UIView setHeight:515];
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
