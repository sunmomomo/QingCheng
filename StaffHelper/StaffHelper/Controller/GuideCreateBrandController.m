//
//  GuideCreateBrandController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideCreateBrandController.h"

#import "GuideSetGymController.h"

#import "QCTextField.h"

#import "UpYun.h"

#import <AVFoundation/AVFoundation.h>

#import "NewGymInfo.h"

#import "ServicesInfo.h"

#import "LoginController.h"

#import "BPush.h"

@interface GuideCreateBrandController ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)Brand *brand;

@end

@implementation GuideCreateBrandController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createData];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)createData
{
    
    self.brand = ((AppDelegate*)[UIApplication sharedApplication].delegate).course.gym.brand;
    
}

-(void)createUI
{
    
    self.title = @"添加健身房品牌";
    
    self.leftType = MONaviLeftTypeBack;
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIImageView *guideImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(16)+64, MSW-Width320(42), Height320(42))];
    
    guideImg.image = [UIImage imageNamed:@"guide_step_1"];
    
    guideImg.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:guideImg];
    
    UILabel *guideLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, guideImg.bottom+Height320(20), MSW, Height320(17))];
    
    guideLabel.text = @"— 新建健身房品牌 —";
    
    guideLabel.textColor = UIColorFromRGB(0x999999);
    
    guideLabel.textAlignment = NSTextAlignmentCenter;
    
    guideLabel.font = AllFont(14);
    
    [self.view addSubview:guideLabel];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64+Height320(110), MSW, Height320(112))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:topView];
    
    UIButton *iconButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(72))];
    
    [iconButton addTarget:self action:@selector(cameraClick) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:iconButton];
    
    [iconButton addTarget:self action:@selector(cameraClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(80), iconButton.height)];
    
    topLabel.text = @"品牌logo";
    
    topLabel.textColor = UIColorFromRGB(0x999999);
    
    topLabel.font = AllFont(14);
    
    topLabel.userInteractionEnabled = NO;
    
    [topView addSubview:topLabel];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(77), Height320(12), Width320(48), Height320(48))];
    
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    self.iconView.layer.borderWidth = 1;
    
    self.iconView.userInteractionEnabled = NO;
    
    self.iconView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
    
    [topView addSubview:self.iconView];
    
    if (self.brand.imgURL.absoluteString.length) {
        
        [self.iconView sd_setImageWithURL:self.brand.imgURL];
        
    }
    
    UIImageView *topArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.4), Height320(30), Width320(7.4), Height320(12))];
    
    topArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [topView addSubview:topArrow];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), Height320(72)-OnePX, MSW, OnePX)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [iconButton addSubview:sep];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), Height320(72), MSW-Width320(32), Height320(40))];
    
    self.nameTF.placeholder = @"品牌名";
    
    self.nameTF.font = AllFont(14);
    
    self.nameTF.delegate = self;
    
    self.nameTF.noLine = YES;
    
    if (self.brand.name.length) {
        
        self.nameTF.text = self.brand.name;
        
    }
    
    [topView addSubview:self.nameTF];
    
    UIButton *confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    confirmButton.backgroundColor = kMainColor;
    
    confirmButton.layer.cornerRadius = 2;
    
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [confirmButton addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:confirmButton];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)confirmClick
{
    
    if (!self.nameTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请填写品牌名" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    self.brand.name = self.nameTF.text;
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"";
    
    [self.hud showAnimated:YES];
    
    NewGymInfo *info = [[NewGymInfo alloc]init];
    
    [info createBrand:self.brand Result:^(BOOL success, NSString *error) {
        
        if (success) {
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = @"创建成功";
            
            [self.hud hideAnimated:YES afterDelay:1.5];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                GuideSetGymController *svc = [[GuideSetGymController alloc]init];
                
                [self.navigationController pushViewController:svc animated:YES];
                
            });
            
        }else{
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = error;
            
            self.hud.label.numberOfLines = 0;
            
            [self.hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
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
                
                
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"相机访问受限，请到设置-隐私-相机中允许【健身房管理】访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
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
    
    self.brand.imgURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
    
    [uy uploadImage:self.image savekey:url];
    
}

@end
