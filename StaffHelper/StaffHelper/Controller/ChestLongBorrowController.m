//
//  ChestLongBorrowController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestLongBorrowController.h"

#import "QCTextField.h"

#import "MOCell.h"

#import "QCKeyboardView.h"

#import "StudentDetailInfo.h"

#import "CardPayChooseCell.h"

#import "CardPayChooseView.h"

#import "ChestEditController.h"

#import "ChestBorrowChooseStudentController.h"

#import "CardCreateChooseKindController.h"

#import "ChestBorrowInfo.h"

@interface ChestLongBorrowController ()<QCKeyboardViewDelegate,CardPayChooseViewDelegate>

@property(nonatomic,strong)QCTextField *startTF;

@property(nonatomic,strong)QCTextField *endTF;

@property(nonatomic,strong)MOCell *userCell;

@property(nonatomic,strong)CardPayChooseCell *cardCell;

@property(nonatomic,strong)UIView *secView;

@property(nonatomic,strong)UIButton *confirmButton;

@property(nonatomic,strong)CardPayChooseView *cardView;

@property(nonatomic,strong)UIDatePicker *startDP;

@property(nonatomic,strong)UIDatePicker *endDP;

@property(nonatomic,strong)QCTextField *priceTF;

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)Card *chooseCard;

@property(nonatomic,assign)PayWay payWay;

@property(nonatomic,strong)StudentDetailInfo *stuInfo;

@property(nonatomic,strong)NSArray *cardArray;

@property(nonatomic,strong)UILabel *chestNameLabel;

@property(nonatomic,strong)UILabel *areaLabel;

@property(nonatomic,assign)BOOL endManual;

@property(nonatomic,strong)Student *user;

@end

@implementation ChestLongBorrowController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadData
{
    
    self.chestNameLabel.text = self.chest.name;
    
    self.areaLabel.text = self.chest.area.areaName;
    
    __weak typeof(self)weakS = self;
    
    self.stuInfo.cardDataFinish = ^(BOOL success){
        
        NSMutableArray *cards = [NSMutableArray array];
        
        for (Card *card in weakS.stuInfo.cardArray) {
            
            if (card.cardKind.type != CardKindTypeTime && card.remain>=0) {
                
                if (card.validTo && card.checkValid) {
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                    
                    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
                    
                    dateFormatter.dateFormat = @"yyyy-MM-dd";
                    
                    NSTimeInterval timeInterval = [[dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]] timeIntervalSinceDate:[dateFormatter dateFromString:card.validTo]];
                    
                    if (timeInterval<=0) {
                        
                        [cards addObject:card];
                        
                    }
                    
                }else{
                    
                    [cards addObject:card];
                    
                }
                
            }
            
        }
        
        weakS.cardView.cards = cards;
        
        if (cards.count) {
            
            weakS.chooseCard = [cards firstObject];
            
        }else{
            
            weakS.payWay = PayWayCash;
            
        }
        
    };
    
    [self.stuInfo requestChestCardInfoWithStudent:self.user];
    
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
    
    [self.stuInfo requestChestCardInfoWithStudent:self.user];
    
}

-(void)createUI
{
    
    self.title = @"长期租用更衣柜";
    
    self.rightType = MONaviRightTypeEdit;
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.mainView];
    
    self.chestNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(20), MSW, Height320(27))];
    
    self.chestNameLabel.text = self.chest.name;
    
    self.chestNameLabel.textColor = kMainColor;
    
    self.chestNameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.chestNameLabel.font = AllFont(24);
    
    [self.mainView addSubview:self.chestNameLabel];
    
    self.areaLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.chestNameLabel.bottom, self.chestNameLabel.width, Height320(14))];
    
    self.areaLabel.text = self.chest.area.areaName;
    
    self.areaLabel.textColor = kMainColor;
    
    self.areaLabel.textAlignment = NSTextAlignmentCenter;
    
    self.areaLabel.font = AllFont(12);
    
    [self.mainView addSubview:self.areaLabel];
    
    UIView *userView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(81), MSW, Height320(40)*3)];
    
    userView.backgroundColor = UIColorFromRGB(0xffffff);
    
    userView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    userView.layer.borderWidth = OnePX;
    
    [self.mainView addSubview:userView];
    
    self.userCell = [[MOCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.userCell.titleLabel.text = @"会员";
    
    self.userCell.placeholder = @"请选择";
    
    [userView addSubview:self.userCell];
    
    [self.userCell addTarget:self action:@selector(userChoose) forControlEvents:UIControlEventTouchUpInside];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"yyyy-MM-dd";
    
    self.startTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.userCell.bottom, self.userCell.width, Height320(40))];
    
    self.startTF.placeholder = @"开始日期";
    
    self.startTF.type = QCTextFieldTypeCell;
    
    self.startTF.text = [df stringFromDate:[NSDate date]];
    
    [userView addSubview:self.startTF];
    
    QCKeyboardView *startKV = [QCKeyboardView defaultKeboardView];
    
    startKV.tag = 101;
    
    startKV.delegate = self;
    
    self.startDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.startDP.datePickerMode = UIDatePickerModeDate;
    
    self.startDP.date = [NSDate date];
    
    startKV.keyboard = self.startDP;
    
    self.startTF.inputView = startKV;
    
    self.endTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.startTF.bottom, self.userCell.width, Height320(40))];
    
    self.endTF.placeholder = @"结束日期";
    
    self.endTF.type = QCTextFieldTypeCell;
    
    self.endTF.text = [df stringFromDate:[NSDate dateWithTimeIntervalSinceNow:86400*30]];
    
    [userView addSubview:self.endTF];
    
    QCKeyboardView *endKV = [QCKeyboardView defaultKeboardView];
    
    endKV.tag = 102;
    
    endKV.delegate = self;
    
    self.endDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.endDP.datePickerMode = UIDatePickerModeDate;
    
    self.endDP.date = [NSDate dateWithTimeIntervalSinceNow:86400*30];
    
    endKV.keyboard = self.endDP;
    
    self.endTF.inputView = endKV;
    
    self.secView = [[UIView alloc]initWithFrame:CGRectMake(0, userView.bottom+Height320(12), MSW, Height320(40)*2)];
    
    self.secView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.secView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.secView.layer.borderWidth = OnePX;
    
    [self.mainView addSubview:self.secView];
    
    self.cardCell = [[CardPayChooseCell alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    self.cardCell.cardPlaceholder = @"请选择支付方式";
    
    [self.secView addSubview:self.cardCell];
    
    [self.cardCell addTarget:self action:@selector(cardChoose) forControlEvents:UIControlEventTouchUpInside];
    
    self.priceTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.cardCell.bottom, MSW-Width320(32), Height320(40))];
    
    self.priceTF.placeholder = @"金额（元）";
    
    self.priceTF.keyboardType = UIKeyboardTypeDecimalPad;
    
    [self.priceTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [self.secView addSubview:self.priceTF];
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), self.secView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    self.confirmButton.backgroundColor = kMainColor;
    
    self.confirmButton.layer.cornerRadius = Width320(2);
    
    [self.confirmButton setTitle:@"确定租用" forState:UIControlStateNormal];
    
    [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [self.confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainView addSubview:self.confirmButton];
    
    self.cardView = [CardPayChooseView defaultView];
    
    self.cardView.delegate = self;
    
    [self.view addSubview:self.cardView];
    
    [self check];
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    [self check];
    
}

-(void)check
{
    
    if (self.user && self.startTF.text.length && self.endTF.text.length && (self.chooseCard||self.payWay) && self.priceTF.text.length) {
        
        self.confirmButton.alpha = 1;
        
    }else{
        
        self.confirmButton.alpha = 0.4;
        
    }
    
}

-(void)confirm:(UIButton*)button
{
    
    [self.view endEditing:YES];
    
    if (!self.user) {
        
        [[[UIAlertView alloc]initWithTitle:@"请选择会员" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else if (!self.chooseCard && !self.payWay){
        
        [[[UIAlertView alloc]initWithTitle:@"请选择支付方式" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else if(!self.priceTF.text.length){
        
        [[[UIAlertView alloc]initWithTitle:@"请填写收费金额" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else{
        
        button.userInteractionEnabled = NO;
        
        self.chest.start = self.startTF.text;
        
        self.chest.end = self.endTF.text;
        
        ChestBorrowInfo *info = [[ChestBorrowInfo alloc]init];
        
        [info borrowLongUseChest:self.chest withUser:self.user andCard:self.chooseCard orPayWay:self.payWay andCost:[self.priceTF.text integerValue] result:^(BOOL success, NSString *error) {
            
            button.userInteractionEnabled = YES;
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [self.view addSubview:hud];
            
            if (success) {
                
                hud.label.text = @"租用成功";
                
                [hud showAnimated:YES];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popToViewControllerName:@"ChestListController" isReloadData:YES];
                    
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


-(void)setPayWay:(PayWay)payWay
{
    
    _payWay = payWay;
    
    if (_payWay) {
        
        self.cardCell.cardName = _payWay == PayWayCash?@"现金支付":_payWay == PayWayCard?@"刷卡支付":_payWay == PayWayTransfer?@"转账支付":@"其他";
        
        self.priceTF.placeholder = @"金额（元）";
        
        [self.cardCell changeHeight:Height320(40)];
        
        self.cardCell.remain = nil;
        
        [self.priceTF changeTop:self.cardCell.bottom];
        
        [self.secView changeHeight:self.priceTF.bottom];
        
        [self.confirmButton changeTop:self.secView.bottom+Height320(12)];
        
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
    
    [self.secView changeHeight:self.priceTF.bottom];
    
    [self.confirmButton changeTop:self.secView.bottom+Height320(12)];
    
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
    
    [self check];
    
}

-(void)userChoose
{
    
    ChestBorrowChooseStudentController *svc = [[ChestBorrowChooseStudentController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.chooseFinish = ^(Student *stu){
        
        weakS.user = stu;
        
        weakS.userCell.subtitle = stu.name;
        
        [weakS createData];
        
        [weakS check];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)buyCard
{
    
    CardCreateChooseKindController *svc = [[CardCreateChooseKindController alloc]init];
    
    svc.gym = AppGym;
    
    svc.student = self.user;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)cardChoose
{
    
    [self.view endEditing:YES];
    
    if (self.user) {
        
        [self.cardView show];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:@"请选择会员" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}

-(void)naviRightClick
{
    
    ChestEditController *svc = [[ChestEditController alloc]init];
    
    svc.isAdd = NO;
    
    svc.chest = [self.chest copy];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"yyyy-MM-dd";
    
    if (keyboardView.tag == 101) {
        
        if (!self.endManual) {
            
            self.startTF.text = [df stringFromDate:self.startDP.date];
            
            self.endDP.date = [NSDate dateWithTimeInterval:86400*30 sinceDate:self.startDP.date];
            
            self.endTF.text = [df stringFromDate:self.endDP.date];
            
            [self.view endEditing:YES];
            
            [self check];
            
        }else{
            
            if ([self.startDP.date timeIntervalSinceDate:self.endDP.date]>0) {
                
                [[[UIAlertView alloc]initWithTitle:@"开始日期不能晚于结束日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
                
            }else{
                
                self.startTF.text = [df stringFromDate:self.startDP.date];
                
                [self.view endEditing:YES];
                
                [self check];
                
            }
            
        }
        
    }else{
        
        if ([self.startDP.date timeIntervalSinceDate:self.endDP.date]>0) {
            
            [[[UIAlertView alloc]initWithTitle:@"结束日期不能早于开始日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }else{
            
            self.endManual = YES;
            
            self.endTF.text = [df stringFromDate:self.endDP.date];
            
            [self.view endEditing:YES];
            
            [self check];
            
        }
        
    }
    
}

@end
