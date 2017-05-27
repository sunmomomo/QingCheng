//
//  SuggestController.m
//  健身教练助手
//
//  Created by 馍馍帝😈 on 15/8/14.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import "SuggestController.h"

#import "QCTextField.h"

#import "MOTextView.h"

#import "UpYun.h"

#import <AVFoundation/AVFoundation.h>

#define API @"/api/feedback/"

@interface SuggestController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>

@property(nonatomic,strong)QCTextField *emailTF;

@property(nonatomic,strong)MOTextView *suggestTV;

@property(nonatomic,strong)UIButton *confirmBtn;

@property(nonatomic,strong)UIButton *uploadBtn;

@property(nonatomic,strong)UIImageView *photo;

@property(nonatomic,strong)UIView *photoView;

@property(nonatomic,copy)NSString *urlStr;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation SuggestController

- (void)viewDidLoad {
    
    [super viewDidLoad];
        
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

-(void)createUI
{
    
    self.title = @"意见反馈";
        
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(146.5))];
    
    topView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:topView];
    
    self.emailTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(21.3), 0, MSW-Width320(42.6), Height320(44))];
    
    self.emailTF.textColor = UIColorFromRGB(0x222222);
    
    self.emailTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.emailTF.font = STFont(14);
    
    self.emailTF.placeholder = @"您的邮箱";
    
    self.emailTF.delegate = self;
    
    [topView addSubview:self.emailTF];
    
    self.suggestTV = [[MOTextView alloc]initWithFrame:CGRectMake(Width320(21.3)-5, self.emailTF.bottom, self.emailTF.width+10, topView.height-self.emailTF.height)];
    
    self.suggestTV.placeholder = @"感谢您的意见或建议:）";
    
    self.suggestTV.placeholderColor = UIColorFromRGB(0x999999);
    
    self.suggestTV.textColor = UIColorFromRGB(0x222222);
    
    self.suggestTV.font = STFont(14);
    
    self.suggestTV.delegate = self;
    
    [topView addSubview:self.suggestTV];
    
    self.uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.uploadBtn.frame = CGRectMake(0, topView.bottom+Height320(13.3), MSW, Height320(39));
    
    self.uploadBtn.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.uploadBtn.titleLabel.font = STFont(14);
    
    [self.view addSubview:self.uploadBtn];
    
    UILabel *btnLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(21.3), 0, Width320(100), self.uploadBtn.height)];
    
    btnLabel.text = @"上传图片";
    
    btnLabel.textColor = UIColorFromRGB(0x999999);
    
    btnLabel.font = STFont(16);
    
    [self.uploadBtn addSubview:btnLabel];
    
    UIImageView *btnImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(22.7), 0, Width320(6.7), Height320(10.7))];
    
    btnImg.image = [UIImage imageNamed:@"cellarrow"];
    
    btnImg.center = CGPointMake(btnImg.center.x, self.uploadBtn.height/2);
    
    [self.uploadBtn addSubview:btnImg];
    
    [self.uploadBtn addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
    
    self.photoView = [[UIView alloc]initWithFrame:CGRectMake(0, self.uploadBtn.top, MSW, Height320(84))];
    
    self.photoView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:self.photoView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(21.3), 0, Width320(100), self.photoView.height)];
    
    label.text = @"上传图片";
    
    label.textColor = UIColorFromRGB(0x999999);
    
    label.font = STFont(16);
    
    [self.photoView addSubview:label];
    
    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(22.7), 0, Width320(6.7), Height320(10.7))];
    
    arrow.image = [UIImage imageNamed:@"cellarrow"];
    
    arrow.center = CGPointMake(arrow.center.x, self.photoView.height/2);
    
    [self.photoView addSubview:arrow];
    
    [self.photoView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)]];
    
    self.photo = [[UIImageView alloc]initWithFrame:CGRectMake(arrow.left-Width320(80), Height320(8), Width320(68), Height320(68))];
    
    self.photo.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.photoView addSubview:self.photo];
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.confirmBtn.frame = CGRectMake(Width320(27), self.uploadBtn.bottom+Height320(15.5), MSW-Width320(54), Height320(43));
    
    self.confirmBtn.backgroundColor = kMainColor;
    
    [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.confirmBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    self.confirmBtn.layer.cornerRadius = 2;
    
    self.confirmBtn.layer.masksToBounds = YES;
    
    [self.confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.confirmBtn];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    self.hud.mode = MBProgressHUDModeText;
    
    [self.view addSubview:self.hud];
    
    self.photoView.hidden = YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.emailTF resignFirstResponder];
    
    [self.suggestTV resignFirstResponder];
    
}

-(void)tap:(UITapGestureRecognizer*)tap
{
    
    UIActionSheet *actionSheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"修改照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    }else{
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"修改照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@"从手机相册选择", nil];
        
    }
    
    actionSheet.delegate = self;
    
    actionSheet.tag = 1;
    
    [actionSheet showInView:self.view];
    
    
}

-(void)confirm:(UIButton*)btn
{
    
    if (!self.suggestTV.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请填写建议内容" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }else if (!self.emailTF.text.length){
        
        [[[UIAlertView alloc]initWithTitle:@"请填写邮箱" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    btn.userInteractionEnabled = NO;
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"提交中";
    
    [self.hud showAnimated:YES];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:self.suggestTV.text forKey:@"content"];
    
    [para setParameter:self.emailTF.text forKey:@"email"];
    
    [para setParameter:self.urlStr forKey:@"photo"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:API postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        btn.userInteractionEnabled = YES;
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [self suggestResult:YES andDescription:nil];
            
        }else
        {
            
            [self suggestResult:NO andDescription:responseDic[@"msg"]];
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        btn.userInteractionEnabled = YES;
        
        [self suggestResult:NO andDescription:error];
        
    }];
    
}

-(void)suggestResult:(BOOL)success andDescription:(NSString *)description
{
    
    self.hud.mode = MBProgressHUDModeText;
    
    if (success) {
        
        self.hud.label.text = @"提交成功";
        
        [self.hud showAnimated:YES];
        
        [self.hud hideAnimated:YES afterDelay:1.0f];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
            
        });
        
    }else
    {
        
        self.hud.label.text = description;
        
        [self.hud showAnimated:YES];
        
        [self.hud hideAnimated:YES afterDelay:1.0f];
        
    }
    
}

-(void)uploadImage:(UIButton*)btn
{
    
    UIActionSheet *actionSheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    }else{
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
    
    }
    
    actionSheet.delegate = self;
    
    actionSheet.tag = 0;
    
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSInteger index = buttonIndex-actionSheet.tag;
    
    if (index == -1) {
        
        self.photo.image = nil;
        
        self.urlStr = @"";
        
        self.photoView.hidden = YES;
        
        self.uploadBtn.hidden = NO;
        
        [self.confirmBtn changeTop:self.uploadBtn.bottom+Height320(15.5)];
        
    }
    
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        if(index-actionSheet.tag == 0)
        {
            
            NSString *mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                
                
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"摄像头访问受限，请到设置-隐私-相机中允许健身教练助手访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
            }
            //拍照
            sourceType = UIImagePickerControllerSourceTypeCamera;
        }else if(index == 1)
        {
            //从相册选择
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else
        {
            return;
        }
    }else{
        if (index == 0) {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }else
        {
            return;
        }
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.sourceType = sourceType;
    
    imagePickerController.allowsEditing = YES;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [UIImage imageWithData:UIImageJPEGRepresentation([UIImage fixOrientation:[info objectForKey:UIImagePickerControllerEditedImage]], 0.75)];
    
    UpYun *uy = [[UpYun alloc] init];
    
    NSString *url = [UpYun getSaveKey];
    
    uy.successBlocker = ^(NSURLResponse *response,id data){
        
        self.hud.label.text = @"上传成功";
        
        self.hud.mode = MBProgressHUDModeText;
        
        [self.hud showAnimated:YES];
        
        [self.hud hideAnimated:YES afterDelay:1.0f];
        
        [self.photo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]]];
        
        self.urlStr = [NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url];
        
        self.uploadBtn.hidden = YES;
        
        self.photoView.hidden = NO;
        
        [self.confirmBtn changeTop:self.photoView.bottom+Height320(15.5)];
        
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
    
    [uy uploadImage:image savekey:url];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
