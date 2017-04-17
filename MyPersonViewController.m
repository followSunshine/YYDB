//
//  MyPersonViewController.m
//  YiYuanDuoBao
//
//  Created by chenyu on 16/11/25.
//  Copyright © 2016年 chen1. All rights reserved.
//

#import "MyPersonViewController.h"
#import "UIView+CGSet.h"
#import "UIImageView+WebCache.h"
#import "AFHTTPSessionManager.h"
@interface MyPersonViewController ()<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView *headimage;
    UITextField *nametf;
    UITextField *numtf;
    UIDatePicker *datePick;
    UILabel *Btimelabel;
    UILabel *sexLabel;
    UIPickerView *pickview;
    NSMutableArray *arr;
    UIImage *localimage;
}
@end
@implementation MyPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    
    [self setUI];
    [self request];
}
- (void)setNavigationBar {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SWIDTH, 44)];
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"个人资料";
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
- (void)setUI {
    arr = [NSMutableArray arrayWithArray:@[@"男",@"女",@"保密"]];


    UIView *view = [[UIView alloc]initWithFrame:[UIView setRectWithX:0 andY:64*667/SHEIGHT andWidth:375 andHeight:86]];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UILabel *label1 = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:0 andWidth:300 andHeight:86]];
    label1.textColor = SF_COLOR(102, 102, 102);
    label1.font = [UIFont systemFontOfSize:15];
    label1.text = @"头像";
    UILabel *line = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:85.5 andWidth:375 andHeight:0.3]];
    line.backgroundColor = SF_COLOR(229, 229, 229);
    [view addSubview:line];

    UIImageView *image1 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:350 andY:38 andWidth:10 andHeight:10]];
    image1.image = [UIImage imageNamed:@"灰箭头"];
    [view addSubview:image1];
    [view addSubview:label1];
    
    headimage =[[UIImageView alloc]initWithFrame:CGRectMake(SWIDTH-[UIView setWidth:31]-[UIView setHeight:60], [UIView setHeight:13], [UIView setHeight:60], [UIView setHeight:60])];
    headimage.image = [UIImage imageNamed:@"qicon"];
    headimage.layer.cornerRadius = [UIView setHeight:60]/2;
    headimage.clipsToBounds = YES;
    [view addSubview:headimage];
    UIButton *btn1 = [[UIButton alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:86]];
    btn1.backgroundColor = [UIColor clearColor];
    [view addSubview:btn1];
    [btn1 addTarget:self action:@selector(headClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSArray *arr1 = @[@"昵称",@"手机号码",@"性别",@"生日"];
    for (int i = 0; i<4; i++) {
        UIView *view = [[UIView alloc]init];
        if (i == 4) {
            view.frame = [UIView setRectWithX:0 andY:i*40+64*667/SHEIGHT+86+10 andWidth:375 andHeight:40];
            UILabel *line = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:0.3]];
            line.backgroundColor = SF_COLOR(229, 229, 229);
            [view addSubview:line];
        }else {
            view.frame = [UIView setRectWithX:0 andY:i*40+64*667/SHEIGHT+86 andWidth:375 andHeight:40];
        }
        view.backgroundColor = [UIColor whiteColor];
        UILabel *line = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:39.5 andWidth:375 andHeight:0.3]];
        line.backgroundColor = SF_COLOR(229, 229, 229);
        [view addSubview:line];
        
        UILabel *namelabe = [[UILabel alloc]initWithFrame:[UIView setRectWithX:12 andY:0 andWidth:100 andHeight:40]];
        namelabe.textColor = SF_COLOR(102, 102, 102);
        namelabe.font = [UIFont systemFontOfSize:15];
        namelabe.text = arr1[i];
        [view addSubview:namelabe];
        
        UIImageView *image1 = [[UIImageView alloc]initWithFrame:[UIView setRectWithX:350 andY:15 andWidth:10 andHeight:10]];
        image1.image = [UIImage imageNamed:@"灰箭头"];
        [view addSubview:image1];
        
        if (i==0) {
            nametf = [[UITextField alloc]initWithFrame:[UIView setRectWithX:144 andY:0 andWidth:200 andHeight:40]];
            nametf.delegate = self;
            [view addSubview:nametf];
            nametf.tag = 952;
            nametf.textAlignment = NSTextAlignmentRight;
            nametf.font = [UIFont systemFontOfSize:12];
            nametf.textColor = SF_COLOR(102, 102, 102);
            [view addSubview:nametf];
        }
        if (i == 1) {
            numtf = [[UITextField alloc]initWithFrame:[UIView setRectWithX:144 andY:0 andWidth:200 andHeight:40]];
            numtf.delegate = self;
            [view addSubview:numtf];
            numtf.textAlignment = NSTextAlignmentRight;
            numtf.font = [UIFont systemFontOfSize:12];
            numtf.textColor = SF_COLOR(102, 102, 102);
            [view addSubview:numtf];
            numtf.keyboardType = UIKeyboardTypeNumberPad;
        }if (i==2) {
            sexLabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:144 andY:0 andWidth:200 andHeight:40]];
            sexLabel.font = [UIFont systemFontOfSize:12];
            sexLabel.textColor = SF_COLOR(102, 102, 102);
            sexLabel.textAlignment = NSTextAlignmentRight;
            [view addSubview:sexLabel];
            view.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sexClick:)];
            [view addGestureRecognizer:tap];

            
            
        }if (i==3) {
            Btimelabel = [[UILabel alloc]initWithFrame:[UIView setRectWithX:144 andY:0 andWidth:200 andHeight:40]];
            Btimelabel.font = [UIFont systemFontOfSize:12];
            Btimelabel.textColor = SF_COLOR(102, 102, 102);
            Btimelabel.textAlignment = NSTextAlignmentRight;
            [view addSubview:Btimelabel];
            view.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeclick:)];
            [view addGestureRecognizer:tap];
            
            
        }if(i==4){
            
        }
        [self.view addSubview:view];
    }
    
}
- (void)postInfoWithIndex:(int)index {
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSString *a;
    NSString *str;
    if (index==0) {
            a = @"user_name";
        str = [NSString stringWithFormat:@"%@?ctl=user_center&act=set&v=3&%@=%@&uid=%@",urlpre,a,nametf.text,del
               .userid];

    }else if (index ==1){
            a = @"sex";
        int b ;
        if ([sexLabel.text isEqualToString:@"男"]) {
            b = 1;
        }else if([sexLabel.text isEqualToString:@"女"]){
            b = 2;
        }else if([sexLabel.text isEqualToString:@"保密"]){
            b = -1;
        }
        str = [NSString stringWithFormat:@"%@?ctl=user_center&act=set&v=3&%@=%d&uid=%@",urlpre,a,b,del.userid];

    }else if (index ==2){
            a = @"birthday";
        
        str = [NSString stringWithFormat:@"%@?ctl=user_center&act=set&v=3&%@=%@&uid=%@",urlpre,a,Btimelabel.text,del.userid];
        
    }else if (index ==3) {
            a = @"user_logo";
        NSDictionary *dic = @{@"user_logo":[self imageBase64WithDataURL:localimage]};
        [manager POST:[NSString stringWithFormat:@"%@?ctl=user_center&act=set&v=3&uid=%@",urlpre,del.userid] parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        

        
        return;
    }else if (index ==4) {
        a = @"mobile";
        str = [NSString stringWithFormat:@"%@?ctl=user_center&act=set&v=3&%@=%@&uid=%@",urlpre,a,numtf.text,del.userid];
    }
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager POST:str parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (NSString *)imageBase64WithDataURL:(UIImage *)image
{
    NSData *imageData =nil;
    NSString *mimeType =nil;
    
    //图片要压缩的比例，此处100根据需求，自行设置
    CGFloat x =100 / image.size.height;
    if (x >1)
    {
        x = 1.0;
    }
    imageData = UIImageJPEGRepresentation(image, x);
    mimeType = @"image/png";
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions:0]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 952) {
        [self postInfoWithIndex:0];
    }else {
        [self postInfoWithIndex:4];
    }
    
}
- (void)request {
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
#pragma mark------
    NSString *str = [NSString stringWithFormat:@"%@?ctl=user_center&act=get&v=3&uid=%@",urlpre,del.userid];
    [manager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *str = dic[@"status"];
        if (str.intValue==1) {
            
            nametf.text = dic[@"user_name"];
            numtf.text = dic[@"mobile"];
            
            if ([dic[@"sex"] isEqualToString:@"1"]) {
                sexLabel.text =@"男";
            }else if([dic[@"sex"] isEqualToString:@"2"]){
                sexLabel.text =@"女";
            }else {
                sexLabel.text =@"保密";
            }
            Btimelabel.text = [NSString stringWithFormat:@"%@-%@-%@",dic[@"byear"],dic[@"bmonth"],dic[@"bday"]];
            [headimage sd_setImageWithURL:[NSURL URLWithString:dic[@"user_logo"]]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [numtf resignFirstResponder];
    [nametf resignFirstResponder];
}
- (void)timeclick:(UITapGestureRecognizer *)tap {
    datePick = [[UIDatePicker alloc] init];
    
    datePick.datePickerMode = UIDatePickerModeDate;
    NSLog(@"%@", [NSLocale availableLocaleIdentifiers]);
    [datePick setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    [datePick setTimeZone:[NSTimeZone localTimeZone]];
    [datePick setDate:[NSDate date] animated:YES];
    [datePick setMaximumDate:[NSDate date]];
    [datePick setDatePickerMode:UIDatePickerModeDate];
    
    UIAlertController *alert;
    if (!alert) {
        alert = [UIAlertController alertControllerWithTitle:@"选择时间" message:@"\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            Btimelabel.text = [formatter stringFromDate:datePick.date];
            [alert dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        
        [alert.view addSubview:datePick];//将datePicker添加到UIAlertController实例中
        [alert addAction:cancel];//将确定按钮添加到UIAlertController实例中
    }
    [self presentViewController:alert animated:YES completion:^{
    }];//通过模态视图模式显示UIAlertController，相当于UIACtionSheet的show方法
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    headimage.image = newPhoto;
    localimage = newPhoto;
    [self postInfoWithIndex:3];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sexClick:(UITapGestureRecognizer *) tap{
    pickview = [[UIPickerView alloc]init];
    [pickview sizeToFit];
    pickview.dataSource = self;
    pickview.delegate = self;
    UIAlertController *alert;
    if (!alert) {
        alert = [UIAlertController alertControllerWithTitle:nil message:@"\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self postInfoWithIndex:2];
            
            [alert dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        
        [alert.view addSubview:pickview];//将datePicker添加到UIAlertController实例中
        [alert addAction:cancel];//将确定按钮添加到UIAlertController实例中
    }
    [self presentViewController:alert animated:YES completion:^{
    }];//通过模态视图模式显示UIAlertController
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    sexLabel.text = arr[row];
    [self postInfoWithIndex:1];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc]initWithFrame:[UIView setRectWithX:0 andY:0 andWidth:375 andHeight:20]];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = SF_COLOR(102, 102, 102);
    label.text = arr[row];
    return label;
}
- (void)headClick {
    /**
     *  弹出提示框
     */
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //按钮：从相册选择，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //初始化UIImagePickerController
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式1：通过相册（呈现全部相册），UIImagePickerControllerSourceTypePhotoLibrary
        //获取方式2，通过相机，UIImagePickerControllerSourceTypeCamera
        //获取方法3，通过相册（呈现全部图片），UIImagePickerControllerSourceTypeSavedPhotosAlbum
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //允许编辑，即放大裁剪
        PickerImage.allowsEditing = YES;
        //自代理
        PickerImage.delegate = self;
        //页面跳转
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：拍照，类型：UIAlertActionStyleDefault
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        /**
         其实和从相册选择一样，只是获取方式不同，前面是通过相册，而现在，我们要通过相机的方式
         */
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        //获取方式:通过相机
        PickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    //按钮：取消，类型：UIAlertActionStyleCancel
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
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
