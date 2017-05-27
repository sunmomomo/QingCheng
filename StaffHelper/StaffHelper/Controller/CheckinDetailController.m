//
//  CheckinDetailController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinDetailController.h"

#import "CheckinInfo.h"

#import "UpYun.h"

#import "CheckinPhotoHistoryInfo.h"

#import <AVFoundation/AVFoundation.h>

#import "PictureShowController.h"

@interface CheckinDetailController ()<UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)UIButton *iconView;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UIImageView *sexImg;

@property(nonatomic,strong)UILabel *phoneLabel;

@property(nonatomic,strong)UILabel *cardLabel;

@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)UILabel *chestLabel;

@property(nonatomic,strong)UILabel *checkinTimeLabel;

@property(nonatomic,strong)UILabel *checkinStaffLabel;

@property(nonatomic,strong)UILabel *checkoutTimeLabel;

@property(nonatomic,strong)UILabel *checkoutStaffLabel;

@property(nonatomic,strong)UIImageView *checkoutImg;

@property(nonatomic,strong)UIButton *cancelButton;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation CheckinDetailController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
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
    
    self.title = @"签到详情";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(117))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    self.iconView = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), Height320(14), Width320(50), Height320(50))];
    
    if (self.checkin.student.photo.absoluteString.length) {
        
        [self.iconView sd_setImageWithURL:self.checkin.student.photo forState:UIControlStateNormal];
        
    }else{
        
        [self.iconView setImage:[UIImage imageNamed:@"checkin_photo_add"] forState:UIControlStateNormal];
        
    }
    
    [topView addSubview:self.iconView];
    
    [self.iconView addTarget:self action:@selector(editPhoto) forControlEvents:UIControlEventTouchUpInside];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconView.right+Width320(10), Height320(13), Width320(200), Height320(16))];
    
    self.nameLabel.textColor = UIColorFromRGB(0x333333);
    
    self.nameLabel.font = AllFont(14);
    
    self.nameLabel.text = self.checkin.student.name;
    
    [self.nameLabel autoWidth];

    [topView addSubview:self.nameLabel];
    
    self.sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.nameLabel.right+Width320(5), Height320(15), Width320(12), Height320(12))];
    
    [topView addSubview:self.sexImg];
    
    self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom+Height320(5), MSW-Width320(22)-self.sexImg.right, Height320(14))];
    
    self.phoneLabel.textColor = UIColorFromRGB(0x666666);
    
    self.phoneLabel.font = AllFont(12);
    
    self.phoneLabel.text = [NSString stringWithFormat:@"手机：%@",self.checkin.student.phone];
    
    [topView addSubview:self.phoneLabel];
    
    self.cardLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.left, self.phoneLabel.bottom+Height320(5), self.phoneLabel.width, Height320(14))];
    
    self.cardLabel.textColor = UIColorFromRGB(0x666666);
    
    self.cardLabel.font = AllFont(12);
    
    NSString *remain = @"";
    
    switch (self.checkin.card.cardKind.type) {
            
        case CardKindTypePrepaid:
            
            remain = [NSString stringWithFormat:@"余额：%.0f元",self.checkin.card.remain];
            
            break;
            
        case CardKindTypeCount:
            
            remain = [NSString stringWithFormat:@"余额：%.0f次",self.checkin.card.remain];
            
            break;
            
        case CardKindTypeTime:
            
            remain = [NSString stringWithFormat:@"有效期：%@至%@",[self.checkin.card.start substringToIndex:10],[self.checkin.card.end substringToIndex:10]];
            
            break;
            
        default:
            break;
    }
    
    self.cardLabel.text = [NSString stringWithFormat:@"会员卡：%@（%@）",self.checkin.card.cardKind.cardKindName,remain];
    
    self.cardLabel.numberOfLines = 0;
    
    CGSize cardSize = [self.cardLabel.text boundingRectWithSize:CGSizeMake(MSW-Width320(82), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    [self.cardLabel changeSize:cardSize];
    
    [topView addSubview:self.cardLabel];
    
    [topView changeHeight:self.cardLabel.bottom+Height320(5)];
    
    if (self.checkin.card.cardKind.type != CardKindTypeTime) {
        
        self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.left, self.cardLabel.bottom+Height320(5), self.cardLabel.width, Height320(14))];
        
        self.priceLabel.textColor = UIColorFromRGB(0x666666);
        
        self.priceLabel.font = AllFont(12);
        
        self.priceLabel.text = [NSString stringWithFormat:@"费用：%ld%@",(long)self.checkin.card.cardKind.cost,self.checkin.card.cardKind.type == CardKindTypePrepaid?@"元":@"次"];
        
        [topView addSubview:self.priceLabel];
        
        [topView changeHeight:self.priceLabel.bottom+Height320(5)];
        
    }
    
    if (self.checkin.chest) {
        
        self.chestLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.cardLabel.left, self.priceLabel?self.priceLabel.bottom+Height320(5):self.cardLabel.bottom+Height320(5), self.cardLabel.width, Height320(14))];
        
        self.chestLabel.textColor = UIColorFromRGB(0x666666);
        
        self.chestLabel.font = AllFont(12);
        
        self.chestLabel.text = [NSString stringWithFormat:@"更衣柜号：%@",self.checkin.chest.name];
        
        [topView addSubview:self.chestLabel];
        
        [topView changeHeight:self.chestLabel.bottom+Height320(5)];
        
    }
    
    UIView *checkView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Width320(12), MSW, Height320(101))];
    
    checkView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    checkView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    checkView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:checkView];
    
    UIImageView *checkinImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(17), Width320(16), Height320(16))];
    
    checkinImg.image = [[UIImage imageNamed:@"checkin_button"]imageWithTintColor:UIColorFromRGB(0x56C981)];
    
    [checkView addSubview:checkinImg];
    
    self.checkoutImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(68), Width320(16), Height320(16))];
    
    self.checkoutImg.image = [[UIImage imageNamed:@"checkout_button"] imageWithTintColor:UIColorFromRGB(0xFBBF95)];
    
    [checkView addSubview:self.checkoutImg];
    
    self.checkinTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(42), Height320(9), MSW-Width320(54), Height320(14))];
    
    self.checkinTimeLabel.textColor = UIColorFromRGB(0x333333);
    
    self.checkinTimeLabel.font = AllFont(12);
    
    self.checkinTimeLabel.text = [NSString stringWithFormat:@"签到时间：%@",self.checkin.createTime];
    
    [checkView addSubview:self.checkinTimeLabel];
    
    if (self.checkin.checkinStaff) {
        
        self.checkinStaffLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(42), self.checkinTimeLabel.bottom+Height320(4), self.checkinTimeLabel.width, Height320(14))];
        
        self.checkinStaffLabel.text = [NSString stringWithFormat:@"操作员：%@",self.checkin.checkinStaff.name.length?self.checkin.checkinStaff.name:@""];
        
        self.checkinStaffLabel.textColor = UIColorFromRGB(0x999999);
        
        self.checkinStaffLabel.font = AllFont(12);
        
        [checkView addSubview:self.checkinStaffLabel];
        
    }else{
        
        [self.checkinTimeLabel changeTop:Height320(18)];
        
    }
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(42), Height320(50), MSW-Width320(42), 1/[UIScreen mainScreen].scale)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [checkView addSubview:sep];
    
    self.checkoutTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(42), Height320(60), self.checkinTimeLabel.width, Height320(14))];
    
    self.checkoutTimeLabel.font = AllFont(12);
    
    if (self.checkin.checkoutTime) {
        
        self.checkoutTimeLabel.text = [NSString stringWithFormat:@"签出时间：%@",self.checkin.checkoutTime];
        
        self.checkoutTimeLabel.textColor = UIColorFromRGB(0x333333);
        
        self.checkoutImg.image = [[UIImage imageNamed:@"checkout_button"] imageWithTintColor:UIColorFromRGB(0xFBBF95)];
        
        if (!self.checkin.checkinStaff) {
            
            [self.checkoutTimeLabel changeTop:Height320(69)];
            
        }else{
            
            self.checkoutStaffLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(42), self.checkoutTimeLabel.bottom+Height320(4), self.checkoutTimeLabel.width, Height320(14))];
            
            self.checkoutStaffLabel.text = [NSString stringWithFormat:@"操作员：%@",self.checkin.checkoutStaff.name.length?self.checkin.checkoutStaff.name:@""];
            
            self.checkoutStaffLabel.textColor = UIColorFromRGB(0x999999);
            
            self.checkoutStaffLabel.font = AllFont(12);
            
            [checkView addSubview:self.checkoutStaffLabel];
            
        }
        
    }else{
        
        [self.checkoutTimeLabel changeTop:Height320(69)];
        
        self.checkoutTimeLabel.text = @"暂未签出";
        
        self.checkoutTimeLabel.textColor = UIColorFromRGB(0x999999);
        
        self.checkoutImg.image = [[UIImage imageNamed:@"checkout_button"] imageWithTintColor:UIColorFromRGB(0x999999)];
        
    }
    
    [checkView addSubview:self.checkoutTimeLabel];
    
    self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, checkView.bottom+Height320(12), MSW, Height320(40))];
    
    self.cancelButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.cancelButton.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    self.cancelButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    [self.cancelButton setTitle:self.checkin.canceled?@"已撤销":@"撤 销" forState:UIControlStateNormal];
    
    [self.cancelButton setTitleColor:self.checkin.canceled?UIColorFromRGB(0x999999):UIColorFromRGB(0xEA6161) forState:UIControlStateNormal];
 
    self.cancelButton.titleLabel.font = AllFont(14);
    
    [self.view addSubview:self.cancelButton];
    
    if (!self.checkin.canceled) {
        
        [self.cancelButton addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)cancelClick:(UIButton*)button
{
    
    if ([PermissionInfo sharedInfo].permissions.checkinPermission.deleteState) {
        
        [[[UIAlertView alloc]initWithTitle:@"确定要撤销签到吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil]show];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        CheckinInfo *info = [[CheckinInfo alloc]init];
        
        [info cancelCheckin:self.checkin result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
                
                [self.view addSubview:hud];
                
                hud.mode = MBProgressHUDModeText;
                
                hud.label.text = @"撤销成功";
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
                [self.cancelButton setTitle:@"已撤销" forState:UIControlStateNormal];
                
                [self.cancelButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
                
                [self.cancelButton removeTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
                
                for (MOViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([NSStringFromClass([vc class]) isEqualToString:@"CheckinHistoryController"]) {
                        
                        [vc reloadData];
                        
                    }
                    
                }
                
            }else{
                
                MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
                
                [self.view addSubview:hud];
                
                hud.mode = MBProgressHUDModeText;
                
                hud.label.text = error;
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}

-(void)editPhoto
{
    
    if (self.checkin.student.photo.absoluteString.length) {
        
        PictureShowController *svc = [[PictureShowController alloc]init];
        
        svc.imageURL = self.checkin.student.photo;
        
        [self presentViewController:svc animated:YES completion:nil];
        
        return;
        
    }
    
    if ([PermissionInfo sharedInfo].permissions.userPermission.editState||[PermissionInfo sharedInfo].permissions.personalUserPermission.editState) {
        
        UIActionSheet *actionSheet;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传会员照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
        }else{
            actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传会员照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
        }
        actionSheet.delegate = self;
        [actionSheet showInView:self.view];
        
    }else{
        
        [self showNoPermissionAlert];
        
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
    
    [self uploadImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)uploadImage
{
    
    UpYun *uy = [[UpYun alloc] init];
    
    uy.successBlocker = ^(NSURLResponse *response,id data){
        
        CheckinPhotoHistoryInfo *info = [[CheckinPhotoHistoryInfo alloc]init];
        
        [info uploadPhoto:self.checkin.student.photo.absoluteString student:self.checkin.student result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                [self reloadData];
                
                self.hud.label.text = @"上传成功";
                
                self.hud.mode = MBProgressHUDModeText;
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.0f];
                
                [self.iconView sd_setImageWithURL:self.checkin.student.photo forState:UIControlStateNormal];
                
            }else{
                
                self.checkin.student.photo = nil;
                
                self.hud.label.text = error;
                
                self.hud.label.numberOfLines = 0;
                
                self.hud.mode = MBProgressHUDModeText;
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.0f];
                
            }
            
        }];
        
    };
    
    uy.failBlocker = ^(NSError *error){
        
        self.hud.label.text = @"上传图片失败";
        
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
    
    self.checkin.student.photo = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
    
    [uy uploadImage:self.image savekey:url];
    
}

@end
