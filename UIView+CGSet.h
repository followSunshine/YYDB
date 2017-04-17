//
//  UIView+CGSet.h
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/24.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import <UIKit/UIKit.h>
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

#define iPhone4S_frame ((Width == 320) && (Height == 480))

#define iPhone5S_frame ((Width == 320) && (Height == 568))

#define iPhone6_frame ((Width == 375) && (Height == 667))

#define iPhone6P_frame ((Width == 414) && (Height == 736))
#define IPad2_frame ((Width == 768) && (Height == 1024))
#define iPadPro_frame ((Width == 768) && (Height == 1024))
#define iPadPro12_frame ((Width == 1024) && (Height == 1366))
//1024  1366 ipadpro 12.9
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define SCREEN_4S_WIDTH 320
#define SCREEN_4S_HEIGHT 480

#define SELF_SIZE self.bounds.size

@interface UIView (CGSet)
/**
 *  坐标宽高适配
 *
 *  @param x      横坐标
 *  @param y      纵坐标
 *  @param width  宽
 *  @param height 高
 *
 *  @return frame
 */
+ (CGRect)setRectWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height;
/**
 *  宽高适配
 *
 *  @param width  宽
 *  @param height 高
 *
 *  @return size
 */
+ (CGSize)setSizeWithWidth:(CGFloat)width andHeight:(CGFloat)height;
/**
 *  高度适配
 *
 *  @param height 高
 *
 *  @return cgFloat
 */
+ (CGFloat)setHeight:(CGFloat)height;

+ (CGFloat)setWidth:(CGFloat)height;
@end


