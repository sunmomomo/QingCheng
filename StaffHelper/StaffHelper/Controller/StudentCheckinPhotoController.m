//
//  StudentCheckinPhotoController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "StudentCheckinPhotoController.h"

#import "CheckinPhotoCell.h"

#import "CheckinPhotoHistoryInfo.h"

#import "UpYun.h"

#import <AVFoundation/AVFoundation.h>

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface StudentCheckinPhotoController ()<UITableViewDelegate,MOTableViewDatasource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)CheckinPhotoHistoryInfo *info;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)UIButton *editButton;

@end

@implementation StudentCheckinPhotoController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self createUI];
    
    [self createData];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

-(void)createData
{
    
    self.info = [[CheckinPhotoHistoryInfo alloc]init];
    
    [self.info requestDataWithStudent:self.student result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        self.tableView.tableHeaderView.hidden = !self.info.histories.count;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)reloadData
{
    
    CheckinPhotoHistoryInfo *info = [[CheckinPhotoHistoryInfo alloc]init];
    
    [info requestDataWithStudent:self.student result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        if (success) {
            
            self.info.histories = info.histories;
            
        }
        
        self.tableView.tableHeaderView.hidden = !self.info.histories.count;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"会员照片";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[CheckinPhotoCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(178))];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(142))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.tableView.tableHeaderView addSubview:topView];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/2-Width320(40), Height320(20), Width320(80), Height320(80))];
    
    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.iconView.layer.masksToBounds = YES;
    
    if (self.student.photo.absoluteString.length) {
        
        [self.iconView sd_setImageWithURL:self.student.photo];
        
    }else{
        
        self.iconView.image = [UIImage imageNamed:@"img_default_checkinphoto"];
        
    }
    
    [topView addSubview:self.iconView];
    
    if (AppGym) {
        
        self.editButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(40), self.iconView.bottom, Width320(80), topView.height-self.iconView.bottom)];
        
        self.editButton.titleLabel.font = AllFont(14);
        
        [self.editButton setTitleColor:kMainColor forState:UIControlStateNormal];
        
        if (self.student.photo.absoluteString.length) {
            
            [self.editButton setTitle:@"修改" forState:UIControlStateNormal];
            
        }else{
            
            [self.editButton setTitle:@"添加" forState:UIControlStateNormal];
            
        }
        
        [self.editButton addTarget:self action:@selector(editPhoto) forControlEvents:UIControlEventTouchUpInside];
        
        [topView addSubview:self.editButton];
        
    }else{
        
        UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.iconView.bottom, MSW, topView.height-self.iconView.bottom)];
        
        addLabel.font = AllFont(14);
        
        addLabel.textColor = UIColorFromRGB(0x999999);
        
        addLabel.textAlignment = NSTextAlignmentCenter;
        
        addLabel.text = @"如需修改会员照片请到场馆内操作";
        
        [topView addSubview:addLabel];
        
    }
    
    UILabel *labelView = [[UILabel alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, Height320(36))];
    
    labelView.text = @"    会员照片修改记录";
    
    labelView.textColor = UIColorFromRGB(0x999999);
    
    labelView.font = AllFont(12);
    
    [self.tableView.tableHeaderView addSubview:labelView];
    
    [self.view addSubview:self.tableView];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.histories.count;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(72);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CheckinPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    CheckinPhotoHistory *history = self.info.histories[indexPath.row];
    
    cell.staffName = history.staffName;
    
    cell.time = history.time;
    
    cell.imageURL = history.photo;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)editPhoto
{
    
    if ((AppGym &&([PermissionInfo sharedInfo].permissions.userPermission.editState||[PermissionInfo sharedInfo].permissions.personalUserPermission.editState))||(!AppGym && ([[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.student.gyms andPermission:[Permission userPermission] andType:PermissionTypeEdit]||[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.student.gyms andPermission:[Permission personalUserPermission] andType:PermissionTypeEdit]))) {
        
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
    
    [self.iconView setImage:self.image];
    
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
                
                if (self.editFinish) {
                    
                    self.editFinish();
                    
                }
                
                [self reloadData];
                
                [self.editButton setTitle:@"修改" forState:UIControlStateNormal];
                
                self.hud.label.text = @"修改成功";
                
                self.hud.mode = MBProgressHUDModeText;
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.0f];
                
            }else{
                
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

-(UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    
    UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64)];
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(120), Height320(78), Width320(80), Height320(80))];
    
    emptyImg.image = [UIImage imageNamed:@"checkin_photo_empty"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(20), MSW, Height320(22))];
    
    emptyLabel.text = @"会员照片";
    
    emptyLabel.textColor = UIColorFromRGB(0x333333);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(16);
    
    [emptyView addSubview:emptyLabel];
    
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(30), emptyLabel.bottom+Height320(15), Width320(260), Height320(42))];
    
    hintLabel.text = AppGym?@"通过会员照片工作人员可以在签到、预约的时候辨别会员真实身份":@"通过会员照片工作人员可以在签到、预约的时候辨别会员真实身份，请在场馆内添加";
    
    hintLabel.textColor = UIColorFromRGB(0x999999);
    
    hintLabel.textAlignment = NSTextAlignmentCenter;
    
    hintLabel.font = AllFont(14);
    
    hintLabel.numberOfLines = 0;
    
    [emptyView addSubview:hintLabel];
    
    CGSize size = [hintLabel.text boundingRectWithSize:CGSizeMake(Width320(260), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
    
    [hintLabel changeSize:size];
    
    if (AppGym) {
        
        UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(90), hintLabel.bottom+Height320(20), Width320(140), Height320(40))];
        
        addButton.layer.cornerRadius = 2;
        
        addButton.backgroundColor = kMainColor;
        
        [addButton setTitle:@"上传照片" forState:UIControlStateNormal];
        
        [addButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        addButton.titleLabel.font = AllFont(14);
        
        [addButton addTarget:self action:@selector(showCamera:) forControlEvents:UIControlEventTouchUpInside];
        
        [emptyView addSubview:addButton];
        
    }
    
    return emptyView;
    
}


@end
