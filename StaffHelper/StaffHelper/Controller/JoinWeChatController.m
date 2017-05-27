//
//  JoinWeChatController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/20.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "JoinWeChatController.h"

#import <AVFoundation/AVFoundation.h>

#import "UpYun.h"

#import "QCTextField.h"

#import "JoinCompleteController.h"

#import "GymDetailInfo.h"

@interface JoinWeChatController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)QCTextField *wechatTF;

@property(nonatomic,strong)UIImageView *imageView;

@property(nonatomic,copy)NSURL *imageURL;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UIImage *image;

@end

@implementation JoinWeChatController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
}

-(void)createUI
{
    
    self.title = @"对接到微信公众号";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.rightTitle = @"下一步";
    
    self.rightButtonEnable = AppGym.wechatName.length && AppGym.wechatImg.absoluteString.length;
    
    self.rightColor = AppGym.wechatName.length && AppGym.wechatImg.absoluteString.length?kMainColor:[kMainColor colorWithAlphaComponent:0.5];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(112))];
    
    view.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:view];
    
    self.wechatTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.wechatTF.placeholderColor = UIColorFromRGB(0x333333);
    
    self.wechatTF.placeholder = @"公众号名称";
    
    self.wechatTF.textPlaceholder = @"填写公众号名称";
    
    if (AppGym.wechatName) {
        
        self.wechatTF.text = AppGym.wechatName;
        
    }
    
    [self.wechatTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [view addSubview:self.wechatTF];
    
    UIButton *iconView = [[UIButton alloc]initWithFrame:CGRectMake(0, self.wechatTF.bottom, MSW, Height320(72))];
    
    iconView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [view addSubview:iconView];
    
    [iconView addTarget:self action:@selector(cameraClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *iconLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(200), iconView.height)];
    
    iconLabel.text = @"上传公众号二维码";
    
    iconLabel.textColor = UIColorFromRGB(0x333333);
    
    iconLabel.font = AllFont(14);
    
    iconLabel.userInteractionEnabled = NO;
    
    [iconView addSubview:iconLabel];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(77), Height320(12), Width320(48), Height320(48))];
    
    self.imageView.image = [UIImage imageNamed:@"checkin_photo_empty"];
    
    self.imageView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
    
    if (AppGym.wechatImg) {
        
        [self.imageView sd_setImageWithURL:AppGym.wechatImg];
        
    }
    
    [iconView addSubview:self.imageView];
    
    UIImageView *iconArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.4), Height320(30), Width320(7.4), Height320(12))];
    
    iconArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [iconView addSubview:iconArrow];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    [self check];
    
}

-(void)check
{
    
    if (self.wechatTF.text.length && self.imageURL.absoluteString.length) {
        
        self.rightButtonEnable = YES;
        
        self.rightColor = kMainColor ;
        
    }else{
        
        self.rightButtonEnable = NO;
        
        self.rightColor = [kMainColor colorWithAlphaComponent:0.5];
        
    }
    
}


-(void)cameraClick
{
    
    [self.view endEditing:YES];
    
    UIActionSheet *actionSheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传公众号二维码" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    }else{
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传公众号二维码" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
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
    
    [self.imageView setImage:self.image];
    
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
        
        [self check];
        
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
    
    self.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
    
    [uy uploadImage:self.image savekey:url];
    
}

-(void)naviRightClick
{
    
    JoinCompleteController *svc = [[JoinCompleteController alloc]init];
    
    svc.wechatName = self.wechatTF.text;
    
    svc.wechatImg = self.imageURL;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

@end
