//
//  AdminController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "AdminController.h"

#import "MOPickerView.h"

#import "QCTextField.h"

#import "QCKeyboardView.h"

#import "UpYun.h"

#import "PositionInfo.h"

#import <AVFoundation/AVFoundation.h>

#import "StaffListInfo.h"

#import "CountryChooseTextField.h"

#import "AdminVerifyController.h"

@interface AdminController ()<UITextFieldDelegate,QCKeyboardViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *sexTF;

@property(nonatomic,strong)CountryChooseTextField *phoneTF;

@property(nonatomic,strong)MOPickerView *sexPV;

@property(nonatomic,strong)UIButton *changeButton;

@property(nonatomic,strong)NSArray *sexArray;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)PositionInfo *positionInfo;


@end

@implementation AdminController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        self.sexArray = @[@"男",@"女"];
        
    }
    
    return self;
    
}

-(void)createData
{
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.title = @"超级管理员";
    
    self.rightTitle = @"确定";
    
    UIImageView *hintIcon = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(12)+64, Width320(14), Height320(14))];
    
    hintIcon.image = [UIImage imageNamed:@"hint_circle"];
    
    [self.view addSubview:hintIcon];
    
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(10)+64, MSW-Width320(32), Height320(34))];
    
    hintLabel.textColor = UIColorFromRGB(0x999999);
    
    hintLabel.numberOfLines = 0;
    
    hintLabel.font = AllFont(12);
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:@"      修改超级管理员的基本信息并不会变换超级管理员身份，需要变更请使用「变更超级管理员」功能"];
    
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle1 setLineSpacing:Height320(4)];
    
    [astr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [astr length])];
    
    hintLabel.attributedText = astr;
    
    [self.view addSubview:hintLabel];
    
    UIButton *topView = [[UIButton alloc]initWithFrame:CGRectMake(0, 64+Height320(54), MSW, Height320(72))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:topView];
    
    [topView addTarget:self action:@selector(cameraClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(50), topView.height)];
    
    topLabel.text = @"头像";
    
    topLabel.textColor = UIColorFromRGB(0x999999);
    
    topLabel.font = AllFont(14);
    
    topLabel.userInteractionEnabled = NO;
    
    [topView addSubview:topLabel];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake([PermissionInfo sharedInfo].permissions.staffPermission.editState?MSW-Width320(77):MSW-Width320(64), Height320(12), Width320(48), Height320(48))];
    
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    self.iconView.layer.borderWidth = 1;
    
    self.iconView.userInteractionEnabled = NO;
    
    self.iconView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
    
    if (self.admin.iconUrl.absoluteString.length) {
        
        [self.iconView sd_setImageWithURL:self.admin.iconUrl];
        
    }else{
        
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.admin.sex == SexTypeWoman?@"http://zoneke-img.b0.upaiyun.com/7f362320fb3c82270f6c9c623e39ba92.png":@"http://zoneke-img.b0.upaiyun.com/75656eb980b79e7748041f830332cc62.png"]];
        
    }
    
    [topView addSubview:self.iconView];
    
    UIImageView *topArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.4), Height320(30), Width320(7.4), Height320(12))];
    
    topArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [topView addSubview:topArrow];
    
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(12),MSW, Height320(40)*3)];
    
    secondView.backgroundColor = UIColorFromRGB(0xffffff);
    
    secondView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    secondView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:secondView];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.nameTF.placeholder = @"姓名";
    
    self.nameTF.text = self.admin.name;
    
    self.nameTF.delegate = self;
    
    self.nameTF.mustInput = YES;
    
    [secondView addSubview:self.nameTF];
    
    self.sexTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.sexTF.placeholder = @"性别";
    
    self.sexTF.text = self.admin.sex == SexTypeMan?@"男":@"女";
    
    self.sexTF.delegate = self;
    
    self.sexTF.mustInput = YES;
    
    [secondView addSubview:self.sexTF];
    
    self.sexPV = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.sexPV.titleArray = self.sexArray;
    
    QCKeyboardView *sexKV = [QCKeyboardView defaultKeboardView];
    
    sexKV.keyboard = self.sexPV;
    
    sexKV.tag = 101;
    
    sexKV.delegate = self;
    
    self.sexTF.inputView = sexKV;
    
    self.phoneTF = [[CountryChooseTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.sexTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.phoneTF.mustInput = YES;
    
    self.phoneTF.text = self.admin.phone;
    
    if (self.admin.country) {
        
        self.phoneTF.country = self.admin.country;
        
    }
    
    self.phoneTF.delegate = self;
    
    self.phoneTF.mustInput = YES;
    
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [secondView addSubview:self.phoneTF];
    
    self.changeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, secondView.bottom+Height320(12), MSW, Height320(40))];
    
    self.changeButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.changeButton setTitle:@"变更超级管理员" forState:UIControlStateNormal];
    
    [self.changeButton setTitleColor:kDeleteColor forState:UIControlStateNormal];
    
    self.changeButton.titleLabel.font = AllFont(14);
    
    [self.changeButton addTarget:self action:@selector(changeAdmin) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.changeButton];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)changeAdmin
{
    
    AdminVerifyController *svc = [[AdminVerifyController alloc]init];
    
    svc.admin = self.admin;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    self.sexTF.text = self.sexPV.titleArray[self.sexPV.currentRow];
    
    if (!self.admin.iconUrl.absoluteString.length) {
        
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:[self.sexTF.text isEqualToString:@"女"]?@"http://zoneke-img.b0.upaiyun.com/7f362320fb3c82270f6c9c623e39ba92.png":@"http://zoneke-img.b0.upaiyun.com/75656eb980b79e7748041f830332cc62.png"]];
        
    }
    
    [self.view endEditing:YES];
    
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
    
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
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    }else{
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
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
    
    self.admin.iconUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
    
    [uy uploadImage:self.image savekey:url];
    
}

-(void)naviRightClick
{
    
    if ([PermissionInfo sharedInfo].permissions.staffPermission.editState) {
        
        NSString *regex;
        
        if ([self.phoneTF.country.countryNo isEqualToString:@"+886"]) {
            
            regex = @"^[0][9][0-9]{8}$";
            
        }else if ([self.phoneTF.country.countryNo isEqualToString:@"+86"]) {
            
            regex = @"^[1][34578][0-9]{9}$";
            
        }
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        if (!self.phoneTF.text.length) {
            
            [[[UIAlertView alloc]initWithTitle:@"尚未输入手机号" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else if (![pred evaluateWithObject:self.phoneTF.text]) {
            
            [[[UIAlertView alloc]initWithTitle:@"请输入正确的手机号" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else if (!self.nameTF.text.length){
            
            [[[UIAlertView alloc]initWithTitle:@"请填写工作人员姓名" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else{
            
            self.admin.name = self.nameTF.text;
            
            self.admin.phone = self.phoneTF.text;
            
            self.admin.country = self.phoneTF.country;
            
            self.admin.sex = [self.sexTF.text isEqualToString:@"男"]?SexTypeMan:SexTypeWoman;
            
            StaffListInfo *info = [[StaffListInfo alloc]init];
            
            [info editStaff:self.admin withGym:self.gym result:^(BOOL success, NSString *error) {
                
                if (success) {
                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    self.hud.label.text = @"修改成功";
                    
                    [self.hud showAnimated:YES];
                    
                    [self.hud hideAnimated:YES afterDelay:1.5];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        if (self.editFinish) {
                            self.editFinish();
                        }
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    });
                    
                }else
                {
                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    self.hud.label.text = error;
                    
                    self.hud.label.numberOfLines = 0;
                    
                    [self.hud showAnimated:YES];
                    
                    [self.hud hideAnimated:YES afterDelay:1.5];
                    
                }
                
            }];
            
        }
        
    }
    
}



@end
