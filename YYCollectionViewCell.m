//
//  YYCollectionViewCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/12/13.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "YYCollectionViewCell.h"

@implementation YYCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:[UIView setRectWithX:107.5 andY:0 andWidth:160 andHeight:160]];
        [self.contentView addSubview:img];
        self.imageView = img;
    }
    
    return self;
}
- (void)setImge:(NSString *)imge {
    _imge = imge;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imge] placeholderImage:[UIImage imageNamed:@"占位图"]];
}
@end
