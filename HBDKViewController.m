//
//  HBDKViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/12/1.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "HBDKViewController.h"
#import "HBModel.h"
#import "UIView+CGSet.h"
#import "MyHBTableViewCell.h"
@interface HBDKViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation HBDKViewController
-(instancetype)init {
    if (self=[super init]) {
        self.arr = [NSArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"可用红包";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    [self setUP];
    
}
- (void)setUP {
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT-64) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[MyHBTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableview.backgroundColor = SF_COLOR(242, 242, 242);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    self.dataArray = [NSMutableArray array];
    for (NSDictionary *dic in self.arr) {
        HBModel *model = [[HBModel alloc]initWithDictionary:dic error:nil];
        [self.dataArray addObject:model];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    HBModel *model = self.dataArray[indexPath.row];
    del.hongbao_id = model.id;
    del.hongbao_money = model.money;
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyHBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell reloadwith:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [UIView setHeight:144];
    }else {
        return [UIView setHeight:136];
    }
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
