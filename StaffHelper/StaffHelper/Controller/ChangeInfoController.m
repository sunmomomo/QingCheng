//
//  ChangeInfoController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChangeInfoController.h"

#import "QCTextField.h"

#import "DistrictPickerView.h"

#import "MOPickerView.h"

#import "QCKeyboardView.h"

#import "UpYun.h"

#import "ChatHeader.h"

#import "RootController.h"

#import <AVFoundation/AVFoundation.h>

@interface ChangeInfoController ()<UITextFieldDelegate,QCKeyboardViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *sexTF;

@property(nonatomic,strong)QCTextField *cityTF;

@property(nonatomic,strong)MOPickerView *sexPV;

@property(nonatomic,strong)DistrictPickerView *districtPV;

@property(nonatomic,strong)UIButton *saveButton;

@property(nonatomic,strong)NSArray *sexArray;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation ChangeInfoController

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
    
    self.sexArray = @[@"男",@"女"];
    
    self.userInfo = [[StaffUserInfo alloc]init];
    
    [self.userInfo requestResult:^(BOOL success, NSString *error) {
        
        if (success) {
            
            [self.iconView sd_setImageWithURL:self.userInfo.staff.iconUrl];
            
            self.nameTF.text = self.userInfo.staff.name;
            
            self.sexTF.text = self.userInfo.staff.sex == SexTypeMan?@"男":@"女";
            
            self.cityTF.text = self.userInfo.staff.districtCode?[DistrictInfo cityForDistrictCode:self.userInfo.staff.districtCode]:@"";
            
            [self check];
            
        }
        
    }];
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.title = @"编辑个人资料";
    
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
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(77), Height320(12), Width320(48), Height320(48))];
    
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    self.iconView.layer.borderWidth = 1;
    
    self.iconView.userInteractionEnabled = NO;
    
    self.iconView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
    
    [self.iconView sd_setImageWithURL:self.userInfo.staff.iconUrl];
    
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
    
    self.nameTF.placeholder = @"用户名";
    
    self.nameTF.text = self.userInfo.staff.name;
    
    self.nameTF.delegate = self;
    
    self.nameTF.mustInput = YES;
    
    [secondView addSubview:self.nameTF];
    
    self.sexTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.sexTF.placeholder = @"性别";
    
    self.sexTF.text = self.userInfo.staff.sex == SexTypeMan?@"男":@"女";
    
    self.sexTF.delegate = self;
    
    [secondView addSubview:self.sexTF];
    
    self.sexPV = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.sexPV.titleArray = self.sexArray;
    
    QCKeyboardView *sexKV = [QCKeyboardView defaultKeboardView];
    
    sexKV.keyboard = self.sexPV;
    
    sexKV.tag = 101;
    
    sexKV.delegate = self;
    
    self.sexTF.inputView = sexKV;
    
    self.cityTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.sexTF.bottom, MSW-Width320(32), Height320(40))];
    
    self.cityTF.noLine = YES;
    
    self.cityTF.placeholder = @"城市";
    
    self.cityTF.text = self.userInfo.staff.districtCode?[DistrictInfo cityForDistrictCode:self.userInfo.staff.districtCode]:@"";
    
    self.cityTF.delegate = self;
    
    [secondView addSubview:self.cityTF];
    
    self.districtPV = [DistrictPickerView defaultPickerView];
    
    QCKeyboardView *cityKV = [QCKeyboardView defaultKeboardView];
    
    cityKV.keyboard = self.districtPV;
    
    cityKV.tag = 102;
    
    cityKV.delegate = self;
    
    self.cityTF.inputView = cityKV;
    
    self.saveButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), secondView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    self.saveButton.backgroundColor = kMainColor;
    
    self.saveButton.titleLabel.font = AllFont(14);
    
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    
    [self.saveButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [self.view addSubview:self.saveButton];
    
    [self.saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    [self check];
    
}

-(void)save
{
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"";
    
    [self.hud showAnimated:YES];
    
    self.userInfo.staff.name = self.nameTF.text;
    
    self.userInfo.staff.sex = [self.sexTF.text isEqualToString:@"男"]?SexTypeMan:SexTypeWoman;
    
    self.userInfo.staff.districtCode = self.districtPV.districtCode;
    
    [self.userInfo updateStaffResult:^(BOOL success, NSString *error) {
        
        if (success) {
            
            self.hud.label.text = @"修改成功";
            
            self.hud.mode = MBProgressHUDModeText;
            
            [self.hud showAnimated:YES];
            
            [self.hud hideAnimated:YES afterDelay:1.5f];
            
            [[TIMFriendshipManager sharedInstance]SetNickname:self.userInfo.staff.name succ:^{
                
                [[TIMFriendshipManager sharedInstance]SetFaceURL:self.userInfo.staff.iconUrl.absoluteString succ:^{
                    
                } fail:^(int code, NSString *msg) {
                    
                }];
                
            } fail:^(int code, NSString *msg) {
                
            }];
            
            [[RootController sharedSliderController]reloadMessageData];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (self.editFinish) {
                    self.editFinish();
                }
                
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
        }else{
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = error;
            
            [self.hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

-(void)touchTap:(UITapGestureRecognizer*)tap
{
    
    [self check];
    
    [self.view endEditing:YES];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    [self check];
    
    return YES;
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    if (keyboardView.tag == 101) {
        
        self.sexTF.text = self.sexArray[self.sexPV.currentRow];
        
        [self.sexTF resignFirstResponder];
        
    }else{
        
        self.cityTF.text = [DistrictInfo cityForDistrictCode:self.districtPV.districtCode];
        
        [self.cityTF resignFirstResponder];
        
        [self check];
        
    }
    
}

-(void)check
{
    
    if (!self.nameTF.text.length) {
        
        self.saveButton.backgroundColor = [kMainColor colorWithAlphaComponent:0.3];
        
        self.saveButton.userInteractionEnabled = NO;
        
    }else
    {
        
        self.saveButton.backgroundColor = kMainColor;
        
        self.saveButton.userInteractionEnabled = YES;
        
    }
    
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
    
    self.userInfo.staff.iconUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
    
    [uy uploadImage:self.image savekey:url];
    
}

@end
