//
//  CourseEditController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseEditController.h"

#import <AVFoundation/AVFoundation.h>

#import "QCTextField.h"

#import "QCKeyboardView.h"

#import "UpYun.h"

#import "MOPickerView.h"

#import "CourseListInfo.h"

#import "MOCell.h"

#import "CourseMeassureController.h"

#import "CourseGymController.h"

static NSString *identifier = @"Cell";

@interface CourseEditController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIAlertViewDelegate,QCKeyboardViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)UIImageView *icon;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *timeTF;

@property(nonatomic,strong)QCTextField *capacityTF;

@property(nonatomic,strong)QCTextField *minNumTF;

@property(nonatomic,strong)MOCell *meassureCell;

@property(nonatomic,strong)MOCell *suitCell;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UITableView *gymListView;

@end

@implementation CourseEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.title = self.isAdd?self.course.type == CourseTypeGroup?@"添加团课种类":@"添加私教种类":@"编辑基本信息";
    
    if (self.isAdd)
    {
    self.rightTitle = @"完成";
    }else
    {
        self.rightTitle = @"保存";
    }
    
    
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.mainView];
    
    UILabel *basicLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(11), MSW, Height320(16))];
    
    basicLabel.text = @"基本信息";
    
    basicLabel.textColor = UIColorFromRGB(0x999999);
    
    basicLabel.font = AllFont(12);
    
    [self.mainView addSubview:basicLabel];
    
    Permission *permission;
    
    if (self.course.type == CourseTypeGroup) {
        
        permission = [PermissionInfo sharedInfo].permissions.groupPermission;
        
    }else{
        
        permission = [PermissionInfo sharedInfo].permissions.privatePermission;
        
    }
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, basicLabel.bottom+Height320(9),MSW, (!self.isAdd&&((AppGym &&permission.editState)||(!AppGym && [[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.course.gyms andPermission:permission andType:PermissionTypeEdit]==PermissionStateAll)))?Height320(40)*4+Height320(66):Height320(160))];
    
    topView.backgroundColor = UIColorFromRGB(0Xffffff);
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    [self.mainView addSubview:topView];
    
    if (!self.isAdd) {
        
        if (self.course.gyms.count >1 &&AppGym) {
            
            UIImageView *hintImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), basicLabel.bottom+Height320(4), Width320(14), Height320(14))];
            
            hintImg.image = [UIImage imageNamed:@"hint_circle"];
            
            [self.mainView addSubview:hintImg];
            
            UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(hintImg.right+Width320(6), basicLabel.bottom+Height320(4), MSW-hintImg.right-Width320(22), Height320(16))];
            
            hintLabel.text = @"请在「连锁运营」中修改基本信息";
            
            hintLabel.textColor = UIColorFromRGB(0x999999);
            
            hintLabel.font = AllFont(12);
            
            [self.mainView addSubview:hintLabel];
            
            [topView changeTop:hintLabel.bottom+Height320(10)];
            
        }else if (!AppGym&&([[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.course.gyms andPermission:permission andType:PermissionTypeEdit]==PermissionStatePart)){
            
            UIImageView *hintImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(31), Width320(14), Height320(14))];
            
            hintImg.image = [UIImage imageNamed:@"hint_circle"];
            
            [self.mainView addSubview:hintImg];
            
            UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(hintImg.right+Width320(6), basicLabel.bottom+Height320(4), MSW-hintImg.right-Width320(22), Height320(40))];
            
            hintLabel.text = @"此课程种类适用于多个场馆，仅在所有适用场馆下都具有编辑课程种类权限的用户才能进行编辑。";
            
            hintLabel.textColor = UIColorFromRGB(0x999999);
            
            hintLabel.font = AllFont(12);
            
            hintLabel.numberOfLines = 0;
            
            CGSize size = [hintLabel.text boundingRectWithSize:CGSizeMake(hintLabel.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:hintLabel.font} context:nil].size;
            
            [hintLabel changeSize:size];
            
            [self.mainView addSubview:hintLabel];
            
            [topView changeTop:hintLabel.bottom+Height320(10)];
            
        }
        
    }
    
    if (self.isAdd||(!self.isAdd&&[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.course.gyms andPermission:permission andType:PermissionTypeEdit]==PermissionStateAll)) {
        
        UIButton *topButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0, MSW, Height320(66))];
        
        topButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        [topView addSubview:topButton];
        
        [topButton addTarget:self action:@selector(getImage) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(150), topButton.height)];
        
        topLabel.text = @"课程图片";
        
        topLabel.textColor = UIColorFromRGB(0x999999);
        
        topLabel.font = STFont(16);
        
        topLabel.userInteractionEnabled = NO;
        
        [topView addSubview:topLabel];
        
        self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(66), Height320(8), Width320(50), Height320(50))];
        
        [self.icon setImage:[UIImage imageNamed:@"cameraplaceholder"]];
        
        if (self.course.imgUrl.absoluteString.length) {
            
            [self.icon sd_setImageWithURL:self.course.imgUrl];
        }
        
        self.icon.userInteractionEnabled = NO;
        
        [topButton addSubview:self.icon];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), topButton.height-1/[UIScreen mainScreen].scale, MSW-Width320(32), 1/[UIScreen mainScreen].scale)];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [topView addSubview:sep];
        
        self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), topButton.bottom, MSW-Width320(32), Height320(40))];
        
        self.nameTF.placeholder = @"名称";
        
        self.nameTF.delegate = self;
        
        self.nameTF.mustInput = YES;
        
        self.nameTF.text = self.course.name;
        
        [topView addSubview:self.nameTF];
        
        self.timeTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
        
        self.timeTF.placeholder = @"时长(分钟)";
        
        self.timeTF.keyboardType = UIKeyboardTypeNumberPad;
        
        self.timeTF.delegate = self;
        
        self.timeTF.mustInput = YES;
        
        self.timeTF.text = self.course.during?[NSString stringWithInteger:self.course.during]:@"";
        
        [topView addSubview:self.timeTF];
        
        [topView changeHeight:self.timeTF.bottom];
        
        if (self.course.type == CourseTypeGroup) {
            
            self.capacityTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.timeTF.bottom, self.nameTF.width, self.nameTF.height)];
            
            self.capacityTF.placeholder = @"单节可约人数";
            
            self.capacityTF.keyboardType = UIKeyboardTypeNumberPad;
            
            self.capacityTF.delegate = self;
            
            self.capacityTF.text = self.course.capacity?[NSString stringWithInteger:self.course.capacity]:@"";
            
            [topView addSubview:self.capacityTF];
            
            self.minNumTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.capacityTF.bottom, self.nameTF.width, self.nameTF.height)];
            
            self.minNumTF.placeholder = @"最小上课人数";
            
            self.minNumTF.keyboardType = UIKeyboardTypeNumberPad;
            
            self.minNumTF.delegate = self;
            
            self.minNumTF.mustInput = YES;
            
            self.minNumTF.text = self.course.minNumber?[NSString stringWithInteger:self.course.minNumber]:@"";
            
            [topView addSubview:self.minNumTF];
            
            self.meassureCell = [[MOCell alloc]initWithFrame:CGRectMake(self.nameTF.left, self.minNumTF.bottom, self.nameTF.width, self.nameTF.height)];
            
            self.meassureCell.titleLabel.text = @"默认课程计划";
            
            self.meassureCell.noLine = YES;
            
            [self.meassureCell addTarget:self action:@selector(messureChoose) forControlEvents:UIControlEventTouchUpInside];
            
            self.meassureCell.subtitle = self.course.meassure?self.course.meassure.name:@"无";
            
            [topView addSubview:self.meassureCell];
            
            [topView changeHeight:self.meassureCell.bottom];
            
        }
        
    }else{
        
        UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(56), Height320(56))];
        
        iconView.contentMode = UIViewContentModeScaleAspectFit;
        
        [iconView sd_setImageWithURL:self.course.imgUrl];
        
        [topView addSubview:iconView];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(iconView.right+Width320(12), Height320(20), MSW-Width320(24)-iconView.right, Height320(18))];
        
        titleLabel.text = self.course.name;
        
        titleLabel.textColor = UIColorFromRGB(0x333333);
        
        titleLabel.font = AllFont(16);
        
        [topView addSubview:titleLabel];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabel.left, titleLabel.bottom+Height320(8), titleLabel.width, Height320(15))];
        
        timeLabel.text = [NSString stringWithFormat:@"时长%ldmin，累计%ld节",(long)self.course.during,(long)self.course.courseNum];
        
        timeLabel.textColor = UIColorFromRGB(0x999999);
        
        timeLabel.font = AllFont(13);
        
        [topView addSubview:timeLabel];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(12), Height320(80)-1/[UIScreen mainScreen].scale, MSW-Width320(24), 1/[UIScreen mainScreen].scale)];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [topView addSubview:sep];
        
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), sep.bottom+Height320(11), MSW-Width320(24), Height320(15))];
        
        numLabel.textColor = UIColorFromRGB(0x999999);
        
        numLabel.font = AllFont(13);
        
        NSMutableAttributedString *astr1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"单节可约人数    %ld人",(long)self.course.capacity]];
        
        [astr1 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:NSMakeRange(10, astr1.length-10)];
        
        numLabel.attributedText = astr1;
        
        [topView addSubview:numLabel];
        
        [topView changeHeight:numLabel.bottom+Height320(10)];
        
        if (self.course.type == CourseTypeGroup) {
            
            UILabel *minnumLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), numLabel.bottom+Height320(5), MSW-Width320(24), Height320(15))];
            
            minnumLabel.textColor = UIColorFromRGB(0x999999);
            
            minnumLabel.font = AllFont(13);
            
            NSMutableAttributedString *astr2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"最小上课人数    %ld人",(long)self.course.minNumber]];
            
            [astr2 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:NSMakeRange(10, astr2.length-10)];
            
            minnumLabel.attributedText = astr2;
            
            [topView addSubview:minnumLabel];
            
            UILabel *meassureLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), minnumLabel.bottom+Height320(5), MSW-Width320(24), Height320(15))];
            
            meassureLabel.textColor = UIColorFromRGB(0x999999);
            
            meassureLabel.font = AllFont(13);
            
            NSMutableAttributedString *astr3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"默认课程计划    %@",self.course.meassure.name.length?self.course.meassure.name:@"无"]];
            
            [astr3 addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x333333) range:NSMakeRange(10, astr3.length-10)];
            
            meassureLabel.attributedText = astr3;
            
            [topView addSubview:meassureLabel];
            
            [topView changeHeight:meassureLabel.bottom+Height320(10)];
            
        }
        
    }
    
    if (!AppGym) {
        
        UILabel *suitLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(12), MSW-Width320(32), Height320(14))];
        
        suitLabel.text = @"适用场馆";
        
        suitLabel.textColor = UIColorFromRGB(0x999999);
        
        suitLabel.font = AllFont(12);
        
        [self.mainView addSubview:suitLabel];
        
        UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(36), MSW, Height320(40))];
        
        secondView.backgroundColor = UIColorFromRGB(0xffffff);
        
        [self.mainView addSubview:secondView];
        
        self.suitCell = [[MOCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
        
        self.suitCell.titleLabel.text = @"适用场馆";
        
        self.suitCell.noLine = YES;
        
        self.suitCell.mustInput = YES;
        
        if (self.course.gyms.count>1) {
            
            self.suitCell.subtitle = [NSString stringWithFormat:@"%ld家",(unsigned long)self.course.gyms.count];
            
        }else if (self.course.gyms.count == 1){
            
            self.suitCell.subtitle = ((Gym*)[self.course.gyms firstObject]).name;
            
        }
        
        [self.suitCell addTarget:self action:@selector(suitChoose) forControlEvents:UIControlEventTouchUpInside];
        
        [secondView addSubview:self.suitCell];
        
        self.mainView.contentSize = CGSizeMake(0, secondView.bottom+Height320(20));
        
    }else{
        
        if (!self.isAdd) {
            
            UILabel *suitLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(12), MSW-Width320(32), Height320(14))];
            
            suitLabel.text = @"适用场馆";
            
            suitLabel.textColor = UIColorFromRGB(0x999999);
            
            suitLabel.font = AllFont(12);
            
            [self.mainView addSubview:suitLabel];
            
            if (!((AppDelegate*)[UIApplication sharedApplication].delegate).oneGym) {
                
                UIImageView *suitHintImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), suitLabel.bottom+Height320(4), Width320(14), Height320(14))];
                
                suitHintImg.image = [UIImage imageNamed:@"hint_circle"];
                
                [self.mainView addSubview:suitHintImg];
                
                UILabel *suitHintLabel = [[UILabel alloc]initWithFrame:CGRectMake(suitHintImg.right+Width320(6), suitLabel.bottom+Height320(4), MSW-suitHintImg.right-Width320(22), Height320(16))];
                
                suitHintLabel.text = @"请在「连锁运营」中修改适用场馆";
                
                suitHintLabel.textColor = UIColorFromRGB(0x999999);
                
                suitHintLabel.font = AllFont(12);
                
                [self.mainView addSubview:suitHintLabel];
                
            }
            
            self.gymListView = [[UITableView alloc]initWithFrame:CGRectMake(0, ((AppDelegate*)[UIApplication sharedApplication].delegate).oneGym?topView.bottom+Height320(35):topView.bottom+Height320(55), MSW, self.course.gyms.count*Height320(40))];
            
            self.gymListView.backgroundColor = UIColorFromRGB(0xffffff);
            
            self.gymListView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
            
            self.gymListView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
            
            self.gymListView.dataSource = self;
            
            self.gymListView.delegate = self;
            
            self.gymListView.userInteractionEnabled = NO;
            
            self.gymListView.separatorInset = UIEdgeInsetsMake(0, Width320(16), 0, Width320(16));
            
            [self.gymListView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
            
            self.gymListView.tableFooterView = [UIView new];
            
            [self.mainView addSubview:self.gymListView];
            
            self.mainView.contentSize = CGSizeMake(0, self.gymListView.bottom+Height320(20));
            
        }
        
    }
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)suitChoose
{
    
    CourseGymController *svc = [[CourseGymController alloc]init];
    
    svc.course = self.course;
    
    svc.isAdd = self.isAdd;
    
    __weak typeof(self)weakS = self;
    
    svc.chooseFinish = ^{
       
        weakS.suitCell.subtitle = weakS.course.gyms.count == 1?((Gym*)[weakS.course.gyms firstObject]).name:[NSString stringWithFormat:@"%ld家",(unsigned long)weakS.course.gyms.count];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)messureChoose
{
    
    CourseMeassureController *svc = [[CourseMeassureController alloc]init];
    
    svc.course = self.course;
    
    __weak typeof(self)weakS = self;
    
    svc.chooseFinish = ^{
       
        weakS.meassureCell.subtitle = weakS.course.meassure?weakS.course.meassure.name:@"无";
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}


-(void)getImage
{
    
    [self.nameTF resignFirstResponder];
    
    [self.timeTF resignFirstResponder];
    
    UIActionSheet *actionSheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传课程图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    }else{
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传课程图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
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
    
    self.course.image = [UIImage fixOrientation:[info objectForKey:UIImagePickerControllerEditedImage]];
    
    [self.icon setImage:self.course.image];
    
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
    
    [uy uploadImage:self.course.image savekey:url];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
        
    [textField resignFirstResponder];
    
    return YES;
    
}

-(BOOL)checkNext
{
    
    if (!self.nameTF.text.length) {
        
        [self errorWithMessage:@"课程名称尚未填写"];
        
        return NO;
        
    }
    
    if (!self.timeTF.text.length) {
        
        [self errorWithMessage:@"课程时长尚未填写"];
        
        return NO;
        
    }
    
    if (self.course.type == CourseTypeGroup) {
        
        if (!self.minNumTF.text.length) {
            
            [self errorWithMessage:@"最小上课人数尚未填写"];
            
            return NO;
            
        }
        
    }
    
    if (!self.course.gyms.count && !AppGym) {
        
        [self errorWithMessage:@"请选择适用场馆"];
     
        return NO;
        
    }
    
    return YES;
    
}

-(void)errorWithMessage:(NSString *)message
{
    
    [[[UIAlertView alloc]initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        CourseListInfo *info = [[CourseListInfo alloc]init];
        
        [info deleteCourse:self.course result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = @"删除成功";
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                if (self.editFinish) {
                    self.editFinish();
                }
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                });
                
            }
            
        }];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.course.gyms.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Gym *gym = self.course.gyms[indexPath.row];
    
    cell.textLabel.text = gym.name;
    
    cell.textLabel.font = AllFont(14);
    
    cell.textLabel.textColor = UIColorFromRGB(0x333333);
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(40);
    
}

-(void)naviRightClick
{
    
    CourseListInfo *info = [[CourseListInfo alloc]init];
    
    if (self.isAdd) {
        
        BOOL canNext = [self checkNext];
        
        if (!canNext) {
            
            return;
            
        }
        
        self.course.name = self.nameTF.text;
        
        self.course.during = [self.timeTF.text integerValue];
        
        self.course.minNumber = [self.minNumTF.text integerValue];
        
        self.course.capacity = [self.capacityTF.text integerValue];
        
        self.rightButtonEnable = NO;
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"";
        
        [self.hud showAnimated:YES];
        
        [info createCourse:self.course result:^(BOOL success, NSString *error) {
            
            self.rightButtonEnable = YES;
            
            if (success) {
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = @"创建成功";
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                if (self.editFinish) {
                    self.editFinish();
                }
                
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
        
        Permission *permission;
        
        if (self.course.type == CourseTypeGroup) {
            
            permission = [PermissionInfo sharedInfo].permissions.groupPermission;
            
        }else{
            
            permission = [PermissionInfo sharedInfo].permissions.privatePermission;
            
        }
        
        if ((AppGym &&permission.editState)||(!AppGym && [[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.course.gyms andPermission:permission andType:PermissionTypeEdit]==PermissionStateAll)) {
            
            BOOL canNext = [self checkNext];
            
            if (!canNext) {
                
                return;
                
            }
            
            self.course.name = self.nameTF.text;
            
            self.course.during = [self.timeTF.text integerValue];
            
            self.course.minNumber = [self.minNumTF.text integerValue];
            
            self.course.capacity = [self.capacityTF.text integerValue];
            
            self.rightButtonEnable = NO;
            
            self.hud.mode = MBProgressHUDModeIndeterminate;
            
            self.hud.label.text = @"";
            
            [self.hud showAnimated:YES];
            
            [info editCourse:self.course result:^(BOOL success, NSString *error) {
                
                if (success) {
                    
                    if (AppGym) {
                        
                        self.rightButtonEnable = YES;
                        
                        self.hud.mode = MBProgressHUDModeText;
                        
                        self.hud.label.text = @"修改成功";
                        
                        [self.hud showAnimated:YES];
                        
                        [self.hud hideAnimated:YES afterDelay:1.5];
                        
                        if (self.editFinish) {
                            self.editFinish();
                        }
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [self.navigationController popViewControllerAnimated:YES];
                            
                        });
                        
                    }else{
                        
                        CourseListInfo *tempInfo = [[CourseListInfo alloc]init];
                        
                        [tempInfo changeGymWithCourse:self.course result:^(BOOL success, NSString *error) {
                            
                            self.rightButtonEnable = YES;
                            
                            if (success) {
                                
                                self.hud.mode = MBProgressHUDModeText;
                                
                                self.hud.label.text = @"修改成功";
                                
                                [self.hud showAnimated:YES];
                                
                                [self.hud hideAnimated:YES afterDelay:1.5];
                                
                                if (self.editFinish) {
                                    self.editFinish();
                                }
                                
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [self.navigationController popViewControllerAnimated:YES];
                                    
                                });
                                
                            }else{
                                
                                self.hud.mode = MBProgressHUDModeText;
                                
                                self.hud.label.text = error;
                                
                                self.hud.label.numberOfLines = 0;
                                
                                [self.hud hideAnimated:YES afterDelay:1.5];
                                
                            }
                            
                        }];
                        
                    }
                    
                }else{
                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    self.hud.label.text = error;
                    
                    self.hud.label.numberOfLines = 0;
                    
                    [self.hud hideAnimated:YES afterDelay:1.5];
                    
                }
                
            }];
            
        }else if (!AppGym){
            
            self.rightButtonEnable = NO;
            
            self.hud.mode = MBProgressHUDModeIndeterminate;
            
            self.hud.label.text = @"";
            
            [self.hud showAnimated:YES];
            
            [info changeGymWithCourse:self.course result:^(BOOL success, NSString *error) {
                
                self.rightButtonEnable = YES;
                
                if (success) {
                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    self.hud.label.text = @"修改成功";
                    
                    [self.hud showAnimated:YES];
                    
                    [self.hud hideAnimated:YES afterDelay:1.5];
                    
                    if (self.editFinish) {
                        self.editFinish();
                    }
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
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
    
}

@end
