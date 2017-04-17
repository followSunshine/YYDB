//
//  UIView+CGGetRect.m
//  聚惠
//
//  Created by MS on 15/12/27.
//  Copyright (c) 2015年 chenyu. All rights reserved.
//

#import "UIView+CGGetRect.h"

@implementation UIView (CGGetRect)

+ (CGRect)getRectWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height {
    CGRect rect = CGRectZero;
    
    if (iPhone4S_frame) {
        rect = CGRectMake(x, y, width, height);
    }else if (iPhone5S_frame) {
        rect = CGRectMake(x *(320 / 320.), y *(568 / 480.), width *(320 / 320.), height *(568 / 480.));
    }
    else if (iPhone6_frame) {
        rect = CGRectMake(x *(375 / 320.), y *(667 / 480.), width *(375 / 320.), height *(667 / 480.));
    }else if (iPadPro_frame){
           rect = CGRectMake(x *(768 / 320.), y *(1024 / 480.), width *(768 / 320.), height *(1024 / 480.));
    }else if (IPad2_frame){
            rect = CGRectMake(x *(768 / 320.), y *(1024 / 480.), width *(768 / 320.), height *(1024 / 480.));
    }else if (iPadPro12_frame){
        rect = CGRectMake(x *(1024 / 320.), y *(1366 / 480.), width *(1024 / 320.), height *(1366 / 480.));
    }
    else {
        rect = CGRectMake(x *(414 / 320.), y *(736 / 480.), width *(414 / 320.), height *(736 / 480.));

    }
    return rect;
}

+ (CGSize)getSizeWithWidth:(CGFloat)width andHeight:(CGFloat)height {
    CGSize size = CGSizeZero;
    
    if (iPhone4S_frame || iPhone5S_frame) {
        size = CGSizeMake(width, height);
    }else if (iPhone6_frame) {
        size = CGSizeMake(width *(375 / 320.), height *(667 / 480.));
    }else if (IPad2_frame){
        size = CGSizeMake(width *(768 / 320.), height *(1024 / 480.));
    }else if (iPadPro12_frame){
        size = CGSizeMake(width *(1024 / 320.), height *(1366 / 480.));
    }else {
        size = CGSizeMake(width *(414 / 320.), height *(736 / 480.));
    }
    return size;
}

+ (CGFloat)getHeight:(CGFloat)height {
    CGFloat gao = 0;
    if (iPhone4S_frame) {
        gao = height;
    }else if (iPhone5S_frame) {
        gao = height * (568 / 480.);
    }else if (iPhone6_frame) {
        gao = height *(667 / 480.);
    }else if (IPad2_frame){
        gao = height *(1024 / 480.);
    }else if (iPadPro12_frame){
        gao = height *(1366 / 480.);
    }else {
        gao = height *(736 / 480.);
    }
    return gao;
}
+ (CGFloat)getWidth:(CGFloat)height {
    CGFloat gao = 0;
    if (iPhone4S_frame) {
        gao = height;
    }else if (iPhone5S_frame) {
        gao = height * (320 / 320.);
    }else if (iPhone6_frame) {
        gao = height *(375 / 320.);
    }else if (IPad2_frame){
        gao = height *(768 / 480.);
    }else if (iPadPro12_frame){
        gao = height *(1024 / 480.);
    }else {
        gao = height *(414 / 320.);
    }
    return gao;
}
@end
