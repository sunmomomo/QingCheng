
//
//  QualityTrainEditController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/25.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "QualityTrainEditController.h"

#import "UpYun.h"

#import "QCTextField.h"

#import "QCKeyboardView.h"

#import "ChooseOgnController.h"

#import <AVFoundation/AVFoundation.h>

#define API @"/api/certificates/"

@interface QualityTrainEditController ()<UITextFieldDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,QCKeyboardViewDelegate>

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *subtitleLabel;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *issueTF;

@property(nonatomic,strong)QCTextField *startTF;

@property(nonatomic,strong)QCTextField *endTF;

@property(nonatomic,strong)QCTextField *photoSTF;

@property(nonatomic,strong)QCTextField *qualityNameTF;

@property(nonatomic,strong)UISwitch *gradeSwitch;

@property(nonatomic,strong)UISwitch *photoSwitch;

@property(nonatomic,strong)UIButton *uploadBtn;

@property(nonatomic,strong)UIImageView *photo;

@property(nonatomic,strong)UIView *photoView;

@property(nonatomic,strong)UIButton *confirmBtn;

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UIDatePicker *issueDP;

@property(nonatomic,strong)UIDatePicker *startDP;

@property(nonatomic,strong)UIDatePicker *endDP;

@property(nonatomic,strong)NSDate *startDate;

@property(nonatomic,strong)NSDate *endDate;

@property(nonatomic,assign)BOOL endDPCanShow;

@property(nonatomic,strong)UIView *touchView;

@property(nonatomic,strong)UIView *fstView;

@property(nonatomic,strong)UIView *thirdView;

@end

@implementation QualityTrainEditController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.quality = [[Quality alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_isAdd) {
        
        self.title = @"编辑培训认证";
        
    }else
    {
        
        self.title = @"添加培训认证";
        
    }
    
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self createData];
    
    [self createUI];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    if (!self.quality) {
        self.quality = [[Quality alloc]init];
    }
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    if (self.quality.issueTime) {
        
        self.startDate = [df dateFromString:self.quality.issueTime];
        
    }
    if (self.quality.endTime) {
        
        self.endDate = [df dateFromString:self.quality.endTime];
        
    }
    
    
}

-(void)createUI
{
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.mainView];
    
    UIButton *topView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(66))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.mainView addSubview:topView];
    
    [topView addTarget:self action:@selector(topClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(13), Width320(40), Height320(40))];
    
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    [self.iconView sd_setImageWithURL:self.quality.organization.imgUrl];
    
    [topView addSubview:self.iconView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconView.right+Width320(8), Height320(16), Width320(240), Height320(18))];
    
    self.titleLabel.textColor = UIColorFromRGB(0x222222);
    
    self.titleLabel.font = STFont(16);
    
    self.titleLabel.text = self.quality.organization.name;
    
    [topView addSubview:self.titleLabel];
    
    self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+Height320(3), self.titleLabel.width, Height320(18))];
    
    self.subtitleLabel.textColor = UIColorFromRGB(0x999999);
    
    self.subtitleLabel.font = STFont(14);
    
    self.subtitleLabel.text = self.quality.organization.contact;
    
    [topView addSubview:self.subtitleLabel];
    
    UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(25), Height320(19.5), Width320(6.7), Height320(10.7))];
    
    arrowImg.image = [UIImage imageNamed:@"cellarrow"];
    
    arrowImg.center = CGPointMake(arrowImg.center.x, Height320(33));
    
    [topView addSubview:arrowImg];
    
    self.fstView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(12), MSW, Height320(88))];
    
    self.fstView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.mainView addSubview:self.fstView];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(44))];
    
    self.nameTF.placeholder = @"培训名称";
    
    self.nameTF.text = self.quality.title;
    
    self.nameTF.delegate = self;
    
    self.nameTF.mustInput = YES;
    
    [self.fstView addSubview:self.nameTF];
    
    self.issueTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.issueTF.placeholder = @"培训日期";
    
    self.issueTF.text = self.quality.issueTime;
    
    self.issueTF.mustInput = YES;
    
    [self.fstView addSubview:self.issueTF];
    
    QCKeyboardView *issueKV = [[QCKeyboardView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(216))];
    
    issueKV.delegate = self;
    
    self.issueDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, Height320(39), MSW, Height320(177))];
    
    self.issueDP.datePickerMode = UIDatePickerModeDate;
    
    [issueKV addSubview:self.issueDP];
    
    issueKV.tag = 102;
    
    self.issueTF.inputView = issueKV;
    
    self.thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, self.fstView.bottom+Height320(12), MSW, Height320(44))];
    
    self.thirdView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.mainView addSubview:self.thirdView];
    
    self.photoSTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, 0, self.nameTF.width, self.nameTF.height)];
    
    self.photoSTF.placeholder = @"有无证书";
    
    self.photoSTF.userInteractionEnabled = NO;
    
    [self.thirdView addSubview:self.photoSTF];
    
    self.photoSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(self.photoSTF.right-51, self.photoSTF.height/2-15.5, 51, 31)];
    
    self.photoSwitch.on = self.quality.title.length;
    
    self.photoSwitch.tag = 102;
    
    [self.photoSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.thirdView addSubview:self.photoSwitch];
    
    self.qualityNameTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.photoSTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.qualityNameTF.placeholder = @"证书名称";
    
    self.qualityNameTF.delegate = self;
    
    self.qualityNameTF.text = self.quality.certificateName;
    
    [self.thirdView addSubview:self.qualityNameTF];
    
    self.startTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.qualityNameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.startTF.placeholder = @"证书生效日期";
    
    self.startTF.delegate = self;
    
    self.startTF.text = self.quality.startTime;
    
    [self.thirdView addSubview:self.startTF];
    
    QCKeyboardView *startKV = [[QCKeyboardView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(216))];
    
    startKV.delegate = self;
    
    self.startDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, Height320(39), MSW, Height320(177))];
    
    self.startDP.datePickerMode = UIDatePickerModeDate;
    
    [startKV addSubview:self.startDP];
    
    startKV.tag = 103;
    
    self.startTF.inputView = startKV;
    
    self.endTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.startTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.endTF.placeholder = @"证书失效日期";
    
    self.endTF.delegate = self;
    
    self.endTF.text = [self.quality.endTime isEqualToString:@"3000-01-01"]?@"长期有效":self.quality.endTime;
    
    [self.thirdView addSubview:self.endTF];
    
    QCKeyboardView *endKV = [[QCKeyboardView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(216))];
    
    endKV.delegate = self;
    
    self.endDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, Height320(39), MSW, Height320(177))];
    
    self.endDP.datePickerMode = UIDatePickerModeDate;
    
    [endKV addSubview:self.endDP];
    
    endKV.tag = 104;
    
    self.endTF.inputView = endKV;
    
    self.uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.uploadBtn.frame = CGRectMake(0, self.endTF.bottom, MSW, Height320(44));
    
    self.uploadBtn.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.thirdView addSubview:self.uploadBtn];
    
    UILabel *uploadLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(200), self.uploadBtn.height)];
    
    uploadLabel.text = @"上传证书/图片";
    
    uploadLabel.textColor = UIColorFromRGB(0x999999);
    
    uploadLabel.font = STFont(14);
    
    [self.uploadBtn addSubview:uploadLabel];
    
    UIImageView *uploadArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), self.uploadBtn.height/2-Height320(6), Width320(7), Height320(12))];
    
    uploadArrow.image = [UIImage imageNamed:@"cellarrow"];
    
    [self.uploadBtn addSubview:uploadArrow];
    
    [self.uploadBtn addTarget:self action:@selector(uploadImage) forControlEvents:UIControlEventTouchUpInside];
    
    self.photoView = [[UIView alloc]initWithFrame:CGRectMake(0, self.uploadBtn.top, MSW, Height320(244))];
    
    self.photoView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.photoView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadImage)]];
    
    [self.thirdView addSubview:self.photoView];
    
    self.photo = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(14.2), Height320(14.2), MSW-Width320(28.4), self.photoView.height-Height320(28.4))];
    
    [self.photo sd_setImageWithURL:self.quality.photo];
    
    self.photo.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.photoView addSubview:self.photo];
    
    [self.uploadBtn addTarget:self action:@selector(uploadImage) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.confirmBtn.frame = CGRectMake(Width320(21.3), 0, MSW-Width320(42.6), Height320(42.6));
    
    self.confirmBtn.backgroundColor = kMainColor;
    
    [self.confirmBtn setTitle:@"确  定" forState:UIControlStateNormal];
    
    [self.confirmBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    self.confirmBtn.layer.cornerRadius = 2;
    
    self.confirmBtn.layer.masksToBounds = YES;
    
    [self.confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainView addSubview:self.confirmBtn];
    
    [self check];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    self.hud.mode = MBProgressHUDModeText;
    
    [self.view addSubview:self.hud];
    
    self.touchView = [[UIView alloc]initWithFrame:self.view.frame];
    
    [self.view addSubview:self.touchView];
    
    [self.touchView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchTap:)]];
    
    self.touchView.hidden = YES;
    
}

-(void)switchChanged:(UISwitch*)aSwitch
{
    
    [self check];
    
}

-(void)touchTap:(UITapGestureRecognizer*)tap
{
    
    [self.view endEditing:YES];
    
    self.endDPCanShow = NO;
    
    self.touchView.hidden = YES;
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField == self.endTF){
        
        self.touchView.hidden = NO;
        
        if (self.endDPCanShow) {
            
            self.endDPCanShow = NO;
            
            return YES;
            
        }
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"长期有效",@"选择日期", nil];
        
        [actionSheet showInView:self.view];
        
        actionSheet.tag = 102;
        
        return NO;
        
    }
    else
    {
        
        self.touchView.hidden = NO;
        
        [self.view bringSubviewToFront:self.touchView];
        
        return YES;
        
    }
    
}

-(void)keyboardConfirm:(QCKeyboardView*)keyboadeView
{
    
    self.touchView.hidden = YES;
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    if (keyboadeView.tag == 102)
    {
        
        self.issueTF.text = [df stringFromDate:self.issueDP.date];
        self.quality.issueTime = [df stringFromDate:self.issueDP.date];
        
        [self.issueTF resignFirstResponder];
        
    }else if (keyboadeView.tag == 103) {
        
        NSDate *date = [df dateFromString:[df stringFromDate:self.startDP.date]];
        
        if (self.endDate) {
            
            NSTimeInterval timeInterval = [date timeIntervalSinceDate:self.endDate];
            
            if (timeInterval>=0&&self.endDate) {
                
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"生效日期必须早于失效日期" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil]show];
                
                return;
                
            }
            
        }
        
        self.startDate = date;
        
        self.startTF.text = [df stringFromDate:date];
        
        self.quality.startTime = [df stringFromDate:date];
        
        [self.startTF resignFirstResponder];
        
    }else if(keyboadeView.tag == 104)
    {
        
        NSDate *date = [df dateFromString:[df stringFromDate:self.endDP.date]];
        
        if (self.startDate) {
            
            NSTimeInterval timeInterval = [self.startDate timeIntervalSinceDate:date];
            
            if (timeInterval>=0&&self.endDate) {
                
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"失效日期必须晚于生效日期" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil]show];
                
                return;
                
            }
            
        }
        
        self.endDate = date;
        
        self.quality.endTime = [df stringFromDate:date];
        
        self.endTF.text = [df stringFromDate:date];
        
        [self.endTF resignFirstResponder];
        
    }
    
}

-(void)confirm:(UIButton*)btn
{
    
    if (self.photoSwitch.isOn) {
        
        if (!self.qualityNameTF.text.length) {
            
            [self errorWithInfo:@"请填写证书名称"];
            
            return;
            
        }
        
    }
    
    if (self.nameTF.text.length&&self.quality.organization.ognId && self.quality.issueTime.length) {
        
        if (self.photoSwitch.isOn) {
            
            if (!self.quality.endTime.length|| !self.quality.startTime.length) {
                
                [[[UIAlertView alloc]initWithTitle:@"信息填写不完全" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil]show];
                
                return;
                
            }
            
        }
        
        btn.userInteractionEnabled = NO;
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"";
        
        [self.hud showAnimated:YES];
        
        Parameters *para = [[Parameters alloc]init];
        
        [para setParameter:[NSNumber numberWithInteger:CoachId] forKey:@"coach_id"];
        
        [para setParameter:@"2" forKey:@"type"];
        
        [para setParameter:self.nameTF.text forKey:@"name"];
        
        [para setParameter:[NSNumber numberWithInteger:self.quality.organization.ognId] forKey:@"organization_id"];
        
        [para setParameter:self.quality.issueTime forKey:@"date_of_issue"];
        
        if (self.photoSwitch.isOn) {
            
            [para setParameter:self.quality.startTime forKey:@"start"];
            
            [para setParameter:self.quality.endTime forKey:@"end"];
            
            if ([self.endTF.text isEqualToString:@"长期有效"]) {
                
                [para setParameter:@"0" forKey:@"will_expired"];
                
            }else
            {
                
                [para setParameter:@"1" forKey:@"will_expired"];
                
            }
            
            [para setParameter:self.qualityNameTF.text forKey:@"certificate_name"];
            
            [para setParameter:[self.quality.photo absoluteString] forKey:@"photo"];
            
        }else
        {
            
            [para removeParameterWithKey:@"start"];
            
            [para removeParameterWithKey:@"end"];
            
            [para removeParameterWithKey:@"certificate_name"];
            
            [para setParameter:@"" forKey:@"photo"];
            
        }
        
        if (_isAdd) {
            
            [MOAFHelp AFPostHost:ROOT bindPath:API postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
                
                btn.userInteractionEnabled = YES;
                
                if ([responseDic[@"status"]integerValue] == 200) {
                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    self.hud.label.text = @"添加成功";
                    
                    [self.hud showAnimated:YES];
                    
                    [self.hud hideAnimated:YES afterDelay:1.0f];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        if (self.editFinish) {
                            self.editFinish(self.quality);
                        }
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    });
                    
                }else
                {
                    
                    [self errorWithInfo:responseDic[@"msg"]];
                    
                }
                
            } failure:^(AFHTTPSessionManager *operation, NSString *error) {
                
                btn.userInteractionEnabled = YES;
                
                [self errorWithInfo:error];
                
            }];
            
            
        }else
        {
            
            NSString *api = [NSString stringWithFormat:@"%@%ld/",API,(long)self.quality.qualityId];
            
            [MOAFHelp AFPutHost:ROOT bindPath:api putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
                
                btn.userInteractionEnabled = YES;
                
                if ([responseDic[@"status"]integerValue]==200) {
                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    self.hud.label.text = @"修改成功";
                    
                    [self.hud showAnimated:YES];
                    
                    [self.hud hideAnimated:YES afterDelay:1.0f];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        self.quality.title = self.nameTF.text;
                        
                        self.quality.certificateName = self.qualityNameTF.text;
                        
                        if (!self.photoSwitch.isOn) {
                            
                            self.quality.startTime = @"";
                            
                            self.quality.endTime = @"";
                            
                            self.quality.certificateName = @"";
                            
                            self.quality.photo = nil;
                            
                        }
                        
                        if (self.editFinish) {
                            self.editFinish(self.quality);
                        }
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    });
                    
                }else
                {
                    
                    [self errorWithInfo:responseDic[@"msg"]];
                    
                }
                
            } failure:^(AFHTTPSessionManager *operation, NSString *error) {
                
                btn.userInteractionEnabled = YES;
                
                [self errorWithInfo:error];
                
            }];
            
        }
        
        
    }else
    {
        
        [[[UIAlertView alloc]initWithTitle:@"信息填写不完全" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil]show];
        
    }
    
}

-(void)errorWithInfo:(NSString *)info
{
    
    self.hud.mode = MBProgressHUDModeText;
    
    self.hud.label.text = info;
    
    [self.hud showAnimated:YES];
    
    [self.hud hideAnimated:YES afterDelay:1.0f];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    self.touchView.hidden = YES;
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)uploadImage
{
    
    UIActionSheet *actionSheet;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
        
    }else{
        
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
        
    }
    
    actionSheet.delegate = self;
    
    actionSheet.tag = 101;
    
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag == 101) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            if(buttonIndex == 0)
            {
                
                NSString *mediaType = AVMediaTypeVideo;
                AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
                if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                    
                    
                    [[[UIAlertView alloc]initWithTitle:@"提示" message:@"摄像头访问受限，请到设置-隐私-相机中允许健身教练助手访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                    
                    return;
                }
                //拍照
                sourceType = UIImagePickerControllerSourceTypeCamera;
            }else if(buttonIndex == 1)
            {
                //从相册选择
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }else
            {
                return;
            }
        }else{
            if (buttonIndex == 0) {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }else
            {
                return;
            }
        }
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }else
    {
        
        self.touchView.hidden = YES;
        
        if (buttonIndex == 0) {
            
            self.quality.endTime = @"3000-01-01";
            
            self.endTF.text = @"长期有效";
            
            NSDateFormatter *df = [[NSDateFormatter alloc]init];
            
            df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
            
            [df setDateFormat:@"yyyy-MM-dd"];
            
            self.endDate = [df dateFromString:self.quality.endTime];
            
        }else if(buttonIndex == 1)
        {
            
            self.endDPCanShow = YES;
            
            [self.endTF becomeFirstResponder];
            
        }
        
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [[UIImage imageWithData:UIImageJPEGRepresentation([UIImage fixOrientation:[info objectForKey:UIImagePickerControllerOriginalImage]], 0.5)]fixOrientation];
    
    UpYun *uy = [[UpYun alloc] init];
    
    NSString *url = [UpYun getSaveKey];
    
    uy.successBlocker = ^(NSURLResponse *response,id data){
        
        self.hud.label.text = @"上传成功";
        
        self.hud.mode = MBProgressHUDModeText;
        
        [self.hud showAnimated:YES];
        
        self.quality.photo = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
        
        [self check];
        
    };
    
    uy.failBlocker = ^(NSError *error){
        
        self.hud.label.text = @"上传失败";
        
        self.hud.mode = MBProgressHUDModeText;
        
        [self.hud showAnimated:YES];
        
        [self.hud hideAnimated:YES afterDelay:1.0];
        
    };
    
    uy.progressBlocker = ^(CGFloat percent, long long requestDidSendBytes)
    {
        
        self.hud.mode = MBProgressHUDModeAnnularDeterminate;
        
        self.hud.label.text = @"";
        
        self.hud.progress = percent;
        
        [self.hud showAnimated:YES];
        
    };
    
    [uy uploadImage:image savekey:url];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)check
{
    
    if (!self.photoSwitch.isOn) {
        
        [self.thirdView changeHeight:Height320(44)];
        
        self.photoSTF.noLine = YES;
        
        self.qualityNameTF.hidden = YES;
        
        self.startTF.hidden = YES;
        
        self.endTF.hidden = YES;
        
        self.uploadBtn.hidden = YES;
        
        self.photoView.hidden = YES;
        
        [self.confirmBtn changeTop:self.thirdView.bottom+Height320(12)];
        
        self.mainView.contentSize = CGSizeMake(0, self.confirmBtn.bottom+Height320(19));
        
    }else
    {
        
        self.photoSTF.noLine = NO;
        
        self.qualityNameTF.hidden = !self.photoSwitch.isOn;
        
        self.startTF.hidden = !self.photoSwitch.isOn;
        
        self.endTF.hidden = !self.photoSwitch.isOn;
        
        if (self.quality.photo&&[self.quality.photo absoluteString].length) {
            
            self.uploadBtn.hidden = YES;
            
            self.photoView.hidden = NO;
            
            [self.thirdView changeHeight:self.photoSwitch.isOn?self.photoView.bottom:Height320(44)];
            
            [self.confirmBtn changeTop:self.thirdView.bottom+Height320(12)];
            
            self.mainView.contentSize = CGSizeMake(0, self.confirmBtn.bottom+Height320(19));
            
            if (self.quality.photo.absoluteString) {
                
                if ([self.quality.photo.absoluteString rangeOfString:@"!"].length) {
                    
                    [self.photo sd_setImageWithURL:[NSURL URLWithString:self.quality.photo.absoluteString]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                        [self.hud hideAnimated:YES];
                        
                    }];
                    
                }else{
                    
                    if ([self.quality.photo.absoluteString rangeOfString:@"!/watermark/"].length) {
                        
                        [self.photo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!small/watermark/%@",[[self.quality.photo.absoluteString componentsSeparatedByString:@"!/watermark/"]firstObject],[[self.quality.photo.absoluteString componentsSeparatedByString:@"!/watermark/"]lastObject]]]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            
                            [self.hud hideAnimated:YES];
                            
                        }];
                        
                    }else if ([self.quality.photo.absoluteString rangeOfString:@"/watermark/"].length){
                        
                        [self.photo sd_setImageWithURL:[NSURL URLWithString:self.quality.photo.absoluteString]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            
                            [self.hud hideAnimated:YES];
                            
                        }];
                        
                    }else{
                        
                        [self.photo sd_setImageWithURL:[NSURL URLWithString:[self.quality.photo.absoluteString stringByAppendingString:@"!small"]]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            
                            [self.hud hideAnimated:YES];
                            
                        }];
                        
                    }
                    
                }
                
            }
            
        }else
        {
            
            self.uploadBtn.hidden = NO;
            
            self.photoView.hidden = YES;
            
            [self.thirdView changeHeight:self.photoSwitch.isOn?self.uploadBtn.bottom:Height320(44)];
            
            [self.confirmBtn changeTop:self.thirdView.bottom+Height320(12)];
            
            self.mainView.contentSize = CGSizeMake(0, self.confirmBtn.bottom+Height320(19));
            
        }
        
    }
    
}

-(void)topClick{
    
    ChooseOgnController *svc = [[ChooseOgnController alloc]init];
    
    svc.title = @"修改主办机构";
    
    __weak typeof(self)weakS = self;
    
    svc.addSuccess = ^(Quality *quality){
        
        weakS.quality.organization = quality.organization;
        
        [weakS.iconView sd_setImageWithURL:quality.organization.imgUrl];
        
        weakS.titleLabel.text = quality.organization.name;
        
        weakS.subtitleLabel.text = quality.organization.contact;
        
        [weakS dismissViewControllerAnimated:YES completion:nil];
        
    };
    
    [self presentViewController:svc animated:YES completion:nil];
    
}


@end
