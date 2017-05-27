//
//  CardDetailController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardDetailController.h"

#import "CardRechargeChooseSpecController.h"

#import "CardPayController.h"

#import "CardRestListController.h"

#import "YFCardView.h"

#import "QCTextField.h"

#import "CardDetailInfo.h"

#import "CardConsumeRecordController.h"

#import "CardRechargeChooseGymController.h"

#import "CardPayChooseGymController.h"

#import "CardChangeNumberController.h"

#import "CardChooseStudentController.h"

#import "CardChooseGymController.h"

#import "YFCardDetailCModel.h"

#import "YFGrayCellModel.h"

#import "YFAppService.h"

#import "YFCardStudentVC.h"

#import "NSObject+YFExtension.h"

#import "YFModifyCardValidTimeVC.h"

@interface CardButton : UIButton

@property(nonatomic,strong)UIImageView *imgView;

@property(nonatomic,strong)UILabel *label;



@end

@implementation CardButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectZero];
        
        _imgView.userInteractionEnabled = NO;
        
        [self addSubview:_imgView];
        
        _label = [[UILabel alloc]initWithFrame:CGRectZero];
        
        _label.font = AllFont(12);
        
        [self addSubview:_label];
        
    }
    return self;
}

@end

@interface CardDetailController ()<UIAlertViewDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UIView *secView;

@property(nonatomic,strong)UILabel *headerLabel;

@property(nonatomic,strong)YFCardView *cardView;

@property(nonatomic,strong)QCTextField *totalRechargeTF;

@property(nonatomic,strong)QCTextField *totalCostTF;

@property(nonatomic,strong)UIView *normalView;

@property(nonatomic,strong)CardButton *renewButton;

@property(nonatomic,strong)CardDetailInfo *info;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic, strong)YFCardDetailCModel *cardStudentsModel;
@property(nonatomic, strong)YFCardDetailCModel *suitGymsModel;
@property(nonatomic, strong)YFCardDetailCModel *payHistoryModel;
@property(nonatomic, strong)YFCardDetailCModel *cardNumModel;

@end

@implementation CardDetailController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kPostUpdateCardValidTimeSuccessYF object:nil];
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
    [self reloadUI];
    
    [self initDataModel];
}

- (void)initDataModel
{
    self.baseTableView.bounces = NO;
    self.baseDataArray = [NSMutableArray array];
    
    YFGrayCellModel *grayModel = [YFGrayCellModel defaultWithCellHeght:11.0];
    
    [self.baseDataArray addObject:grayModel];
    [self.baseDataArray addObject:self.cardStudentsModel];
    [self.baseDataArray addObject:self.suitGymsModel];
    [self.baseDataArray addObject:self.payHistoryModel];
    [self.baseDataArray addObject:self.cardNumModel];
    
    [self.baseTableView reloadData];
}

-(void)createData
{
    
    self.info = [[CardDetailInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    [self.info requestWithCard:self.card Result:^(BOOL success, NSString *error) {
        
        [weakS reloadUI];
        
    }];
    
}

-(void)reloadUI
{
    
    self.cardView.cardName = self.card.cardName;
    
    self.cardView.cardNumber = self.card.cardNumber;
    
    self.cardView.users = self.card.users;
    
    self.cardView.gyms = self.card.cardKind.gyms;
    
    self.cardView.state = self.card.state;
    
    self.cardView.trial_days = self.card.trial_days;
    
    
    self.cardView.startTime = self.card.cardKind.type == CardKindTypeTime?self.card.start:self.card.validFrom;
    
    self.cardView.endTime = self.card.cardKind.type == CardKindTypeTime?self.card.end:self.card.validTo;
    
    self.cardView.type = self.card.cardKind.type;
    
    self.cardView.remain =self.card.remain;
    
    self.cardView.cardId = self.card.cardId;
    
    self.cardView.checkValid = self.card.cardKind.type == CardKindTypeTime?YES:self.card.checkValid;
    
    self.cardView.cardBackColor = self.card.color;
    
    if (self.card.state == CardStateStop) {
        
        self.normalView.hidden = YES;
        
        self.renewButton.hidden = NO;
        
    }else
    {
        
        self.normalView.hidden = NO;
        
        self.renewButton.hidden = YES;
        
    }
    
    self.totalRechargeTF.text = self.info.totalRecharge;
    
    self.totalCostTF.text = self.info.totalCost;
    
    NSString *str = @"";
    
    for (NSInteger i = 0; i<self.card.users.count; i++) {
        
        Student *stu = self.card.users[i];
        
        str = [str stringByAppendingString:stu.name];
        
        if (i<self.card.users.count-1) {
            
            str = [str stringByAppendingString:@"、"];
            
        }
        
    }
    
    NSString *userStr = str;
    
    //    CGSize userSize = [userStr boundingRectWithSize:CGSizeMake(MSW-Width320(44), CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: AllFont(12)} context:nil].size;
    
    self.cardStudentsModel.des = userStr;
    //
    
    NSString *gymStr = @"";
    
    for (NSInteger i = 0; i<self.card.cardKind.gyms.count; i++) {
        
        Gym *gym = self.card.cardKind.gyms[i];
        
        gymStr = [gymStr stringByAppendingString:gym.name];
        
        if (i<self.card.cardKind.gyms.count-1) {
            
            gymStr = [gymStr stringByAppendingString:@"，"];
            
        }
        
    }
    self.suitGymsModel.des = gymStr;
    
    NSString *cardNum = [self.card.cardNumber guardStringYF];
    if (cardNum.length) {
        self.cardNumModel.des = cardNum;
    }
    
    NSString *unit = self.card.cardKind.type == CardKindTypePrepaid?@"元":self.card.cardKind.type == CardKindTypeTime?@"天":@"次";
    
    self.info.totalRecharge = [self.info.totalRecharge guardStringYF];
    self.info.totalCost = [self.info.totalCost guardStringYF];
    
    if (self.info.totalRecharge.length == 0)
    {
        self.info.totalRecharge = @"0";
    }
    
    if (self.info.totalCost.length == 0)
    {
        self.info.totalCost = @"0";
    }
    
    self.payHistoryModel.des = [NSString stringWithFormat:@"累计充值%@%@，累计消费%@%@",self.info.totalRecharge,unit,self.info.totalCost,unit];
    //
    //    CGSize gymSize = [gymStr boundingRectWithSize:CGSizeMake(MSW-Width320(44), CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: AllFont(12)} context:nil].size;
    
    //    [self.topView changeHeight:Height320(196)+userSize.height+gymSize.height];
    //
    //    [self.cardView changeHeight:Height320(148)+userSize.height+gymSize.height];
    
    //    [self.normalView changeTop:self.cardView.bottom];
    //
    //    [self.renewButton changeTop:self.cardView.bottom];
    //
    [self.headerLabel changeTop:self.topView.bottom];
    
    [self.secView changeTop:self.headerLabel.bottom];
    
    [self.baseTableView reloadData];
    
}

-(void)reloadData
{
    
    [self createData];
    
}

-(void)createUI
{
    
    self.title = @"会员卡详情";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    NSString *str = @"";
    
    for (NSInteger i = 0; i<self.card.users.count; i++) {
        
        Student *stu = self.card.users[i];
        
        str = [str stringByAppendingString:stu.name];
        
        if (i<self.card.users.count-1) {
            
            str = [str stringByAppendingString:@"、"];
            
        }
        
    }
    
    //    NSString *userStr = [@"绑定会员：" stringByAppendingString:str];
    //
    //    CGSize userSize = [userStr boundingRectWithSize:CGSizeMake(MSW-Width320(44), CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: AllFont(12)} context:nil].size;
    //
    //    NSString *gymStr = @"适用场馆：";
    //
    //    for (NSInteger i = 0; i<self.card.cardKind.gyms.count; i++) {
    //
    //        Gym *gym = self.card.cardKind.gyms[i];
    //
    //        gymStr = [gymStr stringByAppendingString:gym.name];
    //
    //        if (i<self.card.cardKind.gyms.count-1) {
    //
    //            gymStr = [gymStr stringByAppendingString:@"，"];
    //
    //        }
    //
    //    }
    //
    //    CGSize gymSize = [gymStr boundingRectWithSize:CGSizeMake(MSW-Width320(44), CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: AllFont(12)} context:nil].size;
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(143))];
    
    //    self.topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    //
    //    self.topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    self.topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    //    [self.view addSubview:self.topView];
    
    
    self.cardView = [[YFCardView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(143))];
    
    [self.topView addSubview:self.cardView];
    
    self.normalView = [[UIView alloc]initWithFrame:CGRectMake(0, self.cardView.bottom, MSW, Height320(40))];
    
    _normalView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.topView addSubview:_normalView];
    
    [self.topView changeHeight:self.topView.height + self.normalView.height];
    
    [self.baseTableView setTableHeaderView:self.topView];
    
    
    CGFloat buttonWith =(NSInteger) MSW/3.7;
    CGFloat imageXX = Width320(19);
    CGFloat labelXX = Width320(45);
    CGFloat imageYY = (Height320(40) - Height320(18)) / 2.0;
    
    
    
    CardButton *rechargeButton = [[CardButton alloc]initWithFrame:CGRectMake(0, 0, buttonWith, Height320(40))];
    
    rechargeButton.imgView.frame = CGRectMake(imageXX, imageYY, Width320(18), Height320(18));
    
    rechargeButton.imgView.image = [UIImage imageNamed:@"card_recharge"];
    
    rechargeButton.label.frame = CGRectMake(labelXX, 0, Width320(35), Height320(40));
    
    rechargeButton.label.textColor = UIColorFromRGB(0x666666);
    
    rechargeButton.label.text = @"充值";
    
    rechargeButton.label.font = AllFont(XFrom5YF(12));
    
    [rechargeButton addTarget:self action:@selector(cardRecharge) forControlEvents:UIControlEventTouchUpInside];
    
    [_normalView addSubview:rechargeButton];
    
    CardButton *costButton = [[CardButton alloc]initWithFrame:CGRectMake(buttonWith, 0, buttonWith, Height320(40))];
    
    costButton.imgView.frame = CGRectMake(imageXX, imageYY, Width320(18), Height320(18));
    
    costButton.imgView.image = [UIImage imageNamed:@"card_cost"];
    
    costButton.label.frame = CGRectMake(labelXX, 0, Width320(35), Height320(40));
    
    costButton.label.textColor = UIColorFromRGB(0x666666);
    
    costButton.label.text = @"扣费";
    
    costButton.label.font = AllFont(XFrom5YF(12));
    
    [costButton addTarget:self action:@selector(cardCost) forControlEvents:UIControlEventTouchUpInside];
    
    [_normalView addSubview:costButton];
    
    CardButton *stopButton = [[CardButton alloc]initWithFrame:CGRectMake(buttonWith*2, 0, buttonWith, Height320(40))];
    
    stopButton.imgView.frame = CGRectMake(imageXX, imageYY, Width320(18), Height320(18));
    
    stopButton.imgView.image = [UIImage imageNamed:@"card_rest"];
    
    stopButton.label.frame = CGRectMake(labelXX, 0, Width320(35), Height320(40));
    
    stopButton.label.textColor = UIColorFromRGB(0x666666);
    
    stopButton.label.text = @"请假";
    
    stopButton.label.font = AllFont(XFrom5YF(12));
    
    [stopButton addTarget:self action:@selector(cardRest) forControlEvents:UIControlEventTouchUpInside];
    
    [_normalView addSubview:stopButton];
    
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(buttonWith * 3, 0, MSW - buttonWith * 3, Height320(40))];
    
    [rightButton setImage:[UIImage imageNamed:@"moreGray"] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(naviRightClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_normalView addSubview:rightButton];
    
    
    UIView *firstSep = [[UIView alloc]initWithFrame:CGRectMake(buttonWith-0.5, Height320(8), 1, _normalView.height-Height320(16))];
    
    firstSep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [_normalView addSubview:firstSep];
    
    UIView *secSep = [[UIView alloc]initWithFrame:CGRectMake(buttonWith*2-0.5, Height320(8), 1, _normalView.height-Height320(16))];
    
    secSep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [_normalView addSubview:secSep];
    
    
    UIView *thSep = [[UIView alloc]initWithFrame:CGRectMake(buttonWith*3-0.5, Height320(8), 1, _normalView.height-Height320(16))];
    
    thSep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [_normalView addSubview:thSep];
    
    
    _renewButton = [[CardButton alloc]initWithFrame:_normalView.frame];
    
    _renewButton.tag = 104;
    
    _renewButton.imgView.frame = CGRectMake(Width320(110), Height320(11), Width320(18), Height320(18));
    
    _renewButton.imgView.image = [UIImage imageNamed:@"card_renew"];
    
    _renewButton.label.frame = CGRectMake(Width320(134), 0, Width320(150), Height320(40));
    
    _renewButton.label.text = @"恢复该会员卡";
    
    _renewButton.label.textColor = kMainColor;
    
    [_renewButton addTarget:self action:@selector(cardRenew) forControlEvents:UIControlEventTouchUpInside];
    
    _renewButton.label.font = AllFont(XFrom5YF(12));
    
    
    [self.topView addSubview:_renewButton];
    
    
    
    _renewButton.hidden = self.card.state != CardStateStop;
    
    _normalView.hidden = self.card.state == CardStateStop;
    
    //    self.headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), self.topView.bottom, Width320(150), Height320(40))];
    //
    //    self.headerLabel.text = @"会员卡消费记录";
    //
    //    self.headerLabel.textColor = UIColorFromRGB(0x999999);
    //
    //    self.headerLabel.font = AllFont(12);
    //
    //    [self.view addSubview:self.headerLabel];
    //
    //    self.secView = [[UIView alloc]initWithFrame:CGRectMake(0, self.headerLabel.bottom, MSW, self.card.cardKind.type == CardKindTypeTime?Height320(40):Height320(40)*3)];
    //
    //    self.secView.backgroundColor = UIColorFromRGB(0xffffff);
    //
    //    self.secView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    //
    //    self.secView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    //
    //    [self.view addSubview:self.secView];
    
    if (self.card.cardKind.type != CardKindTypeTime) {
        
        self.totalRechargeTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(13), 0, MSW-Width320(26), Height320(40))];
        
        self.totalRechargeTF.placeholder = [@"累积充值"  stringByAppendingString:self.card.cardKind.type == CardKindTypePrepaid?@"（元）":self.card.cardKind.type == CardKindTypeTime?@"（天）":@"（次）"];
        
        self.totalRechargeTF.placeholderColor = UIColorFromRGB(0x666666);
        
        self.totalRechargeTF.textColor = UIColorFromRGB(0x666666);
        
        self.totalRechargeTF.userInteractionEnabled = NO;
        
        self.totalRechargeTF.noLine = YES;
        
        self.totalRechargeTF.font = AllFont(12);
        
        [self.secView addSubview:self.totalRechargeTF];
        
        UIView *sep1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.totalRechargeTF.bottom-1, MSW, 1)];
        
        sep1.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self.secView addSubview:sep1];
        
        self.totalCostTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(13), self.totalRechargeTF.bottom, self.totalRechargeTF.width, self.totalRechargeTF.height)];
        
        self.totalCostTF.placeholder = [@"累积消费" stringByAppendingString:self.card.cardKind.type == CardKindTypePrepaid?@"（元）":self.card.cardKind.type == CardKindTypeTime?@"（天）":@"（次）"];
        
        self.totalCostTF.placeholderColor = UIColorFromRGB(0x666666);
        
        self.totalCostTF.textColor = UIColorFromRGB(0x666666);
        
        self.totalCostTF.userInteractionEnabled = NO;
        
        self.totalCostTF.noLine = YES;
        
        self.totalCostTF.font = AllFont(12);
        
        [self.secView addSubview:self.totalCostTF];
        
        UIView *sep2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.totalCostTF.bottom-1, MSW, 1)];
        
        sep2.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self.secView addSubview:sep2];
        
    }
    
    UIButton *checkButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.totalCostTF.bottom, MSW, Height320(40))];
    
    [self.secView addSubview:checkButton];
    
    [checkButton addTarget:self action:@selector(checkCost) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *checkImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(113), Height320(13), Width320(13), Height320(15))];
    
    checkImg.image = [UIImage imageNamed:@"check_rest"];
    
    [checkButton addSubview:checkImg];
    
    UILabel *checkLabel = [[UILabel alloc]initWithFrame:CGRectMake(checkImg.right+Width320(6), 0, Width320(150), Height320(40))];
    
    checkLabel.text = @"查看消费记录";
    
    checkLabel.textColor = UIColorFromRGB(0x666666);
    
    checkLabel.font = AllFont(12);
    
    [checkButton addSubview:checkLabel];
    
    [checkButton addTarget:self action:@selector(checkCost) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    self.hud.mode = MBProgressHUDModeText;
    
}

-(void)checkCost
{
    
    if ([PermissionInfo sharedInfo].permissions.cardReportPermission.readState) {
        
        CardConsumeRecordController *svc = [[CardConsumeRecordController alloc]init];
        
        svc.totalRecharge = self.info.totalRecharge;
        
        svc.totalCost = self.info.totalCost;
        
        svc.card = self.card;
        
        svc.remain = [NSString stringWithFormat:self.card.cardKind.type == CardKindTypeTime?@"%.0f天":self.card.cardKind.type == CardKindTypePrepaid?@"%.2f元":@"%.0f次",self.card.remain];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)cardRecharge
{
    
    if ((AppGym &&([PermissionInfo sharedInfo].permissions.cardPermission.editState ||[PermissionInfo sharedInfo].permissions.personalCardPermission.editState))||(!AppGym && ([[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission cardPermission] andType:PermissionTypeEdit] ||[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission personalCardPermission] andType:PermissionTypeEdit]))) {
        
        Gym *gym = ((AppDelegate *)[UIApplication sharedApplication].delegate).gym;
        
        if (gym) {
            
            CardRechargeChooseSpecController *svc = [[CardRechargeChooseSpecController alloc]init];
            
            svc.card = self.card;
            
            svc.gym = gym;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else if (self.card.cardKind.gyms.count == 1) {
            
            CardRechargeChooseSpecController *svc = [[CardRechargeChooseSpecController alloc]init];
            
            svc.card = self.card;
            
            svc.gym = [self.card.cardKind.gyms firstObject];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else
        {
            
            GymListInfo *info = [GymListInfo shareInfo];
            
            [info requestResult:^(BOOL success, NSString *error) {
                
                NSArray *gyms = [info getHavePowerGymsWithGyms:self.card.cardKind.gyms];
                
                if (gyms.count == 1) {
                    
                    CardRechargeChooseSpecController *svc = [[CardRechargeChooseSpecController alloc]init];
                    
                    svc.card = self.card;
                    
                    svc.gym = [gyms firstObject];
                    
                    [self.navigationController pushViewController:svc animated:YES];
                    
                }else{
                    
                    CardRechargeChooseGymController *svc = [[CardRechargeChooseGymController alloc]init];
                    
                    svc.card = self.card;
                    
                    svc.info = info;
                    
                    [self.navigationController pushViewController:svc animated:YES];
                    
                }
                
            }];
            
        }
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)cardCost
{
    
    if ((AppGym &&([PermissionInfo sharedInfo].permissions.cardPermission.editState ||[PermissionInfo sharedInfo].permissions.personalCardPermission.editState))||(!AppGym && ([[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission cardPermission] andType:PermissionTypeEdit] ||[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission personalCardPermission] andType:PermissionTypeEdit]))) {
        
        Gym *gym = ((AppDelegate*)[UIApplication sharedApplication].delegate).gym;
        
        if (gym) {
            
            CardPayController *svc = [[CardPayController alloc]init];
            
            svc.card = self.card;
            
            svc.gym = gym;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else if (self.card.cardKind.gyms.count == 1) {
            
            CardPayController *svc = [[CardPayController alloc]init];
            
            svc.card = self.card;
            
            svc.gym = [self.card.cardKind.gyms firstObject];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else
        {
            
            GymListInfo *info = [GymListInfo shareInfo];
            
            [info requestResult:^(BOOL success, NSString *error) {
                
                NSArray *gyms = [info getHavePowerGymsWithGyms:self.card.cardKind.gyms];
                
                if (gyms.count == 1) {
                    
                    CardPayController *svc = [[CardPayController alloc]init];
                    
                    svc.card = self.card;
                    
                    svc.gym = [gyms firstObject];
                    
                    [self.navigationController pushViewController:svc animated:YES];
                    
                }else{
                    
                    CardPayChooseGymController *svc = [[CardPayChooseGymController alloc]init];
                    
                    svc.card = self.card;
                    
                    svc.info = info;
                    
                    [self.navigationController pushViewController:svc animated:YES];
                    
                }
                
            }];
            
        }
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)cardRest
{
    
    if ((AppGym &&([PermissionInfo sharedInfo].permissions.cardPermission.editState ||[PermissionInfo sharedInfo].permissions.personalCardPermission.editState))||(!AppGym && ([[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission cardPermission] andType:PermissionTypeEdit] ||[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission personalCardPermission] andType:PermissionTypeEdit]))) {
        
        CardRestListController *svc = [[CardRestListController alloc]init];
        
        svc.gym = self.gym;
        
        svc.card = self.card;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)cardStop
{
    
    if ((AppGym && ([PermissionInfo sharedInfo].permissions.cardPermission.editState ||[PermissionInfo sharedInfo].permissions.personalCardPermission.editState))||(!AppGym && ([[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission cardPermission] andType:PermissionTypeEdit] ||[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission personalCardPermission] andType:PermissionTypeEdit]))) {
        
        if (self.card.state == CardStateStop) {
            
            [[[UIAlertView alloc]initWithTitle:@"会员卡已处于停卡状态" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否确认停卡" message:@"停卡后：\n1.会员无法继续使用该会员卡；\n2.默认列表不展示已停卡的会员卡；\n3.停卡后可手动恢复该会员卡。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认停卡",nil];
            
            alert.tag = 101;
            
            [alert show];
            
        }
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)cardRenew
{
    
    if ((AppGym && ([PermissionInfo sharedInfo].permissions.cardPermission.editState ||[PermissionInfo sharedInfo].permissions.personalCardPermission.editState))||(!AppGym && ([[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission cardPermission] andType:PermissionTypeEdit] ||[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission personalCardPermission] andType:PermissionTypeEdit]))) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定恢复该会员卡吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        alert.tag = 102;
        
        [alert show];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 101) {
        
        if (buttonIndex == 1) {
            
            [self.info stopWithCardId:self.card.cardId Result:^(BOOL success, NSString *error) {
                
                if (success) {
                    
                    self.hud.label.text = @"停卡成功";
                    
                    [self.hud showAnimated:YES];
                    
                    [self.hud hideAnimated:YES afterDelay:1.0];
                    
                    [self reloadData];
                    
                    if (self.editFinish) {
                        
                        self.editFinish();
                        
                    }
                    
                }
                
            }];
            
        }
        
    }else if (alertView.tag == 102){
        
        if (buttonIndex == 1) {
            
            [self.info renewWithCardId:self.card.cardId Result:^(BOOL success, NSString *error) {
                
                if (success) {
                    
                    self.hud.label.text = @"恢复成功";
                    
                    [self.hud showAnimated:YES];
                    
                    [self.hud hideAnimated:YES afterDelay:1.0];
                    
                    [self reloadData];
                    
                    if (self.editFinish) {
                        
                        self.editFinish();
                        
                    }
                    
                }
                
            }];
            
        }
        
    }
    
}

-(void)naviRightClick
{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"停卡" otherButtonTitles:@"修改会员卡有效期",nil];
    
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
        
        if ((AppGym && ([PermissionInfo sharedInfo].permissions.cardPermission.editState ||[PermissionInfo sharedInfo].permissions.personalCardPermission.editState))||(!AppGym && ([[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission cardPermission] andType:PermissionTypeEdit] ||[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission personalCardPermission] andType:PermissionTypeEdit]))) {
            
            [self cardStop];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
    }else if (buttonIndex == 1)
    {
//#warning 权限判断
        if ((AppGym && ([PermissionInfo sharedInfo].permissions.cardPermission.editState ||[PermissionInfo sharedInfo].permissions.personalCardPermission.editState))||(!AppGym && ([[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission cardPermission] andType:PermissionTypeEdit] ||[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission personalCardPermission] andType:PermissionTypeEdit]))) {
            
//            self.cardView.checkValid =  YES;

            
            YFModifyCardValidTimeVC *cardValidVC = [[YFModifyCardValidTimeVC alloc] init];
            
            cardValidVC.isValidtTime = self.card.cardKind.type == CardKindTypeTime?YES:self.card.checkValid;
            
            cardValidVC.start = self.card.cardKind.type == CardKindTypeTime?self.card.start:self.card.validFrom;
            
            cardValidVC.cardId = self.card.cardId;
            
            cardValidVC.gym = self.gym;
            
            cardValidVC.end = self.card.cardKind.type == CardKindTypeTime?self.card.end:self.card.validTo;
            
            cardValidVC.isCanTurnOffDateSwitch = !(self.card.cardKind.type == CardKindTypeTime);
            
            [self.navigationController pushViewController:cardValidVC animated:YES];

            
        }else{
            
            [self showNoPermissionAlert];
            
        }

           }
    
    
    //    else if (buttonIndex == 1){
    //
    //        if ((AppGym && ([PermissionInfo sharedInfo].permissions.cardPermission.editState ||[PermissionInfo sharedInfo].permissions.personalCardPermission.editState))||(!AppGym && ([[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission cardPermission] andType:PermissionTypeEdit] ||[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission personalCardPermission] andType:PermissionTypeEdit]))) {
    //
    //            CardChangeNumberController *svc = [[CardChangeNumberController alloc]init];
    //
    //            svc.card = self.card;
    //
    //            [self.navigationController pushViewController:svc animated:YES];
    //
    //        }else{
    //
    //            [self showNoPermissionAlert];
    //
    //        }
    //
    //    }else if (buttonIndex == 2){
    //
    //        if ((AppGym && ([PermissionInfo sharedInfo].permissions.cardPermission.editState ||[PermissionInfo sharedInfo].permissions.personalCardPermission.editState))||(!AppGym && ([[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission cardPermission] andType:PermissionTypeEdit] ||[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission personalCardPermission] andType:PermissionTypeEdit]))) {
    //
    //            if (AppGym) {
    //
    //                CardChooseStudentController *svc = [[CardChooseStudentController alloc]init];
    //
    //                svc.isEdit = YES;
    //
    //                svc.card = self.card;
    //
    //                svc.gym = AppGym;
    //
    //                [self.navigationController pushViewController:svc animated:YES];
    //
    //            }else{
    //
    //                if (self.card.cardKind.gyms.count == 1) {
    //
    //                    CardChooseStudentController *svc = [[CardChooseStudentController alloc]init];
    //
    //                    svc.isEdit = YES;
    //
    //                    svc.card = self.card;
    //
    //                    svc.gym = [self.card.cardKind.gyms firstObject];
    //
    //                    [self.navigationController pushViewController:svc animated:YES];
    //
    //                }else{
    //
    //                    CardChooseGymController *svc = [[CardChooseGymController alloc]init];
    //
    //                    svc.card = self.card;
    //
    //                    [self.navigationController pushViewController:svc animated:YES];
    //
    //                }
    //
    //            }
    //
    //        }else{
    //
    //            [self showNoPermissionAlert];
    //        }
    //    }
}

- (YFCardDetailCModel *)cardStudentsModel
{
    if (!_cardStudentsModel)
    {
        weakTypesYF
        _cardStudentsModel = [YFCardDetailCModel defaultWithYYModelDic:nil selectBlock:^(id model){
            
            YFCardStudentVC *cardVC = [[YFCardStudentVC alloc] init];
            cardVC.gym = weakS.gym;
            cardVC.card = weakS.card;
            [weakS.navigationController pushViewController:cardVC animated:YES];
        }];
        _cardStudentsModel.name = @"绑定会员";
        _cardStudentsModel.iconImageName = @"cardStudent";
    }
    return _cardStudentsModel;
}

- (YFCardDetailCModel *)suitGymsModel
{
    if (!_suitGymsModel)
    {
        _suitGymsModel =  [YFCardDetailCModel defaultWithYYModelDic:nil selectBlock:^(id model){
            
            [YFAppService showAlertMessage:@"请在会员卡种类中修改适用场馆" oneTitle:@"知道了"];
        }];
        _suitGymsModel.isShowArrow = NO;
        _suitGymsModel.name = @"适用场馆";
        _suitGymsModel.iconImageName = @"suitGym";
        _suitGymsModel.numLinesOfdesLabel = 0;
    }
    return _suitGymsModel;
}

- (YFCardDetailCModel *)payHistoryModel
{
    if (!_payHistoryModel)
    {
        weakTypesYF
        _payHistoryModel =  [YFCardDetailCModel defaultWithYYModelDic:nil selectBlock:^(id model){
            [weakS checkCost];
        }];
        _payHistoryModel.name = @"消费记录";
        _payHistoryModel.iconImageName = @"payHistory";
    }
    return _payHistoryModel;
}

- (YFCardDetailCModel *)cardNumModel
{
    if (!_cardNumModel)
    {
        weakTypesYF
        _cardNumModel = [YFCardDetailCModel defaultWithYYModelDic:nil selectBlock:^(id model){
            [weakS modifyCardNum];
        }];
        _cardNumModel.des = @"未填写";
        _cardNumModel.name = @"实体卡号";
        _cardNumModel.iconImageName = @"cardNum";
    }
    return _cardNumModel;
}

- (void)parHistoyAction
{
    
}

- (void)modifyCardNum
{
    if ((AppGym && ([PermissionInfo sharedInfo].permissions.cardPermission.editState ||[PermissionInfo sharedInfo].permissions.personalCardPermission.editState))||(!AppGym && ([[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission cardPermission] andType:PermissionTypeEdit] ||[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.card.cardKind.gyms andPermission:[Permission personalCardPermission] andType:PermissionTypeEdit]))) {
        
        CardChangeNumberController *svc = [[CardChangeNumberController alloc]init];
        
        svc.card = self.card;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}



//@property(nonatomic, strong)YFCardDetailCModel *cardStudentsModel;
//@property(nonatomic, strong)YFCardDetailCModel *suitGymsModel;
//@property(nonatomic, strong)YFCardDetailCModel *payHistoryModel;
//@property(nonatomic, strong)YFCardDetailCModel *cardNumModel;

@end
