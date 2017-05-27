//
//  CustomReportController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/13.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "CustomReportController.h"

#import "QCKeyboardView.h"

#import "QCTextField.h"

#import "ReportShowController.h"

#import "CourseListInfo.h"

#import "CardKindListInfo.h"

#import "GymListInfo.h"

#import "ReportShowController.h"

#import "MOPickerView.h"

#import "MOTwoComPickerView.h"

@interface CustomReportController ()<QCKeyboardViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)QCTextField *startTimeTF;

@property(nonatomic,strong)QCTextField *endTimeTF;

@property(nonatomic,strong)QCTextField *firstTF;

@property(nonatomic,strong)QCTextField *secondTF;

@property(nonatomic,strong)QCTextField *thirdTF;

@property(nonatomic,strong)QCTextField *forthTF;

@property(nonatomic,strong)UIDatePicker *startDP;

@property(nonatomic,strong)UIDatePicker *endDP;

@property(nonatomic,strong)CourseListInfo *coursesInfo;

@property(nonatomic,strong)CardKindListInfo *cardKindInfo;

@property(nonatomic,strong)MOTwoComPickerView *coursePV;

@property(nonatomic,strong)MOTwoComPickerView *cardKindPV;

@property(nonatomic,strong)MOPickerView *payWayPV;

@property(nonatomic,strong)MOPickerView *tradeTypePV;

@property(nonatomic,strong)MOPickerView *checkinTypePV;

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UIButton *createBtn;

@end

@implementation CustomReportController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

-(void)createData
{
    
    __weak typeof(self)weakS = self;
    
    if(self.type == ReportInfoTypeSchedule)
    {
        
        self.coursesInfo = [[CourseListInfo alloc]init];
        
        __weak typeof(self)weakS = self;
        
        self.coursesInfo.requestFinish = ^(BOOL success) {
            
            NSMutableArray *allArray = [@[@"全部课程"] mutableCopy];
            
            NSMutableArray *groupArray = [@[@"全部团课"] mutableCopy];
            
            NSMutableArray *privateArray = [@[@"全部私教"] mutableCopy];
            
            for (Course *course in weakS.coursesInfo.courses) {
                
                [allArray addObject:course.name];
                
            }
            
            for (Course *course in weakS.coursesInfo.groups) {
                
                [groupArray addObject:course.name];
                
            }
            
            for (Course *course in weakS.coursesInfo.privates) {
                
                [privateArray addObject:course.name];
                
            }
            
            weakS.coursePV.dataArray = @[@{@"title":@"全部课程",@"data":allArray},@{@"title":@"团课",@"data":groupArray},@{@"title":@"私教",@"data":privateArray}];
            
        };
        
        [self.coursesInfo requestAllDataWithGym:self.gym];
        
    }else if(self.type == ReportInfoTypeSell)
    {
        
        self.cardKindInfo = [[CardKindListInfo alloc]init];
        
        [self.cardKindInfo requestResult:^(BOOL success, NSString *error) {
            
            NSMutableArray *allArray = [@[@"全部会员卡种类"] mutableCopy];
            
            NSMutableArray *prepaidArray = [@[@"全部储值卡"] mutableCopy];
            
            NSMutableArray *countArray = [@[@"全部次卡"] mutableCopy];
            
            NSMutableArray *timeArray = [@[@"全部期限卡"] mutableCopy];
            
            for (CardKind *cardKind in weakS.cardKindInfo.cardKinds) {
                
                if (cardKind.type == CardKindTypePrepaid) {
                    
                    [prepaidArray addObject:cardKind.cardKindName];
                    
                }else if (cardKind.type == CardKindTypeCount){
                    
                    [countArray addObject:cardKind.cardKindName];
                    
                }else{
                    
                    [timeArray addObject:cardKind.cardKindName];
                    
                }
                
                [allArray addObject:cardKind.cardKindName];
                
            }
            
            weakS.cardKindPV.dataArray = @[@{@"title":@"全部会员卡种类",@"data":allArray},@{@"title":@"储值类型",@"data":prepaidArray},@{@"title":@"次卡类型",@"data":countArray},@{@"title":@"期限类型",@"data":timeArray}];
            
        }];
        
    }else{
        
        self.cardKindInfo = [[CardKindListInfo alloc]init];
        
        [self.cardKindInfo requestReportCardKindsWithGym:self.gym result:^(BOOL success, NSString *error) {
            
            NSMutableArray *allArray = [@[@"全部会员卡种类"] mutableCopy];
            
            NSMutableArray *prepaidArray = [@[@"全部储值卡"] mutableCopy];
            
            NSMutableArray *countArray = [@[@"全部次卡"] mutableCopy];
            
            NSMutableArray *timeArray = [@[@"全部期限卡"] mutableCopy];
            
            for (CardKind *cardKind in weakS.cardKindInfo.cardKinds) {
                
                if (cardKind.type == CardKindTypePrepaid) {
                    
                    [prepaidArray addObject:cardKind.cardKindName];
                    
                }else if (cardKind.type == CardKindTypeCount){
                    
                    [countArray addObject:cardKind.cardKindName];
                    
                }else{
                    
                    [timeArray addObject:cardKind.cardKindName];
                    
                }
                
                [allArray addObject:cardKind.cardKindName];
                
            }
            
            weakS.cardKindPV.dataArray = @[@{@"title":@"全部会员卡种类",@"data":allArray},@{@"title":@"储值类型",@"data":prepaidArray},@{@"title":@"次卡类型",@"data":countArray},@{@"title":@"期限类型",@"data":timeArray}];
            
        }];
        
    }
    
}

-(void)createUI
{
    
    self.title = @"自定义报表";
    
    self.navigationBarColor = UIColorFromRGB(0xfafafa);
    
    self.navigationTitleColor = UIColorFromRGB(0x666666);
    
    self.shadowType = MONaviShadowTypeLine;
    
    self.leftType = MONaviLeftTypeBlackClose;
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, self.type == ReportInfoTypeSell?Height320(40)*5:Height320(40)*3)];
    
    self.topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:self.topView];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    self.startTimeTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.startTimeTF.placeholder = @"开始日期";
    
    self.startTimeTF.text = [df stringFromDate:[NSDate date]];
    
    self.startTimeTF.delegate = self;
    
    [self.topView addSubview:self.startTimeTF];
    
    QCKeyboardView *startKV = [QCKeyboardView defaultKeboardView];
    
    startKV.delegate = self;
    
    startKV.tag = 201;
    
    self.startDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.startDP.datePickerMode = UIDatePickerModeDate;
    
    if (self.start.length) {
        
        self.startDP.minimumDate = [df dateFromString:self.start];
        
    }
    
    startKV.keyboard = self.startDP;
    
    self.startTimeTF.inputView = startKV;
    
    self.endTimeTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.startTimeTF.left, self.startTimeTF.bottom, self.startTimeTF.width, self.startTimeTF.height)];
    
    self.endTimeTF.placeholder = @"结束日期";
    
    self.endTimeTF.text = [df stringFromDate:[NSDate date]];
    
    self.endTimeTF.delegate = self;
    
    [self.topView addSubview:self.endTimeTF];
    
    QCKeyboardView *endKV = [QCKeyboardView defaultKeboardView];
    
    endKV.tag = 202;
    
    endKV.delegate = self;
    
    self.endDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.endDP.datePickerMode = UIDatePickerModeDate;
    
    if (self.end.length) {
        
        self.endDP.maximumDate = [df dateFromString:self.start];
        
    }
    
    endKV.keyboard = self.endDP;
    
    self.endTimeTF.inputView = endKV;
    
    self.firstTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.startTimeTF.left, self.endTimeTF.bottom, self.startTimeTF.width, self.startTimeTF.height)];
    
    self.firstTF.placeholder = self.type == ReportInfoTypeSchedule?@"课程":@"会员卡种类";
    
    self.firstTF.text = self.type == ReportInfoTypeSchedule?@"全部课程":@"全部会员卡种类";
    
    self.firstTF.delegate = self;
    
    self.firstTF.noLine = self.type == ReportInfoTypeSchedule;
    
    self.firstTF.type = QCTextFieldTypeCell;
    
    [self.topView addSubview:self.firstTF];
    
    if (self.type == ReportInfoTypeSell) {
        
        self.secondTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.firstTF.left, self.firstTF.bottom, self.firstTF.width, self.firstTF.height)];
        
        self.secondTF.placeholder = @"交易类型";
        
        self.secondTF.text = @"不限";
        
        self.secondTF.delegate = self;
        
        self.secondTF.type = QCTextFieldTypeCell;
        
        [self.topView addSubview:self.secondTF];
        
        self.thirdTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.firstTF.left, self.secondTF.bottom, self.firstTF.width, self.firstTF.height)];
        
        self.thirdTF.placeholder = @"支付方式";
        
        self.thirdTF.text = @"不限";
        
        self.thirdTF.delegate = self;
        
        self.thirdTF.type = QCTextFieldTypeCell;
        
        self.thirdTF.noLine = YES;
        
        [self.topView addSubview:self.thirdTF];
        
    }
    
    if (self.type == ReportInfoTypeSchedule) {
        
        QCKeyboardView *courseKV = [QCKeyboardView defaultKeboardView];
        
        courseKV.tag = 101;
        
        courseKV.delegate = self;
        
        self.firstTF.inputView = courseKV;
        
        self.coursePV = [[MOTwoComPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
        
        courseKV.keyboard = self.coursePV;
        
    }else if(self.type == ReportInfoTypeSell){
        
        QCKeyboardView *cardKindKV = [QCKeyboardView defaultKeboardView];
        
        cardKindKV.tag = 101;
        
        cardKindKV.delegate = self;
        
        self.firstTF.inputView = cardKindKV;
        
        self.cardKindPV = [[MOTwoComPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
        
        cardKindKV.keyboard = self.cardKindPV;
        
        QCKeyboardView *tradeKV = [QCKeyboardView defaultKeboardView];
        
        tradeKV.tag = 102;
        
        tradeKV.delegate = self;
        
        self.secondTF.inputView = tradeKV;
        
        self.tradeTypePV = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
        
        self.tradeTypePV.titleArray = @[@"不限",@"新购卡",@"充值",@"注册送卡",@"扣费"];
        
        tradeKV.keyboard = self.tradeTypePV;
        
        QCKeyboardView *payKV = [QCKeyboardView defaultKeboardView];
        
        payKV.tag = 104;
        
        payKV.delegate = self;
        
        self.thirdTF.inputView = payKV;
        
        self.payWayPV = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
        
        self.payWayPV.titleArray = @[@"不限",@"微信扫码支付",@"微信支付",@"现金支付",@"刷卡支付",@"赠送",@"转账支付",@"其他支付"];
        
        payKV.keyboard = self.payWayPV;
        
    }else{
        
        QCKeyboardView *cardKindKV = [QCKeyboardView defaultKeboardView];
        
        cardKindKV.tag = 101;
        
        cardKindKV.delegate = self;
        
        self.firstTF.inputView = cardKindKV;
        
        self.cardKindPV = [[MOTwoComPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
        
        cardKindKV.keyboard = self.cardKindPV;
        
        QCKeyboardView *typeKV = [QCKeyboardView defaultKeboardView];
        
        typeKV.tag = 102;
        
        typeKV.delegate = self;
        
        self.secondTF.inputView = typeKV;
        
        self.checkinTypePV = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
        
        self.checkinTypePV.titleArray = @[@"全部状态",@"已签出",@"暂未签出",@"已撤销"];
        
        typeKV.keyboard = self.checkinTypePV;
        
    }
    
    self.createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.createBtn.frame = CGRectMake(Width320(26.7), self.topView.bottom+Height320(18.2), MSW-Width320(53.4), Height320(43));
    
    self.createBtn.backgroundColor = kMainColor;
    
    [self.createBtn setTitle:@"生成报表" forState:UIControlStateNormal];
    
    self.createBtn.layer.cornerRadius = 1;
    
    self.createBtn.layer.masksToBounds = YES;
    
    [self.createBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [self.createBtn addTarget:self action:@selector(create:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.createBtn];
    
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboadeView
{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    if (keyboadeView.tag == 201){
        
        NSTimeInterval timeInterval = [[df dateFromString:[df stringFromDate:self.startDP.date]] timeIntervalSinceDate:[df dateFromString:self.endTimeTF.text]];
        
        if (timeInterval>0) {
            
            [[[UIAlertView alloc]initWithTitle:@"开始日期不能晚于结束日期" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else
        {
            
            self.startTimeTF.text = [df stringFromDate:self.startDP.date];
            
            [self.view endEditing:YES];
            
        }
        
    }else if(keyboadeView.tag == 202)
    {
        
        NSTimeInterval timeInterval = [[df dateFromString:[df stringFromDate:self.endDP.date]] timeIntervalSinceDate:[df dateFromString:self.startTimeTF.text]];
        
        if (timeInterval<0) {
            
            [[[UIAlertView alloc]initWithTitle:@"结束日期不能早于开始日期" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else
        {
            
            self.endTimeTF.text = [df stringFromDate:self.endDP.date];
            
            [self.view endEditing:YES];
            
        }
        
    }else{
        
        [self.view endEditing:YES];
        
        [self.view endEditing:YES];
        
        if (self.type == ReportInfoTypeSchedule) {
            
            if (keyboadeView.tag == 101)
            {
                
                self.firstTF.text = self.coursePV.dataArray[self.coursePV.selectCompoment][@"data"][self.coursePV.selectRow];
                
                if (self.coursePV.selectRow == 0) {
                    
                    self.filter.course = nil;
                    
                    if (self.coursePV.selectCompoment == 0) {
                        
                        self.filter.allGroup = NO;
                        
                        self.filter.allPrivate = NO;
                        
                    }else if (self.coursePV.selectCompoment == 1){
                        
                        self.filter.allGroup = YES;
                        
                    }else{
                        
                        self.filter.allPrivate = YES;
                        
                    }
                    
                }else{
                    
                    if (self.coursePV.selectCompoment == 0) {
                        
                        self.filter.course = self.coursesInfo.courses[self.coursePV.selectRow-1];
                        
                    }else if (self.coursePV.selectCompoment == 1){
                        
                        self.filter.course = self.coursesInfo.groups[self.coursePV.selectRow-1];
                        
                    }else{
                        
                        self.filter.course = self.coursesInfo.privates[self.coursePV.selectRow-1];
                        
                    }
                    
                }
                
            }
            
        }else if(self.type == ReportInfoTypeSell){
            
            if (keyboadeView.tag == 101)
            {
                
                self.firstTF.text = self.cardKindPV.dataArray[self.cardKindPV.selectCompoment][@"data"][self.cardKindPV.selectRow];
                
                if (self.cardKindPV.selectRow == 0) {
                    
                    self.filter.cardKind = nil;
                    
                    if (self.cardKindPV.selectCompoment == 0) {
                        
                        self.filter.allPrepaidCardKind = NO;
                        
                        self.filter.allTimeCardKind = NO;
                        
                        self.filter.allCountCardKind = NO;
                        
                    }else if (self.cardKindPV.selectCompoment == 1){
                        
                        self.filter.allPrepaidCardKind = YES;
                        
                    }else if (self.cardKindPV.selectCompoment == 1){
                        
                        self.filter.allCountCardKind = YES;
                        
                    }else{
                        
                        self.filter.allTimeCardKind = YES;
                        
                    }
                    
                }else if (self.cardKindPV.selectRow == 1){
                    
                    if (self.cardKindPV.selectCompoment == 0) {
                        
                        self.filter.cardKind = self.cardKindInfo.cardKinds[self.cardKindPV.selectRow-1];
                        
                    }else if (self.cardKindPV.selectCompoment == 1){
                        
                        self.filter.cardKind = self.cardKindInfo.prepaidCardKinds[self.cardKindPV.selectRow-1];
                        
                    }else if (self.cardKindPV.selectCompoment == 2){
                        
                        self.filter.cardKind = self.cardKindInfo.countCardKinds[self.cardKindPV.selectRow-1];
                        
                    }else{
                        
                        self.filter.cardKind = self.cardKindInfo.timeCardKinds[self.cardKindPV.selectRow-1];
                        
                    }
                    
                }else{
                    
                    if (self.cardKindPV.selectCompoment == 0) {
                        
                        self.filter.cardKind = self.cardKindInfo.cardKinds[self.cardKindPV.selectRow-1];
                        
                    }else if (self.cardKindPV.selectCompoment == 1){
                        
                        self.filter.cardKind = self.cardKindInfo.prepaidCardKinds[self.cardKindPV.selectRow-1];
                        
                    }else if (self.cardKindPV.selectCompoment == 2){
                        
                        self.filter.cardKind = self.cardKindInfo.countCardKinds[self.cardKindPV.selectRow-1];
                        
                    }else{
                        
                        self.filter.cardKind = self.cardKindInfo.timeCardKinds[self.cardKindPV.selectRow-1];
                        
                    }
                    
                }
                
            }else if(keyboadeView.tag == 102)
            {
                
                self.secondTF.text = self.tradeTypePV.titleArray[self.tradeTypePV.currentRow];
                
                if (self.tradeTypePV.currentRow == 0) {
                    
                    self.filter.tradeType = TradeTypeNone;
                    
                }else if (self.tradeTypePV.currentRow == 1) {
                    
                    self.filter.tradeType = TradeTypeCreate;
                    
                }else if (self.tradeTypePV.currentRow == 2){
                    
                    self.filter.tradeType = TradeTypeRecharge;
                    
                }else if (self.tradeTypePV.currentRow == 3) {
                    
                    self.filter.tradeType = TradeTypeGive;
                    
                }else{
                    
                    self.filter.tradeType = TradeTypeCost;
                    
                }
                
            }else if (keyboadeView.tag == 104){
                
                self.thirdTF.text = self.payWayPV.titleArray[self.payWayPV.currentRow];
                
                if (self.payWayPV.currentRow == 0) {
                    
                    self.filter.payWay = PayWayNone;
                    
                }else if (self.payWayPV.currentRow == 1) {
                    
                    self.filter.payWay = PayWayQRCode;
                    
                }else if (self.payWayPV.currentRow == 2){
                    
                    self.filter.payWay = PayWayWeChat;
                    
                }else if (self.payWayPV.currentRow == 3) {
                    
                    self.filter.payWay = PayWayCash;
                    
                }else if (self.payWayPV.currentRow == 4){
                    
                    self.filter.payWay = PayWayCard;
                    
                }else if (self.payWayPV.currentRow == 5){
                    
                    self.filter.payWay = PayWayGive;
                    
                }else if (self.payWayPV.currentRow == 6){
                    
                    self.filter.payWay = PayWayTransfer;
                    
                }else{
                    
                    self.filter.payWay = PayWayOther;
                    
                }
                
            }
            
        }else{
            
            if (keyboadeView.tag == 101)
            {
                
                self.firstTF.text = self.cardKindPV.dataArray[self.cardKindPV.selectCompoment][@"data"][self.cardKindPV.selectRow];
                
                if (self.cardKindPV.selectRow == 0) {
                    
                    self.filter.cardKind = nil;
                    
                    if (self.cardKindPV.selectCompoment == 0) {
                        
                        self.filter.allPrepaidCardKind = NO;
                        
                        self.filter.allTimeCardKind = NO;
                        
                        self.filter.allCountCardKind = NO;
                        
                    }else if (self.cardKindPV.selectCompoment == 1){
                        
                        self.filter.allPrepaidCardKind = YES;
                        
                    }else if (self.cardKindPV.selectCompoment == 1){
                        
                        self.filter.allCountCardKind = YES;
                        
                    }else{
                        
                        self.filter.allTimeCardKind = YES;
                        
                    }
                    
                }else if (self.cardKindPV.selectRow == 1){
                    
                    if (self.cardKindPV.selectCompoment == 0) {
                        
                        self.filter.cardKind = self.cardKindInfo.cardKinds[self.cardKindPV.selectRow-1];
                        
                    }else if (self.cardKindPV.selectCompoment == 1){
                        
                        self.filter.cardKind = self.cardKindInfo.prepaidCardKinds[self.cardKindPV.selectRow-1];
                        
                    }else if (self.cardKindPV.selectCompoment == 2){
                        
                        self.filter.cardKind = self.cardKindInfo.countCardKinds[self.cardKindPV.selectRow-1];
                        
                    }else{
                        
                        self.filter.cardKind = self.cardKindInfo.timeCardKinds[self.cardKindPV.selectRow-1];
                        
                    }
                    
                }else{
                    
                    if (self.cardKindPV.selectCompoment == 0) {
                        
                        self.filter.cardKind = self.cardKindInfo.cardKinds[self.cardKindPV.selectRow-1];
                        
                    }else if (self.cardKindPV.selectCompoment == 1){
                        
                        self.filter.cardKind = self.cardKindInfo.prepaidCardKinds[self.cardKindPV.selectRow-1];
                        
                    }else if (self.cardKindPV.selectCompoment == 2){
                        
                        self.filter.cardKind = self.cardKindInfo.countCardKinds[self.cardKindPV.selectRow-1];
                        
                    }else{
                        
                        self.filter.cardKind = self.cardKindInfo.timeCardKinds[self.cardKindPV.selectRow-1];
                        
                    }
                    
                }
                
            }else if(keyboadeView.tag == 102){
                
                self.secondTF.text = self.checkinTypePV.titleArray[self.checkinTypePV.currentRow];
                
                if (self.checkinTypePV.currentRow == 0) {
                    
                    self.filter.checkinType = CheckinTypeNone;
                    
                }else if (self.checkinTypePV.currentRow == 1) {
                    
                    self.filter.checkinType = CheckinTypeCheckout;
                    
                }else if (self.checkinTypePV.currentRow == 2){
                    
                    self.filter.checkinType = CheckinTypeCheckin;
                    
                }else{
                    
                    self.filter.checkinType = CheckinTypeCancel;
                    
                }
                

            }
            
        }
        
    }
    
}


-(void)create:(UIButton*)btn
{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    if ([[df dateFromString:self.endTimeTF.text] timeIntervalSinceDate:[df dateFromString:self.startTimeTF.text]]>86400*31) {
        
        [[[UIAlertView alloc]initWithTitle:@"报表时间不能超过31天" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    self.filter.startDate = self.startTimeTF.text;
    
    self.filter.endDate = self.endTimeTF.text;
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if (self.customFinish) {
            
            self.customFinish(self.filter);
            
        }
        
    }];
    
}

-(void)naviLeftClick
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


@end
