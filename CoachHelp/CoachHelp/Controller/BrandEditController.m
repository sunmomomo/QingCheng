//
//  BrandEditController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "BrandEditController.h"

#import "QCTextField.h"

#import "UpYun.h"

#import "MOCell.h"

#import <AVFoundation/AVFoundation.h>

#import "BrandListInfo.h"

@interface BrandEditController ()<UIAlertViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation BrandEditController

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
    
    
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.title = @"编辑品牌信息";
    
    self.rightTitle = @"确定";
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(72)+Height320(40))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:topView];
    
    UIButton *topButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(72))];
    
    [topView addSubview:topButton];
    
    [topButton addTarget:self action:@selector(cameraClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(120), topButton.height)];
    
    topLabel.text = @"品牌logo";
    
    topLabel.textColor = UIColorFromRGB(0x999999);
    
    topLabel.font = AllFont(14);
    
    topLabel.userInteractionEnabled = NO;
    
    [topButton addSubview:topLabel];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(77), Height320(12), Width320(48), Height320(48))];
    
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    self.iconView.layer.borderWidth = 1;
    
    self.iconView.userInteractionEnabled = NO;
    
    self.iconView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
    
    [self.iconView sd_setImageWithURL:self.brand.imgURL];
    
    [topView addSubview:self.iconView];
    
    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(self.iconView.right+Width320(6), Height320(30), Width320(7.5), Height320(12))];
    
    arrow.image = [UIImage imageNamed:@"cellarrow"];
    
    [topView addSubview:arrow];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), topButton.bottom-1/[UIScreen mainScreen].scale, MSW-Width320(32), 1/[UIScreen mainScreen].scale)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [topView addSubview:sep];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), topButton.bottom, MSW-Width320(32), Height320(40))];
    
    self.nameTF.placeholder = @"品牌名";
    
    self.nameTF.text = self.brand.name;
    
    self.nameTF.delegate = self;
    
    self.nameTF.textColor = UIColorFromRGB(0x666666);
    
    [topView  addSubview:self.nameTF];
    
    UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(12), MSW, Height320(40))];
    
    deleteButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    deleteButton.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    deleteButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    [deleteButton setTitle:@"删除该品牌" forState:UIControlStateNormal];
    
    [deleteButton setTitleColor:kDeleteColor forState:UIControlStateNormal];
    
    deleteButton.titleLabel.font = AllFont(14);
    
    [self.view addSubview:deleteButton];
    
    [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)deleteClick
{
    
    [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"请联系青橙客服\n%@",QCPhone] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫",nil]show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",QCPhone]]];
        
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
    
    self.brand.imgURL =  [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
    
    [uy uploadImage:self.image savekey:url];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)naviRightClick
{
    
    if (!self.nameTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请输入品牌名" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"";
    
    [self.hud showAnimated:YES];
    
    self.brand.name = self.nameTF.text;
    
    BrandListInfo *info = [[BrandListInfo alloc]init];
    
    [info changeBrand:self.brand result:^(BOOL success, NSString *error) {
        
        if (success) {
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = @"修改成功";
            
            [self.hud hideAnimated:YES afterDelay:1.5];
            
            for (MOViewController *vc in self.navigationController.viewControllers) {
                
                if ([NSStringFromClass([vc class]) isEqualToString:@"HomeController"]) {
                    
                    [vc reloadData];
                    
                }
                
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self popViewControllerAndReloadData];
                
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

@end
