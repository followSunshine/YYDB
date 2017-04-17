//
//  HeaderCollectionReusableView.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/9/1.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "HeaderCollectionReusableView.h"
#import "UIView+CGSet.h"
@implementation HeaderCollectionReusableView
{
    
    NSMutableArray *_btnArray;
    NSMutableArray *_dataArray;
    UICollectionView *_collectionView;
    NSMutableArray *timearray;
    NSString *isbtn;
    BOOL isRefresh;
    NSTimer *timer;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(indextmp:) name:@"tmpindex" object:nil];
    }
    return self;
}
- (void)indextmp:(NSNotification *)n {
    
    NSString *str = [n.userInfo objectForKey:@"tmp"];
    UIButton *brn = (UIButton *)[self viewWithTag:710+str.intValue];
    isbtn = n.userInfo[@"isbtn"];
    [self btnclick12:brn];
}
- (void) setup {
    
    _dataArray = [NSMutableArray array];
    timearray = [NSMutableArray array];
    self.scrollview = [SDCycleScrollView cycleScrollViewWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:148] imageURLStringsGroup:nil];
    self.scrollview.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    
    self.scrollview.autoScrollTimeInterval = 4;
    
    self.scrollview.delegate = self;
    
    self.scrollview.dotColor = [UIColor whiteColor];
    
    [self addSubview:self.scrollview];
//    UILabel*labe = [[UILabel alloc]initWithFrame:CGRectMake(0, SHEIGHT*79/120, SWIDTH, SHEIGHT/96)];
//    labe.backgroundColor = SF_COLOR(248, 248, 248);
//    labe.backgroundColor = [UIColor yellowColor];
//    [self addSubview:labe];
    NSString *str = [NSString stringWithFormat:@"%f",[UIView setHeight:433]];
    NSNotification *notic = [NSNotification notificationWithName:@"labelheight" object:nil userInfo:@{@"height":str}];
    [[NSNotificationCenter defaultCenter] postNotification:notic];
    UILabel *bglabel =[[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:423 andWidth:375 andHeight:10]];
    bglabel.backgroundColor = SF_COLOR(242, 242, 242);
    [self addSubview:bglabel];

    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:[UIView setRectWithX:12 andY:303 andWidth:351 andHeight:120] collectionViewLayout:layout];
    layout.itemSize = CGSizeMake([UIView setWidth:117], [UIView setHeight:120]);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView.showsHorizontalScrollIndicator = false;
    [_collectionView registerClass:[JXCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    _collectionView.delegate= self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    [cell cellwithmodel:_dataArray[indexPath.row]];
    return cell;
    
}
- (void)btnclick12:(id)sender {
    UIButton *brn = (UIButton *)sender;
    
    NSLog(@"%ld",(long)brn.tag);
    for (int i = 0; i < 5; i++) {
        if (i == brn.tag - 710) {
            UILabel *label = [self viewWithTag:720+i];
            label.backgroundColor=SF_COLOR(255, 54, 93);
            
        }else {
            UILabel *label = [self viewWithTag:720+i];
            label.backgroundColor=[UIColor clearColor];
        }
    }
    for (int i = 0; i<5; i++) {
        UIButton *but = [self viewWithTag:710+i];
        [but setSelected:NO];
    }
    [brn setSelected:YES];
    if (![isbtn isEqualToString:@"1"]) {
        
        NSDictionary *dic = @{@"index":[NSString stringWithFormat:@"%ld",brn.tag-710]};
        NSNotification *no = [NSNotification notificationWithName:@"refreshindex" object:nil userInfo:dic];
        [[NSNotificationCenter defaultCenter]postNotification:no];

    }
    isbtn = nil;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:self.AdvsArray[index],@"index",nil];
    
    NSNotification *nf = [NSNotification notificationWithName:@"tongzhi" object:nil userInfo:dic];
    
    [[NSNotificationCenter defaultCenter] postNotification:nf];
    
}
- (NSString *)timeFormatted:(int)totalSeconds
{
    int seconds = totalSeconds % 100;
    int minutes = (totalSeconds / 100) % 60;
    int hours = (totalSeconds / 6000)%60;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}

- (void)refresjtime {
    int time;
    for (int i = 0; i < timearray.count; i++) {
        time = [timearray[i] intValue];
        JXCollectionViewCell *cell = (JXCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        cell.label2.text = [self timeFormatted:--time];
        cell.label2.textColor = SF_COLOR(255, 54, 93);
        
        [timearray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",time]];

        if (time<=0) {
            cell.label2.text = @"开奖中";
            cell.label2.textAlignment = NSTextAlignmentCenter;
            [timearray removeObjectAtIndex:i];
            if (timearray.count==0) {
                [timer invalidate];
                timer = nil;
            }
        }
    }
}

- (void)reloadDatawith:(NSArray *)advsArr and:(NSArray *)indexArr and:(NSArray *)newestArr and:(NSArray *)duoBaoArray and:(NSString *)time{
    _dataArray = [NSMutableArray arrayWithArray:duoBaoArray];
    [timearray removeAllObjects];
    for (int i = 0; i < _dataArray.count; i++) {
        DuoBaoModel *model = _dataArray[i];
        if (model.has_lottery.integerValue==0) {
            
            
            NSString *stime = [NSString stringWithFormat:@"%d",(model.lottery_time.intValue-time.intValue)*100];
            [timearray addObject:stime];
        }
    }
    if (timearray.count>0) {
        if (!timer) {
            timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(refresjtime) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
        }
        
    }

    [_collectionView reloadData];

    
    if (isRefresh) {
        return;
    }
    isRefresh = YES;
    self.AdvsArray = [NSMutableArray array];
    
    self.NewsetArray = [NSMutableArray array];
    
    self.AdvsArray = [NSMutableArray arrayWithArray:advsArr];
    
    self.NewsetArray = [NSMutableArray arrayWithArray:newestArr];
    
    self.duobaoArray = [NSMutableArray array];
    
    self.duobaoArray = [NSMutableArray arrayWithArray:duoBaoArray];
    
    _btnArray = [NSMutableArray array];
    
    for (id index in indexArr) {
        IndexModel *model = (IndexModel *)index;
        
        NSLog(@"%@    %@",model.name,model.icon_name);
        
    }

    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSArray *arr = @[@"最热",@"最新",@"最快",@"高价",@"低价"];
    
    if (del.isShenHe) {
        arr = @[@"热度",@"新奇",@"快速"];
    }
    for (int i = 0; i < arr.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:375/arr.count*i andY:433 andWidth:375/arr.count andHeight:32]];
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
        btn.tag = 710+i;
        [self addSubview:btn];
        
        UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:17.5 andY:31 andWidth:40 andHeight:1.8]];
        if (del.isShenHe) {
            label.frame = [UIView setRectWithX:24 andY:31 andWidth:76 andHeight:1.8];
        }
        
        if (i==0) {
            label.backgroundColor = SF_COLOR(255, 54, 93);
        }
        label.tag = 720+i;
        [btn addSubview:label];
    }

    
    NSArray *imageArr = @[@"1分类",@"1十元",@"1揭晓",@"1晒单"];
    NSArray *titleArr = @[@"分类",@"10元专区",@"揭晓",@"晒单"];

    if (del.isShenHe) {
        titleArr = @[@"分类专区",@"10元精品",@"奖品揭晓",@"晒单分享"];
        imageArr = @[@"新分类",@"新10元",@"新揭晓",@"新晒单"];

    }


        for(int i = 0 ;i < 4; i++)
        {
            
            UIButton *btn = [[UIButton alloc]initWithFrame:[UIView setRectWithX:0+i*375/4 andY:148 andWidth:375/4 andHeight:80]];

            IndexModel *model = (IndexModel *)indexArr[i];
            
            [_btnArray addObject:model];
                        
            [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
            
            btn.tag = 100+i;
            
            [self addSubview:btn];
            
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake((SWIDTH/4-[UIView setHeight:50])/2+i*SWIDTH/4, [UIView setHeight:155], [UIView setHeight:50], [UIView setHeight:50])];
            
            imageview.image = [UIImage imageNamed:imageArr[i]];
            [self addSubview:imageview];

            UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:i*375/4 andY:209 andWidth:375/4 andHeight:13]];
            
            label.textColor = SF_COLOR(51,51, 51);
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14];
            label.text = titleArr[i];
            if (SWIDTH == 320) {
//                imageview.frame = CGRectMake((SWIDTH/4-[UIView setHeight:50])/2+i*SWIDTH/4, [UIView setHeight:130], [UIView setHeight:50], [UIView setHeight:50]);
                label.font = [UIFont systemFontOfSize:12];
//                label.frame =[UIView setRectWithX:i*375/4 andY:213 andWidth:375/4 andHeight:13];
            }
            [self addSubview:label];
        }
    UILabel *line1label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:228.5 andWidth:351 andHeight:0.3]];
    line1label.backgroundColor = SF_COLOR(229, 229, 229);
    [self addSubview:line1label];
    
    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake([UIView setWidth:17], [UIView setHeight:235], [UIView setHeight:20], [UIView setHeight:20])];
    
    
    imageview1.image = [UIImage imageNamed:@"icon通知"];
    
    [self addSubview:imageview1];
//    if (SWIDTH ==320) {
//        imageview1.frame = CGRectMake([UIView setWidth:17], [UIView setHeight:195], [UIView setHeight:20], [UIView setHeight:20]);
//    }
    
    NSMutableArray *urlarr = [NSMutableArray array];
    
    for (id admodel in advsArr) {
        AdvsModel *model = (AdvsModel *)admodel;
        
        [urlarr addObject:model.img];
        
    }
    
    [self.scrollview setImageURLStringsGroup:urlarr];
    
    UILabel *bglabel =[[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:261 andWidth:375 andHeight:10]];
    bglabel.backgroundColor = SF_COLOR(242, 242, 242);
    [self addSubview:bglabel];
    
    UILabel * zuiXinLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:271 andWidth:375 andHeight:32]];
    zuiXinLabel.text = @"     最新揭晓";
    zuiXinLabel.textAlignment = NSTextAlignmentLeft;
    zuiXinLabel.font = [UIFont systemFontOfSize:15];
    zuiXinLabel.textColor = SF_COLOR(51, 51, 51);
    
    UILabel *lainelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 0.3)];
    lainelabel.backgroundColor =SF_COLOR(232, 232, 232);
    [zuiXinLabel addSubview:lainelabel];
    [self addSubview:zuiXinLabel];
    UILabel *lainelabel1 = [[UILabel alloc]initWithFrame:CGRectMake([UIView setWidth:12], zuiXinLabel.frame.size.height-0.3, SWIDTH, 0.3)];
    [zuiXinLabel addSubview:lainelabel1];
    lainelabel1.backgroundColor =SF_COLOR(229, 229, 229);
    
    UIImageView *rImage = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:375-29 andY:10 andWidth:12 andHeight:12]];
    rImage.image = [UIImage imageNamed:@"灰箭头"];
    [zuiXinLabel addSubview:rImage];
    
    UIButton *glabel = [[UIButton alloc]initWithFrame:[UIView setRectWithX:293 andY:0 andWidth:50 andHeight:32]];
    
    [glabel setTitle:@"更多" forState:UIControlStateNormal];
    [glabel setTitleColor:SF_COLOR(153, 153, 153) forState:UIControlStateNormal];
    glabel.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [glabel addTarget:self action:@selector(GoToJX) forControlEvents:UIControlEventTouchUpInside];
    
    [zuiXinLabel addSubview:glabel];
 
    zuiXinLabel.userInteractionEnabled = YES;

#pragma mark ---
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DuoBaoModel *model = _dataArray[indexPath.row];
    NSString *str = model.has_lottery;
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:model.userid,@"index",str,@"status",nil];
    
    NSNotification *nf = [NSNotification notificationWithName:@"tongzhi2" object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter] postNotification:nf];
}
- (void)GoToJX {
    NSNotification *notice = [NSNotification notificationWithName:@"pushtomain" object:nil userInfo:@{@"num":@"3"}];
    
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
}
- (void)btnclick:(UIButton *)btn {
    
    IndexModel *model = (IndexModel *)_btnArray[btn.tag-100];
    
    if ([model.userid isEqualToString:@"83"]) {
        
        NSNotification *notice = [NSNotification notificationWithName:@"pushtomain" object:nil userInfo:@{@"num":@"3"}];
        
        [[NSNotificationCenter defaultCenter] postNotification:notice];

        return;
        
    }
    NSString *str = [NSString stringWithFormat:@"%ld",btn.tag-100];
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:str,@"index",nil];
    
    NSNotification *nf = [NSNotification notificationWithName:@"tongzhi23" object:nil userInfo:dic];
    
    [[NSNotificationCenter defaultCenter] postNotification:nf];
    
    
}


@end
