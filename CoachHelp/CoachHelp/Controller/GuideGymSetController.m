//
//  GuideGymSetController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/11.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideGymSetController.h"

#import "GuideCourseTypeController.h"

#import "GuideAddressController.h"

#import "QCTextField.h"

#import "UpYun.h"

#import <AVFoundation/AVFoundation.h>

#import "BPush.h"

#import "LoginController.h"

#import "MOCell.h"

#import "GuideInfo.h"

#import "RootController.h"

#import "ServicesInfo.h"

@interface GuideGymSetController ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)Brand *brand;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)MOCell *addressTF;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UIButton *confirmButton;

@end

@implementation GuideGymSetController

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        self.gym = MOAppDelegate.guide.gym;
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createData];
    
    [self createUI];
    
    [self reloadData];
    
}

-(void)reloadData
{
    if (self.gym.imgUrl.absoluteString) {
        
        if ([self.gym.imgUrl.absoluteString rangeOfString:@"!"].length) {
            
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.gym.imgUrl.absoluteString]];
            
        }else{
            
            if ([self.gym.imgUrl.absoluteString rangeOfString:@"!/watermark/"].length) {
                
                [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!small/watermark/%@",[[self.gym.imgUrl.absoluteString componentsSeparatedByString:@"!/watermark/"]firstObject],[[self.gym.imgUrl.absoluteString componentsSeparatedByString:@"!/watermark/"]lastObject]]]];
                
            }else if ([self.gym.imgUrl.absoluteString rangeOfString:@"/watermark/"].length){
                
                [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.gym.imgUrl.absoluteString]];
                
            }else{
                
                [self.iconView sd_setImageWithURL:[NSURL URLWithString:[self.gym.imgUrl.absoluteString stringByAppendingString:@"!small"]]];
                
            }
            
        }
        
    }else{
        
        self.iconView.image = [UIImage imageNamed:@"gym_empty"];
        
    }
    
    self.nameTF.text = self.gym.name;
    
    self.addressTF.subtitle = self.gym.address;
    
    [self check];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.brand = MOAppDelegate.guide.brand;
    
    self.gym = MOAppDelegate.guide.gym;
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.title = @"新建健身房";
    
    UILabel *guideLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64+Height320(5), MSW, Height320(17))];
    
    guideLabel.text = @"— 设置场馆 —";
    
    guideLabel.textColor = UIColorFromRGB(0x999999);
    
    guideLabel.textAlignment = NSTextAlignmentCenter;
    
    guideLabel.font = AllFont(14);
    
    [self.view addSubview:guideLabel];
    
    UIButton *topView = [[UIButton alloc]initWithFrame:CGRectMake(0, guideLabel.bottom+Height320(12), MSW, Height320(72))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:topView];
    
    UIImageView *brandIcon = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(12), Width320(48), Height320(48))];
    
    brandIcon.layer.cornerRadius = brandIcon.width/2;
    
    brandIcon.layer.masksToBounds = YES;
    
    brandIcon.layer.borderWidth = 1;
    
    brandIcon.userInteractionEnabled = NO;
    
    brandIcon.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
    
    [topView addSubview:brandIcon];
    
    if (self.brand.imgURL.absoluteString) {
        
        if ([self.brand.imgURL.absoluteString rangeOfString:@"!"].length) {
            
            [brandIcon sd_setImageWithURL:[NSURL URLWithString:self.brand.imgURL.absoluteString]];
            
        }else{
            
            if ([self.brand.imgURL.absoluteString rangeOfString:@"/watermark/"].length) {
                
                [brandIcon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!small/watermark/%@",[[self.brand.imgURL.absoluteString componentsSeparatedByString:@"/watermark/"]firstObject],[[self.brand.imgURL.absoluteString componentsSeparatedByString:@"/watermark/"]lastObject]]]];
                
            }else{
                
                [brandIcon sd_setImageWithURL:[NSURL URLWithString:[self.brand.imgURL.absoluteString stringByAppendingString:@"!small"]]];
                
            }
            
        }
        
    }else{
        
        brandIcon.image = [UIImage imageNamed:@"gym_empty"];
        
    }
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(brandIcon.right+Width320(6), 0, MSW-brandIcon.right-Width320(30), Height320(72))];
    
    topLabel.text = MOAppDelegate.guide.brand.name;
    
    topLabel.textColor = UIColorFromRGB(0x999999);
    
    topLabel.font = AllFont(14);
    
    topLabel.userInteractionEnabled = NO;
    
    [topView addSubview:topLabel];
    
    UIButton *secView = [[UIButton alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(12), MSW, Height320(152))];
    
    secView.backgroundColor = UIColorFromRGB(0xffffff);
    
    secView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    secView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:secView];
    
    UIButton *iconButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(72))];
    
    [iconButton addTarget:self action:@selector(cameraClick) forControlEvents:UIControlEventTouchUpInside];
    
    [secView addSubview:iconButton];
    
    UILabel *secLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(80), Height320(72))];
    
    secLabel.text = @"场馆logo";
    
    secLabel.textColor = UIColorFromRGB(0x999999);
    
    secLabel.font = AllFont(14);
    
    secLabel.userInteractionEnabled = NO;
    
    [iconButton addSubview:secLabel];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(77), Height320(12), Width320(48), Height320(48))];
    
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    self.iconView.layer.borderWidth = 1;
    
    self.iconView.userInteractionEnabled = NO;
    
    self.iconView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
    
    [iconButton addSubview:self.iconView];
    
    UIImageView *secArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.4), Height320(30), Width320(7.4), Height320(12))];
    
    secArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [iconButton addSubview:secArrow];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), Height320(72)-OnePX, MSW-Width320(32), OnePX)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [iconButton addSubview:sep];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), Height320(72), MSW-Width320(32), Height320(40))];
    
    self.nameTF.placeholder = @"场馆名称（店名）";
    
    self.nameTF.mustInput = YES;
    
    self.nameTF.font = AllFont(14);
    
    self.nameTF.delegate = self;
    
    self.nameTF.textPlaceholder = @"填写场馆名称";
    
    [self.nameTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [secView addSubview:self.nameTF];
    
    self.addressTF = [[MOCell alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.addressTF.titleLabel.text = @"地址";
    
    self.addressTF.mustInput = YES;
    
    self.addressTF.placeholder = @"请填写";
    
    self.addressTF.noLine = YES;
    
    [secView addSubview:self.addressTF];
    
    [self.addressTF addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), secView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    self.confirmButton.backgroundColor = kMainColor;
    
    self.confirmButton.layer.cornerRadius = 2;
    
    [self.confirmButton setTitle:@"下一步" forState:UIControlStateNormal];
    
    [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [self.confirmButton addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.confirmButton];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)check
{
    
    self.confirmButton.alpha = self.nameTF.text.length&&self.addressTF.subtitle.length?1:0.4;
    
    self.confirmButton.userInteractionEnabled = self.nameTF.text.length&&self.addressTF.subtitle.length;
    
}

-(void)cellClick:(MOCell *)cell
{
    
    [self.view endEditing:YES];
    
    GuideAddressController *svc = [[GuideAddressController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)confirmClick
{
    
    [MOAppDelegate saveGuide];
    
    self.confirmButton.userInteractionEnabled = NO;
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"";
    
    [self.hud showAnimated:YES];
    
    [GuideInfo uploadResult:^(BOOL success,NSString *error) {
        
        if (success) {
            
            MOAppDelegate.guide = nil;
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = @"创建成功";
            
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"guide"];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[ServicesInfo shareInfo]requestSuccess:^{
                
                [self.hud hideAnimated:YES afterDelay:1.5f];
                
                AppGym = [[ServicesInfo shareInfo].services firstObject];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    MOAppDelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[RootController sharedSliderController]];
                    
                    [RootController sharedSliderController].navigationController.navigationBar.hidden = YES;
                    
                    [RootController sharedSliderController].selectIndex = 0;
                    
                    [[RootController sharedSliderController] showGuide];
                    
                    [[RootController sharedSliderController]reloadData];
                    
                });
                
            } Failure:^{
                
            }];
            
        }else
        {
            
            self.confirmButton.userInteractionEnabled = YES;
            
            [self errorWithMsg:error];
            
        }
        
    }];
    
}

-(void)errorWithMsg:(NSString *)msg
{
    
    self.hud.mode = MBProgressHUDModeText;
    
    self.hud.label.text = msg;
    
    self.hud.label.numberOfLines = 0;
    
    [self.hud showAnimated:YES];
    
    [self.hud hideAnimated:YES afterDelay:1.5f];
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    self.gym.name = textField.text;
    
    [self check];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)cameraClick
{
    
    [self.view endEditing:YES];
    
    UIActionSheet *actionSheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传品牌logo" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    }else{
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传品牌logo" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
    }
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        if(buttonIndex == 0)
        {
            
            NSString *mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                
                
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"相机访问受限，请到设置-隐私-相机中允许【健身教练助手】访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
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
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        [self performSelector:@selector(showCamera:) withObject:[NSNumber numberWithInteger:sourceType] afterDelay:1.0f];
        
    }else
    {
        
        self.imagePickerController = [[UIImagePickerController alloc] init];
        
        self.imagePickerController.delegate = self;
        
        self.imagePickerController.allowsEditing = YES;
        
        self.imagePickerController.sourceType = sourceType;
        
        [self presentViewController:self.imagePickerController animated:YES completion:^{}];
        
    }
    
}

-(void)showCamera:(NSNumber*)typeNumber
{
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    
    self.imagePickerController.delegate = self;
    
    self.imagePickerController.allowsEditing = YES;
    
    self.imagePickerController.sourceType = [typeNumber integerValue];
    
    [self presentViewController:self.imagePickerController animated:YES completion:^{}];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    self.image = [UIImage fixOrientation:[info objectForKey:UIImagePickerControllerEditedImage]];
    
    [self.iconView setImage:self.image];
    
    [self uploadImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)uploadImage
{
    
    UpYun *uy = [[UpYun alloc] init];
    
    uy.successBlocker = ^(NSURLResponse *response,id data){
        
        self.hud.label.text = @"上传成功";
        
        self.hud.mode = MBProgressHUDModeText;
        
        [self.hud showAnimated:YES];
        
        [self.hud hideAnimated:YES afterDelay:1.0f];
        
    };
    
    uy.failBlocker = ^(NSError *error){
        
        self.hud.label.text = @"上传失败";
        
        self.hud.mode = MBProgressHUDModeText;
        
        [self.hud showAnimated:YES];
        
        [self.hud hideAnimated:YES afterDelay:1.0f];
        
    };
    
    uy.progressBlocker = ^(CGFloat percent, long long requestDidSendBytes)
    {
        
        self.hud.mode = MBProgressHUDModeAnnularDeterminate;
        
        self.hud.label.text = @"";
        
        self.hud.progress = percent;
        
        [self.hud showAnimated:YES];
        
    };
    
    NSString *url = [UpYun getSaveKey];
    
    self.gym.imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
    
    [uy uploadImage:self.image savekey:url];
    
}

@end
