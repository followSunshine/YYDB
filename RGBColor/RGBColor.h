//
//  RGBColor.h
//  DDMenu ---- 抽屉效果
//
//  Created by 李洪峰 on 15/9/29.
//  Copyright (c) 2015年 LHF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RGBColor : NSObject


//颜色  //通过网站可以查询到颜色的代码  http://www.114la.com/other/rgb.htm
+(UIColor *) colorWithHexString: (NSString *)stringToConvert;


@end
