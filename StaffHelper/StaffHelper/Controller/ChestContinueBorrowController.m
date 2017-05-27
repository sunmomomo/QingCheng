//
//  ChestContinueBorrowController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestContinueBorrowController.h"

#import "QCTextField.h"

#import "QCKeyboardView.h"

#import "CardPayChooseCell.h"

#import "CardPayChooseView.h"

#import "StudentDetailInfo.h"

#import "ChestBorrowInfo.h"

#import "CardCreateChooseKindController.h"

@interface ChestContinueBorrowController ()<QCKeyboardViewDelegate,CardPayChooseViewDelegate>

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)QCTextField *endTF;

@property(nonatomic,strong)UIDatePicker *endDP;

@property(nonatomic,strong)UILabel *daysLabel;

@property(nonatomic,strong)UIView *thirdView;

@property(nonatomic,strong)CardPayChooseCell *cardCell;

@property(nonatomic,strong)CardPayChooseView *cardView;

@property(nonatomic,strong)QCTextField *priceTF;

@property(nonatomic,strong)UIButton *confirmButton;

@property(nonatomic,strong)Card *chooseCard;

@property(nonatomic,assign)PayWay payWay;

@property(nonatomic,strong)StudentDetailInfo *stuInfo;

@end

@implementation ChestContinueBorrowController

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
    
    self.stuInfo = [[StudentDetailInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    self.stuInfo.cardDataFinish = ^(BOOL success){
        
        NSMutableArray *cards = [NSMutableArray array];
        
        for (Card *card in weakS.stuInfo.cardArray) {
            
            if (card.cardKind.type != CardKindTypeTime) {
                
                [cards addObject:card];
                
            }
            
        }
        
        weakS.cardView.cards = cards;
        
        if (cards.count) {
            
            weakS.chooseCard = [cards firstObject];
            
        }else{
            
            weakS.payWay = PayWayCash;
            
        }
        
    };
    
    [self.stuInfo requestChestCardInfoWithStudent:self.chest.borrowUser];
    
}

-(void)createUI
{
    
    self.title = @"续租";
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.mainView];
    
    UILabel *chestNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(20), MSW, Height320(27))];
    
    chestNameLabel.text = self.chest.name;
    
    chestNameLabel.textColor = kMainColor;
    
    chestNameLabel.textAlignment = NSTextAlignmentCenter;
    
    chestNameLabel.font = AllFont(24);
    
    [self.mainView addSubview:chestNameLabel];
    
    UILabel *areaLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, chestNameLabel.bottom, chestNameLabel.width, Height320(14))];
    
    areaLabel.text = self.chest.area.areaName;
    
    areaLabel.textColor = kMainColor;
    
    areaLabel.textAlignment = NSTextAlignmentCenter;
    
    areaLabel.font = AllFont(12);
    
    [self.mainView addSubview:areaLabel];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(81), MSW, Height320(150))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = OnePX;
    
    [self.mainView addSubview:topView];
    
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(15), Width320(64), Height320(16))];
    
    firstLabel.text = @"状 态";
    
    firstLabel.textColor = UIColorFromRGB(0x999999);
    
    firstLabel.font = AllFont(14);
    
    [topView addSubview:firstLabel];
    
    UILabel *stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(89), firstLabel.top, Width320(180), Height320(16))];
    
    stateLabel.text = @"长期租用";
    
    stateLabel.textColor = UIColorFromRGB(0xf9944e);
    
    stateLabel.font = AllFont(14);
    
    [topView addSubview:stateLabel];
    
    UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLabel.left, firstLabel.bottom+Height320(10), firstLabel.width, firstLabel.height)];
    
    secondLabel.text = @"期 限";
    
    secondLabel.textColor = UIColorFromRGB(0x999999);
    
    secondLabel.font = AllFont(14);
    
    [topView addSubview:secondLabel];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(89), secondLabel.top, Width320(180), Height320(16))];
    
    timeLabel.text = [NSString stringWithFormat:@"%@至%@",_chest.start,_chest.end];
    
    timeLabel.textColor = UIColorFromRGB(0x333333);
    
    timeLabel.font = AllFont(14);
    
    [topView addSubview:timeLabel];
    
    UILabel *thirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLabel.left, secondLabel.bottom+Height320(10), firstLabel.width, firstLabel.height)];
    
    thirdLabel.text = @"会 员";
    
    thirdLabel.textColor = UIColorFromRGB(0x999999);
    
    thirdLabel.font = AllFont(14);
    
    [topView addSubview:thirdLabel];
    
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(89), thirdLabel.top, Width320(180), Height320(16))];
    
    userLabel.text = _chest.borrowUser.name;
    
    userLabel.textColor = UIColorFromRGB(0x333333);
    
    userLabel.font = AllFont(14);
    
    [topView addSubview:userLabel];
    
    UILabel *forthLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLabel.left, thirdLabel.bottom+Height320(10), firstLabel.width, firstLabel.height)];
    
    forthLabel.text = @"手 机";
    
    forthLabel.textColor = UIColorFromRGB(0x999999);
    
    forthLabel.font = AllFont(14);
    
    [topView addSubview:forthLabel];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(89), forthLabel.top, Width320(180), Height320(16))];
    
    phoneLabel.text = _chest.borrowUser.phone;
    
    phoneLabel.textColor = UIColorFromRGB(0x333333);
    
    phoneLabel.font = AllFont(14);
    
    [topView addSubview:phoneLabel];
    
    UILabel *fifthLabel = [[UILabel alloc]initWithFrame:CGRectMake(firstLabel.left, forthLabel.bottom+Height320(10), firstLabel.width, firstLabel.height)];
    
    fifthLabel.text = @"剩余天数";
    
    fifthLabel.textColor = UIColorFromRGB(0x999999);
    
    fifthLabel.font = AllFont(14);
    
    [topView addSubview:fifthLabel];
    
    UILabel *remainLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(89), fifthLabel.top, Width320(180), Height320(16))];
    
    remainLabel.textColor = UIColorFromRGB(0x333333);
    
    NSString *remain = [NSString stringWithFormat:@"%ld 天",(long)_chest.remain];
    
    if (_chest.remain<=0) {
        
        NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:remain];
        
        [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xEA6161) range:NSMakeRange(0, astr.length-2)];
        
        remainLabel.attributedText = astr;
        
    }else{
        
        remainLabel.text = remain;
        
    }
    
    remainLabel.font = AllFont(14);
    
    [topView addSubview:remainLabel];
    
    UILabel *continueLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(11), Width320(200), Height320(14))];
    
    continueLabel.text = @"续租时间";
    
    continueLabel.textColor = UIColorFromRGB(0x999999);
    
    continueLabel.font = AllFont(12);
    
    [self.mainView addSubview:continueLabel];
    
    self.daysLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(106), continueLabel.top, Width320(90), Height320(14))];
    
    self.daysLabel.textColor = UIColorFromRGB(0x999999);
    
    self.daysLabel.textAlignment = NSTextAlignmentRight;
    
    self.daysLabel.font = AllFont(12);
    
    [self.mainView addSubview:self.daysLabel];
    
    UIView *secView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(34), MSW, Height320(40))];
    
    secView.backgroundColor = UIColorFromRGB(0xffffff);
    
    secView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    secView.layer.borderWidth = OnePX;
    
    [self.mainView addSubview:secView];
    
    self.endTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"yyyy-MM-dd";
    
    self.endTF.placeholder = [NSString stringWithFormat:@"%@  至", [df stringFromDate:[NSDate dateWithTimeInterval:86400 sinceDate:[df dateFromString:self.chest.end]]]];
    
    self.endTF.textPlaceholder = @"选择结束日期";
    
    self.endTF.type = QCTextFieldTypeCell;
    
    self.endTF.noLine = YES;
    
    [secView addSubview:self.endTF];
    
    QCKeyboardView *endKV = [QCKeyboardView defaultKeboardView];
    
    endKV.delegate = self;
    
    self.endDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.endDP.datePickerMode = UIDatePickerModeDate;
    
    self.endDP.date = [NSDate dateWithTimeInterval:86400*30 sinceDate:[NSDate date]];
    
    endKV.keyboard = self.endDP;
    
    self.endTF.inputView = endKV;
    
    self.thirdView = [[UIView alloc]initWithFrame:CGRectMake(0, secView.bottom+Height320(12), MSW, Height320(40)*2)];
    
    self.thirdView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.thirdView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.thirdView.layer.borderWidth = OnePX;
    
    [self.mainView addSubview:self.thirdView];
    
    self.cardCell = [[CardPayChooseCell alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    self.cardCell.cardPlaceholder = @"请选择支付方式";
    
    [self.thirdView addSubview:self.cardCell];
    
    [self.cardCell addTarget:self action:@selector(cardChoose) forControlEvents:UIControlEventTouchUpInside];
    
    self.priceTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.cardCell.bottom, MSW-Width320(32), Height320(40))];
    
    self.priceTF.placeholder = @"金额（元）";
    
    self.priceTF.keyboardType = UIKeyboardTypeDecimalPad;
    
    [self.thirdView addSubview:self.priceTF];
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), self.thirdView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    self.confirmButton.backgroundColor = kMainColor;
    
    self.confirmButton.layer.cornerRadius = Width320(2);
    
    [self.confirmButton setTitle:@"确定续租" forState:UIControlStateNormal];
    
    [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [self.mainView addSubview:self.confirmButton];
    
    [self.confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cardView = [CardPayChooseView defaultView];
    
    self.cardView.delegate = self;
    
    [self.view addSubview:self.cardView];
    
}

-(void)confirm:(UIButton*)button
{
    
    [self.view endEditing:YES];
    
    if (!self.endTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请填写结束日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else if (!self.chooseCard && !self.payWay){
        
        [[[UIAlertView alloc]initWithTitle:@"请选择支付方式" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else if (!self.priceTF.text.length){
        
        [[[UIAlertView alloc]initWithTitle:@"请填写收费金额" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else{
        
        button.userInteractionEnabled = NO;
        
        ChestBorrowInfo *info = [[ChestBorrowInfo alloc]init];
        
        self.chest.end = self.endTF.text;
        
        [info continueChest:self.chest andCard:self.chooseCard orPayWay:self.payWay andCost:[self.priceTF.text integerValue] result:^(BOOL success, NSString *error) {
            
            button.userInteractionEnabled = YES;
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [self.view addSubview:hud];
            
            if (success) {
                
                hud.label.text = @"续租成功";
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popViewControllerAndReloadData];
                    
                });
                
            }else{
                
                hud.label.text = error;
                
                hud.label.numberOfLines = 0;
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"yyyy-MM-dd";
    
    if ([self.endDP.date timeIntervalSinceDate:[df dateFromString:self.chest.end]]<0) {
        
        [[[UIAlertView alloc]initWithTitle:@"结束日期不能早于开始日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    self.endTF.text = [df stringFromDate:self.endDP.date];
    
    self.daysLabel.text = [NSString stringWithFormat:@"%ld天",(long)[self.endDP.date timeIntervalSinceDate:[df dateFromString:self.chest.end]]/86400];
    
    [self.view endEditing:YES];
    
}

-(void)setPayWay:(PayWay)payWay
{
    
    _payWay = payWay;
    
    if (_payWay) {
        
        self.cardCell.cardName = _payWay == PayWayCash?@"现金支付":_payWay == PayWayCard?@"刷卡支付":_payWay == PayWayTransfer?@"转账支付":@"其他";
        
        self.priceTF.placeholder = @"金额（元）";
        
        [self.cardCell changeHeight:Height320(40)];
        
        self.cardCell.remain = nil;
        
        [self.priceTF changeTop:self.cardCell.bottom];
        
        [self.thirdView changeHeight:self.priceTF.bottom];
        
        [self.confirmButton changeTop:self.thirdView.bottom+Height320(12)];
        
    }
    
}

-(void)setChooseCard:(Card *)chooseCard
{
    
    _chooseCard = chooseCard;
    
    self.cardCell.cardName = _chooseCard.cardKind.cardKindName;
    
    if (_chooseCard.cardKind.type == CardKindTypePrepaid) {
        
        self.cardCell.remain = [NSString stringWithFormat:@"余额：%.0f元",_chooseCard.remain];
        
        self.priceTF.placeholder = @"金额（元）";
        
    }else{
        
        self.cardCell.remain = [NSString stringWithFormat:@"余额：%.0f次",_chooseCard.remain];
        
        self.priceTF.placeholder = @"金额（次）";
        
    }
    
    [self.cardCell changeHeight:Height320(54)];
    
    [self.priceTF changeTop:self.cardCell.bottom];
    
    [self.thirdView changeHeight:self.priceTF.bottom];
    
    [self.confirmButton changeTop:self.thirdView.bottom+Height320(12)];
    
}


-(void)cardPayChooseCard:(Card *)card orPayWay:(PayWay)payWay
{
    
    if (card) {
        
        self.chooseCard = card;
        
        _payWay = PayWayNone;
        
    }else if (payWay){
        
        self.payWay = payWay;
        
        _chooseCard = nil;
        
    }
    
}

-(void)buyCard
{
    
    CardCreateChooseKindController *svc = [[CardCreateChooseKindController alloc]init];
    
    svc.gym = AppGym;
    
    svc.student = self.chest.borrowUser;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)cardChoose
{
    
    [self.view endEditing:YES];
    
    [self.cardView show];
    
}

@end
