//
//  CheckinQRCodeController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinQRCodeController.h"

#import "GradientView.h"

#import "UIImage+Category.h"

@interface CheckinQRCodeController ()

@end

@implementation CheckinQRCodeController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    
    self.title = self.checkType == CheckTypeCheckin?@"签到二维码":@"签出二维码";
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.leftType = MONaviLeftTypeClose;
    
    UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    UIColor *topColor = self.checkType == CheckTypeCheckin?UIColorFromRGB(0x8CB5BA):UIColorFromRGB(0x8CA3BA);
    
    UIColor *bottomColor = self.checkType == CheckTypeCheckin?UIColorFromRGB(0xBDE4E9):UIColorFromRGB(0xBED7EF);
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
    gradientLayer.bounds = mainView.bounds;
    gradientLayer.borderWidth = 0;
    
    gradientLayer.frame = mainView.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[[topColor colorWithAlphaComponent:0.86] CGColor],
                            (id)[[bottomColor colorWithAlphaComponent:0.86] CGColor], nil];
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(0.0, 1.0);
    
    [mainView.layer insertSublayer:gradientLayer atIndex:0];
    
    [self.view addSubview:mainView];
    
    UIView *codeBackView = [[UIView alloc]initWithFrame:CGRectMake(Width320(20), Height320(80)+64, MSW-Width320(40), Height320(332))];
    
    codeBackView.backgroundColor = UIColorFromRGB(0xffffff);
    
    codeBackView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
    
    codeBackView.layer.shadowOpacity = 0.2;
    
    codeBackView.layer.shadowOffset = CGSizeMake(0, 2);
    
    [self.view addSubview:codeBackView];
    
    UIView *codeView = [[UIView alloc]initWithFrame:codeBackView.frame];
    
    codeView.backgroundColor = UIColorFromRGB(0xffffff);
    
    codeView.layer.cornerRadius = Width320(2);
    
    codeView.layer.masksToBounds = YES;
    
    [self.view addSubview:codeView];
    
    UILabel *codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, codeView.width, Height320(44))];
    
    codeLabel.backgroundColor = UIColorFromRGB(0xf6f6f6);
    
    codeLabel.text = self.checkType == CheckTypeCheckin?@"签到二维码":@"签出二维码";
    
    codeLabel.textColor = UIColorFromRGB(0x333333);
    
    codeLabel.textAlignment = NSTextAlignmentCenter;
    
    codeLabel.font = AllFont(14);
    
    [codeView addSubview:codeLabel];
    
    UIImageView *codeImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(50), codeLabel.bottom+Height320(28), codeView.width-Width320(100), codeView.width-Width320(100))];
   
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    
    [filter setDefaults];
    
    //将字符串转换成NSData
    
    NSData *data=[self.qrcode dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    
    CIImage *outputImage=[filter outputImage];
    
    codeImg.image = [UIImage createNonInterpolatedUIImageFormCIImage:outputImage withSize:codeImg.frame.size.width];
    
    [codeView addSubview:codeImg];
    
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, codeImg.bottom+Height320(12), codeView.width, Height320(40))];
    
    hintLabel.text = [@"出示此二维码，让会员通过微信扫一扫\n等工具扫码" stringByAppendingString:self.checkType == CheckTypeCheckin?@"签到":@"签出"];
    
    hintLabel.textColor = UIColorFromRGB(0x999999);
    
    hintLabel.textAlignment = NSTextAlignmentCenter;
    
    hintLabel.numberOfLines = 0;
    
    hintLabel.font = AllFont(13);
    
    [codeView addSubview:hintLabel];
    
}

-(void)naviLeftClick
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


@end
