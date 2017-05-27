//
//  GuideAddCoachController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideAddCoachController.h"

#import "QCKeyboardView.h"

#import "QCTextField.h"

#import "MOPickerView.h"

#import "UpYun.h"

#import "CountryChooseTextField.h"

#import <AVFoundation/AVFoundation.h>

@interface GuideAddCoachController ()<UITextFieldDelegate,QCKeyboardViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)Coach *coach;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *sexTF;

@property(nonatomic,strong)MOPickerView *sexPV;

@property(nonatomic,strong)NSArray *sexArray;

@property(nonatomic,strong)CountryChooseTextField *phoneTF;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UIButton *confirmButton;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation GuideAddCoachController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.coach = [[Coach alloc]init];
        
        self.sexArray = @[@"男",@"女"];
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    
    self.title = @"添加新教练";
    
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
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(77), Height320(12), Width320(48), Height320(48))];
    
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    self.iconView.layer.borderWidth = 1;
    
    self.iconView.userInteractionEnabled = NO;
    
    self.iconView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
    
    if (self.coach.iconUrl.absoluteString.length) {
        
        [self.iconView sd_setImageWithURL:self.coach.iconUrl];
        
    }else
    {
        
        self.iconView.image = [UIImage imageNamed:self.coach.sex == SexTypeMan?@"img_default_teacher_male":@"img_default_teacher_female"];
        
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
    
    [secondView addSubview:self.nameTF];
    
    [self.nameTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.sexTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.sexTF.placeholder = @"性别";
    
    self.sexTF.delegate = self;
    
    self.sexTF.text = @"男";
    
    [secondView addSubview:self.sexTF];
    
    QCKeyboardView *keyboard = [QCKeyboardView defaultKeboardView];
    
    keyboard.delegate = self;
    
    self.sexTF.inputView = keyboard;
    
    self.sexPV = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 37, MSW, 177)];
    
    self.sexPV.titleArray = self.sexArray;
    
    keyboard.keyboard = self.sexPV;
    
    self.phoneTF = [[CountryChooseTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.sexTF.bottom, self.nameTF.width, self.nameTF.height)];

    self.phoneTF.textPlaceholder = @"请填写手机号";

    self.phoneTF.delegate = self;
    
    self.phoneTF.mustInput = YES;
    
    self.phoneTF.noLine = YES;
    
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.phoneTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [secondView addSubview:self.phoneTF];
    
     self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), secondView.bottom+Height320(12), MSW-Width320(32), Height320(44))];
    
    self.confirmButton.backgroundColor = kMainColor;
    
    self.confirmButton.layer.cornerRadius = 2;
    
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    self.confirmButton.titleLabel.font = AllFont(14);
    
    [self.confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.confirmButton];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    [self check];
    
}

-(void)chooseCountry:(CountryPhone *)country
{
    
    self.phoneTF.placeholder = [NSString stringWithFormat:@"%@ %@",country.name,country.countryNo];
    
}

-(void)check
{
    
    if (self.nameTF.text.length&&self.phoneTF.text.length) {
        
        self.confirmButton.backgroundColor = kMainColor;
        
        self.confirmButton.userInteractionEnabled = YES;
        
    }else
    {
        
        self.confirmButton.backgroundColor = [kMainColor colorWithAlphaComponent:0.3];
        
        self.confirmButton.userInteractionEnabled = NO;
        
    }
    
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
    
    [self.sexTF resignFirstResponder];
    
    self.sexTF.text = self.sexArray[self.sexPV.currentRow];
    
    self.coach.sex = [self.sexArray indexOfObject:self.sexTF.text];
    
    if (!self.coach.iconUrl.absoluteString.length) {
        
        self.iconView.image = [UIImage imageNamed:self.coach.sex == SexTypeMan?@"img_default_teacher_male":@"img_default_teacher_female"];
        
    }
    
}

-(void)textFieldDidChanged:(UITextField*)textField
{
    
    if (textField == self.nameTF) {
        
        self.coach.name = self.nameTF.text;
        
    }
    
    if (textField == self.phoneTF) {
        
        self.coach.phone = self.phoneTF.text;
        
    }
    
    [self check];
    
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
    
    if (![pred evaluateWithObject:self.phoneTF.text]) {
        
        [[[UIAlertView alloc]initWithTitle:@"请输入正确的手机号" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    for (Coach *coach in MOAppDelegate.course.coaches) {
        
        if ([coach.phone isEqualToString:self.phoneTF.text]) {
            
            [[[UIAlertView alloc]initWithTitle:@"已存在该手机号的教练" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
    }
    
    if (self.nameTF.text.length && self.phoneTF.text.length) {
        
        self.coach.country = self.phoneTF.country;
        
        AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        
        NSMutableArray *array = delegate.course.coaches;
        
        [array addObject:self.coach];
        
        if (self.addSuccess) {
            self.addSuccess();
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

-(void)cameraClick
{
    
    [self.nameTF resignFirstResponder];
    
    [self.sexTF resignFirstResponder];
    
    [self.phoneTF resignFirstResponder];
    
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
    
    self.coach.iconUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
    
    [uy uploadImage:self.image savekey:url];
    
}


@end
