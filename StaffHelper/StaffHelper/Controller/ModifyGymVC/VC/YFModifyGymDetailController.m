//
//  YFModifyGymDetailController.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/6.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFModifyGymDetailController.h"

#import "QCTextField.h"

#import "Gym.h"

#import "GuideAddressController.h"

#import "GuideSummaryController.h"

#import "GuideCourseTypeController.h"

#import "UpYun.h"

#import <AVFoundation/AVFoundation.h>

#import "LoginController.h"

#import "WebViewController.h"

#import "ServicesInfo.h"

#import "LoginController.h"

#import "BPush.h"

#import "GuideInfo.h"

#import "RootController.h"

#import "BrandDetailInfo.h"

#import "YFHttpService+Extension.h"

#import "Parameters+YFExtension.h"

#import "NSMutableDictionary+YFExtension.h"

#import "UIView+YFLoadingView.h"

#import "UIView+YFLoadAniView.h"

#define HelpURL @"/mobile/gym/guide/"

#define ModifyGymURL @"/api/staffs/%ld/services/%ld/"

@interface YFModifyGymDetailController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *addressTF;

@property(nonatomic,strong)QCTextField *contactTF;

@property(nonatomic,strong)QCTextField *summaryTF;

@property(nonatomic,strong)UIView *fillView;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

// 修改时 用到
@property(nonatomic, copy)NSString *lat;

@property(nonatomic, copy)NSString *lng;
@end

@implementation YFModifyGymDetailController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
}

-(void)createUI
{
   self.title = @"场馆信息";
    
   self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
   self.rightTitle = @"保存";
    
    UIScrollView *mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:mainView];
    

    UIButton *secView = [[UIButton alloc]initWithFrame:CGRectMake(0, Height320(12), MSW, Height320(232))];
    
    secView.backgroundColor = UIColorFromRGB(0xffffff);
    
    secView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    secView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [mainView addSubview:secView];
    
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
    
    // 场馆图片
    [self.iconView sd_setImageWithURL:self.gym.imgUrl];
    
    [iconButton addSubview:self.iconView];
    
    UIImageView *secArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.4), Height320(30), Width320(7.4), Height320(12))];
    
    secArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [iconButton addSubview:secArrow];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), Height320(72)-OnePX, MSW-Width320(32), OnePX)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [iconButton addSubview:sep];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), Height320(72), MSW-Width320(32), Height320(40))];
    
    self.nameTF.placeholder = @"场馆名称（店名）";
    
    self.nameTF.textColor = UIColorFromRGB(0x666666);
    
    self.nameTF.font = AllFont(14);
    
    self.nameTF.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.nameTF.delegate = self;
    
    self.nameTF.returnKeyType = UIReturnKeyDone;
    
    self.nameTF.text = self.gym?self.gym.name:@"";
    
    self.nameTF.mustInput = YES;
    
    [self.nameTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [secView addSubview:self.nameTF];
    
    self.addressTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.addressTF.placeholder = @"地址";
    
    self.addressTF.mustInput = YES;
    
    self.addressTF.delegate = self;
//    
//    if (self.gym.gd_district.city.name.length) {
//        
//        self.addressTF.text = [NSString stringWithFormat:@"%@%@%@",self.gym.gd_district.province.name,self.gym.gd_district.city.name,self.gym.address.length?self.gym.address:@""];
//        
//    }
    
    self.addressTF.text = self.gym.address.length?self.gym.address:@"";
    
    [secView addSubview:self.addressTF];
    
    self.contactTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.addressTF.left, self.addressTF.bottom, self.addressTF.width, self.addressTF.height)];
    
    self.contactTF.placeholder = @"联系方式";
    
    self.contactTF.mustInput = YES;
    
    self.contactTF.delegate = self;
    
    if (self.gym.contact.length) {
        
        self.contactTF.text = self.gym.contact;
        
    }
    
    [self.contactTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [secView addSubview:self.contactTF];
    
    self.summaryTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.addressTF.left, self.contactTF.bottom, self.addressTF.width, self.addressTF.height)];
    
    self.summaryTF.placeholder = @"描述下您的健身房";
    
    self.summaryTF.delegate = self;
    
    self.summaryTF.noLine = YES;
    
    [secView addSubview:self.summaryTF];
    
    UIView *fillView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(64), self.summaryTF.height)];
    
    self.summaryTF.rightView = fillView;
    
    UILabel *fillLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width320(56), fillView.height)];
    
    fillLabel.text = @"已填写";
    
    fillLabel.textColor = UIColorFromRGB(0xaaaaaa);
    
    fillLabel.textAlignment = NSTextAlignmentCenter;
    
    fillLabel.font = AllFont(14);
    
    [fillView addSubview:fillLabel];
    
    UIImageView *fillImg = [[UIImageView alloc]initWithFrame:CGRectMake(fillLabel.right, 0, Width320(7.4), Height320(12))];
    
    fillImg.image = [UIImage imageNamed:@"gray_arrow"];
    
    fillImg.center = CGPointMake(fillImg.center.x, fillView.height/2);
    
    [fillView addSubview:fillImg];
    
    if (self.gym.summary.length) {
        
        self.summaryTF.rightViewMode = UITextFieldViewModeAlways;
        
    }
    
    mainView.contentSize = CGSizeMake(0, secView.bottom+Height320(14));
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    [self check];
    
}

-(void)help
{
    
    NSString *api = [NSString stringWithFormat:@"%@%@",ROOT,HelpURL];
    
    WebViewController *svc = [[WebViewController alloc]init];
    
    svc.url = [NSURL URLWithString:api];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    // 这代表是从 会员模块的 场馆信息页进来的
    if (self.gym.gymId == AppGym.gymId)
    {
        if (![PermissionInfo sharedInfo].permissions.studioPermission.editState) {
            
            [self showNoPermissionAlert];
            return NO;
        }
    }

    if (textField == self.addressTF) {
        
        GuideAddressController *svc = [[GuideAddressController alloc]init];
        
        svc.gym = [self.gym copy];
        
        __weak typeof(self)weakS = self;
        
        __weak typeof(svc)weakAddVC = svc;
        
        svc.fillFinish = ^(Gym *gym){
            
            
            weakS.gym.city = gym.city;
            
            weakS.gym.districtCode = gym.districtCode;
            
            
            
            weakS.gym.address = gym.address;
            
            weakS.addressTF.text = [NSString stringWithFormat:@"%@",weakS.gym.address.length?weakS.gym.address:@""];
            
            weakS.lat = weakAddVC.lat;
            
            weakS.lng = weakAddVC.lng;
            
            [weakS check];
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
        return NO;
        
    }else if(textField == self.summaryTF){
        
        GuideSummaryController *svc = [[GuideSummaryController alloc]init];
        
        svc.gym = [self.gym copy];
        
        __weak typeof(self)weakS = self;
        
        svc.fillFinish = ^(Gym *gym){
            
            weakS.gym.summary = gym.summary;
            
            if (weakS.gym.summary.length) {
                
                weakS.summaryTF.rightViewMode = UITextFieldViewModeAlways;
                
            }else
            {
                weakS.summaryTF.rightViewMode = UITextFieldViewModeNever;
            }
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
        return NO;
        
    }else
    {
        
        return YES;
        
    }
    
}

-(void)textFieldDidChanged:(UITextField*)textField
{
    
    [self check];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    [self check];
    
    return YES;
    
}

-(void)check
{
    
    if (self.nameTF.text.length && self.addressTF.text.length && self.contactTF.text.length) {
        
        self.navi.rightButton.alpha = 1.0;
        
         self.navi.rightButton.userInteractionEnabled = YES;
        
    }else
    {
        
        self.navi.rightButton.alpha = 0.4;
        
         self.navi.rightButton.userInteractionEnabled = NO;
        
    }
    
}

-(void)naviRightClick
{
    
    [self.view endEditing:YES];
 
    
    // 这代表是从 会员模块的 场馆信息页进来的
    if (self.gym.gymId == AppGym.gymId)
    {
        if (![PermissionInfo sharedInfo].permissions.studioPermission.editState) {
            
            [self showNoPermissionAlert];
            return;
        }
    }

    if (self.nameTF.text.length == 0)
    {
        
        return;
    }
    
     self.navi.rightButton.userInteractionEnabled = NO;
    
    self.gym.name = self.nameTF.text;
    
    self.gym.contact = self.contactTF.text;
    
    Parameters *param = [Parameters instanceYF];
    /*
    "photo", "name", "description", "address",
    "gd_district_id", "contact", "gd_lng", "gd_lat"
    */
    
    [param setParameter:self.gym.imgUrl.absoluteString forKey:@"photo"];
    //
    [param setParameter:self.gym.name forKey:@"name"];

    [param setParameter:self.gym.summary forKey:@"description"];

    [param setParameter:self.addressTF.text forKey:@"address"];

    [param.data setStringLengthNotZero_FY:self.gym.contact toKey:@"contact"];
    
    [param.data setStringLengthNotZero_FY:self.gym.districtCode toKey:@"gd_district_id"];
    
    [param.data setObject_FY:self.lng forKey:@"gd_lng"];
    
    [param.data setObject_FY:self.lat forKey:@"gd_lat"];
    
    NSString *urlString =  [NSString stringWithFormat:ModifyGymURL,StaffId,(long)self.gym.gymId];
    urlString = [NSString stringWithFormat:@"%@%@",ROOT,urlString];
        weakTypesYF
    [self.view setLoadViewOffsetNavi];
    [YFHttpService putSuccessOrFail:urlString parameters:param.data modelClass:nil showLoadingOnView:self.view success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoDataModel * _Nullable dataModel) {
        
        [weakS.view showHint:@"保存成功"];
       
        [weakS.origingym copyGymWhenMOdifySUccessGym:weakS.gym];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kModifyGymDetailIdtifierYF object:nil];
        
        weakS.navi.rightButton.userInteractionEnabled = YES;

        if (weakS.modifySuccess)
        {
            weakS.modifySuccess(nil);
        }else
        {
            [weakS.view showHint:@"保存成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakS.navigationController popViewControllerAnimated:YES];
            });
            
        }
    } failure:^(NSError * _Nullable error) {
        weakS.navi.rightButton.userInteractionEnabled = YES;
        
    }];
    
//    __weak typeof(self)weakS = self;
    
//    [GuideInfo uploadCourse:MOAppDelegate.course result:^(BOOL success,NSString *error,Gym *gym) {
//        
//        if (success) {
//            
//            self.hud.mode = MBProgressHUDModeText;
//            
//            self.hud.label.text = @"创建成功";
//            
//            [self.hud hideAnimated:YES afterDelay:1.5f];
//            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                
//                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"course"];
//                
//                [[NSUserDefaults standardUserDefaults]synchronize];
//                
//                AppGym = gym;
//                
//                AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//                
//                [[RootController sharedSliderController]createDataResult:^{
//                    
//                    appDelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[RootController sharedSliderController]];
//                    
//                    [[RootController sharedSliderController] firstIn];
//                    
//                }];
//                
//            });
//            
//        }else
//        {
//            
//             self.navi.rightButton.userInteractionEnabled = YES;
//            
//            [weakS errorWithMsg:error];
//            
//        }
//        
//    }];
    
}

-(void)cameraClick
{
    
    [self.view endEditing:YES];
    
    UIActionSheet *actionSheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传场馆图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    }else{
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传场馆图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
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
    
    self.gym.image = [UIImage fixOrientation:[info objectForKey:UIImagePickerControllerEditedImage]];
    
    [self.iconView setImage:self.gym.image];
    
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
    
    [uy uploadImage:self.gym.image savekey:url];
    
}


-(void)errorWithMsg:(NSString *)msg
{
    
    self.hud.mode = MBProgressHUDModeText;
    
    self.hud.label.text = msg;
    
    self.hud.label.numberOfLines = 0;
    
    [self.hud showAnimated:YES];
    
    [self.hud hideAnimated:YES afterDelay:1.5f];
    
}

@end
