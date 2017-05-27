//
//  IntroEditController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/24.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "IntroEditController.h"

#import "IntroCell.h"

#import "UpYun.h"

#import "InsertWordController.h"

#import <AVFoundation/AVFoundation.h>

#import "UserDetailInfo.h"

static NSString *identifier = @"Cell";

@interface IntroEditController ()<IntroDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)NSMutableArray *introArray;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)NSIndexPath *imgIndexPath;

@end

@implementation IntroEditController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self createUI];
    
    [self createData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

-(void)createData
{
    
    
    UserDetailInfo *userInfo = [[UserDetailInfo alloc]init];
    
    [userInfo requestResult:^(BOOL success, NSString *error) {
        
        self.introArray = userInfo.user.intro;
        
        [self.tableView reloadData];
        
    }];
    
    
}

-(void)naviRightClick
{
    
    NSString *value = [NSString string];
    
    for (NSDictionary *obj in self.introArray) {
        
        if ([obj[@"type"] isEqualToString:@"word"]) {
            
            value =  [value stringByAppendingString:[NSString stringWithFormat:@"<p>%@</p>",obj[@"content"]]];
            
        }else{
            
            value = [value stringByAppendingString:[NSString stringWithFormat:@"<img src=\"%@\"/>",obj[@"content"]]];
            
        }
        
    }
    
    if (!value.length) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
        return;
        
    }
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"请稍候";
    
    [self.hud showAnimated:YES];
    
    NSString *api = [NSString stringWithFormat:@"/api/coaches/%ld/",CoachId];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:value forKey:@"description"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:api putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = @"修改成功";
            
            [self.hud showAnimated:YES];
            
            [self.hud hideAnimated:YES afterDelay:1.0f];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
                
            });
            
        }else
        {
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = responseDic[@"msg"];
            
            [self.hud showAnimated:YES];
            
            [self.hud hideAnimated:YES afterDelay:1.0f];
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.hud.mode = MBProgressHUDModeText;
        
        self.hud.label.text = error;
        
        [self.hud showAnimated:YES];
        
        [self.hud hideAnimated:YES afterDelay:1.0f];
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    
    self.rightType = MONaviRightTypeTitle;
    
    self.rightTitle = @"保存";
    
    self.title = @"自我介绍";
        
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-Height320(42.5)) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[IntroCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, MSH-Height320(42.5)-1, MSW, 1)];
    
    bottomView.backgroundColor = UIColorFromRGB(0xe4e4e4);
    
    [self.view addSubview:bottomView];
    
    UIButton *wordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    wordBtn.frame = CGRectMake(0, MSH-Height320(42.5), MSW/2, Height320(42.5));
    
    [self.view addSubview:wordBtn];
    
    UIImageView *wordImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(29.7), Height320(12.4), Width320(17.7), Height320(17.7))];
    
    wordImg.image = [UIImage imageNamed:@"insertword"];
    
    [wordBtn addSubview:wordImg];
    
    UILabel *wordLabel = [[UILabel alloc]initWithFrame:CGRectMake(wordImg.right+Width320(7.5), 0, Width320(100), wordBtn.height)];
    
    wordLabel.text = @"插入一段文字";
    
    wordLabel.textColor = UIColorFromRGB(0x666666);
    
    wordLabel.font = STFont(14);
    
    [wordBtn addSubview:wordLabel];
    
    UIButton *picBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    picBtn.frame = CGRectMake(MSW/2, wordBtn.top, wordBtn.width, wordBtn.height);
    
    [self.view addSubview:picBtn];
    
    UIImageView *picImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(29.7), Height320(12.4), Width320(17.7), Height320(17.7))];
    
    picImg.image = [UIImage imageNamed:@"insertpic"];
    
    [picBtn addSubview:picImg];
    
    UILabel *picLabel = [[UILabel alloc]initWithFrame:CGRectMake(picImg.right+Width320(7.5), 0, Width320(100), picBtn.height)];
    
    picLabel.text = @"插入一张图片";
    
    picLabel.textColor = UIColorFromRGB(0x666666);
    
    picLabel.font = STFont(14);
    
    [picBtn addSubview:picLabel];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(MSW/2-0.5, picBtn.top+Height320(12.8), 1, picBtn.height-Height320(25.6))];
    
    sep.backgroundColor = UIColorFromRGB(0xaaaaaa);
    
    [self.view addSubview:sep];
    
    [wordBtn addTarget:self action:@selector(insertWord:) forControlEvents:UIControlEventTouchUpInside];
    
    [picBtn addTarget:self action:@selector(insertImg:) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)imgActionSheet
{
    
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

-(void)insertImg:(UIButton*)btn
{
    
    [self imgActionSheet];
    
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
                
                
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"摄像头访问受限，请到设置-隐私-相机中允许健身教练助手访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
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
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = NO;
    
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [UIImage imageWithData:UIImageJPEGRepresentation([UIImage fixOrientation:[info objectForKey:UIImagePickerControllerOriginalImage]], 0.75)];
    
    UpYun *uy = [[UpYun alloc] init];
    
    NSString *url = [UpYun getSaveKey];
    
    uy.successBlocker = ^(NSURLResponse *response,id data){
        
        self.hud.label.text = @"上传成功";
        
        self.hud.mode = MBProgressHUDModeText;
        
        [self.hud showAnimated:YES];
        
        [self.hud hideAnimated:YES afterDelay:1.0f];
        
        if (self.imgIndexPath) {
            
            if (self.introArray.count>self.imgIndexPath.row) {
                
                [self.introArray replaceObjectAtIndex:self.imgIndexPath.row withObject:@{@"type":@"img",@"content":[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]}];
                
            }
            
            self.imgIndexPath = nil;
            
        }else
        {
            
            [self.introArray addObject:@{@"type":@"img",@"content":[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]}];
            
        }
        
        [self.tableView reloadData];
        
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

-(void)insertWord:(UIButton*)btn
{
    
    InsertWordController *svc = [[InsertWordController alloc]init];
    
    svc.isEdit = NO;
    
    __weak typeof(self)weakS = self;
    
    svc.inputFinish = ^(NSString *text){
        
        if (text.length) {
            
            [weakS.introArray addObject:@{@"type":@"word",@"content":text}];
            
            [weakS.tableView reloadData];
            
        }
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.introArray.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    IntroCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSDictionary *dict = self.introArray[indexPath.row];
    
    if ([dict[@"type"] isEqualToString:@"word"]) {
        
        [cell setContent:dict[@"content"] andStyle:contentStyleText];
        
    }else
    {
        
        [cell setContent:dict[@"content"] andStyle:contentStyleImg];
        
    }
    
    if (indexPath.row == 0) {
        
        cell.movemode = moveNoUp;
        
    }else if (indexPath.row == self.introArray.count-1)
    {
        
        cell.movemode = moveNoDown;
        
    }else
    {
        
        cell.movemode = moveAll;
        
    }
    
    if (self.introArray.count == 1) {
        
        cell.movemode = moveNO;
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.delegate = self;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    IntroCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSDictionary *dict = self.introArray[indexPath.row];
    
    if ([dict[@"type"] isEqualToString:@"word"]) {
        
        [cell setContent:dict[@"content"] andStyle:contentStyleText];
        
    }else
    {
        
        [cell setContent:dict[@"content"] andStyle:contentStyleImg];
        
    }
    
    return [cell heightForCell];
}

-(void)remove:(UIButton *)btn
{
    
    NSDictionary *dict = self.introArray[btn.tag];
    
    NSString *hint;
    
    if ([dict[@"type"] isEqualToString:@"word"]) {
        
        hint = @"删除这段文字";
        
    }else
    {
        
        hint = @"删除这张图片";
        
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:hint message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    
    alert.tag = btn.tag;
    
    [alert show];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        [self.introArray removeObjectAtIndex:alertView.tag];
        
        [self.tableView reloadData];
        
    }
    
}


-(void)up:(UIButton *)btn{
    
    NSDictionary *dict1 = self.introArray[btn.tag];
    
    NSDictionary *dict2 = self.introArray[btn.tag-1];
    
    [self.introArray replaceObjectAtIndex:btn.tag-1 withObject:dict1];
    
    [self.introArray replaceObjectAtIndex:btn.tag withObject:dict2];
    
    [self.tableView reloadData];
    
}

-(void)down:(UIButton *)btn
{
    
    NSDictionary *dict1 = self.introArray[btn.tag];
    
    NSDictionary *dict2 = self.introArray[btn.tag+1];
    
    [self.introArray replaceObjectAtIndex:btn.tag+1 withObject:dict1];
    
    [self.introArray replaceObjectAtIndex:btn.tag withObject:dict2];
    
    [self.tableView reloadData];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dict = self.introArray[indexPath.row];
    
    if ([dict[@"type"] isEqualToString:@"word"]) {
        
        InsertWordController *svc = [[InsertWordController alloc]init];
        
        svc.isEdit = YES;
        
        svc.text = dict[@"content"];
        
        __weak typeof(self)weakS = self;
        
        svc.inputFinish = ^(NSString *text){
            
            if (text.length) {
                
                [weakS.introArray replaceObjectAtIndex:indexPath.row withObject:@{@"type":@"word",@"content":text}];
                
                [weakS.tableView reloadData];
                
            }else
            {
                
                [weakS.introArray removeObject:dict];
                
                [weakS.tableView reloadData];
                
            }
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else
    {
        
        self.imgIndexPath = indexPath;
        
        [self imgActionSheet];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


@end
