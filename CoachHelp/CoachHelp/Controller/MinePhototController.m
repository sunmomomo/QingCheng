//
//  MinePhototController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2017/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MinePhototController.h"

#import "MinePhotoCell.h"

#import "UpYun.h"

#import "MinePhotoInfo.h"

#import <AVFoundation/AVFoundation.h>

static NSString *identifier = @"Cell";

@interface MinePhototController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DZNEmptyDataSetSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)NSArray *imgArrays;

@property(nonatomic,strong)NSMutableArray *deleteArray;

@property(nonatomic,assign)BOOL editing;

@property(nonatomic,strong)UIButton *addButton;

@property(nonatomic,strong)UIButton *deleteButton;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation MinePhototController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    self.deleteArray = [NSMutableArray array];
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    MinePhotoInfo *info = [[MinePhotoInfo alloc]init];
    
    [info requestResult:^(BOOL success, NSString *error) {
        
        if (success) {
            
            self.imgArrays = info.photos;
            
        }
        
        [self.collectionView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"照片墙";
    
    self.rightType = MONaviRightTypeEdit;
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-Height320(52)) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    
    self.collectionView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
        
        self.collectionView.prefetchingEnabled = NO;
        
    }
    
    self.collectionView.dataSource = self;
    
    self.collectionView.delegate = self;

    self.collectionView.emptyDataSetSource = self;
    
    [self.collectionView registerClass:[MinePhotoCell class] forCellWithReuseIdentifier:identifier];
    
    [self.view addSubview:self.collectionView];
    
    self.addButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), self.collectionView.bottom, MSW-Width320(32), Height320(40))];
    
    self.addButton.layer.cornerRadius = Width320(2);
    
    self.addButton.backgroundColor = kMainColor;
    
    [self.addButton setTitle:@"上传照片" forState:UIControlStateNormal];
    
    [self.addButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    self.addButton.titleLabel.font = AllFont(16);
    
    [self.view addSubview:self.addButton];
    
    [self.addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, MSH-Height320(40), MSW, Height320(40))];
    
    self.deleteButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.deleteButton setTitleColor:kDeleteColor forState:UIControlStateNormal];
    
    [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    
    self.deleteButton.titleLabel.font = AllFont(16);
    
    [self.view addSubview:self.deleteButton];
    
    [self.deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.deleteButton.hidden = YES;
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    self.hud.mode = MBProgressHUDModeText;
    
    [self.view addSubview:self.hud];
    
}

-(void)addClick
{
    
    if (self.imgArrays.count>=5) {
        
        [[[UIAlertView alloc]initWithTitle:@"你最多只能上传5张照片" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }else{
        
        UIActionSheet *actionSheet;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
        }else{
            actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
        }
        actionSheet.delegate = self;
        [actionSheet showInView:self.view];
        
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
    
    [self uploadImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)uploadImage
{
    
    NSString *url = [UpYun getSaveKey];
    
    UpYun *uy = [[UpYun alloc] init];
    
    uy.successBlocker = ^(NSURLResponse *response,id data){
        
        MinePhotoInfo *info = [[MinePhotoInfo alloc]init];
        
        [info addPhoto:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url] result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                [self reloadData];
                
                self.hud.label.text = @"上传成功";
                
                self.hud.mode = MBProgressHUDModeText;
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.0f];
                
            }else{
                
                self.hud.label.text = @"上传失败";
                
                self.hud.mode = MBProgressHUDModeText;
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.0f];
                
            }
            
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
    
    [uy uploadImage:self.image savekey:url];
    
}

-(void)deleteClick
{
    
    if (self.deleteArray.count) {
        
        [[[UIAlertView alloc]initWithTitle:@"确定删除这些照片？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil]show];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        
        hud.mode = MBProgressHUDModeIndeterminate;
        
        [self.view addSubview:hud];
        
        [hud showAnimated:YES];
        
        self.deleteButton.userInteractionEnabled = NO;
        
        MinePhotoInfo *info = [[MinePhotoInfo alloc]init];
        
        NSMutableArray *photos = [NSMutableArray array];
        
        for (NSIndexPath *indexPath in self.deleteArray) {
            
            MinePhoto *photo = self.imgArrays[indexPath.row];
            
            [photos addObject:[NSString stringWithFormat:@"%ld",(long)photo.photoId]];
            
        }
        
        [info deletePhotos:photos result:^(BOOL success, NSString *error) {
            
            self.deleteButton.userInteractionEnabled = YES;
            
            hud.mode = MBProgressHUDModeText;
            
            if (success) {
                
                hud.label.text = @"删除成功";
                
                [hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self naviRightClick];
                    
                    [self reloadData];
                    
                });
                
            }else{
                
                hud.label.text = error;
                
                [hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.imgArrays.count;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger width = (MSW-OnePX*6)/3;
    
    return CGSizeMake(width, width);
    
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    NSInteger width = (MSW-OnePX*6)/3;
    
    return UIEdgeInsetsMake(0, (MSW-width*3-OnePX*6)/2, 0, (MSW-width*3-OnePX*6)/2);
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return OnePX*3;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return OnePX*3;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MinePhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    MinePhoto *photo = self.imgArrays[indexPath.row];
    
    cell.imgURL = [NSURL URLWithString:photo.urlString];
    
    cell.editing = self.editing;
    
    cell.choosed = [self.deleteArray containsObject:indexPath];
    
    return cell;
    
}

-(UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    
    UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64)];
    
    emptyView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/2-Width320(50), Height320(150), Width320(100), Height320(100))];
    
    emptyImg.image = [UIImage imageNamed:@"mine_photo_empty"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(18), MSW, Height320(18))];
    
    emptyLabel.text = @"暂无照片";
    
    emptyLabel.textColor = UIColorFromRGB(0x747474);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(13);
    
    [emptyView addSubview:emptyLabel];
    
    return emptyView;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if (self.editing) {
        
        if ([self.deleteArray containsObject:indexPath]) {
            
            [self.deleteArray removeObject:indexPath];
            
        } else {
            
            [self.deleteArray addObject:indexPath];
            
        }
        
        [self.collectionView reloadData];
        
    }
    
}

-(void)naviRightClick
{
    
    self.editing = !self.editing;
    
    self.rightType = self.editing?MONaviRightTypeTitle:MONaviRightTypeEdit;
    
    if (self.editing) {
        
        self.rightTitle = @"取消";
        
    }
    
    self.addButton.hidden = self.editing;
    
    self.deleteButton.hidden = !self.editing;
    
    [self.deleteArray removeAllObjects];
    
    [self.collectionView reloadData];
    
}

@end
