//
//  StudentDetailController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/11/18.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "StudentDetailController.h"

#import "StudentDetailInfo.h"

#import "ChooseView.h"

#import "WebViewController.h"

#import "ReportCell.h"

#import "CardCell.h"

#import "FollowRecordTextCell.h"

#import "FollowRecordImageCell.h"

#import "FollowRecordToolView.h"

#import "CardCreateChooseKindController.h"

#import "CardDetailController.h"

#import "StudentEditController.h"

#import "PictureShowController.h"

#import "MeasuresListController.h"

#import "UpYun.h"

#import <AVFoundation/AVFoundation.h>

#import "AgentInfo.h"

#import "AgentController.h"

#import "CardCreateChooseGymController.h"

#import "StudentDeleteGymController.h"

#import "StudentCheckinPhotoController.h"

#import "CheckinPhotoHistoryInfo.h"

#import "StudentChooseGymController.h"

#import "StudentSellerController.h"

#import "StudentCoachController.h"

#import "StudentSellerGymController.h"
#import "YFStudentListVC.h"
#import "YFButton.h"
#import "YFAppService.h"
#import "YFModuleManager.h"
#import "YFStudnetOriginVC.h"

#import "StudentIntegralController.h"

#import "IntegralHistoryInfo.h"

#import "IntegralSettingInfo.h"

#import "YFStuDetaiRecoHeaderView.h"

#import "YFGymPopView.h"

static NSString *reportIdentifier = @"Report";

static NSString *cardIdentifier = @"Card";

static NSString *followTextIdentifier = @"Text";

static NSString *followImgIdentifier = @"Image";

@interface StudentDetailController ()<MONaviDelegate,ChooseViewDatasource,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,FollowRecordImageCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,FollowRecordToolViewDelegate>

@property(nonatomic,strong)StudentDetailInfo *studentInfo;

@property(nonatomic,strong)UIImageView *icon;

@property(nonatomic,strong)UIImageView *photoView;

@property(nonatomic,strong)UIImageView *sexImg;

@property(nonatomic,strong)UILabel *nameLabel;


@property(nonatomic,strong)UILabel *typeLabel;
@property(nonatomic,strong)UIView *typeColorView;


@property(nonatomic,strong)ChooseView *chooseView;

@property(nonatomic,strong)UITableView *recordTableView;

@property(nonatomic,strong)UITableView *cardTableView;

@property(nonatomic,strong)UITableView *followTableView;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UILabel *bodyTestTime;

@property(nonatomic,strong)UIImagePickerController *imagePickerController;

@property(nonatomic,strong)FollowRecordToolView *toolView;

@property(nonatomic,strong)UILabel *phoneLabel;

@property(nonatomic,strong)UILabel *birthLabel;

@property(nonatomic,strong)UILabel *addressLabel;

@property(nonatomic,strong)UILabel *registerTimeLabel;

@property(nonatomic,assign)BOOL isCheckinPhoto;

// 来源 label
@property(nonatomic,strong)UILabel *originLabel;
// 会员积分
@property(nonatomic,strong)UILabel *pointsLabel;

@property(nonatomic,strong)UILabel *integralLabel;

@property(nonatomic,assign)BOOL integralUsed;

// 推荐 label
@property(nonatomic,strong)UILabel *recoLabel;
@property(nonatomic,strong)NSString *recoIdYF;

@property(nonatomic, strong)YFStuDetaiRecoHeaderView *recoHeaderView;

@property(nonatomic, strong)YFGymPopView *popGymView;

@end

@implementation StudentDetailController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
    if ([self.cardTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.cardTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.cardTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.cardTableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

-(void)createData
{
    
    [self.icon sd_setImageWithURL:self.student.avatar];
    
    self.sexImg.image = [UIImage imageNamed:self.student.sex == SexTypeMan?@"sex_male":@"sex_female"];
    
    self.nameLabel.text = self.student.name;
    self.phoneLabel.text = self.student.phone;
    __weak typeof(self)weakS = self;
    
    self.studentInfo = [[StudentDetailInfo alloc]initWithStudent:self.student];
    self.studentInfo.recoShopidParam = self.popGymView.param;
    self.studentInfo.cardDataFinish = ^(BOOL success){
       
        [weakS.cardTableView reloadData];
        
    };
    
    self.studentInfo.followFinish = ^(BOOL success){
        
        [weakS.followTableView reloadData];
        
        if (weakS.followTableView.contentSize.height>weakS.followTableView.height) {
            
            [weakS.followTableView setContentOffset:CGPointMake(0, weakS.followTableView.contentSize.height-weakS.followTableView.height)];
            
        }
        
    };
    
    self.studentInfo.stuFinish = ^(BOOL success){
        
        if (AppGym) {
            
            weakS.typeLabel.hidden = NO;
            weakS.typeColorView.hidden = NO;

            if (weakS.student.type == UserTypeFollowing)
            {
                 weakS.typeLabel.text = @"已接洽";
                weakS.typeColorView.backgroundColor = RGB_YF(249, 148, 78);
            }else if (weakS.student.type == UserTypeNewRegister){
                weakS.typeLabel.text = @"新注册";
                weakS.typeColorView.backgroundColor = RGB_YF(110, 184, 241);

            }else
            {
                weakS.typeLabel.text = @"会员";
                weakS.typeColorView.backgroundColor = RGB_YF(13, 177, 75);
            }
            
            
            
//            weakS.typeLabel.text = weakS.student.type == UserTypeNormal?@"会员":weakS.student.type == UserTypeFollowing?@"已接洽":@"新注册";
            
//            weakS.typeLabel.backgroundColor = weakS.student.type == UserTypeNormal?UIColorFromRGB(0x0DB14B):weakS.student.type == UserTypeFollowing?UIColorFromRGB(0xF9944E):UIColorFromRGB(0x6EB8F1);
            
        }
        
        weakS.nameLabel.text = weakS.student.name;
        weakS.phoneLabel.text = weakS.student.phone;
        [weakS.icon sd_setImageWithURL:weakS.student.avatar];
        
        weakS.sexImg.image = [UIImage imageNamed:weakS.student.sex == SexTypeMan?@"sex_male":@"sex_female"];
        
        [weakS.chooseView reloadAtIndex:3];
        
        weakS.recoIdYF = weakS.student.recommend_by_id;
        weakS.recoLabel.text = weakS.student.recommend_by;
        weakS.originLabel.text = weakS.student.origin;
        
        IntegralSettingInfo *settingInfo = [[IntegralSettingInfo alloc]init];
        
        [settingInfo requestResult:^(BOOL success, NSString *error) {
            
            weakS.integralUsed = settingInfo.setting.used;
            
            if (weakS.integralUsed) {
                
                IntegralHistoryInfo *integralInfo = [[IntegralHistoryInfo alloc]init];
                
                [integralInfo requestWithStudent:weakS.student result:^(BOOL success, NSString *error) {
                    
                    weakS.student.integral = integralInfo.integral;
                    
                    weakS.integralLabel.text = [NSString formatStringWithFloat:integralInfo.integral];
                    
                    [weakS.chooseView reloadAtIndex:3];
                    
                }];
                
            }
            
        }];
        
    };
    
    self.studentInfo.recordFinish = ^(BOOL success){
       
        [weakS.recordTableView setTableHeaderView:weakS.recoHeaderView];

        [weakS.popGymView setGymArray:weakS.studentInfo.gymArray];
        
        [weakS.recordTableView reloadData];
    };
    
    [self.studentInfo request];
    
}

-(void)reloadData
{
    self.studentInfo.recoShopidParam = self.popGymView.param;
    
    [self.studentInfo requestStuInfoWithStudent:self.student];
    
    [self.studentInfo requestCardInfoWithStudent:self.student];
    
}
-(void)reloadRecoData
{
    self.studentInfo.recoShopidParam = self.popGymView.param;

    [self.studentInfo requestRecoWithStu:self.student];
}

-(void)reloadStuInfo
{
    
    __weak typeof(self)weakS = self;
    
    self.studentInfo.stuFinish = ^(BOOL success){
        
        if (AppGym) {
            
            weakS.typeLabel.hidden = NO;
            
            weakS.typeLabel.text = weakS.student.type == UserTypeNormal?@"会员":weakS.student.type == UserTypeFollowing?@"已接洽":@"新注册";
            
        }
        weakS.nameLabel.text = weakS.student.name;
        weakS.phoneLabel.text = weakS.student.phone;
        [weakS.icon sd_setImageWithURL:weakS.student.avatar];
        
        weakS.sexImg.image = [UIImage imageNamed:weakS.student.sex == SexTypeMan?@"sex_male":@"sex_female"];
        
        [weakS.chooseView reloadAtIndex:3];
        
        weakS.recoIdYF = weakS.student.recommend_by_id;
        weakS.recoLabel.text = weakS.student.recommend_by;
        weakS.originLabel.text = weakS.student.origin;

        IntegralHistoryInfo *integralInfo = [[IntegralHistoryInfo alloc]init];
        
        [integralInfo requestWithStudent:weakS.student result:^(BOOL success, NSString *error) {
            
            weakS.student.integral = integralInfo.integral;
            
            weakS.integralLabel.text = [NSString formatStringWithFloat:integralInfo.integral];
            
        }];
        
    };
    
    [self.studentInfo requestStuInfoWithStudent:weakS.student];
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.title = @"会员详情";
    
    self.rightType =  MONaviRightTypeMore;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(121))];
    
    topView.backgroundColor = UIColorFromRGB(0x4e4e4e);
    
    [self.view addSubview:topView];
    
    self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(20), Height320(12), Width320(49), Height320(49))];
    
    self.icon.layer.cornerRadius = self.icon.width/2;
    
    self.icon.layer.masksToBounds = YES;
    
    self.icon.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
    
    self.icon.layer.borderWidth = 1;
    
    [topView addSubview:self.icon];
    
    self.sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.icon.right-Width320(15.3), self.icon.bottom-Height320(16), Width320(14), Height320(14))];
    
    self.sexImg.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.sexImg.layer.borderWidth = 1;
    
    self.sexImg.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
    
    self.sexImg.layer.cornerRadius = self.sexImg.width/2;
    
    self.sexImg.layer.masksToBounds = YES;
    
    [topView addSubview:self.sexImg];
    
    if (AppGym) {
        
        self.typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(54), Height320(20), Width320(35), Height320(11))];
        
        self.typeLabel.textColor = UIColorFromRGB(0xffffff);
        
        self.typeLabel.font = AllFont(11);
        
        self.typeLabel.textAlignment = NSTextAlignmentLeft;
        
        [topView addSubview:self.typeLabel];
        
        self.typeLabel.hidden = YES;
        
        self.typeColorView = [[UILabel alloc]initWithFrame:CGRectMake(self.typeLabel.left - Width320(10), self.typeLabel.top + Height320(2), Width320(6), Height320(6))];
        self.typeColorView.layer.cornerRadius = self.typeColorView.width / 2.0;
        self.typeColorView.layer.masksToBounds = YES;
        [topView addSubview:self.typeColorView];
        
        self.typeColorView.hidden = YES;

        
        
        
    }
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(78), self.icon.top + Height320(3), MSW-Width320(78) - 90.0, Height320(20))];
    
    self.nameLabel.textColor = UIColorFromRGB(0xffffff);
    
    self.nameLabel.font = AllFont(14);
    
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
//    self.nameLabel.backgroundColor = [UIColor redColor];
    [topView addSubview:self.nameLabel];
    
    self.phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom + Height320(2), self.nameLabel.width, Height320(20))];
    
    self.phoneLabel.textColor = UIColorFromRGB(0xffffff);
    
    self.phoneLabel.font = AllFont(14);
    
    self.phoneLabel.textAlignment = NSTextAlignmentLeft;
    
    [topView addSubview:self.phoneLabel];
    
    CGFloat buttonWidth = MSW / 2.0;
    
    for (NSUInteger i = 0; i < 2; i ++)
    {
        YFButton *button = [[YFButton alloc] initWithFrame:CGRectMake(0 + (buttonWidth + 0.5) * i, topView.height - Height320(40.0), buttonWidth - 0.5, Height320(40)) imageFrame:CGRectMake(Width320(40.0), Height320(12.5), Width320(15.0), Height320(15.0)) titleFrame:CGRectMake(Width320(68), Height320(13.5), Width320(50.0), Height320(12.0))];
        [button setBackgroundColor:RGB_YF(61, 61, 61)];
        if (i == 0)
        {
            [button setTitle:@"拨打电话" forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"phoneStudentDetai"] forState:UIControlStateNormal];
        }else
        {
            [button setTitle:@"发送短信" forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"smsStudentDetai"] forState:UIControlStateNormal];

        }
        button.tag = i + 1;
        [button addTarget:self action:@selector(buttonPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:FontSizeFY(Width320(12.0))];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];

        [topView addSubview:button];
    }
    
    
    
    
    
    
    self.chooseView = [[ChooseView alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, MSH-topView.bottom)];
    
    self.chooseView.rowHeight = Height320(36);
    
    self.chooseView.rowWidth = Width320(58.7);
    
    self.chooseView.rowGap = Width320(10);
    
    self.chooseView.datasource = self;
    
    self.chooseView.noRefresh = YES;
    
    [self.view addSubview:self.chooseView];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    [self.hud hideAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    if (self.selectIndex > 0)
    {
        self.chooseView.selectNum = self.selectIndex;
        [self.chooseView reload];
    }
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    
    NSDictionary *userInfo = notification.userInfo;
    
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        
        if (keyboardF.origin.y >= MSH) {
            
            [self.followTableView changeHeight:self.chooseView.height-self.chooseView.rowHeight-self.toolView.height];
            
            [self.toolView changeTop:self.followTableView.bottom];
            
        }else
        {
            
            [self.followTableView changeHeight:self.chooseView.height-self.chooseView.rowHeight-keyboardF.size.height-self.toolView.height];
            
            [self.toolView changeTop:self.followTableView.bottom];
            
        }
        
    }];
    
}

-(NSInteger)numberOfRowInChooseView
{
    
    return 4;
    
}

-(NSString *)titleForButtonAtRow:(NSInteger)row
{
    
    return @[@"出勤记录",@"会员卡",@"跟进记录",@"更多信息"][row];
    
}

-(UIScrollView *)viewForRow:(NSInteger)row
{
    
    if (row == 0) {
        
        UIScrollView *recordView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.chooseView.height-self.chooseView.rowHeight)];
        
        self.recordTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MSW, recordView.height-Height320(40)) style:UITableViewStylePlain];
        
        self.recordTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        self.recordTableView.dataSource = self;
        
        self.recordTableView.delegate = self;
        
        self.recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.recordTableView registerClass:[ReportCell class] forCellReuseIdentifier:reportIdentifier];
        
        self.recordTableView.tableFooterView = [UIView new];
        
        
        [recordView addSubview:self.recordTableView];
        
        UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, self.recordTableView.bottom, MSW, Height320(40))];
        
        buttonView.backgroundColor = kMainColor;
        
        [recordView addSubview:buttonView];
        
        UIButton *groupButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, buttonView.width/2, buttonView.height)];
        
        groupButton.backgroundColor = kMainColor;
        
        [groupButton setTitle:@"代约团课" forState:UIControlStateNormal];
        
        [groupButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        groupButton.titleLabel.font = AllFont(14);
        
        groupButton.tag = 101;
        
        [groupButton addTarget:self action:@selector(courseClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonView addSubview:groupButton];
        
        UIButton *privateButton = [[UIButton alloc]initWithFrame:CGRectMake(buttonView.width/2, 0, buttonView.width/2, buttonView.height)];
        
        privateButton.backgroundColor = kMainColor;
        
        [privateButton setTitle:@"代约私教" forState:UIControlStateNormal];
        
        [privateButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        privateButton.titleLabel.font = AllFont(14);
        
        privateButton.tag = 102;
        
        [buttonView addSubview:privateButton];
        
        [privateButton addTarget:self action:@selector(courseClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(buttonView.width/2-0.5,Height320(11) , 1, buttonView.height-Height320(22))];
        
        sep.backgroundColor = UIColorFromRGB(0xffffff);
        
        [buttonView addSubview:sep];
        
        return recordView;
        
    }
    else if (row == 1) {
        
        UIScrollView *cardView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.chooseView.height-self.chooseView.rowHeight)];
        
        self.cardTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MSW, cardView.height-Height320(40)) style:UITableViewStylePlain];
        
        self.cardTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        self.cardTableView.dataSource = self;
        
        self.cardTableView.delegate = self;
        
        [self.cardTableView registerClass:[CardCell class] forCellReuseIdentifier:cardIdentifier];
        
        self.cardTableView.tableFooterView = [UIView new];
        
        [cardView addSubview:self.cardTableView];
        
        UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.cardTableView.bottom, MSW, Height320(40))];
        
        addButton.backgroundColor = kMainColor;
        
        [addButton setTitle:@"购买会员卡" forState:UIControlStateNormal];
        
        [addButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        addButton.titleLabel.font = AllFont(14);
        
        [addButton addTarget:self action:@selector(addCard) forControlEvents:UIControlEventTouchUpInside];
        
        [cardView addSubview:addButton];
        
        return cardView;
        
    }else if (row == 2){
        
        UIScrollView *followView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.chooseView.height-self.chooseView.rowHeight)];
        
        self.followTableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0, MSW, followView.height-Height320(44)) style:UITableViewStylePlain];
        
        self.followTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        self.followTableView.dataSource = self;
        
        self.followTableView.delegate = self;
        
        self.followTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.followTableView registerClass:[FollowRecordTextCell class] forCellReuseIdentifier:followTextIdentifier];
        
        [self.followTableView registerClass:[FollowRecordImageCell class] forCellReuseIdentifier:followImgIdentifier];
        
        self.followTableView.tableFooterView = [UIView new];
        
        self.followTableView.showsVerticalScrollIndicator = NO;
        
        [followView addSubview:self.followTableView];
        
        self.toolView = [[FollowRecordToolView alloc]initWithFrame:CGRectMake(0, self.followTableView.bottom, MSW, Height320(44))];
        
        self.toolView.delegate = self;
        
        if ((AppGym &&([PermissionInfo sharedInfo].permissions.userPermission.editState||[PermissionInfo sharedInfo].permissions.personalUserPermission.editState))||(!AppGym && ([[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.student.gyms andPermission:[Permission userPermission] andType:PermissionTypeEdit]||[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.student.gyms andPermission:[Permission personalUserPermission] andType:PermissionTypeEdit]))) {
            
            self.toolView.userInteractionEnabled = YES;
            
        }else{
            
            self.toolView.userInteractionEnabled = NO;
            
        }
        
        [followView addSubview:self.toolView];
        
        return followView;
        
    }else{
        
        UIScrollView *basicView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.chooseView.height-self.chooseView.rowHeight)];
        
        basicView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0,Height320(10), MSW, Height320(249))];
        
        topView.backgroundColor = UIColorFromRGB(0xffffff);
        
        topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        topView.layer.borderWidth = OnePX;
        
        [basicView addSubview:topView];
        
        // 添加 照片
        UIButton *checkinButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, self.student.photo.absoluteString.length?Height320(68):Height320(40))];
    
        UIView *firSep = [[UIView alloc]initWithFrame:CGRectMake(0, checkinButton.height-OnePX, MSW, OnePX)];
        
        firSep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [checkinButton addSubview:firSep];
        // 体侧
        UIButton *bodyTestButton = [[UIButton alloc]initWithFrame:CGRectMake(0, checkinButton.bottom, MSW, Height320(40))];
        
        [topView addSubview:bodyTestButton];
        
        UIImageView *bodyTestImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(13), Width320(12), Height320(14))];
        
        bodyTestImg.image = [UIImage imageNamed:@"stu_measure"];
        
        [bodyTestButton addSubview:bodyTestImg];
        
        UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(40), 0, Width320(120), Height320(40))];
        
        testLabel.text = @"体测数据";
        
        testLabel.textColor = UIColorFromRGB(0x333333);
        
        testLabel.font = AllFont(13);
        
        [bodyTestButton addSubview:testLabel];
        
        [bodyTestButton addTarget:self action:@selector(measureShow:) forControlEvents:UIControlEventTouchUpInside];
        
        self.bodyTestTime = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(129), 0, Width320(100), Height320(40))];
        
        self.bodyTestTime.textColor = UIColorFromRGB(0x999999);
        
        self.bodyTestTime.font = AllFont(13);
        
        self.bodyTestTime.textAlignment = NSTextAlignmentRight;
        
        [bodyTestButton addSubview:self.bodyTestTime];
        
        UIImageView *measureArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.4), Height320(14), Width320(7.4), Height320(12))];
        
        measureArrow.image = [UIImage imageNamed:@"gray_arrow"];
        
        [bodyTestButton addSubview:measureArrow];
        
        [topView addSubview:checkinButton];
        
        UIImageView *checkImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), checkinButton.height/2-Height320(7), Width320(14), Height320(13))];
        
        checkImg.image = [UIImage imageNamed:@"stu_checkin"];
        
        [checkinButton addSubview:checkImg];
        
        UILabel *checkinLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(40), 0, Width320(80), Height320(15))];
        
        checkinLabel.text = @"会员照片";
        
        checkinLabel.textColor = UIColorFromRGB(0x333333);
        
        checkinLabel.font = AllFont(13);
        
        [checkinButton addSubview:checkinLabel];
        
        checkImg.center = CGPointMake(checkImg.center.x, checkinButton.height/2);
        
        checkinLabel.center = CGPointMake(checkinLabel.center.x, checkinButton.height/2);
        
        [checkinButton addTarget:self action:@selector(checkinShow:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.student.photo.absoluteString.length) {
            
            self.photoView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(69), Height320(14), Width320(40), Height320(40))];
            
            self.photoView.contentMode = UIViewContentModeScaleAspectFit;
            
            self.photoView.layer.masksToBounds = YES;
            
            self.photoView.layer.borderColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.1].CGColor;
            
            self.photoView.layer.borderWidth = OnePX;
            
            [self.photoView sd_setImageWithURL:self.student.photo];
            
            [checkinButton addSubview:self.photoView];
            
        }else{
            
            UILabel *noPhotoLabel = [[UILabel alloc]initWithFrame:CGRectMake(checkinLabel.right, 0, MSW-Width320(29)-checkinLabel.right, Height320(40))];
            
            noPhotoLabel.textColor = UIColorFromRGB(0x999999);
            
            noPhotoLabel.textAlignment = NSTextAlignmentRight;
            
            noPhotoLabel.font = AllFont(12);
            
            if (AppGym) {
                
                NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:@"暂无会员照片，立即添加"];
                
                [astr addAttribute:NSForegroundColorAttributeName value:kMainColor range:NSMakeRange(7, 4)];
                
                noPhotoLabel.attributedText = astr;
                
            }else{
                
                noPhotoLabel.text = @"暂无会员照片";
                
            }
            
            [checkinButton addSubview:noPhotoLabel];
            
        }
        
        UIImageView *checkinArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), checkinButton.height/2-Height320(6), Width320(7), Height320(12))];
        
        checkinArrow.image = [UIImage imageNamed:@"gray_arrow"];
        
        [checkinButton addSubview:checkinArrow];
        
       UIView *basicInfoSubView = [self setInfoViewBottom:bodyTestButton superView:topView];
        
        UIView *tempView;
        
        if (self.integralUsed) {
            
           tempView = [self setIntegralViewBootom:basicInfoSubView superView:topView];
            
        }else{
            
            tempView = basicInfoSubView;
            
        }
        
        UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, tempView.bottom, MSW, 11.0)];
        grayView.backgroundColor = RGB_YF(244, 244, 244);
        [topView addSubview:grayView];
        
        UIButton *sellerView = [[UIButton alloc]initWithFrame:CGRectMake(0, tempView.bottom + 11, MSW, Height320(40))];
        
        sellerView.backgroundColor = UIColorFromRGB(0xffffff);
        
        sellerView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        sellerView.layer.borderWidth = OnePX;
        
        [topView addSubview:sellerView];
        
        UIImageView *sellerImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(17), Height320(13), Width320(12), Height320(14))];
        
        sellerImg.image = [UIImage imageNamed:@"stu_seller"];
        
        [sellerView addSubview:sellerImg];
        
        UILabel *sellerTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(40), 0, Width320(40), Height320(40))];
        
        sellerTitleLabel.text = @"销售";
        
        sellerTitleLabel.textColor = UIColorFromRGB(0x333333);
        
        sellerTitleLabel.font = AllFont(13);
        
        [sellerView addSubview:sellerTitleLabel];
        
        UILabel *sellersLabel = [[UILabel alloc]initWithFrame:CGRectMake(sellerTitleLabel.right, 0, MSW-Width320(29)-sellerTitleLabel.right, Height320(40))];
        
        sellersLabel.textColor = UIColorFromRGB(0x999999);
        
        sellersLabel.font = AllFont(13);
        
        sellersLabel.textAlignment = NSTextAlignmentRight;
        
        [sellerView addSubview:sellersLabel];
        
        if (self.student.sellers.count) {
            
            NSString *sellers = @"";
            
            for (NSInteger i = 0 ; i<self.student.sellers.count; i++) {
                
                Seller *tempSeller = self.student.sellers[i];
                
                if (tempSeller.name.length) {
                    
                    sellers = [sellers stringByAppendingString:tempSeller.name];
                    
                }
                
                if (i<self.student.sellers.count-1) {
                    
                    sellers = [sellers stringByAppendingString:@"，"];
                    
                }
                
            }
            
            sellersLabel.text = sellers;
            
        }else{
            
            sellersLabel.text = @"无销售";
            
        }
        
        [sellerView addTarget:self action:@selector(chooseSeller:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *sellerArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), sellerView.height/2-Height320(6), Width320(7), Height320(12))];
        
        sellerArrow.image = [UIImage imageNamed:@"gray_arrow"];
        
        [sellerView addSubview:sellerArrow];
        
        UIButton *coachView = [[UIButton alloc]initWithFrame:CGRectMake(0, sellerView.bottom, MSW, Height320(40))];
        
        coachView.backgroundColor = UIColorFromRGB(0xffffff);
        
        [topView addSubview:coachView];
        
        UIImageView *coachImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(17), Height320(13), Width320(12), Height320(14))];
        
        coachImg.image = [UIImage imageNamed:@"stu_coach"];
        
        [coachView addSubview:coachImg];
        
        UILabel *coachTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(40), 0, Width320(40), Height320(40))];
        
        coachTitleLabel.text = @"教练";
        
        coachTitleLabel.textColor = UIColorFromRGB(0x333333);
        
        coachTitleLabel.font = AllFont(13);
        
        [coachView addSubview:coachTitleLabel];
        
        UILabel *coachesLabel = [[UILabel alloc]initWithFrame:CGRectMake(coachTitleLabel.right, 0, MSW-Width320(29)-coachTitleLabel.right, Height320(40))];
        
        coachesLabel.textColor = UIColorFromRGB(0x999999);
        
        coachesLabel.font = AllFont(13);
        
        coachesLabel.textAlignment = NSTextAlignmentRight;
        
        [coachView addSubview:coachesLabel];
        
        if (self.student.coaches.count) {
            
            NSString *coachesStr = @"";
            
            for (NSInteger i = 0 ; i<self.student.coaches.count; i++) {
                
                Coach *tempCoach = self.student.coaches[i];
                
                if (tempCoach.name.length) {
                    
                    coachesStr = [coachesStr stringByAppendingString:tempCoach.name];
                    
                }
                
                if (i<self.student.coaches.count-1) {
                    
                    coachesStr = [coachesStr stringByAppendingString:@"，"];
                    
                }
                
            }
            
            coachesLabel.text = coachesStr;
            
        }else{
            
            coachesLabel.text = @"无教练";
            
        }
        
        [coachView addTarget:self action:@selector(chooseCoach:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *coachArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), coachView.height/2-Height320(6), Width320(7), Height320(12))];
        
        coachArrow.image = [UIImage imageNamed:@"gray_arrow"];
        
        [coachView addSubview:coachArrow];
        
        UIView *originSubView = [self setOriginViewBottom:coachView superView:topView];
        [self setRecoViewBottom:originSubView superView:topView];
        
        basicView.contentSize = CGSizeMake(0, originSubView.bottom);
        
        return basicView;
 
    }
    
}

-(void)showIntegral:(UIButton*)button
{
    
    if ([PermissionInfo sharedInfo].permissions.userPermission.readState || [PermissionInfo sharedInfo].permissions.personalUserPermission.readState) {
        
        StudentIntegralController *svc = [[StudentIntegralController alloc]init];
        
        svc.user = self.student;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)edit:(UIButton*)button
{
    
    if ((AppGym &&([PermissionInfo sharedInfo].permissions.userPermission.editState||[PermissionInfo sharedInfo].permissions.personalUserPermission.editState))||(!AppGym && ([[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.student.gyms andPermission:[Permission userPermission] andType:PermissionTypeEdit]||[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.student.gyms andPermission:[Permission personalUserPermission] andType:PermissionTypeEdit]))) {
        
        StudentEditController *svc = [[StudentEditController alloc]init];
        
        svc.studentInfo = self.studentInfo;
        
        __weak typeof(self)weakS = self;
        
        svc.editFinish = ^{
            
            [weakS reloadStuInfo];
            
            if (weakS.editFinish)
            {
                weakS.editFinish();
            }

        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}



-(void)chooseSeller:(UIButton*)button
{
    
    if ([PermissionInfo sharedInfo].permissions.userPermission.editState) {
        
        if (AppGym) {
            
            StudentSellerController *svc = [[StudentSellerController alloc]init];
            
            svc.isCanOnlyChooseSeller = YES;
            
            svc.gym = AppGym;
            
            svc.student = self.student;
            
            svc.isEdit = YES;
            svc.editFinish = self.editFinish;
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            if (self.student.gyms.count == 1 ||[[PermissionInfo sharedInfo]getPermissionNotIgnoredWithGyms:self.student.gyms].count == 1) {
                
                StudentSellerController *svc = [[StudentSellerController alloc]init];
                
                svc.gym = [self.student.gyms firstObject];
                
                svc.student = self.student;
                
                svc.isEdit = YES;
                svc.editFinish = self.editFinish;
                [self.navigationController pushViewController:svc animated:YES];
                
            }else if(![[PermissionInfo sharedInfo]getPermissionNotIgnoredWithGyms:self.student.gyms].count){
                
                [self showNoPermissionAlert];
                
            }else{
                
                StudentSellerGymController *svc = [[StudentSellerGymController alloc]init];
                
                svc.student = self.student;
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }
            
        }
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)chooseCoach:(UIButton*)button
{
    
    if ([PermissionInfo sharedInfo].permissions.userPermission.editState) {
        
        if (AppGym) {
            
            StudentCoachController *svc = [[StudentCoachController alloc]init];
            
            svc.gym = AppGym;
            
            svc.student = self.student;
            
            svc.isEdit = YES;
            svc.editFinish = self.editFinish;
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            if (self.student.gyms.count == 1 ||[[PermissionInfo sharedInfo]getPermissionNotIgnoredWithGyms:self.student.gyms].count == 1) {
                
                StudentCoachController *svc = [[StudentCoachController alloc]init];
                
                svc.gym = [self.student.gyms firstObject];
                
                svc.student = self.student;
                
                svc.isEdit = YES;
                svc.editFinish = self.editFinish;
                [self.navigationController pushViewController:svc animated:YES];
                
            }else if(![[PermissionInfo sharedInfo]getPermissionNotIgnoredWithGyms:self.student.gyms].count){
                
                [self showNoPermissionAlert];
                
            }else{
                
                StudentSellerGymController *svc = [[StudentSellerGymController alloc]init];
                
                svc.student = self.student;
                
                svc.isCoach = YES;
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }
            
        }
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)checkinShow:(UIButton*)button
{
    
    if (AppGym && !self.student.photo.absoluteString.length) {
        
        [self cameraClick];
        
    }else{
        
        StudentCheckinPhotoController *svc = [[StudentCheckinPhotoController alloc]init];
        
        svc.student = self.student;
        
        __weak typeof(self)weakS = self;
        
        svc.editFinish = ^{
            
            [weakS reloadStuInfo];
            if (weakS.editFinish)
            {
                weakS.editFinish();
            }
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

-(void)measureShow:(UIButton*)button
{
    
    MeasuresListController *svc = [[MeasuresListController alloc]init];
    
    svc.student = self.student;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (tableView == self.recordTableView) {
        
        return self.studentInfo.recordArray.count;
        
    }else
    {
        
        return 1;
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.cardTableView) {
        
        return self.studentInfo.cardArray.count;
        
    }else if (tableView == self.recordTableView){
        
        return [self.studentInfo.recordArray[section][@"data"] count];
        
    }else
    {
        
        return self.studentInfo.followArray.count;
        
    }
    
}

-(void)naviRightClick
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除会员" otherButtonTitles:nil];
    
    actionSheet.tag = 101;
    
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag == 101) {
        
        if (buttonIndex == 0){
            
            if ((AppGym &&([PermissionInfo sharedInfo].permissions.userPermission.deleteState||[PermissionInfo sharedInfo].permissions.personalUserPermission.deleteState))||(!AppGym && [[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.student.gyms andPermission:[Permission userPermission] andType:PermissionTypeDelete])||(!AppGym && [[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.student.gyms andPermission:[Permission personalUserPermission] andType:PermissionTypeDelete])) {
                
                NSArray *userGyms = [[PermissionInfo sharedInfo]getDeletePermissionWithGyms:self.student.gyms andPermission:[Permission userPermission]];
                
                NSArray *personalUserGyms = [[PermissionInfo sharedInfo]getDeletePermissionWithGyms:self.student.gyms andPermission:[Permission personalUserPermission]];
                
                NSMutableArray *gyms = [userGyms mutableCopy];
                
                for (Gym *tempGym in personalUserGyms) {
                    
                    BOOL contains = NO;
                    
                    for (Gym *tempUserGym in gyms) {
                        
                        if (tempUserGym.shopId == tempGym.shopId) {
                            
                            contains = YES;
                            
                            break;
                            
                        }
                        
                    }
                    
                    if (!contains) {
                        
                        [gyms addObject:tempGym];
                        
                    }
                    
                }
                
                if (AppGym ||(!AppGym && gyms.count == 1)) {
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否确认删除会员" message:@"该会员的上课记录、会员卡、跟进记录等均会被删除" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
                    
                    alert.tag = 101;
                    
                    [alert show];
                    
                }else{
                    
                    StudentDeleteGymController *svc = [[StudentDeleteGymController alloc]init];
                    
                    svc.student = self.student;
                    
                    [self.navigationController pushViewController:svc animated:YES];
                    
                }
                
            }else{
                
                [self showNoPermissionAlert];
                
            }
            
        }
        
    }else{
        
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
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1 &&alertView.tag == 101) {
        
        Gym *gym = nil;
        
        if (AppGym) {
            
            gym = AppGym;
            
        }else{
            
            NSArray *userGyms = [[PermissionInfo sharedInfo]getDeletePermissionWithGyms:self.student.gyms andPermission:[Permission userPermission]];
            
            NSArray *personalUserGyms = [[PermissionInfo sharedInfo]getDeletePermissionWithGyms:self.student.gyms andPermission:[Permission personalUserPermission]];
            
            NSMutableArray *gyms = [userGyms mutableCopy];
            
            for (Gym *tempGym in personalUserGyms) {
                
                BOOL contains = NO;
                
                for (Gym *tempUserGym in gyms) {
                    
                    if (tempUserGym.shopId == tempGym.shopId) {
                        
                        contains = YES;
                        
                        break;
                        
                    }
                    
                }
                
                if (!contains) {
                    
                    [gyms addObject:tempGym];
                    
                }
                
            }
            
            gym = [gyms firstObject];
            
        }
        
        [self.studentInfo deleteStudent:self.student withGym:gym result:^(BOOL success, NSString *error) {
            
            if (success) {

                [[NSNotificationCenter defaultCenter] postNotificationName:kPostDeleteMemberIdtifierYF object:nil];

                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = @"删除成功";
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kPostDeleteMemberIdtifierYF object:nil];
                    
                    [self popViewControllerAndReloadData];
                    
                });
                
            }else{
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = error;
                
                self.hud.label.numberOfLines = 0;
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (tableView == self.recordTableView) {
        
        return Height320(27);
        
    }else if (tableView == self.cardTableView){
        
        return Height320(24);
        
    }else{
        
        return 0;
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView == self.recordTableView) {
        
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(25))];
        
        header.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, Width320(70), Height320(25))];
        
        label.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        label.textColor = UIColorFromRGB(0x999999);
        
        label.font = AllFont(12);
        
        NSDictionary *dict = self.studentInfo.recordArray[section][@"date"];
        
        label.text = [NSString stringWithFormat:@"%@年%@",dict[@"year"],dict[@"month"]];
        
        [header addSubview:label];
        
        UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(183), 0, Width320(171), Height320(25))];
        
        countLabel.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        countLabel.textColor = UIColorFromRGB(0x999999);
        
        countLabel.font = AllFont(12);
        
        countLabel.textAlignment = NSTextAlignmentRight;
        
        countLabel.text = [NSString stringWithFormat:@"%ld次签到，%ld节团课，%ld节私教",(long)[self.studentInfo.recordArray[section][@"checkin_count"] integerValue],(long)[self.studentInfo.recordArray[section][@"group_count"] integerValue],(long)[self.studentInfo.recordArray[section]                                                                                                                                                                 [@"private_count"] integerValue]];
        
        [header addSubview:countLabel];
        
        return header;
        
    }else if (tableView == self.cardTableView){
        
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(24))];
        
        header.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, Width320(120), Height320(24))];
        
        label.text = [NSString stringWithFormat:@"%ld张会员卡",(unsigned long)self.studentInfo.cardArray.count];
        
        label.textColor = UIColorFromRGB(0x999999);
        
        label.font = AllFont(12);
        
        [header addSubview:label];
        
        return header;
        
    }else{
        
        return nil;
        
    }
    
}


-(void)courseClick:(UIButton*)button
{
    
    if (button.tag == 101) {
        
        if ((AppGym && ![PermissionInfo sharedInfo].permissions.courseOrderPermission.addState)||(!AppGym && ![[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.student.gyms andPermission:[Permission courseOrderPermission] andType:PermissionTypeAdd])) {
            
            [self showNoPermissionAlert];
            
            return;
            
        }
        
    }else{
        
        if ((AppGym && ![PermissionInfo sharedInfo].permissions.privateOrderPermission.addState)||(!AppGym && ![[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.student.gyms andPermission:[Permission privateOrderPermission] andType:PermissionTypeAdd])) {
            
            [self showNoPermissionAlert];
            
            return;
            
        }
        
    }
    
    AgentInfo *info = [[AgentInfo alloc]init];
    
    info.type = button.tag -100;
    
    __weak typeof(self)weakS = self;
    
    __weak typeof(AgentInfo*)weakInfo = info;
    
    info.requestFinish = ^(BOOL success){
        
        if (success) {
            
            if (weakInfo.gyms.count == 1) {
                
                Gym *gym = [weakInfo.gyms firstObject];
                
                WebViewController *svc = [[WebViewController alloc]init];
                
                svc.url = gym.url;
                
                svc.completeAction = ^{
                    
                    [weakS reloadData];
                    
                };
                
                if ([weakS.navigationController.visibleViewController isKindOfClass:[StudentDetailController class]]) {
                    
                    [weakS.navigationController pushViewController:svc animated:YES];
                    
                }
                
            }else if (AppGym){
                
                for (Gym *tempGym in weakInfo.gyms) {
                    
                    if (tempGym.shopId == weakS.gym.shopId && tempGym.brand.brandId == weakS.gym.brand.brandId) {
                        
                        WebViewController *svc = [[WebViewController alloc]init];
                        
                        svc.url = tempGym.url;
                        
                        svc.completeAction = ^{
                            
                            [weakS reloadData];
                            
                        };
                        
                        if ([weakS.navigationController.visibleViewController isKindOfClass:[StudentDetailController class]]) {
                            
                            [weakS.navigationController pushViewController:svc animated:YES];
                            
                        }
                        
                        break;
                        
                    }
                    
                }
                
            }
            else
            {
                
                AgentController *svc = [[AgentController alloc]init];
                
                svc.agentInfo = weakInfo;
                
                svc.title = button.tag == 101?@"代约团课":@"代约私教";
                
                if ([weakS.navigationController.visibleViewController isKindOfClass:[StudentDetailController class]]) {
                    
                    [weakS.navigationController pushViewController:svc animated:YES];
                    
                }
                
            }
            
        }
        
    };
    
    [info requestWithDate:[NSDate date] andStudent:self.student];
    
}

-(void)addCard
{
    
    if (AppGym) {
        
        if (![PermissionInfo sharedInfo].permissions.cardPermission.addState && ![PermissionInfo sharedInfo].permissions.personalCardPermission.addState) {
            
            [self showNoPermissionAlert];
            
            return;
            
        }
        
        CardCreateChooseKindController *svc = [[CardCreateChooseKindController alloc]init];
        
        svc.student = self.student;
        
        svc.gym = AppGym;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        if (![[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.student.gyms andPermission:[Permission cardPermission] andType:PermissionTypeAdd]&&![[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.student.gyms andPermission:[Permission personalCardPermission] andType:PermissionTypeAdd]) {
            
            [self showNoPermissionAlert];
            
            return;
            
        }
        
        if (self.student.gyms.count>1) {
            
            CardCreateChooseGymController *svc = [[CardCreateChooseGymController alloc]init];
            
            svc.student = self.student;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            CardCreateChooseKindController *svc = [[CardCreateChooseKindController alloc]init];
            
            svc.student = self.student;
            
            svc.gym = [self.student.gyms firstObject];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView == self.recordTableView) {
        
        return Height320(63);
        
    }else if (tableView == self.cardTableView){
        
        return Height320(67);
        
    }else{
        
        FollowRecord *record = self.studentInfo.followArray[indexPath.row];
        
        if (record.type == FollowRecordTypeText) {
            
            return record.size.height+Height320(45);
            
        }else
        {
            
            return Height320(106);
            
        }
        
    }
        
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.recordTableView) {
        
        ReportCell *cell = [tableView dequeueReusableCellWithIdentifier:reportIdentifier];
        
        Record *record = self.studentInfo.recordArray[indexPath.section][@"data"][indexPath.row];
        
        if (record.type == CourseTypeCheckin)
        {
            cell.title = @"入场签到";
            
            cell.subtitle = [NSString stringWithFormat:@"%@  %@",record.startTime,record.gym.name];
            
            cell.imageName = @"checkinStudetail";
        }else
        {
            cell.title = [NSString stringWithFormat:@"%@-%@",record.coachName,record.course.name];
            
            cell.subtitle = [NSString stringWithFormat:@"%@-%@  %@",record.startTime,record.endTime,record.gym.name];
            cell.imgUrl = record.course.imgUrl;

        }
        
        
        
        cell.sectionFirst = record.showDate;
        
        cell.month = record.month;
        
        cell.day = record.date;
        
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        return cell;
        
    }else if (tableView == self.cardTableView){
        
        CardCell *cell = [tableView dequeueReusableCellWithIdentifier:cardIdentifier];
        
        Card *card = self.studentInfo.cardArray[indexPath.row];
        
        cell.cardName = card.cardName;
        
        cell.cardBackColor = card.color;
        
        cell.users = card.users;
        
        cell.cardType = card.cardKind.type;
        
        cell.remain = card.remain;
        
        cell.cardNumber = card.cardId;
        
        cell.cardState = card.state;
        
        return cell;
        
    }else
    {
        
        FollowRecord *record = self.studentInfo.followArray[indexPath.row];
        
        if (record.type == FollowRecordTypeText) {
            
            FollowRecordTextCell *cell = [tableView dequeueReusableCellWithIdentifier:followTextIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.content = record.content;
            
            cell.follower = record.staff.name;
            
            cell.iconUrl = record.staff.iconUrl;
            
            cell.date = record.time;
            
            cell.contentSize = record.size;
            
            return cell;
            
        }else
        {
            
            FollowRecordImageCell *cell = [tableView dequeueReusableCellWithIdentifier:followImgIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.imageUrl = record.imageURL;
            
            cell.follower = record.staff.name;
            
            cell.iconUrl = record.staff.iconUrl;
            
            cell.tag = indexPath.row;
            
            cell.delegate = self;
            
            cell.date = record.time;
            
            return cell;
            
        }
       
    }
    
}

-(void)ImageCellClick:(NSInteger)tag
{
    
    FollowRecord *record = self.studentInfo.followArray[tag];
    
    if (record.type == FollowRecordTypeImage) {
        
        PictureShowController *svc = [[PictureShowController alloc]init];
        
        svc.imageURL = record.imageURL;
        
        [self presentViewController:svc animated:YES completion:nil];
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.cardTableView) {
        
        Card *card = self.studentInfo.cardArray[indexPath.row];
        
        if ((AppGym && ([PermissionInfo sharedInfo].permissions.cardPermission.readState||[PermissionInfo sharedInfo].permissions.personalCardPermission.readState)) || (!AppGym &&([[PermissionInfo sharedInfo]getPermissionStateWithGyms:card.cardKind.gyms andPermission:[Permission cardPermission] andType:PermissionTypeAdd]||[[PermissionInfo sharedInfo]getPermissionStateWithGyms:card.cardKind.gyms andPermission:[Permission personalCardPermission] andType:PermissionTypeAdd]))) {
            
            CardDetailController *svc = [[CardDetailController alloc]init];
            svc.gym = self.gym;
            svc.card = card;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.cardTableView) {
        
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [cell setSeparatorInset:UIEdgeInsetsZero];
            
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [cell setLayoutMargins:UIEdgeInsetsZero];
            
        }
        
    }
    
}

#pragma 上传图片

-(void)uploadPictureWithIndex:(NSInteger)index
{
    
    self.isCheckinPhoto = NO;
    
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        if(index == 0)
        {
            
            NSString *mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                
                
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"相机访问受限，请到设置-隐私-相机中允许【健身房管理】访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
            }
            //拍照
            sourceType = UIImagePickerControllerSourceTypeCamera;
        }else if(index == 1)
        {
            //从相册选择
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else
        {
            return;
        }
    }else{
        if (index == 0) {
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

-(void)cameraClick
{
    
    self.isCheckinPhoto = YES;
    
    UIActionSheet *actionSheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传会员照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    }else{
        actionSheet = [[UIActionSheet alloc]initWithTitle:@"上传会员照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择", nil];
    }
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
    
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
    
    [self uploadImage:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)uploadImage:(UIImage*)image
{
    
    UpYun *uy = [[UpYun alloc] init];
    
    NSString *url = [UpYun getSaveKey];
    
    NSURL *imgURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://zoneke-img.b0.upaiyun.com%@",url]];
    
    self.student.photo = imgURL;
    
    uy.successBlocker = ^(NSURLResponse *response,id data){
        
        self.hud.label.text = @"上传成功";
        
        self.hud.mode = MBProgressHUDModeText;
        
        [self.hud showAnimated:YES];
        
        [self.hud hideAnimated:YES afterDelay:1.0f];
        
        if (!self.isCheckinPhoto) {
            
            FollowRecord *record = [[FollowRecord alloc]init];
            
            record.type = FollowRecordTypeImage;
            
            record.imageURL = imgURL;
            
            [self.studentInfo uploadFollow:record];
            
        }else{
            
            CheckinPhotoHistoryInfo *info = [[CheckinPhotoHistoryInfo alloc]init];
            
            [info uploadPhoto:self.student.photo.absoluteString student:self.student result:^(BOOL success, NSString *error) {
                
                if (success) {
                    
                    [self reloadStuInfo];
                    
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
            
        }
        
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

-(void)sendText:(NSString *)string
{
    
    self.toolView.text = @"";
    
    FollowRecord *record = [[FollowRecord alloc]init];
    
    record.type = FollowRecordTypeText;
    
    record.content = string;
    
    [self.studentInfo uploadFollow:record];
    
}

- (void)buttonPhoneAction:(UIButton *)button
{
    if (button.tag == 1)
    {
        NSString *desStr = [NSString stringWithFormat:@"%@",self.student.phone];
        
        if ([UIDevice currentDevice].systemVersion.floatValue>=10.2) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.student.phone]]];
            
        }else{
            
            weakTypesYF
            [YFAppService showAlertMessage:desStr sureTitle:@"呼叫" sureBlock:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",weakS.student.phone]]];
            }];
        }
        
    }else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms:%@",self.student.phone]]];

//        NSString *desStr = [NSString stringWithFormat:@"确定向号码%@发送短信吗？",self.student.phone];
//        weakTypesYF
//        [YFAppService showAlertMessage:desStr sureTitle:@"确定" sureBlock:^{
//        }];
    }
}

// 基本信息
-(UIView *)setInfoViewBottom:(UIView *)onTopView superView:(UIView *)topView
{
    UIButton *sellerView = [[UIButton alloc]initWithFrame:CGRectMake(0, onTopView.bottom, MSW, Height320(40))];
    
    sellerView.backgroundColor = UIColorFromRGB(0xffffff);
    
    sellerView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    sellerView.layer.borderWidth = OnePX;
    
    [topView addSubview:sellerView];
    
    UIImageView *sellerImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(17), Height320(13), Width320(14), Height320(14))];
    
    sellerImg.image = [UIImage imageNamed:@"stu_basic"];
    
    [sellerView addSubview:sellerImg];
    
    UILabel *sellerTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(40), 0, Width320(80), Height320(40))];
    
    sellerTitleLabel.text = @"基本信息";
    
    sellerTitleLabel.textColor = UIColorFromRGB(0x333333);
    
    sellerTitleLabel.font = AllFont(13);
    
    [sellerView addSubview:sellerTitleLabel];
    
    UILabel *sellersLabel = [[UILabel alloc]initWithFrame:CGRectMake(sellerTitleLabel.right, 0, MSW-Width320(29)-sellerTitleLabel.right, Height320(40))];
    
    sellersLabel.textColor = UIColorFromRGB(0x999999);
    
    sellersLabel.font = AllFont(13);
    
    sellersLabel.textAlignment = NSTextAlignmentRight;
    sellersLabel.text = @"编辑";
    [sellerView addSubview:sellersLabel];
    
    [sellerView addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *sellerArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), sellerView.height/2-Height320(6), Width320(7), Height320(12))];
    
    sellerArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [sellerView addSubview:sellerArrow];
    
    [topView changeHeight:sellerView.bottom];
    return sellerView;
}

-(UIView*)setIntegralViewBootom:(UIView*)onTopView superView:(UIView*)topView
{
    
    UIButton *integralButton = [[UIButton alloc]initWithFrame:CGRectMake(0, onTopView.bottom, MSW, Height320(40))];
    
    [topView addSubview:integralButton];
    
    UIView *secSep = [[UIView alloc]initWithFrame:CGRectMake(0, integralButton.height - OnePX, MSW, OnePX)];
    
    secSep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [integralButton addSubview:secSep];
    
    UIImageView *integralmg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(17), Height320(13), Width320(14), Height320(14))];
    
    integralmg.image = [UIImage imageNamed:@"student_detail_integral"];
    
    [integralButton addSubview:integralmg];
    
    UILabel *integralTilteLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(40), 0, Width320(120), Height320(40))];
    
    integralTilteLabel.text = @"会员积分";
    
    integralTilteLabel.textColor = UIColorFromRGB(0x333333);
    
    integralTilteLabel.font = AllFont(13);
    
    [integralButton addSubview:integralTilteLabel];
    
    self.integralLabel = [[UILabel alloc]initWithFrame:CGRectMake(integralTilteLabel.right, 0, MSW-Width320(29)-integralTilteLabel.right, Height320(40))];
    
    self.integralLabel.text = [NSString formatStringWithFloat:self.student.integral];
    
    self.integralLabel.textColor = UIColorFromRGB(0x999999);
    
    self.integralLabel.font = AllFont(13);
    
    self.integralLabel.textAlignment = NSTextAlignmentRight;
    
    [integralButton addSubview:self.integralLabel];
    
    [integralButton addTarget:self action:@selector(showIntegral:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *integralArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), integralButton.height/2-Height320(6), Width320(7), Height320(12))];
    
    integralArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [integralButton addSubview:integralArrow];
    
    [topView changeHeight:integralButton.bottom];
    
    return integralButton;
    
}

// 积分
-(UIView *)setPointsViewBottom:(UIView *)onTopView superView:(UIView *)topView
{
    UIButton *sellerView = [[UIButton alloc]initWithFrame:CGRectMake(0, onTopView.bottom - OnePX, MSW, Height320(40))];
    
    
    sellerView.backgroundColor = UIColorFromRGB(0xffffff);
    
    sellerView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    sellerView.layer.borderWidth = OnePX;
    
    [topView addSubview:sellerView];
    
    UIImageView *sellerImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(17), Height320(13), Width320(14), Height320(14))];
    
    sellerImg.image = [UIImage imageNamed:@"pointIcon"];
    
    [sellerView addSubview:sellerImg];
    
    UILabel *sellerTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(40), 0, Width320(80), Height320(40))];
    
    sellerTitleLabel.text = @"会员积分";
    
    sellerTitleLabel.textColor = UIColorFromRGB(0x333333);
    
    sellerTitleLabel.font = AllFont(13);
    
    [sellerView addSubview:sellerTitleLabel];
    
    UILabel *sellersLabel = [[UILabel alloc]initWithFrame:CGRectMake(sellerTitleLabel.right, 0, MSW-Width320(29)-sellerTitleLabel.right, Height320(40))];
    
    sellersLabel.textColor = UIColorFromRGB(0x999999);
    
    sellersLabel.font = AllFont(13);
    
    sellersLabel.textAlignment = NSTextAlignmentRight;
    self.pointsLabel = sellersLabel;
    [sellerView addSubview:sellersLabel];
    
    [sellerView addTarget:self action:@selector(pointsAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *sellerArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), sellerView.height/2-Height320(6), Width320(7), Height320(12))];
    
    sellerArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [sellerView addSubview:sellerArrow];
    
    [topView changeHeight:sellerView.bottom];
    return sellerView;
}


// 来源
-(UIView *)setOriginViewBottom:(UIView *)onTopView superView:(UIView *)topView
{
    UIButton *sellerView = [[UIButton alloc]initWithFrame:CGRectMake(0, onTopView.bottom - OnePX, MSW, Height320(40))];
    
    
    sellerView.backgroundColor = UIColorFromRGB(0xffffff);
    
    sellerView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    sellerView.layer.borderWidth = OnePX;
    
    [topView addSubview:sellerView];
    
    UIImageView *sellerImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(17), Height320(13), Width320(14), Height320(14))];
    
    sellerImg.image = [UIImage imageNamed:@"studenDetailOrigin"];
    
    [sellerView addSubview:sellerImg];
    
    UILabel *sellerTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(40), 0, Width320(80), Height320(40))];
    
    sellerTitleLabel.text = @"来源";
    
    sellerTitleLabel.textColor = UIColorFromRGB(0x333333);
    
    sellerTitleLabel.font = AllFont(13);
    
    [sellerView addSubview:sellerTitleLabel];
    
    UILabel *sellersLabel = [[UILabel alloc]initWithFrame:CGRectMake(sellerTitleLabel.right, 0, MSW-Width320(29)-sellerTitleLabel.right, Height320(40))];
    
    sellersLabel.textColor = UIColorFromRGB(0x999999);
    
    sellersLabel.font = AllFont(13);
    
    sellersLabel.textAlignment = NSTextAlignmentRight;
    self.originLabel = sellersLabel;
    self.originLabel.text = self.student.origin;

    [sellerView addSubview:sellersLabel];
    
    [sellerView addTarget:self action:@selector(originAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *sellerArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), sellerView.height/2-Height320(6), Width320(7), Height320(12))];
    
    sellerArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [sellerView addSubview:sellerArrow];
    
    [topView changeHeight:sellerView.bottom];
    return sellerView;
}

// 来源
-(UIView *)setRecoViewBottom:(UIView *)onTopView superView:(UIView *)topView
{
    UIButton *sellerView = [[UIButton alloc]initWithFrame:CGRectMake(0, onTopView.bottom - OnePX, MSW, Height320(40))];
    
    sellerView.backgroundColor = UIColorFromRGB(0xffffff);
    
    sellerView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    sellerView.layer.borderWidth = OnePX;
    
    [topView addSubview:sellerView];
    
    UIImageView *sellerImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(17), Height320(13), Width320(14), Height320(14))];
    
    sellerImg.image = [UIImage imageNamed:@"studenDetailReco"];
    
    [sellerView addSubview:sellerImg];
    
    UILabel *sellerTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(40), 0, Width320(80), Height320(40))];
    
    sellerTitleLabel.text = @"推荐人";
    
    sellerTitleLabel.textColor = UIColorFromRGB(0x333333);
    
    sellerTitleLabel.font = AllFont(13);
    
    [sellerView addSubview:sellerTitleLabel];
    
    UILabel *sellersLabel = [[UILabel alloc]initWithFrame:CGRectMake(sellerTitleLabel.right, 0, MSW-Width320(29)-sellerTitleLabel.right, Height320(40))];
    
    sellersLabel.textColor = UIColorFromRGB(0x999999);
    
    sellersLabel.font = AllFont(13);
    
    sellersLabel.textAlignment = NSTextAlignmentRight;
    self.recoLabel = sellersLabel;
    self.recoLabel.text = self.student.recommend_by;

    [sellerView addSubview:sellersLabel];
    
    [sellerView addTarget:self action:@selector(recoAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *sellerArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), sellerView.height/2-Height320(6), Width320(7), Height320(12))];
    
    sellerArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [sellerView addSubview:sellerArrow];
    
    [topView changeHeight:sellerView.bottom];

    return sellerView;
}



- (void)recoAction:(UIButton *)button
{
    weakTypesYF
    UIViewController *VC = [YFModuleManager chooseOriginWithOriginId:self.recoIdYF selectBlock:^(NSString *re_id,NSString *userName) {
        [weakS updateUserInforrecoIdYF:re_id originName:weakS.originLabel.text CompleteBlock:^{
            weakS.recoIdYF = re_id;
            weakS.recoLabel.text = userName;
        }];
       
        [weakS.navigationController popToViewController:self animated:YES];
    }];
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)originAction:(UIButton *)button
{
    YFStudnetOriginVC *studentOriginVC = [[YFStudnetOriginVC alloc] init];
    studentOriginVC.isFilter = NO;
    studentOriginVC.title = @"来源";
    studentOriginVC.isCanAdd = YES;
    studentOriginVC.selectName  = self.originLabel.text;
    studentOriginVC.gym = self.gym;
    weakTypesYF
    __weak typeof(studentOriginVC)weakVC = studentOriginVC;
    [studentOriginVC setSelectBlock:^{
        
        NSString *name = weakVC.selectModel.name;
        
        [weakS updateUserInforrecoIdYF:weakS.recoIdYF originName:name CompleteBlock:^{
            weakS.originLabel.text = name;
        }];
        [weakS.navigationController popToViewController:weakS animated:YES];
        
    }];
    [self.navigationController pushViewController:studentOriginVC animated:YES];

}

- (void)updateUserInforrecoIdYF:(NSString *)recoIdYF originName:(NSString *)originName CompleteBlock:(void (^)())complete

{
    
    if ((AppGym &&([PermissionInfo sharedInfo].permissions.userPermission.editState||[PermissionInfo sharedInfo].permissions.personalUserPermission.editState))||(!AppGym && ([[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.student.gyms andPermission:[Permission userPermission] andType:PermissionTypeEdit]||[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.student.gyms andPermission:[Permission personalUserPermission] andType:PermissionTypeEdit]))) {
        
        [self updateUserInfroActionrecoIdYF:recoIdYF originName:originName CompleteBlock:complete];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
}

- (void)updateUserInfroActionrecoIdYF:(NSString *)recoIdYF originName:(NSString *)originName  CompleteBlock:(void (^)())complete
{
    if (1) {
        
        self.studentInfo.student = self.student;
        
        self.studentInfo.student.origin = originName;
        self.studentInfo.student.recommend_by_id = recoIdYF;
        
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"";
        
        [self.hud showAnimated:YES];
        
      if(1){
            
            [self.studentInfo changeStudent:self.studentInfo.student result:^(BOOL success, NSString *error) {
                
                if (success) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kPostModifyOrAddStudentIdtifierYF object:nil];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kPostAddOriginToMemeberIdtifierYF object:nil];

                    [[NSNotificationCenter defaultCenter] postNotificationName:kPostAddRecomendToMemeberIdtifierYF object:nil];

                    
                    if (complete) {
                        complete();
                    }
                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    self.hud.label.text = @"修改成功";
                    
                    [self.hud showAnimated:YES];
                    
                    [self.hud hideAnimated:YES afterDelay:1.5];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        if (self.editFinish) {
                            self.editFinish();
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
        }
    }
}

- (void)pointsAction:(UIButton *)button
{
    self.pointsLabel.text = @"329";
}

- (void)chooseGym:(UIButton *)button
{
    button.selected = !button.selected;
    [self.popGymView showOrHide];
}

- (YFStuDetaiRecoHeaderView *)recoHeaderView
{
    if (_recoHeaderView == nil) {
        _recoHeaderView = [[YFStuDetaiRecoHeaderView alloc] initWithFrame:CGRectMake(0, 0, MSW, Width320(114))];
        _recoHeaderView.backgroundColor = [UIColor whiteColor];
        [_recoHeaderView.button addTarget:self action:@selector(chooseGym:) forControlEvents:UIControlEventTouchUpInside];
        [_recoHeaderView.button setTitle:AppGym.name forState:UIControlStateNormal];
    }
    
    
    if (self.studentInfo.statModel)
    {
        
        [_recoHeaderView.outView setValueStr:self.studentInfo.statModel.days];
        [_recoHeaderView.attandanceView setValueStr:self.studentInfo.statModel.checkin];
        [_recoHeaderView.groupView setValueStr:self.studentInfo.statModel.group];
        [_recoHeaderView.privateView setValueStr:self.studentInfo.statModel.private_count];

    }
    return _recoHeaderView;
}

- (YFGymPopView *)popGymView
{
    if (_popGymView == nil) {
        _popGymView = [[YFGymPopView alloc] initWithFrame:self.view.bounds superView:self.recordTableView childrenFrame:CGRectMake(Width320(98) - 5, self.recoHeaderView.button.bottom - 13, Width320(218), Width320(205))];
        weakTypesYF

        __weak typeof(_popGymView)popGymWeakView = _popGymView;
        [_popGymView setSelectBlock:^(NSString *d, NSDictionary *n) {
            [weakS reloadRecoData];
            weakS.recoHeaderView.button.selected = NO;
            [weakS.recoHeaderView.button setTitle:popGymWeakView.value forState:UIControlStateNormal];
            [popGymWeakView hide];
            
        }];
        [_popGymView setCancelBlock:^(id m) {
            weakS.recoHeaderView.button.selected = NO;
        }];
        
        
    }
    
    
    _popGymView.gym = self.gym;
    
    
    
    return _popGymView;
}


@end
