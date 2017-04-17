//
//  ContestViewController.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/8/29.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContestViewController : UIViewController
@property (nonatomic, strong)UILabel *Scrolabel;
@property (nonatomic, strong)NSTimer *timer;
+ (ContestViewController *)sharedManager;

@end
