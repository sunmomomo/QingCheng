//
//  GuideCourseController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideCourseController.h"

#import "GuidePlanController.h"

#import <AVFoundation/AVFoundation.h>

#import "QCTextField.h"

#import "QCKeyboardView.h"

#import "Course.h"

#import "UpYun.h"

#import "MOPickerView.h"

#import "KeyboardManager.h"

@interface GuideCourseController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIAlertViewDelegate,QCKeyboardViewDelegate>

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UIView *courseEditView;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *duringTF;

@property(nonatomic,strong)QCTextField *capacityTF;

@property(nonatomic,strong)UIButton *confirmButton;

@property(nonatomic,strong)Course *course;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation GuideCourseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createData];
   
    [self createUI];
    
    [self reloadData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadData
{
    
    if (self.course.imgUrl.absoluteString.length) {
        
        if (self.course.imgUrl.absoluteString) {
            
            if ([self.course.imgUrl.absoluteString rangeOfString:@"!"].length) {
                
                [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.course.imgUrl.absoluteString]];
                
            }else{
                
                if ([self.course.imgUrl.absoluteString rangeOfString:@"!/watermark/"].length) {
                    
                    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!small/watermark/%@",[[self.course.imgUrl.absoluteString componentsSeparatedByString:@"!/watermark/"]firstObject],[[self.course.imgUrl.absoluteString componentsSeparatedByString:@"!/watermark/"]lastObject]]]];
                    
                }else if ([_course.imgUrl.absoluteString rangeOfString:@"/watermark/"].length){
                    
                    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.course.imgUrl.absoluteString]];
                    
                }else{
                    
                    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[self.course.imgUrl.absoluteString stringByAppendingString:@"!small"]]];
                    
                }
                
            }
            
        }
        
    }else{
        
        self.iconView.image = [UIImage imageNamed:@"cameraplaceholder"];
        
    }
    
    self.nameTF.text = self.course.name;
    
    if (self.course.during) {
        
        self.duringTF.text = [NSString stringWithFormat:@"%ld",(long)self.course.during];
        
    }
    
    if (self.course.capacity) {
        
        self.capacityTF.text = [NSString stringWithFormat:@"%ld",(long)self.course.capacity];
        
    }
    
    [self check];
    
}

-(void)createData
{
    
    self.course = ((AppDelegate*)[UIApplication sharedApplication].delegate).course;
    
}

-(void)createUI
{
    
    self.title = @"新建健身房";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIImageView *guideImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(16)+64, MSW-Width320(42), Height320(42))];
    
    guideImg.image = [UIImage imageNamed:@"guide_step_2"];
    
    guideImg.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:guideImg];
    
    UILabel *guideLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, guideImg.bottom+Height320(20), MSW, Height320(17))];
    
    guideLabel.text = self.course.type==CourseTypeGroup?@"— 添加团课种类 —":@"— 添加私教种类 —";
    
    guideLabel.textColor = UIColorFromRGB(0x999999);
    
    guideLabel.textAlignment = NSTextAlignmentCenter;
    
    guideLabel.font = AllFont(14);
    
    [self.view addSubview:guideLabel];
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, guideLabel.bottom+Height320(12), MSW, Height320(192))];
    
    self.topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.topView.layer.borderWidth = OnePX;
    
    self.topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:self.topView];
    
    UIButton *iconButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(72))];
    
    iconButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    iconButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    iconButton.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.topView addSubview:iconButton];
    
    [iconButton addTarget:self action:@selector(cameraClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(100), Height320(72))];
    
    topLabel.text = @"课程图片";
    
    topLabel.textColor = UIColorFromRGB(0x999999);
    
    topLabel.font = AllFont(14);
    
    topLabel.userInteractionEnabled = NO;
    
    [iconButton addSubview:topLabel];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(77), Height320(12), Width320(48), Height320(48))];
    
    self.iconView.layer.borderWidth = 1;
    
    self.iconView.userInteractionEnabled = NO;
    
    self.iconView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
    
    [iconButton addSubview:self.iconView];
    
    UIImageView *topArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.4), Height320(30), Width320(7.4), Height320(12))];
    
    topArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [iconButton addSubview:topArrow];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), Height320(72)-OnePX, MSW, OnePX)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [iconButton addSubview:sep];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), Height320(72), MSW-Width320(32), Height320(40))];
    
    self.nameTF.placeholder = @"名称";
    
    self.nameTF.mustInput = YES;
    
    self.nameTF.textPlaceholder = @"填写课程名称";
    
    self.nameTF.delegate = self;
    
    [self.nameTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [self.topView addSubview:self.nameTF];
    
    self.duringTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.duringTF.placeholder = @"时长（分钟）";
    
    self.duringTF.mustInput = YES;
    
    self.duringTF.textPlaceholder = @"填写课程时长";
    
    self.duringTF.delegate = self;
    
    self.duringTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.duringTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [self.topView addSubview:self.duringTF];
    
    self.capacityTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.duringTF.left, self.duringTF.bottom, self.duringTF.width, self.duringTF.height)];
    
    self.capacityTF.placeholder = @"单节课可约人数";
    
    self.capacityTF.mustInput = YES;
    
    self.capacityTF.textPlaceholder = @"填写人数";
    
    self.capacityTF.delegate = self;
    
    self.capacityTF.noLine = YES;
    
    self.capacityTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.capacityTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [self.topView addSubview:self.capacityTF];
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), self.topView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    self.confirmButton.backgroundColor = kMainColor;
    
    self.confirmButton.layer.cornerRadius = 2;
    
    [self.confirmButton setTitle:@"下一步" forState:UIControlStateNormal];
    
    [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [self.confirmButton addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.confirmButton];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)confirmClick
{
    
    [MOAppDelegate saveCourse];
    
    GuidePlanController *svc = [[GuidePlanController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    if (textField == self.nameTF) {
        
        self.course.name = self.nameTF.text;
        
    }else if (textField == self.duringTF){
        
        self.course.during = [self.duringTF.text integerValue];
        
    }else if (textField == self.capacityTF){
        
        self.course.capacity = [self.capacityTF.text integerValue];
        
    }
    
    [self check];
    
}

-(void)check
{
    
    if (self.course.type == CourseTypePrivate) {
        
        [self.topView changeHeight:Height320(152)];
        
        [self.confirmButton changeTop:self.topView.bottom+Height320(12)];
        
        self.course.capacity = 0;
        
        self.capacityTF.text = @"";
        
        self.duringTF.noLine = YES;
        
        self.capacityTF.hidden = YES;
        
        self.confirmButton.alpha = self.nameTF.text.length&&self.duringTF.text.length?1:0.4;
        
        self.confirmButton.userInteractionEnabled = self.nameTF.text.length;
        
    }else{
        
        [self.topView changeHeight:Height320(192)];
        
        [self.confirmButton changeTop:self.topView.bottom+Height320(12)];
        
        self.duringTF.noLine = NO;
        
        self.capacityTF.hidden = NO;
        
        self.confirmButton.alpha = self.nameTF.text.length&&self.duringTF.text.length && self.capacityTF.text.length?1:0.4;
        
        self.confirmButton.userInteractionEnabled = self.nameTF.text.length;
        
    }
    
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
    
    self.course.imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
    
    [uy uploadImage:self.image savekey:url];
    
}

@end
