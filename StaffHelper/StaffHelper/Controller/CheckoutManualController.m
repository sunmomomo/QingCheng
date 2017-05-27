//
//  CheckoutManualController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckoutManualController.h"

#import "CheckoutCell.h"

#import "CheckoutInfo.h"

#import "CheckSuccessView.h"

#import "UpYun.h"

#import "CheckinPhotoHistoryInfo.h"

#import <AVFoundation/AVFoundation.h>

#import "PictureShowController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CheckoutManualController ()<UITableViewDelegate,MOTableViewDatasource,CheckoutCellDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)CheckoutInfo *info;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)Student *student;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation CheckoutManualController

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
    
    self.info = [[CheckoutInfo alloc]init];
    
    [self.info requestWithStudent:self.stu result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)reloadData
{
    
    [self.info requestWithStudent:self.stu result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"手动签出";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[CheckoutCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(20))];
    
    self.tableView.tableHeaderView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/2-Width320(15), Height320(70), Width320(30), Height320(30))];
    
    emptyImg.image = [UIImage imageNamed:@"empty_nosignout"];
    
    [view addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(18), MSW, Height320(17))];
    
    emptyLabel.text = @"该会员暂无可签出的记录";
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(13);
    
    [view addSubview:emptyLabel];
    
    return view;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Checkout *checkout = self.info.checkouts[indexPath.row];
    
    NSString *str = [NSString stringWithFormat:@"会员卡：%@",checkout.card.cardKind.cardKindName];
    
    NSString *remain = @"";
    
    switch (checkout.card.cardKind.type) {
            
        case CardKindTypePrepaid:
            
            remain = [NSString stringWithFormat:@"余额：%.0f元",checkout.card.remain];
            
            break;
            
        case CardKindTypeCount:
            
            remain = [NSString stringWithFormat:@"余额：%.0f次",checkout.card.remain];
            
            break;
            
        case CardKindTypeTime:
            
            remain = [NSString stringWithFormat:@"有效期：%@-%@",[checkout.card.start substringToIndex:10],[checkout.card.end substringToIndex:10]];
            
            break;
            
        default:
            break;
    }
    
    NSString *cardString = [NSString stringWithFormat:@"%@（%@）",str,remain];
    
    CGSize cardSize = [cardString boundingRectWithSize:CGSizeMake(MSW-Width320(82), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    if (checkout.chest) {
        
        return checkout.card.cardKind.type == CardKindTypeTime?Height320(152)+cardSize.height:Height320(177)+cardSize.height;
        
    }else{
        
        return checkout.card.cardKind.type == CardKindTypeTime?Height320(132)+cardSize.height:Height320(157)+cardSize.height;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CheckoutCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Checkout *checkout = self.info.checkouts[indexPath.row];
    
    cell.iconURL = checkout.student.photo;
    
    cell.name = checkout.student.name;
    
    cell.sex = checkout.student.sex;
    
    cell.phone = checkout.student.phone;
    
    cell.cardName = checkout.card.cardKind.cardKindName;
    
    cell.remain = checkout.card.cardKind.type == CardKindTypePrepaid?[NSString stringWithFormat:@"余额：%.0f元",checkout.card.remain]:checkout.card.cardKind.type == CardKindTypeCount?[NSString stringWithFormat:@"余额：%.0f次",checkout.card.remain]:[NSString stringWithFormat:@"有效期至：%@",[checkout.card.end substringToIndex:10]];
    
    if (checkout.card.cardKind.type != CardKindTypeTime) {
        
        cell.price = [NSString stringWithFormat:checkout.card.cardKind.type == CardKindTypePrepaid?@"%ld元":@"%ld次",(long)checkout.card.cardKind.cost];
        
    }else{
        
        cell.price = @"";
        
    }
    
    cell.checkinTime = checkout.createdTime;
    
    if (checkout.chest) {
        
        cell.chestName = checkout.chest.name;
        
    }else{
        
        cell.chestName = nil;
        
    }
    
    cell.noIgnore = YES;
    
    cell.delegate = self;
    
    cell.tag = indexPath.row;
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.checkouts.count;
    
}

-(void)checkoutCellCheckout:(CheckoutCell *)cell
{
    
    Checkout *checkout = self.info.checkouts[cell.tag];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"是否确认对用户：%@ %@的签到进行签出操作",checkout.student.name,checkout.createdTime] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    alert.tag = cell.tag;
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        Checkout *checkout = self.info.checkouts[alertView.tag];
        
        CheckoutInfo *info = [[CheckoutInfo alloc]init];
        
        [info manualCheckoutWithCheckout:checkout result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                NSMutableArray *checkouts = [self.info.checkouts mutableCopy];
                
                [checkouts removeObjectAtIndex:alertView.tag];
                
                self.info.checkouts = [checkouts copy];
                
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:alertView.tag inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
                
                CheckSuccessView *successView = [CheckSuccessView defaultSuccessView];
                
                successView.title = [NSString stringWithFormat:@"%@签出成功",self.stu.name];
                
                [self.view addSubview:successView];
                
                [successView show];
                
                [self reloadData];
                
            }else{
                
                MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
                
                hud.mode = MBProgressHUDModeText;
                
                [self.view addSubview:hud];
                
                hud.label.text = error;
                
                hud.label.numberOfLines = 0;
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}

-(void)uploadPhotoWithCheckoutCell:(CheckoutCell *)cell
{
    
    Checkout *checkout = self.info.checkouts[cell.tag];
    
    if (!checkout.student.photo.absoluteString.length) {
        
        self.student = checkout.student;
        
        [self editPhoto];
        
    }else{
        
        PictureShowController *svc = [[PictureShowController alloc]init];
        
        svc.imageURL = checkout.student.photo;
        
        [self presentViewController:svc animated:YES completion:nil];
        
    }
    
}

-(void)editPhoto
{
    
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
        
        [info uploadPhoto:self.student.photo.absoluteString student:self.student result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                [self reloadData];
                
                self.hud.label.text = @"上传成功";
                
                self.hud.mode = MBProgressHUDModeText;
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.0f];
                
            }else{
                
                self.student.photo = nil;
                
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
    
    self.student.photo = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
    
    [uy uploadImage:self.image savekey:url];
    
}

@end
