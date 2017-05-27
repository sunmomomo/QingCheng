//
//  ChangeInfoController.m
//  健身教练助手
//
//  Created by 馍馍帝😈 on 15/8/13.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import "ChangeInfoController.h"

#import "MOTextView.h"

#import "UserDetailInfo.h"

#import "QCTextField.h"

#import "QCTextView.h"

#import "UpYun.h"

#import "DistrictInfo.h"

#import "QCKeyboardView.h"

#import "IntroEditController.h"

#import <AVFoundation/AVFoundation.h>

#import "DistrictPickerView.h"

#import "ChatHeader.h"

#import "RootController.h"

#define kUserInfo @"/api/coaches/"

@interface ChangeInfoController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,QCKeyboardViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *sexTF;

@property(nonatomic,strong)QCTextField *cityTF;

@property(nonatomic,strong)QCTextField *wechatTF;

@property(nonatomic,strong)QCTextView *introTF;

@property(nonatomic,strong)User *user;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,copy)NSString *imgUrl;

@property(nonatomic,strong)NSMutableArray *introArray;

@property(nonatomic,strong)UIPickerView *sexPV;

@property(nonatomic,assign)NSInteger sexNum;

@property(nonatomic,strong)NSArray *sexArray;

@property(nonatomic,strong)DistrictPickerView *districtPV;

@property(nonatomic,assign)NSInteger provinceNum;

@property(nonatomic,assign)NSInteger cityNum;

@property(nonatomic,copy)NSString *districtCode;

@property(nonatomic,assign)NSInteger districtNum;

@property(nonatomic,strong)DistrictInfo *districtInfo;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@end

@implementation ChangeInfoController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self createData];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

-(void)createData
{
    
    self.introArray = [NSMutableArray array];
    
    self.districtInfo = [DistrictInfo sharedDistrictInfo];
    
    self.sexArray = @[@"男",@"女"];
    
    self.sexNum = 0;
    
    UserDetailInfo *userInfo = [[UserDetailInfo alloc]init];
    
    [userInfo requestResult:^(BOOL success, NSString *error) {
        
        self.user = userInfo.user;
        
        self.districtCode = self.user.districtCode;
        
        self.nameTF.text = self.user.username;
        
        self.sexTF.text = self.user.sex == SexTypeMan?@"男":@"女";
        
        self.wechatTF.text = self.user.wechat;
        
        if (self.districtCode) {
            
            self.cityTF.text = [DistrictInfo cityForDistrictCode:self.user.districtCode];
            
        }
        
        self.introTF.text = self.user.shortIntro;
        
        if (self.user.iconURL.absoluteString) {
            
            if ([self.user.iconURL.absoluteString rangeOfString:@"!"].length) {
                
                [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.user.iconURL.absoluteString] placeholderImage:[UIImage imageNamed:self.user.sex == SexTypeWoman?@"icon_female":@"icon_male"]];
                
            }else{
                
                if ([self.user.iconURL.absoluteString rangeOfString:@"!/watermark/"].length) {
                    
                    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!small/watermark/%@",[[self.user.iconURL.absoluteString componentsSeparatedByString:@"!/watermark/"]firstObject],[[self.user.iconURL.absoluteString componentsSeparatedByString:@"!/watermark/"]lastObject]]] placeholderImage:[UIImage imageNamed:self.user.sex == SexTypeWoman?@"icon_female":@"icon_male"]];
                    
                }else if ([self.user.iconURL.absoluteString rangeOfString:@"/watermark/"].length){
                    
                    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.user.iconURL.absoluteString] placeholderImage:[UIImage imageNamed:self.user.sex == SexTypeWoman?@"icon_female":@"icon_male"]];
                    
                }else{
                    
                    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[self.user.iconURL.absoluteString stringByAppendingString:@"!small"]] placeholderImage:[UIImage imageNamed:self.user.sex == SexTypeWoman?@"icon_female":@"icon_male"]];
                    
                }
                
            }
            
        }
        
        self.imgUrl = [self.user.iconURL absoluteString];
        
        self.introArray = self.user.intro;
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"基本信息设置";
    
    UIView *tfView=  [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(209))];
    
    tfView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:tfView];
    
    UIButton *iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    iconBtn.frame = CGRectMake(Width320(21.3), 0, MSW-Width320(42.6), Height320(45.3));
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width320(200), iconBtn.height)];
    
    label.text = @"头像";
    
    label.userInteractionEnabled = NO;
    
    label.textColor = UIColorFromRGB(0x666666);
    
    label.font = STFont(14);
    
    [iconBtn addSubview:label];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(iconBtn.width-Width320(36.5), Height320(4.5), Width320(35.5), Height320(35.5))];
    
    self.iconView.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    [iconBtn addTarget:self action:@selector(changeIcon:) forControlEvents:UIControlEventTouchUpInside];
    
    [iconBtn addSubview:self.iconView];
    
    [tfView addSubview:iconBtn];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(21.3), iconBtn.bottom-1, MSW-Width320(42.6), 1)];
    
    sep.backgroundColor = UIColorFromRGB(0xeeeeee);
    
    [tfView addSubview:sep];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(21.3), iconBtn.bottom, MSW-Width320(42.6), Height320(37.7))];
    
    self.nameTF.placeholder = @"姓名";
    
    self.nameTF.delegate = self;
    
    [tfView addSubview:self.nameTF];
    
    self.sexTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.sexTF.placeholder = @"性别";
    
    self.sexTF.delegate = self;
    
    [tfView addSubview:self.sexTF];
    
    self.sexPV = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, MSW, 177)];
    
    self.sexPV.tag = 101;
    
    self.sexPV.delegate = self;
    
    self.sexPV.dataSource = self;
    
    QCKeyboardView *keyboardView = [[QCKeyboardView alloc]initWithFrame:CGRectMake(0, 0, MSW, 216)];
    
    keyboardView.keyboard = self.sexPV;
    
    keyboardView.delegate = self;
    
    keyboardView.tag = 101;
    
    self.sexTF.inputView = keyboardView;
    
    self.cityTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.sexTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.cityTF.placeholder = @"城市";
    
    self.cityTF.delegate = self;
    
    QCKeyboardView *cityKV = [[QCKeyboardView alloc]initWithFrame:CGRectMake(0, 0, MSW, 216)];
    
    cityKV.delegate = self;
    
    cityKV.tag = 102;
    
    _districtPV = [DistrictPickerView defaultPickerView];
    
    cityKV.keyboard = _districtPV;
    
    self.cityTF.inputView = cityKV;
    
    [tfView addSubview:self.cityTF];
    
    self.wechatTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.cityTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.wechatTF.placeholder = @"微信";
    
    self.wechatTF.delegate = self;
    
    [tfView addSubview:self.wechatTF];
    
    self.introTF = [[QCTextView alloc]initWithFrame:CGRectMake(self.nameTF.left-5, self.wechatTF.bottom, self.nameTF.width+10, Height320(86))];
    
    self.introTF.placeholder = @"个性签名";
    
    [tfView addSubview:self.introTF];
    
    [tfView changeHeight:self.introTF.bottom];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    confirmBtn.frame = CGRectMake(Width320(16), tfView.bottom+Height320(13), MSW-Width320(32), Height320(43));
    
    confirmBtn.backgroundColor = kMainColor;
    
    confirmBtn.titleLabel.font = STFont(16);
    
    confirmBtn.layer.cornerRadius = 2;
    
    confirmBtn.layer.masksToBounds = YES;
    
    [confirmBtn setTitle:@"保 存" forState:UIControlStateNormal];
    
    [confirmBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:confirmBtn];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboadeView
{
    
    if (keyboadeView.tag == 101) {
        self.sexTF.text = self.sexArray[self.sexNum];
        
        [self.sexTF resignFirstResponder];
    }else
    {
        
        self.districtCode = self.districtPV.districtCode;
        
        self.cityTF.text = [DistrictInfo cityForDistrictCode:self.districtCode];
        
        [self.cityTF resignFirstResponder];
        
    }
    
}

-(void)confirm:(UIButton *)btn
{
    
    btn.userInteractionEnabled = NO;
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"请稍候";
    
    [self.hud showAnimated:YES];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:self.imgUrl forKey:@"avatar"];
    
    [para setParameter:self.nameTF.text forKey:@"username"];
    
    [para setParameter:[self.sexTF.text isEqualToString:@"女"]?@"1":@"0" forKey:@"gender"];
    
    [para setParameter:self.introTF.text forKey:@"short_description"];
    
    [para setParameter:self.wechatTF.text forKey:@"weixin"];
    
    if(self.districtCode)
    {
        
        [para setParameter:[NSString stringWithFormat:@"%@",self.districtCode] forKey:@"gd_district_id"];
        
    }
    
    NSString *api = [NSString stringWithFormat:@"%@%ld/",kUserInfo,CoachId];
    
    [MOAFHelp AFPutHost:ROOT bindPath:api putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.hud.label.text = @"修改成功";
            
            self.hud.mode = MBProgressHUDModeText;
            
            [self.hud showAnimated:YES];
            
            [self.hud hideAnimated:YES afterDelay:1.0f];
            
            [[TIMFriendshipManager sharedInstance]SetNickname:self.user.username succ:^{
                
                [[TIMFriendshipManager sharedInstance]SetFaceURL:self.user.iconURL.absoluteString succ:^{
                    
                } fail:^(int code, NSString *msg) {
                    
                }];
                
            } fail:^(int code, NSString *msg) {
                
            }];
            
            [[RootController sharedSliderController]reloadMessageData];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self popViewControllerAndReloadData];
                
            });
            
        }else
        {
            
            self.hud.label.text = responseDic[@"msg"];
            
            self.hud.mode= MBProgressHUDModeText;
            
            [self.hud showAnimated:YES];
            
            [self.hud hideAnimated:YES afterDelay:1.0f];
            
        }
        btn.userInteractionEnabled = YES;
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.hud.label.text = error;
        
        self.hud.mode= MBProgressHUDModeText;
        
        [self.hud showAnimated:YES];
        
        [self.hud hideAnimated:YES afterDelay:1.0f];
        
        btn.userInteractionEnabled = YES;
        
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.nameTF resignFirstResponder];
    
    [self.sexTF resignFirstResponder];
    
    [self.cityTF resignFirstResponder];
    
    [self.wechatTF resignFirstResponder];
    
    [self.introTF resignFirstResponder];
    
}

-(void)changeIcon:(UIButton*)btn
{
    
    [self.nameTF resignFirstResponder];
    
    [self.sexTF resignFirstResponder];
    
    [self.cityTF resignFirstResponder];
    
    [self.wechatTF resignFirstResponder];
    
    [self.introTF resignFirstResponder];
    
    UIActionSheet *actionSheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"修改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    }else{
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"修改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
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

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    self.sexNum = row;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return self.sexArray.count;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
    
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return self.sexArray[row];
    
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
    
    self.imgUrl = [NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url];
    
    [uy uploadImage:self.image savekey:url];
    
}


@end
