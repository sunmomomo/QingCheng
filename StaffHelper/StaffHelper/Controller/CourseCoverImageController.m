//
//  CourseCoverImageController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseCoverImageController.h"

#import "CourseCoverCell.h"

#import <AVFoundation/AVFoundation.h>

#import "UpYun.h"

#import "CourseCoverInfo.h"

#import "MOSwitchCell.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CourseCoverImageController ()<UITableViewDelegate,MOTableViewDatasource,CourseCoverCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,MOSwitchCellDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSMutableArray *images;

@property(nonatomic,strong)UIButton *addButton;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)CourseCoverInfo *info;

@property(nonatomic,strong)UILabel *hintLabel;

@property(nonatomic,strong)MOSwitchCell *switchCell;

@end

@implementation CourseCoverImageController

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

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
    
    [self setAddButtonStyle];
    
    self.info = [[CourseCoverInfo alloc]init];
    
    [self.info requestWithCourse:self.course result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        if (success) {
            
            self.images = [self.info.covers mutableCopy];
            
            [self.tableView reloadData];
            
            [self setAddButtonStyle];
            
        }
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"编辑封面照片";
    
    self.rightTitle = @"完成";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.editing = YES;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[CourseCoverCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(102))];
    
    UIView *switchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    switchView.backgroundColor = UIColorFromRGB(0xffffff);
    
    switchView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    switchView.layer.borderWidth = OnePX;
    
    [self.tableView.tableHeaderView addSubview:switchView];
    
    self.switchCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.switchCell.titleLabel.text = @"自定义封面照片";
    
    self.switchCell.noLine = YES;
    
    self.switchCell.delegate = self;
    
    self.switchCell.on = self.course.customCover;
    
    [switchView addSubview:self.switchCell];
    
    self.hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), switchView.bottom, MSW-Width320(24), Height320(56))];
    
    self.hintLabel.textColor = UIColorFromRGB(0x666666);
    
    self.hintLabel.font = AllFont(12);
    
    self.hintLabel.numberOfLines = 0;
    
    [self.tableView.tableHeaderView addSubview:self.hintLabel];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(52))];
    
    self.addButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(12), Height320(6), MSW-Width320(24), Height320(40))];
    
    self.addButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.addButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.addButton.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.addButton setTitle:@"+ 添加封面照片" forState:UIControlStateNormal];
    
    [self.addButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    
    self.addButton.titleLabel.font = AllFont(14);
    
    [self.tableView.tableFooterView addSubview:self.addButton];
    
    [self.addButton addTarget:self action:@selector(addCover) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.tableView];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    [self setAddButtonStyle];
    
    [self check];
    
}

-(void)check
{
    
    self.hintLabel.text = self.switchCell.on?@"最多可以添加5张封面照片，通过长按以后拖动来调整封面图片顺序":@"关闭自定义照片后，封面照片处将随机展示公开上课照片";
    
    self.tableView.tableFooterView.hidden = !self.switchCell.on;
    
    [self.tableView reloadData];
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    [self check];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.switchCell.on?self.images.count:0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(92);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CourseCoverCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.imageURL = self.images[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.delegate = self;
    
    return cell;
    
}

-(void)deleteClickOfCourseCoverCell:(CourseCoverCell *)cell
{
    
    [self.images removeObjectAtIndex:cell.tag];
    
    [self.tableView reloadData];
    
    [self setAddButtonStyle];
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
    
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    NSURL *url = self.images[sourceIndexPath.row];
    
    [self.images removeObjectAtIndex:sourceIndexPath.row];
    
    [self.images insertObject:url atIndex:destinationIndexPath.row];
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleNone;
    
}

-(void)addCover
{
    
    UIActionSheet *actionSheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    }else{
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
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
        
        self.imagePickerController.sourceType = sourceType;
        
        [self presentViewController:self.imagePickerController animated:YES completion:^{}];
        
    }
    
}


-(void)showCamera:(NSNumber*)typeNumber
{
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    
    self.imagePickerController.delegate = self;
    
    self.imagePickerController.sourceType = [typeNumber integerValue];
    
    [self presentViewController:self.imagePickerController animated:YES completion:^{}];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [UIImage fixOrientation:[info objectForKey:UIImagePickerControllerOriginalImage]];
    
    [self uploadImage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)uploadImage:(UIImage*)image
{
    
    UpYun *uy = [[UpYun alloc] init];
    
    NSString *url = [UpYun getSaveKey];
    
    uy.successBlocker = ^(NSURLResponse *response,id data){
        
        self.hud.label.text = @"上传成功";
        
        self.hud.mode = MBProgressHUDModeText;
        
        [self.hud showAnimated:YES];
        
        [self.hud hideAnimated:YES afterDelay:1.0f];
        
        [self.images addObject:[NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]]];
        
        [self.tableView reloadData];
        
        [self setAddButtonStyle];
        
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

-(void)setAddButtonStyle
{
    
    if (self.images.count >=5) {
        
        self.addButton.userInteractionEnabled = NO;
        
        self.addButton.alpha = 0.6;
        
    }else{
        
        self.addButton.userInteractionEnabled = YES;
        
        self.addButton.alpha = 1;
        
    }
    
}

-(void)naviRightClick
{
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"";
    
    [self.hud showAnimated:YES];
    
    self.rightButtonEnable = NO;
    
    if (self.switchCell.on) {
        
        [self.info editCovers:self.images withCourse:self.course result:^(BOOL success, NSString *error) {
            
            self.rightButtonEnable = YES;
            
            if (success) {
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = @"修改成功";
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popViewControllerAndReloadData];
                    
                });
                
            }else{
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = error;
                
                self.hud.label.numberOfLines = 0;
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }else{
        
        [self.info editCustomCover:self.switchCell.on withCourse:self.course result:^(BOOL success, NSString *error) {
            
            self.rightButtonEnable = YES;
            
            if (success) {
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = @"修改成功";
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popViewControllerAndReloadData];
                    
                });
                
            }else{
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = error;
                
                self.hud.label.numberOfLines = 0;
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}

@end
