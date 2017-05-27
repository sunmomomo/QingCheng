//
//  StaffEditController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "StaffEditController.h"

#import "MOPickerView.h"

#import "QCTextField.h"

#import "QCKeyboardView.h"

#import "UpYun.h"

#import "PositionInfo.h"

#import <AVFoundation/AVFoundation.h>

#import "StaffListInfo.h"

#import "CountryChooseTextField.h"

#import "FunctionHintController.h"

@interface StaffEditController ()<UITextFieldDelegate,QCKeyboardViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *sexTF;

@property(nonatomic,strong)CountryChooseTextField *phoneTF;

@property(nonatomic,strong)QCTextField  *positionTF;

@property(nonatomic,strong)MOPickerView *sexPV;

@property(nonatomic,strong)MOPickerView *positionPV;

@property(nonatomic,strong)UIButton *confirmButton;

@property(nonatomic,strong)UIButton *deleteButton;

@property(nonatomic,strong)NSArray *sexArray;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)PositionInfo *positionInfo;

@end

@implementation StaffEditController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.sexArray = @[@"男",@"女"];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createUI];
    
    [self createData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.positionInfo = [[PositionInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    self.positionInfo.requestFinish = ^(BOOL success){
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (Position *position in weakS.positionInfo.positions) {
            
            if ([position.name isEqualToString:weakS.positionTF.text]) {
                
                weakS.positionPV.currentRow = [weakS.positionInfo.positions indexOfObject:position];
                
            }
            
            [array addObject:position.name];
            
        }
        
        weakS.positionPV.titleArray = array;
        
    };
    
    [self.positionInfo requestWithGym:self.gym];
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.title = self.isAdd?@"添加工作人员":@"工作人员详情";
    
    if (!self.isAdd &&[PermissionInfo sharedInfo].permissions.staffPermission.editState) {
        
        self.rightTitle = @"保存";
        
    }
    
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
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake([PermissionInfo sharedInfo].permissions.staffPermission.editState?MSW-Width320(77):MSW-Width320(64), Height320(12), Width320(48), Height320(48))];
    
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    self.iconView.layer.borderWidth = 1;
    
    self.iconView.userInteractionEnabled = NO;
    
    self.iconView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
    
    if (self.staff.iconUrl.absoluteString.length) {
        
        [self.iconView sd_setImageWithURL:self.staff.iconUrl];
        
    }else{
        
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.staff.sex == SexTypeWoman?@"http://zoneke-img.b0.upaiyun.com/7f362320fb3c82270f6c9c623e39ba92.png":@"http://zoneke-img.b0.upaiyun.com/75656eb980b79e7748041f830332cc62.png"]];
        
    }
    
    [topView addSubview:self.iconView];
    
    UIImageView *topArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.4), Height320(30), Width320(7.4), Height320(12))];
    
    topArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [topView addSubview:topArrow];
    
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(12),MSW, Height320(160))];
    
    secondView.backgroundColor = UIColorFromRGB(0xffffff);
    
    secondView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    secondView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:secondView];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.nameTF.placeholder = @"姓名";
    
    self.nameTF.text = self.staff.name;
    
    self.nameTF.delegate = self;
    
    self.nameTF.mustInput = YES;
    
    [secondView addSubview:self.nameTF];
    
    self.sexTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.sexTF.placeholder = @"性别";
    
    self.sexTF.text = self.staff.sex == SexTypeMan?@"男":@"女";
    
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
    
    self.phoneTF.text = self.staff.phone;
    
    if (self.staff.country) {
        
        self.phoneTF.country = self.staff.country;
        
    }
    
    self.phoneTF.delegate = self;
    
    self.phoneTF.mustInput = YES;
    
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [secondView addSubview:self.phoneTF];
    
    self.positionTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.phoneTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.positionTF.placeholder = @"职位";
    
    self.positionTF.text = self.staff.position.name;
    
    self.positionTF.delegate = self;
    
    self.positionTF.noLine = YES;
    
    self.positionTF.mustInput = YES;
    
    [secondView addSubview:self.positionTF];
    
    QCKeyboardView *positionKV = [QCKeyboardView defaultKeboardView];
    
    positionKV.tag = 102;
    
    positionKV.delegate = self;
    
    self.positionTF.inputView = positionKV;
    
    self.positionPV = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 38, MSW, 177)];
    
    positionKV.keyboard = self.positionPV;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), secondView.bottom+Height320(8), MSW-Width320(32), Height320(14))];
    
    button.titleLabel.font = AllFont(12);
    
    [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:@" 请登录［网页端］管理职位权限"];
    
    [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x6EB8F1) range:NSMakeRange(4, 5)];
    
    [button setAttributedTitle:astr forState:UIControlStateNormal];
    
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
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
        
        [self.deleteButton setTitle:@"删除该工作人员" forState:UIControlStateNormal];
        
        [self.deleteButton setTitleColor:kDeleteColor forState:UIControlStateNormal];
        
        self.deleteButton.titleLabel.font = AllFont(14);
        
        [self.deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.deleteButton];
        
    }
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    if (keyboardView.tag == 101) {
        
        self.sexTF.text = self.sexPV.titleArray[self.sexPV.currentRow];
        
        if (!self.staff.iconUrl.absoluteString.length) {
            
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:[self.sexTF.text isEqualToString:@"女"]?@"http://zoneke-img.b0.upaiyun.com/7f362320fb3c82270f6c9c623e39ba92.png":@"http://zoneke-img.b0.upaiyun.com/75656eb980b79e7748041f830332cc62.png"]];
            
        }
        
    }else
    {
        
        self.positionTF.text = self.positionPV.titleArray[self.positionPV.currentRow];
        
    }
    
    [self.view endEditing:YES];
    
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (!self.isAdd && ![PermissionInfo sharedInfo].permissions.staffPermission.editState) {
        
        [self showNoPermissionAlert];
        
        return NO;
        
    }else{
        
        if (textField == self.positionTF) {
            
            [self createData];
            
        }
        
        return YES;
        
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)buttonClick:(UIButton*)button
{
    
    [self.view endEditing:YES];
    
    FunctionHintController *svc = [[FunctionHintController alloc]init];
    
    svc.module = @"/position/setting";
    
    [self.navigationController pushViewController:svc animated:YES];
    
}


-(void)deleteClick
{
    
    [self.view endEditing:YES];
    
    if (![PermissionInfo sharedInfo].permissions.staffPermission.deleteState) {
        
        [self showNoPermissionAlert];
        
        return;
        
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认删除该工作人员吗" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    
    alert.tag = 101;
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 101) {
        
        if (buttonIndex == 1) {
            
            StaffListInfo *info = [[StaffListInfo alloc]init];
            
            [info deleteStaff:self.staff withGym:self.gym result:^(BOOL success, NSString *error) {
                
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
        
    }else if(alertView.tag == 102){
        
        if (buttonIndex == 0) {
            
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            
            pasteboard.string = @"http://cloud.qingchengfit.cn/backend/settings/";
            
            [[[UIAlertView alloc]initWithTitle:@"链接已复制到剪贴板" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
    }
    
}

-(void)confirm
{
    
    [self.view endEditing:YES];
    
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
        
    }else if (!self.positionTF.text.length){
        
        [[[UIAlertView alloc]initWithTitle:@"请选择工作人员职位" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else{
        
        self.staff.name = self.nameTF.text;
        
        self.staff.phone = self.phoneTF.text;
        
        self.staff.country = self.phoneTF.country;
        
        self.staff.sex = [self.sexTF.text isEqualToString:@"男"]?SexTypeMan:SexTypeWoman;
        
        if (self.positionInfo.positions.count) {
            
            self.staff.position = self.positionInfo.positions[self.positionPV.currentRow];
            
        }
        
        StaffListInfo *info = [[StaffListInfo alloc]init];
        
        [info createStaff:self.staff withGym:self.gym result:^(BOOL success, NSString *error) {
            
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
    
    if (!self.isAdd &&![PermissionInfo sharedInfo].permissions.staffPermission.editState) {
        
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
    
    self.staff.iconUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
    
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
            
        }else if (!self.positionTF.text.length){
            
            [[[UIAlertView alloc]initWithTitle:@"请选择工作人员身份" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else{
            
            self.staff.name = self.nameTF.text;
            
            self.staff.phone = self.phoneTF.text;
            
            self.staff.country = self.phoneTF.country;
            
            self.staff.sex = [self.sexTF.text isEqualToString:@"男"]?SexTypeMan:SexTypeWoman;
            
            if (self.positionInfo.positions.count) {
                
                self.staff.position = self.positionInfo.positions[self.positionPV.currentRow];
                
            }
            
            StaffListInfo *info = [[StaffListInfo alloc]init];
            
            [info editStaff:self.staff withGym:self.gym result:^(BOOL success, NSString *error) {
                
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
