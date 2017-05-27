//
//  CoachEditController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoachEditController.h"

#import "QCKeyboardView.h"

#import "QCTextField.h"

#import "MOPickerView.h"

#import "CoachListInfo.h"

#import "UpYun.h"

#import <AVFoundation/AVFoundation.h>

#import "WebViewController.h"

#import "CountryChooseTextField.h"

@interface CoachEditController ()<UITextFieldDelegate,QCKeyboardViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *sexTF;

@property(nonatomic,strong)MOPickerView *sexPV;

@property(nonatomic,strong)NSArray *sexArray;

@property(nonatomic,strong)CountryChooseTextField *phoneTF;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UIButton *confirmButton;

@property(nonatomic,strong)UIButton *deleteButton;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation CoachEditController

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
    
    if (self.isAdd) {
        
        self.coach = [[Coach alloc]init];
        
    }
    
    self.sexArray = @[@"男",@"女"];
    
}

-(void)createUI
{
    
    self.title = self.isAdd?@"添加教练":@"教练详情";
    
    if (!self.isAdd && [PermissionInfo sharedInfo].permissions.coachPermission.editState) {
        
        self.rightTitle = @"保存";
        
    }
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIButton *topView = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(72))];
    
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
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake([PermissionInfo sharedInfo].gym.permissions.coachPermission.editState?MSW-Width320(77):MSW-Width320(64), Height320(12), Width320(48), Height320(48))];
    
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    self.iconView.layer.borderWidth = 1;
    
    self.iconView.userInteractionEnabled = NO;
    
    self.iconView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
    
    if (self.coach.iconUrl.absoluteString.length) {
        
        [self.iconView sd_setImageWithURL:self.coach.iconUrl];
        
    }else
    {
        
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.coach.sex == SexTypeWoman?@"http://zoneke-img.b0.upaiyun.com/7f362320fb3c82270f6c9c623e39ba92.png":@"http://zoneke-img.b0.upaiyun.com/75656eb980b79e7748041f830332cc62.png"]];
        
    }
    
    [topView addSubview:self.iconView];
    
    UIImageView *topArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.4), Height320(30), Width320(7.4), Height320(12))];
    
    topArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [topView addSubview:topArrow];
    
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(12), MSW, Height320(134))];
    
    secondView.backgroundColor = UIColorFromRGB(0xffffff);
    
    secondView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    secondView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    [self.view addSubview:secondView];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 1, MSW-Width320(32), Height320(44))];
    
    self.nameTF.placeholder = @"姓名";
    
    self.nameTF.delegate = self;
    
    self.nameTF.text = self.coach.name;
    
    self.nameTF.mustInput = YES;
    
    [secondView addSubview:self.nameTF];
    
    self.sexTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.sexTF.placeholder = @"性别";
    
    self.sexTF.delegate = self;
    
    self.sexTF.text = self.coach.sex == SexTypeMan?@"男":@"女";
    
    self.sexTF.mustInput = YES;
    
    [secondView addSubview:self.sexTF];
    
    QCKeyboardView *keyboard = [QCKeyboardView defaultKeboardView];
    
    keyboard.delegate = self;
    
    self.sexTF.inputView = keyboard;
    
    self.sexPV = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 37, MSW, 177)];
    
    self.sexPV.titleArray = self.sexArray;
    
    keyboard.keyboard = self.sexPV;
    
    self.phoneTF = [[CountryChooseTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.sexTF.bottom, self.nameTF.width, self.nameTF.height)];

    self.phoneTF.mustInput = YES;
    
    if (self.coach.country) {
        
        self.phoneTF.country = self.coach.country;
        
    }
    
    self.phoneTF.delegate = self;
    
    self.phoneTF.noLine = YES;
    
    self.phoneTF.text = self.coach.phone;
    
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.phoneTF.mustInput = YES;
    
    [secondView addSubview:self.phoneTF];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), secondView.bottom+Height320(8), MSW-Width320(32), Height320(32))];
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    UILabel *buttonLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MSW-Width320(32), Height320(14))];
    
    buttonLabel1.text = @"添加成功后，系统将自动短信通知教练下载";
    
    buttonLabel1.textColor = UIColorFromRGB(0x999999);
    
    buttonLabel1.font = AllFont(12);
    
    buttonLabel1.userInteractionEnabled = NO;
    
    [button addSubview:buttonLabel1];
    
    UIImageView *coachIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height320(18), Width320(14), Height320(14))];
    
    coachIcon.image = [UIImage imageNamed:@"trainer_icon"];
    
    coachIcon.layer.cornerRadius = Width320(2);
    
    [button addSubview:coachIcon];
    
    UILabel *buttonLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(coachIcon.right+Width320(2), buttonLabel1.bottom+Height320(4), button.width-coachIcon.right-Width320(2), Height320(14))];
    
    buttonLabel2.text = @"［健身教练助手APP］";
    
    buttonLabel2.textColor = UIColorFromRGB(0x6EB8F1);
    
    buttonLabel2.font = AllFont(12);
    
    buttonLabel2.userInteractionEnabled = NO;
    
    [button addSubview:buttonLabel2];
    
    if (self.isAdd) {
        
        self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), button.bottom+Height320(12), MSW-Width320(32), Height320(40))];
        
        self.confirmButton.backgroundColor = kMainColor;
        
        self.confirmButton.layer.cornerRadius = 2;
        
        [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        
        [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        self.confirmButton.titleLabel.font = AllFont(14);
        
        [self.confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.confirmButton];
        
    }else
    {
        
        self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, button.bottom+Height320(12), MSW, Height320(40))];
        
        self.deleteButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        [self.deleteButton setTitle:@"删除该教练" forState:UIControlStateNormal];
        
        [self.deleteButton setTitleColor:kDeleteColor forState:UIControlStateNormal];
        
        self.deleteButton.titleLabel.font = AllFont(14);
        
        [self.deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.deleteButton];
        
    }
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (!self.isAdd && ![PermissionInfo sharedInfo].permissions.coachPermission.editState) {
        
        [self showNoPermissionAlert];
        
        return NO;
        
    }else{
        
        return YES;
        
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    [self.sexTF resignFirstResponder];
    
    self.sexTF.text = self.sexArray[self.sexPV.currentRow];
    
    self.coach.sex = [self.sexArray indexOfObject:self.sexTF.text];
    
    if (!self.coach.iconUrl.absoluteString.length) {
        
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:[self.sexTF.text isEqualToString:@"女"]?@"http://zoneke-img.b0.upaiyun.com/7f362320fb3c82270f6c9c623e39ba92.png":@"http://zoneke-img.b0.upaiyun.com/75656eb980b79e7748041f830332cc62.png"]];
        
    }
    
}

-(void)touchTap:(UITapGestureRecognizer *)tap
{
        
    [self.view endEditing:YES];
    
}

-(void)buttonClick:(UIButton*)button
{
    
    [self.view endEditing:YES];
    
    NSURL *appURL = [NSURL URLWithString:@"https://itunes.apple.com/app/id1053738509"];
    
    if ([[UIApplication sharedApplication]canOpenURL:appURL]) {
        
        [[UIApplication sharedApplication]openURL:appURL];
        
    }
    
}


-(void)deleteClick
{
    
    [self.view endEditing:YES];
    
    if (![PermissionInfo sharedInfo].gym.permissions.coachPermission.deleteState) {
        
        [self showNoPermissionAlert];
        
        return;
        
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认删除该教练吗" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    
    alert.tag = 101;
    
    [alert show];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 101) {
        
        if (buttonIndex == 1) {
            
            CoachListInfo *info = [[CoachListInfo alloc]init];
            
            [info deleteCoach:self.coach withGym:self.gym result:^(BOOL success, NSString *error) {
                
                if (success) {
                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    self.hud.label.text = @"删除成功";
                    
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

-(void)confirm
{
    
    NSString *regex;
    
    if ([self.phoneTF.country.countryNo isEqualToString:@"+886"]) {
        
        regex = @"^[0][9][0-9]{8}$";
        
    }else if ([self.phoneTF.country.countryNo isEqualToString:@"+86"]) {
        
        regex = @"^[1][34578][0-9]{9}$";
        
    }
    
    regex = @"^[1][34578][0-9]{9}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (!self.phoneTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"尚未输入手机号" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else if (![pred evaluateWithObject:self.phoneTF.text]) {
        
        [[[UIAlertView alloc]initWithTitle:@"请输入正确的手机号" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else if (!self.nameTF.text.length){
        
        [[[UIAlertView alloc]initWithTitle:@"请填写教练姓名" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else {
        
        self.coach.name = self.nameTF.text;
        
        self.coach.phone = self.phoneTF.text;
        
        self.coach.country = self.phoneTF.country;
        
        self.coach.sex = [self.sexTF.text isEqualToString:@"男"]?SexTypeMan:SexTypeWoman;
        
        CoachListInfo *info = [[CoachListInfo alloc]init];
        
        [info createCoach:self.coach withGym:self.gym result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = @"添加成功";
                
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

-(void)cameraClick
{
    
    [self.view endEditing:YES];
    
    if (!self.isAdd &&![PermissionInfo sharedInfo].permissions.coachPermission.editState) {
        
        [self showNoPermissionAlert];
        
    }else{
        
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
    
    self.coach.iconUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
    
    [uy uploadImage:self.image savekey:url];
    
}

-(void)naviRightClick
{
    
    if ([PermissionInfo sharedInfo].permissions.coachPermission.editState) {
        
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
            
            [[[UIAlertView alloc]initWithTitle:@"请填写教练姓名" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else{
            
            self.hud.mode = MBProgressHUDModeIndeterminate;
            
            self.hud.label.text = @"";
            
            [self.hud showAnimated:YES];
            
            self.coach.name = self.nameTF.text;
            
            self.coach.phone = self.phoneTF.text;
            
            self.coach.sex = [self.sexTF.text isEqualToString:@"男"]?SexTypeMan:SexTypeWoman;
            
            CoachListInfo *info = [[CoachListInfo alloc]init];
            
            [info editCoach:self.coach withGym:self.gym result:^(BOOL success, NSString *error) {
                
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
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}


@end
