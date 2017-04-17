//
//  UIView+CGSet.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/24.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "UIView+CGSet.h"

@implementation UIView (CGSet)
+ (CGRect)setRectWithX:(CGFloat)x andY:(CGFloat)y andWidth:(CGFloat)width andHeight:(CGFloat)height {
    CGRect rect = CGRectZero;
    
    if (iPhone4S_frame) {
        rect = CGRectMake(x *(320 / 375.), y *(480 / 667.), width *(320 / 375.), height *(480 / 667.));
    }else if (iPhone6_frame) {
        rect = CGRectMake(x *(375 / 375.), y *(667. / 667.), width *(375 / 375.), height *(667. / 667.));
    }else if (iPadPro_frame){
        rect = CGRectMake(x *(768 / 375.), y *(1024 / 667.), width *(768 / 375.), height *(1024 / 667.));
    }else if (IPad2_frame){
        rect = CGRectMake(x *(768 / 375.), y *(1024 / 667.), width *(768 / 375.), height *(1024 / 667.));
    }else if (iPadPro12_frame){
        rect = CGRectMake(x *(1024 / 375.), y *(1366 / 667.), width *(1024 / 375.), height *(1366 / 667.));
    }else if (iPhone5S_frame) {
        rect = CGRectMake(x *(320 / 375.), y *(568 / 667.), width *(320 / 375.), height *(568 / 667.));
    }
    else {
        rect = CGRectMake(x *(414 / 375.), y *(736 / 667.), width *(414 / 375.), height *(736 / 667.));
    }
    return rect;
}

+ (CGSize)setSizeWithWidth:(CGFloat)width andHeight:(CGFloat)height {
    CGSize size = CGSizeZero;
    
    if (iPhone4S_frame || iPhone5S_frame) {
        size = CGSizeMake(width *(320 / 375.), height *(480 / 667.));
    }else if (iPhone6_frame) {
        size = CGSizeMake(width *(375 / 375.), height *(667. / 667.));
    }else if (IPad2_frame){
        size = CGSizeMake(width *(768 / 375.), height *(1024 / 667.));
    }else if (iPadPro12_frame){
        size = CGSizeMake(width *(1024 / 375.), height *(1366 / 667.));
    }else {
        size = CGSizeMake(width *(414 / 375.), height *(736 / 667.));
    }
    return size;
}

+ (CGFloat)setHeight:(CGFloat)height {
    CGFloat gao = 0;
    if (iPhone4S_frame) {
        gao = height * (480 / 667.);
    }else if (iPhone5S_frame) {
        gao = height * (568 / 667.);
    }else if (iPhone6_frame) {
        gao = height *(667. / 667.);
    }else if (IPad2_frame){
        gao = height *(1024 / 667.);
    }else if (iPadPro12_frame){
        gao = height *(1366 / 667.);
    }else {
        gao = height *(736 / 667.);
    }
    return gao;
}
+ (CGFloat)setWidth:(CGFloat)height {
    CGFloat gao = 0;
    if (iPhone4S_frame) {
        gao = height * (320 / 375.);
    }else if (iPhone5S_frame) {
        gao = height * (320 / 375.);
    }else if (iPhone6_frame) {
        gao = height *(375 / 375.);
    }else if (IPad2_frame){
        gao = height *(768 / 375.);
    }else if (iPadPro12_frame){
        gao = height *(1024 / 375.);
    }else {
        gao = height *(414 / 375.);
    }
    return gao;
}
@end
