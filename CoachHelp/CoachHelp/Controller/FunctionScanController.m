//
//  CourseSummaryScanController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "FunctionScanController.h"

#import "FunctionInfo.h"

#import <AVFoundation/AVFoundation.h>

@interface FunctionScanController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>

{
    
    int _num;//定时器步长
    
    BOOL _upOrdown;//扫描向上或向下
    
    NSTimer * _timer;//定时器
    
}

@property(nonatomic,strong)UIImageView *scanImgView;

//扫码相关
@property (strong,nonatomic)AVCaptureDevice * device;

@property (strong,nonatomic)AVCaptureDeviceInput * input;

@property (strong,nonatomic)AVCaptureMetadataOutput * output;

@property (strong,nonatomic)AVCaptureSession * session;

@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@property (nonatomic, retain) UIImageView * line;//扫描线

@end

@implementation FunctionScanController

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
    
    self.title = @"在电脑上编辑";
    
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.55];
    
    [self setupCamera];
    
    _upOrdown = NO;
    
    _num =0;
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(MSW/2-110, 110, 220, 2)];
    
    _line.image = [UIImage imageNamed:@"scan_line"];
    
    [self.view addSubview:_line];
    
    self.scanImgView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/2-Width320(110), 64+Height320(76), Width320(220), Height320(220))];
    
    self.scanImgView.image = [UIImage imageNamed:@"scan_pick"];
    
    [self.view addSubview:self.scanImgView];
    
    UIView *topBack = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(76))];
    
    topBack.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.55];
    
    [self.view addSubview:topBack];
    
    UIView *leftBack = [[UIView alloc]initWithFrame:CGRectMake(0, topBack.bottom, self.scanImgView.left, self.scanImgView.height)];
    
    leftBack.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.55];
    
    [self.view addSubview:leftBack];
    
    UIView *rightBack = [[UIView alloc]initWithFrame:CGRectMake(self.scanImgView.right, topBack.bottom, MSW-self.scanImgView.right, self.scanImgView.height)];
    
    rightBack.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.55];
    
    [self.view addSubview:rightBack];
    
    UIView *bottomBack = [[UIView alloc]initWithFrame:CGRectMake(0, self.scanImgView.bottom, MSW, MSH-self.scanImgView.bottom)];
    
    bottomBack.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.55];
    
    [self.view addSubview:bottomBack];
    
    UILabel * labIntroudction1 = [[UILabel alloc] initWithFrame:CGRectMake(Width320(10), self.scanImgView.bottom+Height320(18), MSW-Width320(20), Height320(16))];
    
    labIntroudction1.backgroundColor = [UIColor clearColor];
    
    labIntroudction1.textColor = UIColorFromRGB(0xffffff);
    
    labIntroudction1.font = AllFont(12);
    
    labIntroudction1.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:@"在电脑上打开网址sao.qingchengfit.cn"];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x08CC00) range:NSMakeRange(8, astr.length-8)];
    
    labIntroudction1.attributedText = astr;
    
    [self.view addSubview:labIntroudction1];
    
    UILabel * labIntroudction2 = [[UILabel alloc] initWithFrame:CGRectMake(Width320(10), labIntroudction1.bottom+Height320(8), MSW-Width320(20), Height320(16))];
    
    labIntroudction2.backgroundColor = [UIColor clearColor];
    
    labIntroudction2.textColor= UIColorFromRGB(0xffffff);
    
    labIntroudction2.font = AllFont(12);
    
    labIntroudction2.textAlignment = NSTextAlignmentCenter;
    
    labIntroudction2.text=@"将二维码放于框内，即可自动扫描。";
    
    [self.view addSubview:labIntroudction2];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
}


//扫描线的方向
-(void)animation1
{
    
    if (_upOrdown == NO) {
        
        _num ++;
        
        _line.frame = CGRectMake(MSW/2-Width320(110), 64+Height320(76)+2*_num, Width320(220), 2);
        
        if (2*_num == 280) {
            
            _upOrdown = YES;
            
        }
        
    }
    
    else {
        
        _num --;
        
        _line.frame = CGRectMake(MSW/2-Width320(110), 64+Height320(76)+2*_num, Width320(220), 2);
        
        if (_num == 0) {
            
            _upOrdown = NO;
            
        }
        
    }
    
}

//设置相机
- (void)setupCamera
{
    
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    _output.rectOfInterest = CGRectMake((Height320(76)+64)/MSH,(MSW/2-Width320(110))/MSW, Height320(220)/MSH,Width320(220)/MSW);
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(0,0,MSW,MSH);
    [self.view.layer insertSublayer:self.preview atIndex:1];
    
    // Start
    [_session startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
    }
    
    [_session stopRunning];
    
    FunctionInfo *info = [[FunctionInfo alloc]init];
    
    if (self.url.length) {
        
        [info scanWithString:stringValue andURL:self.url result:^(BOOL success, NSString *error) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
            if (success) {
                
                if (self.scanSuccess) {
                    
                    self.scanSuccess();
                    
                }
                
            }else{
                
                [[[UIAlertView alloc]initWithTitle:@"无法识别该二维码，请确认后再进行扫描。" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
            }
            
        }];
        
    }else{
        
        [info scanWithString:stringValue andModule:self.module result:^(BOOL success, NSString *error) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
            if (success) {
                
                if (self.scanSuccess) {
                    
                    self.scanSuccess();
                    
                }
                
            }else{
                
                [[[UIAlertView alloc]initWithTitle:@"无法识别该二维码，请确认后再进行扫描。" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
            }
            
        }];
        
    }
    
}


@end
