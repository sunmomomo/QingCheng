//
//  StudentEditController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "StudentEditController.h"

#import "QCTextField.h"

#import "MOPickerView.h"

#import "QCKeyboardView.h"

#import "UpYun.h"

#import "YFStudentListVC.h"

#import "StudentChooseGymController.h"

#import "CardChooseStudentController.h"

#import "MOCell.h"

#import <AVFoundation/AVFoundation.h>

#import "StudentSellerController.h"

#import "StaffUserInfo.h"

#import "SellerUserAddController.h"

#import "CountryChooseTextField.h"

#import "StudentCoachController.h"

#import "YFAddOriginVC.h"
#import "YFChooseRecoVC.h"
#import "YFStudnetOriginVC.h"
#import "YFHttpService.h"

@interface StudentEditController ()<UITextFieldDelegate,QCKeyboardViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *sexTF;

@property(nonatomic,strong)CountryChooseTextField *phoneTF;

@property(nonatomic,strong)QCTextField *birthTF;

@property(nonatomic,strong)QCTextField *addressTF;

@property(nonatomic,strong)MOCell *remarkCellF;


@property(nonatomic,strong)MOCell *gymCell;

@property(nonatomic,strong)MOCell *sellerCell;
@property(nonatomic,strong)MOCell *coachCell;
@property(nonatomic,strong)MOCell *originCell;
@property(nonatomic,strong)MOCell *recommendCell;
@property(nonatomic,copy)NSString *recommendId;


@property(nonatomic,strong)MOPickerView *sexPV;

@property(nonatomic,strong)UIDatePicker *birthDP;

@property(nonatomic,strong)NSArray *sexArray;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UIImage *image;

@end

@implementation StudentEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createData];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.sexArray = @[@"男",@"女"];
    
    if (self.isAdd) {
        
        self.studentInfo = [[StudentDetailInfo alloc]initWithStudent:[[Student alloc]init]];
        
    }
    
    if (self.isAdd &&!self.gym.permissions.userPermission.addState) {
        
        StaffUserInfo *info = [[StaffUserInfo alloc]init];
        
        [info requestResult:^(BOOL success, NSString *error) {
            
            self.sellerCell.subtitle = info.staff.name;
            
        }];
        
    }
    
}

-(void)createUI
{
    
    self.title = self.isAdd?@"添加会员":@"编辑会员资料";
    
    if (self.isAdd)
    {
        self.rightTitle = @"确定";
    }
    else
    {
        self.rightTitle = @"保存";
    }
    
    
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.delegate = self;
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.mainView];
    
    if (self.isAdd) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:Height320(5)];
        
        NSString *labelText = @"     添加会员照片可以帮助工作人员在签到、预约时辨别会员真实身份";
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, labelText.length)];
        
        CGSize size = [labelText boundingRectWithSize:CGSizeMake(MSW-Width320(37),Height320(36)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12),NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
        
        UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(12), size.width, size.height)];
        
        hintLabel.attributedText = attributedString;
        
        hintLabel.textColor = UIColorFromRGB(0x999999);
        
        hintLabel.font = AllFont(12);
        
        hintLabel.numberOfLines = 0;
        
        [self.mainView addSubview:hintLabel];
        
        UIImageView *hintImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width320(12),Height320(12))];
        
        hintImg.image = [UIImage imageNamed:@"hint_circle"];
        
        [hintLabel addSubview:hintImg];
        
    }
    
    UIButton *topView = [[UIButton alloc]initWithFrame:CGRectMake(0, self.isAdd?Height320(56):0, MSW, Height320(72))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.mainView addSubview:topView];
    
    [topView addTarget:self action:@selector(cameraClick) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *topLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(120), topView.height)];
    
    topLabel.text = self.isAdd?@"会员照片":@"头像";
    
    topLabel.textColor = UIColorFromRGB(0x999999);
    
    topLabel.font = AllFont(14);
    
    topLabel.userInteractionEnabled = NO;
    
    [topView addSubview:topLabel];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(77), Height320(12), Width320(48), Height320(48))];
    
    self.iconView.layer.borderWidth = 1;
    
    self.iconView.userInteractionEnabled = NO;
    
    self.iconView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
    
    if (!self.isAdd) {
        
        self.iconView.layer.cornerRadius = self.iconView.width/2;
        
        self.iconView.layer.masksToBounds = YES;
        
        if (self.studentInfo.student.avatar.absoluteString.length) {
            
            [self.iconView sd_setImageWithURL:self.studentInfo.student.avatar];
            
        }else{
            
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.studentInfo.student.sex == SexTypeWoman?@"http://zoneke-img.b0.upaiyun.com/f1ac90184acb746e4fbdef4b61dcd6f6.png":@"http://zoneke-img.b0.upaiyun.com/977ad17699c4e4212b52000ed670091a.png"]];
            
        }
        
    }else{
        
        self.iconView.image = [UIImage imageNamed:@"cameraplaceholder"];
        
    }
    
    [topView addSubview:self.iconView];
    
    UIImageView *topArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.4), Height320(30), Width320(7.4), Height320(12))];
    
    topArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [topView addSubview:topArrow];
    
    UIView *secondView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(12),MSW, Height320(240))];
    
    secondView.backgroundColor = UIColorFromRGB(0xffffff);
    
    secondView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    secondView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.mainView addSubview:secondView];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.nameTF.placeholder = @"姓名";
    
    self.nameTF.textPlaceholder = @"填写姓名";
    
    self.nameTF.mustInput = YES;
    
    self.nameTF.text = self.studentInfo.student.name;
    
    self.nameTF.delegate = self;
    
    [secondView addSubview:self.nameTF];
    
    self.sexTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.sexTF.placeholder = @"性别";
    
    self.sexTF.mustInput = YES;
    
    if (self.isAdd) {
        
        self.sexTF.text = @"男";
        
    }else{
        
        self.sexTF.text = self.studentInfo.student.sex == SexTypeWoman?@"女":@"男";
        
    }
    
    self.sexTF.delegate = self;
    
    [secondView addSubview:self.sexTF];
    
    self.sexPV = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.sexPV.titleArray = self.sexArray;
    
    QCKeyboardView *sexKV = [QCKeyboardView defaultKeboardView];
    
    sexKV.keyboard = self.sexPV;
    
    sexKV.tag = 101;
    
    sexKV.delegate = self;
    
    self.sexTF.inputView = sexKV;
    
    self.phoneTF = [[CountryChooseTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.sexTF.bottom, self.nameTF.width, self.nameTF.height)];

    self.phoneTF.mustInput = YES;
    
    if (self.studentInfo.student.phone) {
        
        self.phoneTF.text = self.studentInfo.student.phone;
        
    }
    
    if (self.studentInfo.student.country) {
        
        self.phoneTF.country = self.studentInfo.student.country;
        
    }
    
    self.phoneTF.delegate = self;
    
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [secondView addSubview:self.phoneTF];
    
    self.birthTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.phoneTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.birthTF.placeholder = @"生日";
    
    self.birthTF.textPlaceholder = @"选填";
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.dateFormat = @"yyyy-MM-dd";
    
    self.birthTF.text = self.studentInfo.student.birth;
    
    self.birthTF.delegate = self;
    
    [secondView addSubview:self.birthTF];
    
    QCKeyboardView *birthKV = [QCKeyboardView defaultKeboardView];
    
    birthKV.tag = 102;
    
    birthKV.delegate = self;
    
    self.birthTF.inputView = birthKV;
    
    self.birthDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.birthDP.datePickerMode = UIDatePickerModeDate;
    
    self.birthDP.maximumDate = [NSDate date];
    
    birthKV.keyboard = self.birthDP;
    // 地址
    self.addressTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.birthTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.addressTF.noLine = NO;
    
    self.addressTF.placeholder = @"地址";
    
    self.addressTF.textPlaceholder = @"选填";
    
    self.addressTF.text = self.studentInfo.student.address;
    
    self.addressTF.delegate = self;
    [secondView addSubview:self.addressTF];

    // 备注
    self.remarkCellF = [[MOCell alloc]initWithFrame:CGRectMake(self.addressTF.left, self.addressTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.remarkCellF.titleLabel.text = @"备注";
    
    self.remarkCellF.placeholder = @"请填写";
    
    self.remarkCellF.subtitleColor = UIColorFromRGB(0x333333);
    self.remarkCellF.subtitle= self.studentInfo.student.remarks;
    [secondView addSubview:self.remarkCellF];
    
    secondView.frame = CGRectMake(secondView.mj_x, secondView.mj_y, secondView.width, self.remarkCellF.bottom);
    
    [self.remarkCellF addTarget:self action:@selector(chooseRemark:) forControlEvents:UIControlEventTouchUpInside];

    
    self.mainView.contentSize = CGSizeMake(MSW, secondView.bottom + 25);
    
    
    if (self.isAdd) {
        
        UIView *thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, secondView.bottom+Height320(12), MSW, Height320(40 * 4))];
        
        thirdView.backgroundColor = UIColorFromRGB(0xffffff);
        
        thirdView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        thirdView.layer.borderWidth = OnePX;
        
        [self.mainView addSubview:thirdView];
        
        self.sellerCell = [[MOCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
        
        self.sellerCell.titleLabel.text = @"分配销售";
        
        self.sellerCell.placeholder = @"请选择";
        
        self.sellerCell.subtitleColor = UIColorFromRGB(0x333333);
        
        [thirdView addSubview:self.sellerCell];
        
        if (!self.gym.permissions.userPermission.addState) {
            
            self.sellerCell.userInteractionEnabled = NO;
            
        }
        
        [self.sellerCell addTarget:self action:@selector(chooseSeller:) forControlEvents:UIControlEventTouchUpInside];
        
        self.coachCell = [[MOCell alloc]initWithFrame:CGRectMake(self.sellerCell.left, self.sellerCell.bottom, self.sellerCell.width, self.sellerCell.height)];
        
        self.coachCell.titleLabel.text = @"分配教练";
        
        self.coachCell.placeholder = @"请选择";
        
        self.coachCell.subtitleColor = UIColorFromRGB(0x333333);
        
        [thirdView addSubview:self.coachCell];
        
        if (!self.gym.permissions.userPermission.addState) {
            
            self.coachCell.userInteractionEnabled = NO;
            
        }
        
        [self.coachCell addTarget:self action:@selector(chooseCoach:) forControlEvents:UIControlEventTouchUpInside];
        
        self.originCell = [[MOCell alloc]initWithFrame:CGRectMake(self.coachCell.left, self.coachCell.bottom, self.coachCell.width, self.coachCell.height)];
        
        self.originCell.titleLabel.text = @"来源";
        
        self.originCell.placeholder = @"请选择";
        
        self.originCell.subtitleColor = UIColorFromRGB(0x333333);
        
        [self.originCell addTarget:self action:@selector(originCellAction:) forControlEvents:UIControlEventTouchUpInside];

        
        [thirdView addSubview:self.originCell];
        
        self.recommendCell = [[MOCell alloc]initWithFrame:CGRectMake(self.sellerCell.left, self.originCell.bottom, self.sellerCell.width, self.sellerCell.height)];
        
        self.recommendCell.titleLabel.text = @"推荐人";
        
        self.recommendCell.placeholder = @"查找推荐人";
        
        self.recommendCell.subtitleColor = UIColorFromRGB(0x333333);
        
        [self.recommendCell addTarget:self action:@selector(recommendCellAction:) forControlEvents:UIControlEventTouchUpInside];

        
        [thirdView addSubview:self.recommendCell];
        [thirdView changeHeight:self.recommendCell.bottom];
        
        self.mainView.contentSize = CGSizeMake(MSW, thirdView.bottom + 25);
    }
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)chooseSeller:(MOCell*)cell
{
    
    [self.view endEditing:YES];
    
    if ([PermissionInfo sharedInfo].permissions.userPermission.addState) {
        
        StudentSellerController *svc = [[StudentSellerController alloc]init];
        
        svc.gym = self.gym;
        
        svc.student = self.studentInfo.student;
        
        __weak typeof(self)weakS = self;
        
        svc.chooseFinish = ^(NSArray *sellers){
            
            weakS.studentInfo.student.sellers = sellers;
            
            NSString *sellersStr = @"";
            
            for (NSInteger i = 0 ; i<sellers.count; i++) {
                
                Seller *tempSeller = sellers[i];
                
                sellersStr = [sellersStr stringByAppendingString:tempSeller.name];
                
                if (i<sellers.count-1) {
                    
                    sellersStr = [sellersStr stringByAppendingString:@"，"];
                    
                }
                
            }
            
            weakS.sellerCell.subtitle =  sellersStr;
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

-(void)chooseCoach:(MOCell*)cell
{
    
    [self.view endEditing:YES];
    
    if ([PermissionInfo sharedInfo].permissions.userPermission.addState) {
        
        StudentCoachController *svc = [[StudentCoachController alloc]init];
        
        svc.gym = self.gym;
        
        svc.student = self.studentInfo.student;
        
        __weak typeof(self)weakS = self;
        
        svc.chooseFinish = ^(NSArray *coaches){
            
            weakS.studentInfo.student.coaches = coaches;
            
            NSString *coachesStr = @"";
            
            for (NSInteger i = 0 ; i<coaches.count; i++) {
                
                Coach *tempCoach = coaches[i];
                
                coachesStr = [coachesStr stringByAppendingString:tempCoach.name];
                
                if (i<coaches.count-1) {
                    
                    coachesStr = [coachesStr stringByAppendingString:@"，"];
                    
                }
                
            }
            
            weakS.coachCell.subtitle =  coachesStr;
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
 
    if (keyboardView.tag == 101) {
        
        self.sexTF.text = self.sexArray[self.sexPV.currentRow];
        
        [self.sexTF resignFirstResponder];
        
        if (!self.studentInfo.student.avatar.absoluteString.length && !self.isAdd) {
            
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:[self.sexTF.text isEqualToString:@"女"]?@"http://zoneke-img.b0.upaiyun.com/f1ac90184acb746e4fbdef4b61dcd6f6.png":@"http://zoneke-img.b0.upaiyun.com/977ad17699c4e4212b52000ed670091a.png"]];
            
        }
        
    }else
    {
        
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        
        df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        df.dateFormat = @"yyyy-MM-dd";
        
        self.birthTF.text = [df stringFromDate:self.birthDP.date];
        
        [self.birthTF resignFirstResponder];
        
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
    
}


-(void)cameraClick
{
    
    [self.view endEditing:YES];
    
    UIActionSheet *actionSheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[UIActionSheet alloc]initWithTitle:self.isAdd?@"上传会员照片":@"上传头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    }else{
        actionSheet = [[UIActionSheet alloc]initWithTitle:self.isAdd?@"上传会员照片":@"上传头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
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
    
    if (self.isAdd) {
        
        self.studentInfo.student.photo = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
        
    }else{
        
        self.studentInfo.student.avatar = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
        
    }
    
    [uy uploadImage:self.image savekey:url];
    
}

-(void)naviRightClick
{
    
    if (self.nameTF.text.length && self.sexTF.text.length && self.phoneTF.text.length) {
        
        self.studentInfo.student.name = self.nameTF.text;
        
        self.studentInfo.student.sex = [self.sexTF.text isEqualToString:@"女"]?SexTypeWoman:SexTypeMan;
        
        self.studentInfo.student.phone = self.phoneTF.text;
        
        self.studentInfo.student.country = self.phoneTF.country;
        
        self.studentInfo.student.birth = self.birthTF.text;
        
        self.studentInfo.student.address = self.addressTF.text;
        
        self.studentInfo.student.origin = self.originCell.subtitle;
        
        self.studentInfo.student.remarks = self.remarkCellF.subtitle;
        
        self.studentInfo.student.recommend_by_id = self.recommendId;
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"";
        
        [self.hud showAnimated:YES];
        
        if (self.isAdd) {
            
            self.studentInfo.student.gyms = @[self.gym];
            
            [self.studentInfo createStudent:self.studentInfo.student result:^(BOOL success, NSString *error,Student *stu) {
                
                if (success) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kPostModifyOrAddStudentIdtifierYF object:nil];

                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    self.hud.label.text = @"添加成功";
                    
                    [self.hud showAnimated:YES];
                    
                    [self.hud hideAnimated:YES afterDelay:1.5];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        if (self.addFinish) {
                            self.addFinish();
                        }
                        
                        if (self.gym) {
                            
                            for (MOViewController *vc in self.navigationController.viewControllers) {
                                
                                if ([vc isKindOfClass:[CardChooseStudentController class]]) {
                                    
                                    [vc reloadData];
                                    
                                    [((CardChooseStudentController *)vc) chooseStudent:stu];
                                    
                                    [self.navigationController popToViewController:vc animated:YES];
                                    
                                    return;
                                    
                                }
                                
                            }
                            
                          
                            
                            if ([self.navigationController.visibleViewController isKindOfClass:[StudentEditController class]]) {
                                
                                for (UIViewController *vc in self.navigationController.viewControllers) {
                                    
                                    if ([vc isKindOfClass:[YFStudentListVC class]]) {
                                        
                                        [self.navigationController popToViewController:vc animated:YES];
                                        
                                    }
                                  
                                    
                                }
                                
                            }
                            
                        }else{
                            
                            for (UIViewController *vc in self.navigationController.viewControllers) {
                                
                                if ([vc isKindOfClass:[YFStudentListVC class]]) {
                                    
                                    [self.navigationController popToViewController:vc animated:YES];
                                    
                                }
                                
                            }
                            
                        }
                        
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
            
        }else{
            
            [self.studentInfo changeStudent:self.studentInfo.student result:^(BOOL success, NSString *error) {
                
                if (success) {
                    [[YFHttpService sharedInstance] setInfo:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:kPostModifyOrAddStudentIdtifierYF object:nil];

                    self.hud.mode = MBProgressHUDModeText;
                    
                    self.hud.label.text = @"修改成功";
                    
                    [self.hud showAnimated:YES];
                    
                    [self.hud hideAnimated:YES afterDelay:1.5];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        if (self.editFinish) {
                            self.editFinish();
                        }
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
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
        
    }else
    {
        
        [[[UIAlertView alloc]initWithTitle:@"信息填写不完整" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    }
}

- (void)chooseRemark:(UIButton *)button
{
    YFAddOriginVC *addTextVC = [[YFAddOriginVC alloc] init];
    addTextVC.title = @"填写备注";
    addTextVC.valueText = self.remarkCellF.subtitle;
    addTextVC.placeHolderText = @"填写备注";
    weakTypesYF
    [addTextVC setSelelctBlock:^(NSString *remarkStr) {
        weakS.remarkCellF.subtitle = remarkStr;
        weakS.studentInfo.student.remarks = remarkStr;
        [weakS.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationController pushViewController:addTextVC animated:YES];
}

- (void)originCellAction:(UIButton *)button
{
    
    [self.view endEditing:YES];
    
    YFStudnetOriginVC *studentOriginVC = [[YFStudnetOriginVC alloc] init];
    studentOriginVC.isFilter = NO;
    studentOriginVC.title = @"来源";
    studentOriginVC.isCanAdd = YES;
    studentOriginVC.selectName = self.originCell.subtitle;
    studentOriginVC.gym = self.gym;
    weakTypesYF
    __weak typeof(studentOriginVC)weakVC = studentOriginVC;
    [studentOriginVC setSelectBlock:^{
        weakS.originCell.subtitle = weakVC.selectModel.name;
        weakS.studentInfo.student.remarks = weakVC.selectModel.name;

        [weakS.navigationController popToViewController:weakS animated:YES];
    }];
    [self.navigationController pushViewController:studentOriginVC animated:YES];

    
//    YFAddOriginVC *addTextVC = [[YFAddOriginVC alloc] init];
//    addTextVC.title = @"添加新来源";
//    addTextVC.valueText = self.originCell.subtitle;
//    addTextVC.placeHolderText = @"请输入来源";
//    weakTypesYF
//    [addTextVC setSelelctBlock:^(NSString *remarkStr) {
//        weakS.originCell.subtitle = remarkStr;
//    }];
//    [self.navigationController pushViewController:addTextVC animated:YES];
}

- (void)recommendCellAction:(UIButton *)button
{
    YFChooseRecoVC *recoVC = [[YFChooseRecoVC alloc] init];
    weakTypesYF
    __weak typeof(recoVC)weakVC = recoVC;
    [recoVC setSelectBlock:^{
        weakS.recommendCell.subtitle = weakVC.selectModel.username;
        weakS.recommendId = weakVC.selectModel.r_id;
        [weakS.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationController pushViewController:recoVC animated:YES];
}

@end
