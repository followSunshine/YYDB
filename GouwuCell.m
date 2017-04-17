//
//  GouwuCell.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/10/22.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "GouwuCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+CGSet.h"

@implementation GouwuCell
{
    UIImageView *image;
    UILabel *titlelabel;
    UILabel *zongxulabel;
    UILabel *canyulabel;
    UILabel *syLabel;
    UILabel *addbtn;
    UILabel *detbtn;
    UIButton *shanchubtn;
    UILabel *redlabel;
    int max_buy;
    NSInteger cell_row;
    int min_buy;
    UIButton *btn;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup {
    image = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:22 andY:34 andWidth:90 andHeight:90]];
    
    titlelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:12 andWidth:323 andHeight:14  ]];
    titlelabel.font = [UIFont systemFontOfSize:14];
    titlelabel.textColor = SF_COLOR(16, 16, 16);
    
    syLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:232 andY:39 andWidth:100 andHeight:12]];
    syLabel.textColor =SF_COLOR(102, 102, 102);
    syLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:syLabel];
    
    
    zongxulabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:132 andY:39 andWidth:100 andHeight:12]];
    zongxulabel.textColor = SF_COLOR(102, 102, 102);
    zongxulabel.font = [UIFont systemFontOfSize:12];
    
    
    canyulabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:132 andY:107 andWidth:150 andHeight:12]];
    canyulabel.textColor = SF_COLOR(102, 154, 241);
    canyulabel.font = [UIFont systemFontOfSize:12];
    UIView *label = [[UIView alloc]initWithFrame:[UIView setRectWithX:132 andY:63 andWidth:130 andHeight:32]];
    label.layer.borderWidth = 1;
    label.layer.borderColor = SF_COLOR(153,153,153).CGColor;
    
    label.clipsToBounds = YES;
    
    
    detbtn = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:40 andHeight:32]];
    detbtn.font = [UIFont fontWithName:@"iconfont" size:18];
    detbtn.text = @"\ue6d3";
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detbtn:)];
    [detbtn addGestureRecognizer:tap1];
    detbtn.userInteractionEnabled = YES;
    detbtn.textColor = SF_COLOR(51,51,51);
    detbtn.textAlignment = NSTextAlignmentCenter;
    addbtn = [[UILabel alloc]initWithFrame:[UIView setRectWithX:90 andY:0 andWidth:40 andHeight:32]];
    addbtn.font = [UIFont fontWithName:@"iconfont" size:18];
    addbtn.text = @"\ue6d1";
    addbtn.textColor = SF_COLOR(51,51,51);
    addbtn.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addbtn:)];
    [addbtn addGestureRecognizer:tap];
    addbtn.userInteractionEnabled = YES;
    _textfield = [[UITextField alloc]initWithFrame:[UIView setRectWithX:40 andY:0 andWidth:50 andHeight:32]];
    _textfield.keyboardType = UIKeyboardTypeNumberPad;
    _textfield.textAlignment = NSTextAlignmentCenter;
    _textfield.borderStyle = UITextBorderStyleLine;
    _textfield.layer.borderWidth = 1;
    _textfield.layer.borderColor = SF_COLOR(153, 153, 153).CGColor;
    _textfield.delegate = self;
    _textfield.font = [UIFont systemFontOfSize:15];
    _textfield.textColor = SF_COLOR(51, 51, 51);
    _textfield.userInteractionEnabled = YES;
    
    redlabel = [[UILabel alloc]initWithFrame:[UIView getRectWithX:120 andY:100 andWidth:150 andHeight:10]];
    redlabel.textColor = [UIColor redColor];
    redlabel.font = [UIFont systemFontOfSize:10];
    redlabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:image];
    [self.contentView addSubview:titlelabel];
    [self.contentView addSubview:zongxulabel];
    [self.contentView addSubview:canyulabel];
    [self.contentView addSubview:label];
//    [self.contentView addSubview:redlabel];
    [label addSubview:detbtn];
    [label addSubview:addbtn];
    [label addSubview:_textfield];
    [_textfield addTarget:self action:@selector(valuechang) forControlEvents:UIControlEventEditingDidEnd];

    
    UIImageView *delimage = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:335 andY:12 andWidth:20 andHeight:20]];
    delimage.image = [UIImage imageNamed:@"垃圾桶"];
    delimage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(delClick:)];
    [delimage addGestureRecognizer:tap2];
    
    [self.contentView addSubview:delimage];
    UILabel *linelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:139.5 andWidth:SWIDTH andHeight:0.5]];
    linelabel.backgroundColor = SF_COLOR(232,232,232);
    [self.contentView addSubview:linelabel];
    
    btn = [[UIButton alloc]initWithFrame:CGRectMake(SWIDTH-[UIView setHeight:36]-[UIView setWidth:12], [UIView setHeight:70], [UIView setHeight:36], [UIView setHeight:36])];
    [btn setBackgroundImage:[UIImage imageNamed:@"包尾"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"绿对号"] forState:UIControlStateSelected];
    btn.selected = NO;
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    
}
- (void)btnclick {
    
    if (!btn.selected) {
        _textfield.text = [NSString stringWithFormat:@"%d",max_buy];
    }else {
        _textfield.text = [NSString stringWithFormat:@"%d",min_buy];
    }
    btn.selected = !btn.selected;
    [self valuechang];
}
- (BOOL )textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"string====%@",string);
    
    return YES;
}
- (void)valuechang {
    int a = _textfield.text.intValue;
    if (max_buy) {
        if (a>=max_buy) {
        
            _textfield.text = [NSString stringWithFormat:@"%d",max_buy/min_buy*min_buy];
        }else {
            int b = a/min_buy*min_buy;
            if (b==0){
                b = min_buy;
            }
            _textfield.text = [NSString stringWithFormat:@"%d",b];
        }
        UITableView *table = (UITableView *)[[self superview]superview];
        NSIndexPath *index = [table indexPathForCell:self];
        
        NSNotification *nt = [[NSNotification alloc]initWithName:@"valuechange" object:nil userInfo:@{@"cell":[NSString stringWithFormat:@"%ld",(long)index.row],@"value":_textfield.text}];
        
        [[NSNotificationCenter defaultCenter]postNotification:nt];
    }else {
        return;
    }
    
}
- (void)delClick :(UITapGestureRecognizer *)tap {
    UITableView *table = (UITableView *)[[self superview]superview];
    NSIndexPath *index = [table indexPathForCell:self];
    if (index) {
        NSNotification *nt = [[NSNotification alloc]initWithName:@"gouwudel" object:nil userInfo:@{@"row":index}];
        [[NSNotificationCenter defaultCenter]postNotification:nt];

    }
    
}
- (void)detbtn:(UITapGestureRecognizer *)tap {
    
    int a = _textfield.text.intValue;
    if (a!=min_buy) {
        a-=min_buy;
    }    _textfield.text = [NSString stringWithFormat:@"%d",a];
    
    [self.textfield resignFirstResponder];
    [self valuechang];
}
- (void)addbtn:(UITapGestureRecognizer *)tap {
    int a = _textfield.text.intValue;
    if(a!=max_buy){
        a+=min_buy;
    }
    _textfield.text = [NSString stringWithFormat:@"%d",a];
    [self valuechang];

}
- (void)reloadwith:(GouwuModel *)model {
    
    [image sd_setImageWithURL:[NSURL URLWithString:model.deal_icon]];
    titlelabel.text = model.name;
    NSString *str = [NSString stringWithFormat:@"总需:%@人次",model.max_buy];

    zongxulabel.text = str;
    
    _textfield.text = model.number;
    NSString *string = [NSString stringWithFormat:@"剩余:%@人次",model.residue_count];
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:string];
    int a = (int)model.residue_count.length;
    [mstr addAttribute:NSForegroundColorAttributeName value:SF_COLOR(255, 54, 93) range:NSMakeRange(3, a)];
    syLabel.attributedText = mstr;
    
    canyulabel.text = [NSString stringWithFormat:@"参与次数需为%@的倍数",model.min_buy];
    
    max_buy = model.residue_count.intValue;
    UITableView *table = (UITableView *)[[self superview]superview];
    NSIndexPath *index = [table indexPathForCell:self];
    cell_row = index.row;
    min_buy = model.min_buy.intValue;
    
    if (self.textfield.text.intValue<model.residue_count.intValue) {
        btn.selected=NO;
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_textfield resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    UITableView *table = (UITableView *)[[self superview]superview];
    NSIndexPath *index = [table indexPathForCell:self];
    NSNotification *no = [NSNotification notificationWithName:@"textpost" object:nil userInfo:@{@"index":index}];
    [[NSNotificationCenter defaultCenter]postNotification:no];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
       [_textfield resignFirstResponder];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
