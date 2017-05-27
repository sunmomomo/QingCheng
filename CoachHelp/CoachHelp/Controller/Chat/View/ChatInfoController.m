//
//  ChatInfoController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatInfoController.h"

#import "MOCell.h"

#import "ChatMemberCell.h"

#import "ChatInfo.h"

#import "ChatNameController.h"

#import "ChatChooseMemberController.h"

#import "ChatMemberChangeController.h"

#import "RootController.h"

#import <AVFoundation/AVFoundation.h>

#import "UpYun.h"

#import "ChatUserManager.h"

static NSString *identifier = @"Cell";

@interface ChatInfoController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)MOCell *chatNameCell;

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *members;

@property(nonatomic,strong)UIButton *quitButton;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation ChatInfoController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    ChatInfo *info = [[ChatInfo alloc]init];
    
    [info requestGroupDetailInfoWithModel:self.model result:^(BOOL success, NSString *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.chatNameCell.subtitle = self.model.group.name;
            
            self.members = self.model.group.users;
            
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.model.group.iconURL]];
            
            [self reloadUI];
            
        });
        
    }];
    
}

-(void)reloadUI
{
    
    self.title = [NSString stringWithFormat:@"群聊信息(%ld)",(unsigned long)self.model.group.users.count];
    
    [self.collectionView reloadData];
    
    NSInteger rows = (ceil((float)(self.members.count+2)/5));
    
    [self.collectionView changeHeight:rows*Height(80)+Height(45)+Height(10)];
    
    [self.quitButton changeTop:self.collectionView.bottom+Height(20)];
    
    self.mainView.contentSize = CGSizeMake(0, self.quitButton.bottom+Height(50));
    
}

-(void)createUI
{
    
    self.title = @"群聊信息";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.mainView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.mainView];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, Height(15), MSW, Height(50)+Height(84))];
    
    topView.layer.borderWidth = OnePX;
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.mainView addSubview:topView];
    
    UIButton *topButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(84))];
    
    topButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    [topView addSubview:topButton];
    
    [topButton addTarget:self action:@selector(cameraClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), 0, Width(120), Height(84))];
    
    topLabel.text = @"群聊头像";
    
    topLabel.textColor = UIColorFromRGB(0x333333);
    
    topLabel.font = AllFont(14);
    
    [topButton addSubview:topLabel];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width(75), Height(12), Width(60), Height(60))];
    
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    self.iconView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.iconView.layer.borderWidth = OnePX;
    
    [topButton addSubview:self.iconView];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width(15), Height(84)-OnePX, MSW-Width(30), OnePX)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [topView addSubview:sep];
    
    self.chatNameCell = [[MOCell alloc]initWithFrame:CGRectMake(Width(15), sep.bottom, MSW-Width(30), Height(50))];
    
    self.chatNameCell.titleLabel.text = @"群聊名称";
    
    self.chatNameCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.chatNameCell.subtitle = self.model.group.name;
    
    self.chatNameCell.placeholder = @"请填写";
    
    [topView addSubview:self.chatNameCell];
    
    [self.chatNameCell addTarget:self action:@selector(nameChanged:) forControlEvents:UIControlEventTouchUpInside];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height(15), MSW, MSH-topView.bottom-Height(15)) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    
    self.collectionView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.collectionView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.collectionView.layer.borderWidth = OnePX;
    
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;
    
    self.collectionView.scrollEnabled = NO;
    
    if ([UIDevice currentDevice].systemVersion.floatValue>=10.0) {
        
        self.collectionView.prefetchingEnabled = NO;
        
    }
    
    [self.collectionView registerClass:[ChatMemberCell class] forCellWithReuseIdentifier:identifier];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    [self.mainView addSubview:self.collectionView];
    
    self.quitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.collectionView.bottom+Height(20), MSW, Height(50))];
    
    self.quitButton.layer.borderWidth = OnePX;
    
    self.quitButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.quitButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.quitButton setTitle:@"退出群聊" forState:UIControlStateNormal];
    
    [self.quitButton setTitleColor:kDeleteColor forState:UIControlStateNormal];
    
    [self.quitButton addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainView addSubview:self.quitButton];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.members.count+2;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(Width(58), Height(80));
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, Width(10), 0, Width(10));
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return Width(5);
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return Width(15);
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChatMemberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if (indexPath.row <self.members.count) {
        
        User *member = self.members[indexPath.row];
        
        cell.name = member.username;
        
        cell.type = ChatMemberCellTypeNormal;
        
        cell.iconURL = member.iconURL;
        
    }else if(indexPath.row == self.members.count){
        
        cell.type = ChatMemberCellTypeAdd;
        
    }else{
        
        cell.type = ChatMemberCellTypeSub;
        
    }
    
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(MSW, Height(50));
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    
    return CGSizeMake(MSW, Height(10));
    
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        [header removeAllView];
        
        header.backgroundColor = UIColorFromRGB(0xffffff);
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), Height(14), Width(200), Height(21))];
        
        label.text = [NSString stringWithFormat:@"群聊成员(%ld)",(unsigned long)self.members.count];
        
        label.textColor = UIColorFromRGB(0x333333);
        
        label.font = AllFont(14);
        
        [header addSubview:label];
        
        return header;
        
    }else{
        
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        footer.backgroundColor = UIColorFromRGB(0xffffff);
        
        return footer;
        
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row <self.members.count) {
        
        return;
        
    }else if(indexPath.row == self.members.count){
        
        ChatChooseMemberController *vc = [[ChatChooseMemberController alloc]init];
        
        __weak typeof(self)weakS = self;
        
        vc.chooseFinish = ^(NSArray *members) {
            
            ChatInfo *info = [[ChatInfo alloc]init];
            
            [info addUsers:members withModel:weakS.model result:^(BOOL success, NSString *error) {
                
                MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
                
                hud.mode = MBProgressHUDModeText;
                
                [hud showAnimated:YES];
                
                if (success) {
                    
                    hud.label.text = @"添加成功";
                    
                    [self reloadData];
                    
                    for (MOViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([NSStringFromClass([vc class]) isEqualToString:@"ChatController"]) {
                            
                            [vc reloadData];
                            
                        }
                        
                    }
                    
                    [hud hideAnimated:YES afterDelay:1.5];
                    
                }else{
                    
                    hud.label.text = error;
                    
                    [hud hideAnimated:YES afterDelay:1.5];
                    
                }
                
            }];
            
        };
        
        [self presentViewController:vc animated:YES completion:nil];
        
    }else{
        
        ChatMemberChangeController *vc = [[ChatMemberChangeController alloc]init];
        
        vc.model = self.model;
        
        [self presentViewController:[[UINavigationController alloc]initWithRootViewController:vc] animated:YES completion:nil];
        
    }
    
}

-(void)quit
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确定退出群聊？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        ChatInfo *info = [[ChatInfo alloc]init];
        
        [info quitWithModel:self.model result:^(BOOL success, NSString *error) {
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [hud showAnimated:YES];
            
            if (success) {
                
                hud.label.text = @"退出成功";
                
                [hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popToViewControllerName:@"RootController" isReloadData:NO];
                    
                    [[RootController sharedSliderController]reloadMessageData];
                    
                });
                
            }else{
                
                hud.label.text = error;
                
                [hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}

-(void)nameChanged:(MOCell*)cell
{
    
    __weak typeof(self)weakS = self;
    
    ChatNameController *vc = [[ChatNameController alloc]initWithName:self.model.group.name andNameFinishBlock:^(NSString *name) {
        
        ChatInfo *info = [[ChatInfo alloc]init];
        
        [info changeName:name withModel:weakS.model result:^(BOOL success, NSString *error) {
            
            [weakS reloadData];
            
            weakS.model.group.name = name;
            
            for (MOViewController *vc in weakS.navigationController.viewControllers) {
                
                if ([NSStringFromClass([vc class]) isEqualToString:@"ChatController"]) {
                    
                    [vc reloadData];
                    
                }
                
            }
            
        }];
        
    }];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)cameraClick
{
    
    [self.view endEditing:YES];
    
    UIActionSheet *actionSheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传群聊头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    }else{
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传群聊头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
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
    
    UIImage *image = [UIImage fixOrientation:[info objectForKey:UIImagePickerControllerEditedImage]];
    
    [self.iconView setImage:image];
    
    [self uploadImage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)uploadImage:(UIImage*)image
{
    
    UpYun *uy = [[UpYun alloc] init];
    
    NSString *url = [UpYun getSaveKey];
    
    NSString *imageURL = [NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url];
    
    uy.successBlocker = ^(NSURLResponse *response,id data){
        
        [[TIMGroupManager sharedInstance]ModifyGroupFaceUrl:self.model.identifier url:imageURL succ:^{
            
            self.hud.label.text = @"上传成功";
            
            self.hud.mode = MBProgressHUDModeText;
            
            [self.hud showAnimated:YES];
            
            [self.hud hideAnimated:YES afterDelay:1.0f];
            
            self.model.group.iconURL = imageURL;
            
            [ChatUserManager saveGroup:self.model.group];
            
        } fail:^(int code, NSString *msg) {
            
            self.hud.label.text = @"上传失败";
            
            self.hud.mode = MBProgressHUDModeText;
            
            [self.hud showAnimated:YES];
            
            [self.hud hideAnimated:YES afterDelay:1.0f];
            
        }];
        
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
    
}

@end
