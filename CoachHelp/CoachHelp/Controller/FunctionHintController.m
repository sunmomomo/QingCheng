//
//  FunctionHintController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "FunctionHintController.h"

#import "FunctionScanController.h"

#import <AVFoundation/AVFoundation.h>

@interface FunctionHintController ()

@property(nonatomic,strong)UIView *hintView;

@property(nonatomic,strong)UIView *successView;

@end

@implementation FunctionHintController

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
    
    self.title = @"在电脑中使用功能";
    
    self.hintView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.hintView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:self.hintView];
    
    UIImageView *hintImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(64), Height320(72), Width320(185), Height320(143))];
    
    hintImg.image = [UIImage imageNamed:@"scan_hint"];
    
    [self.hintView addSubview:hintImg];
    
    UILabel *hintFstLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, hintImg.bottom+Height320(18), MSW, Height320(17))];
    
    hintFstLabel.text = @"请在电脑浏览器中打开以下链接";
    
    hintFstLabel.textColor = UIColorFromRGB(0x333333);
    
    hintFstLabel.textAlignment = NSTextAlignmentCenter;
    
    hintFstLabel.font = AllFont(13);
    
    [self.hintView addSubview:hintFstLabel];
    
    UILabel *hintSecLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, hintFstLabel.bottom+Height320(5), MSW, Height320(18))];
    
    hintSecLabel.text = @"sao.qingchengfit.cn";
    
    hintSecLabel.textColor = UIColorFromRGB(0x0DB14B);
    
    hintSecLabel.textAlignment = NSTextAlignmentCenter;
    
    hintSecLabel.font = AllFont(16);
    
    [self.hintView addSubview:hintSecLabel];
    
    UIButton *scanButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(90), hintSecLabel.bottom+Height320(40), Width320(180), Height320(40))];
    
    scanButton.backgroundColor = UIColorFromRGB(0x0DB14B);
    
    scanButton.layer.cornerRadius = 2;
    
    [scanButton setTitle:@"我已经打开，下一步" forState:UIControlStateNormal];
    
    [scanButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    scanButton.titleLabel.font = AllFont(14);
    
    [self.hintView addSubview:scanButton];
    
    [scanButton addTarget:self action:@selector(scan:) forControlEvents:UIControlEventTouchUpInside];
    
    self.successView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.successView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.successView.hidden = YES;
    
    [self.view addSubview:self.successView];
    
    UIImageView *successImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(64), Height320(96), Width320(185), Height320(131))];
    
    successImg.image = [UIImage imageNamed:@"scan_success"];
    
    [self.successView addSubview:successImg];
    
    UILabel *successFstLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, successImg.bottom+Height320(18), MSW, Height320(18))];
    
    successFstLabel.text = @"已成功打开网页编辑器";
    
    successFstLabel.textColor = UIColorFromRGB(0x333333);
    
    successFstLabel.textAlignment = NSTextAlignmentCenter;
    
    successFstLabel.font = AllFont(14);
    
    [self.successView addSubview:successFstLabel];
    
    UILabel *successSecLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, successFstLabel.bottom+Height320(12), MSW, Height320(16))];
    
    successSecLabel.text = @"请在电脑上完成编辑并保存";
    
    successSecLabel.textColor = UIColorFromRGB(0x999999);
    
    successSecLabel.textAlignment = NSTextAlignmentCenter;
    
    successSecLabel.font = AllFont(12);
    
    [self.successView addSubview:successSecLabel];
    
    UILabel *successTrdLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, successSecLabel.bottom+Height320(2), MSW, Height320(16))];
    
    successTrdLabel.text = @"手机上会自动更新信息";
    
    successTrdLabel.textColor = UIColorFromRGB(0x999999);
    
    successTrdLabel.textAlignment = NSTextAlignmentCenter;
    
    successTrdLabel.font = AllFont(12);
    
    [self.successView addSubview:successTrdLabel];
    
}

-(void)scan:(UIButton*)button
{
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"相机访问受限，请到设置-隐私-相机中允许【健身教练助手】访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (self.url.length || self.module.length) {
        
        FunctionScanController *svc = [[FunctionScanController alloc]init];
        
        if (self.url.length) {
            
            svc.url = self.url;
            
        }else{
            
            svc.module = self.module;
            
        }
        
        __weak typeof(self)weakS = self;
        
        svc.scanSuccess = ^{
            
            weakS.hintView.hidden = YES;
            
            weakS.successView.hidden = NO;
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}


@end
