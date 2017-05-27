
//
//  QualityMeetingEditController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/25.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "QualityMeetingEditController.h"

#import "UpYun.h"

#import "QCTextField.h"

#import "QCKeyboardView.h"

#import "ChooseOgnController.h"

#import <AVFoundation/AVFoundation.h>

#define API @"/api/certificates/"

@interface QualityMeetingEditController ()<UITextFieldDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,QCKeyboardViewDelegate>

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *subtitleLabel;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *issueTF;

@property(nonatomic,strong)UIButton *uploadBtn;

@property(nonatomic,strong)UIImageView *photo;

@property(nonatomic,strong)UIView *photoView;

@property(nonatomic,strong)UIButton *confirmBtn;

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UIDatePicker *issueDP;

@property(nonatomic,strong)UIView *touchView;

@property(nonatomic,strong)UIView *fstView;

@end

@implementation QualityMeetingEditController

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
        
        self.title = @"编辑大会认证";
        
    }else
    {
        
        self.title = @"添加大会认证";
        
    }
    
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
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
    
    self.nameTF.placeholder = @"大会名称";
    
    self.nameTF.text = self.quality.title;
    
    self.nameTF.delegate = self;
    
    self.nameTF.mustInput = YES;
    
    [self.fstView addSubview:self.nameTF];
    
    self.issueTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.issueTF.placeholder = @"大会日期";
    
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
    
    self.uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.uploadBtn.frame = CGRectMake(0, self.fstView.bottom+Height320(13.3), MSW, Height320(39));
    
    self.uploadBtn.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.mainView addSubview:self.uploadBtn];
    
    UILabel *uploadLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(200), self.uploadBtn.height)];
    
    uploadLabel.text = @"上传参会凭证";
    
    uploadLabel.textColor = UIColorFromRGB(0x999999);
    
    uploadLabel.font = STFont(16);
    
    [self.uploadBtn addSubview:uploadLabel];
    
    UIImageView *uploadArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), self.uploadBtn.height/2-Height320(6), Width320(7), Height320(12))];
    
    uploadArrow.image = [UIImage imageNamed:@"cellarrow"];
    
    [self.uploadBtn addSubview:uploadArrow];
    
    [self.uploadBtn addTarget:self action:@selector(uploadImage) forControlEvents:UIControlEventTouchUpInside];
    
    self.photoView = [[UIView alloc]initWithFrame:CGRectMake(0, self.uploadBtn.top, MSW, Height320(244))];
    
    self.photoView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.photoView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(uploadImage)]];
    
    [self.mainView addSubview:self.photoView];
    
    self.photo = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(14.2), Height320(14.2), MSW-Width320(28.4), self.photoView.height-Height320(28.4))];
    
    [self.photo sd_setImageWithURL:self.quality.photo];
    
    self.photo.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.photoView addSubview:self.photo];
    
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

-(void)touchTap:(UITapGestureRecognizer*)tap
{
    
    [self.view endEditing:YES];
    
    self.touchView.hidden = YES;
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    self.touchView.hidden = NO;
    
    [self.view bringSubviewToFront:self.touchView];
    
    return YES;
    
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
        
    }
    
}

-(void)confirm:(UIButton*)btn
{
    
    if (self.nameTF.text.length&&self.quality.organization.ognId&&self.quality.issueTime.length) {
        
        btn.userInteractionEnabled = NO;
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"";
        
        [self.hud showAnimated:YES];
        
        Parameters *para = [[Parameters alloc]init];
        
        [para setParameter:[NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults]integerForKey:@"coachId"]] forKey:@"coach_id"];
        
        [para setParameter:@"1" forKey:@"type"];
        
        [para setParameter:self.nameTF.text forKey:@"name"];
        
        [para setParameter:[NSNumber numberWithInteger:self.quality.organization.ognId] forKey:@"organization_id"];
        
        if (self.quality.issueTime) {
            
            [para setParameter:self.quality.issueTime forKey:@"date_of_issue"];
            
        }
        
        [para setParameter:[self.quality.photo absoluteString] forKey:@"photo"];
        
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
        
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [[UIImage imageWithData:UIImageJPEGRepresentation([UIImage fixOrientation:[info objectForKey:UIImagePickerControllerOriginalImage]], 0.5)] fixOrientation];
    
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
    
    if (self.quality.photo&&[self.quality.photo absoluteString].length) {
        
        self.uploadBtn.hidden = YES;
        
        self.photoView.hidden = NO;
        
        [self.confirmBtn changeTop:self.photoView.bottom+Height320(13.3)];
        
        self.mainView.contentSize = CGSizeMake(0, self.confirmBtn.bottom+Height320(20.8));
        
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
        
        [self.confirmBtn changeTop:self.uploadBtn.bottom+Height320(13.3)];
        
        self.mainView.contentSize = CGSizeMake(0, self.confirmBtn.bottom+Height320(20.8));
        
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
