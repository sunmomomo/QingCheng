//
//  YFStudentChooseLatestTimeVC.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentChooseLatestTimeVC.h"
#import "YFLastestTimeModel.h"
#import "YFDateService.h"

#import "YFTimeTwoButtonView.h"

#import "YFTBSectionLineEdgeDelegate.h"

#import "QCKeyboardView.h"

#import "NSMutableDictionary+YFExtension.h"

#import "YFAppService.h"

@interface YFStudentChooseLatestTimeVC ()<QCKeyboardViewDelegate>

@property(nonatomic, strong)YFTimeTwoButtonView *twoButtonView;

@property(nonatomic, strong)QCKeyboardView *startKV;
@property(nonatomic, strong)QCKeyboardView *endKV;
@property(nonatomic, strong)UIDatePicker *startDP;
@property(nonatomic, strong)UIDatePicker *endDP;

@property(nonatomic, copy)NSString *startMonthDay;
@property(nonatomic, copy)NSString *endMonthDay;

@end

@implementation YFStudentChooseLatestTimeVC
@synthesize param = _param;

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.maxCusTimeGapCount = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navi removeFromSuperview];
    self.baseTableView.scrollEnabled = NO;
    [self requestData];
    self.view.backgroundColor = [UIColor clearColor];
    self.baseTableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.twoButtonView];
    self.leftView = self.baseTableView;
    self.rightView = self.twoButtonView;

    
}

- (void)requestData
{
    NSString *todayTimeStr = [YFDateService getDateFromDays:0 formating:nil];
    
    NSString *todayBeforeSevenTimeStr = [YFDateService getDateFromDays:-6 formating:nil];
    
    NSString *todayBeforeMonthTimeStr = [YFDateService getDateFromDays:-29 formating:nil];

    NSMutableArray *dataArray = [NSMutableArray array];
    
    YFLastestTimeModel *latesModel1 = [YFLastestTimeModel defaultWithDic:@{@"valueStr":@"最近7天"}];
    latesModel1.dateStr = [NSString stringWithFormat:@"%@至%@",todayBeforeSevenTimeStr,todayTimeStr];
   
    
    YFLastestTimeModel *latesModel2 = [YFLastestTimeModel defaultWithDic:@{@"valueStr":@"最近30天"}];
    latesModel2.dateStr = [NSString stringWithFormat:@"%@至%@",todayBeforeMonthTimeStr,todayTimeStr];

    if (self.isHaveToday)
    {
        YFLastestTimeModel *latesModel0 = [YFLastestTimeModel defaultWithDic:@{@"valueStr":@"今日"}];
        latesModel0.dateStr = @"";
        latesModel0.isSelected = YES;
        _selectModel = latesModel0;
        
        [dataArray addObject:latesModel0];
        
    }else
    {
        latesModel1.isSelected = YES;
        _selectModel = latesModel1;
    }
    
    [dataArray addObject:latesModel1];
    [dataArray addObject:latesModel2];
    
    if (self.isHaveCustom)
    {
        weakTypesYF
        YFLastestTimeModel *latesModel3 = [YFLastestTimeModel defaultWithYYModelDic:nil selectBlock:^(id m) {
            [weakS showRightView];
        }];
        latesModel3.valueStr = @"自定义";
        latesModel3.dateStr = @"";
        
        latesModel3.edgeInsets = UIEdgeInsetsZero;
        
        [dataArray addObject:latesModel3];
    }

    [self requestSuccessArray:dataArray];
    
    [self creatParam];
}


-(void)setSelectModel:(YFLastestTimeModel *)selectModel
{
    if (_selectModel && [_selectModel isEqual:selectModel] == NO) {
        _selectModel.isSelected = NO;
    }
    
    if ([_selectModel isEqual:selectModel] == YES) {
        _selectModel.isSelected = YES;
    }
    
    _selectModel = selectModel;
    [self.baseTableView reloadData];
    
    if (self.selectBlock) {
        [self creatParam];
        self.selectBlock();
    }
}


- (void)setSelectModelToModel:(YFLastestTimeModel *)model
{
    model.isSelected = YES;
    _selectModel.isSelected = NO;
    
    _selectModel = model;
}

- (void)creatParam
{
    NSUInteger count = 0;
    
    NSNumber *timeType;
    
    if ([_selectModel.valueStr isEqualToString:@"今日"])
    {
        count = 1;
        timeType = @(YFIsRegisterTimeTypeToday);
    }
    else if ([_selectModel.valueStr isEqualToString:@"最近7天"])
    {
        count = 7;
        timeType = @(YFIsRegisterTimeTypeSeven);
    }
    else if ([_selectModel.valueStr isEqualToString:@"最近30天"])
    {
        count = 30;
        timeType = @(YFIsRegisterTimeTypeThirty);
    }else
    {
        timeType = @(YFIsRegisterTimeTypeNone);
    }
    
    NSMutableArray *dateArray = [NSMutableArray array];
    
    NSMutableDictionary *dateParam = [NSMutableDictionary dictionary];
    
    // 有限制的时候 才有这个，默认 0 没有限制
        for (NSInteger i = count - 1; i >= 0; i --)
        {
            NSString *dateStr = [YFDateService getDateFromDays:-i formating:nil];
            
            // 每一天的日期
            [dateArray addObject:dateStr];
        }
    
    [dateParam setObject:[YFDateService getDateFromDays:0 formating:nil] forKey:@"end"];
    [dateParam setObject:[YFDateService getDateFromDays:-(count - 1) formating:nil] forKey:@"start"];
    
    self.param = @{@"DateArray":dateArray,@"DataParam":dateParam};
    
    self.conditionsParam = @{@"DateArray":dateArray,@"DataParam":dateParam,YFIsRegisterTimeKey:timeType};
}


- (YFTimeTwoButtonView *)twoButtonView
{
    if (_twoButtonView == nil)
    {
        _twoButtonView = [[YFTimeTwoButtonView alloc] initWithFrame:CGRectMake(self.view.width, 0, self.view.width, XFrom5To6YF(120))];
        
        _twoButtonView.desName = @"时间段";
        _twoButtonView.inputWidth = XFrom5YF(100);
        [_twoButtonView creatView];
        
        [_twoButtonView.leftButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [_twoButtonView.rightButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _twoButtonView.leftTextField.placeholder = @"起始时间";
        _twoButtonView.rightTextField.placeholder = @"结束时间";
        
        _twoButtonView.leftTextField.inputView = [self startKV];
        _twoButtonView.leftTextField.inputView.tag = 1;
        
        _twoButtonView.rightTextField.inputView = [self endKV];
        
        _twoButtonView.rightTextField.inputView.tag = 2;
    }
    return _twoButtonView;
}

//self.startTimeTF.inputView = self.startKV;


- (QCKeyboardView *)startKV
{
    if (!_startKV)
    {
        _startKV = [QCKeyboardView defaultKeboardView];
        
        _startKV.keyboard = self.startDP;
        
        _startKV.delegate = self;
    }
    return _startKV;
}

-(UIDatePicker *)startDP
{
    if (!_startDP)
    {
        _startDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
        
        _startDP.datePickerMode = UIDatePickerModeDate;
    }
    return _startDP;
}

- (QCKeyboardView *)endKV
{
    if (!_endKV)
    {
        _endKV = [QCKeyboardView defaultKeboardView];
        
        _endKV.keyboard = self.endDP;
        
        _endKV.delegate = self;
    }
    return _endKV;
}

-(UIDatePicker *)endDP
{
    if (!_endDP)
    {
        _endDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
        
        _endDP.datePickerMode = UIDatePickerModeDate;
    }
    return _endDP;
}

- (void)sureAction:(UIButton *)button
{
    if ([self isFullDate] == NO) {
        return;
    }
    if (self.selectBlock) {
        
        NSString *start = self.twoButtonView.leftTextField.text;
        NSString *end = self.twoButtonView.rightTextField.text;
        
        NSDate *endDate = [YFDateService getDateFromDateString:end formatString:nil];
        
        NSMutableArray *dateArray = [NSMutableArray array];
        
        NSMutableDictionary *dateParam = [NSMutableDictionary dictionary];
        
        NSInteger count = [YFDateService calcDaysCurrentToDateString:end startDate:start] + 1;
        
        // 有限制的时候 才有这个，默认 0 没有限制
        if (self.maxCusTimeGapCount)
        {
            if (count > self.maxCusTimeGapCount)
            {
                [YFAppService showAlertMessage:[NSString stringWithFormat:@"时间间隔不能超过%@天",@(self.maxCusTimeGapCount)]];
                return;
            }
            
        for (NSInteger i = count - 1; i >= 0; i --)
        {
            NSString *dateStr = [YFDateService getDateFromdate:endDate Days:-i formating:nil];
            
            // 每一天的日期
            [dateArray addObject:dateStr];
        }
        }
        [dateParam setObject:end forKey:@"end"];
        [dateParam setObject:start forKey:@"start"];
        
        self.param = @{@"DateArray":dateArray,@"DataParam":dateParam};

        self.conditionsParam = @{@"DateArray":dateArray,@"DataParam":dateParam,YFIsRegisterTimeKey:@(YFIsRegisterTimeTypeNone)};
        
        
        self.title = [NSString stringWithFormat:@"%@至%@",self.startMonthDay,self.endMonthDay];
        
//        self.footerDateStr = [NSString stringWithFormat:@"%@至%@",start,end];
        
        // 选中自定义
        YFLastestTimeModel *model = self.baseDataArray.lastObject;
        model.isSelected = YES;
        _selectModel.isSelected = NO;
        _selectModel = model;
        [self.baseTableView reloadData];
        
        self.selectBlock();
    }
    
}

- (void)backAction:(UIButton *)button
{
    [self showLeftView];
}

- (BOOL)isFullDate
{
    if (self.twoButtonView.leftTextField.text.length == 0)
    {
        [[[UIAlertView alloc]initWithTitle:@"请填写开始日期" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        return NO;
    }
    
    if (self.twoButtonView.rightTextField.text.length == 0)
    {
        [[[UIAlertView alloc]initWithTitle:@"请填写结束日期" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        return NO;
    }
    return YES;
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboadeView
{
    
    
    NSDateFormatter *df = [YFDateService dateformatter];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    if (keyboadeView.tag == 1){
        
        
        NSTimeInterval timeInterval = [[df dateFromString:[df stringFromDate:self.startDP.date]] timeIntervalSinceDate:[df dateFromString:self.twoButtonView.rightTextField.text]];
        
        if (timeInterval>0 && self.twoButtonView.rightTextField.text.length > 0) {
            
            [[[UIAlertView alloc]initWithTitle:@"开始日期不能晚于结束日期" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else
        {
            
            self.twoButtonView.leftTextField.text = [df stringFromDate:self.startDP.date];
            
            [df setDateFormat:@"MM-dd"];
            
            
            self.startMonthDay = [df stringFromDate:self.startDP.date];
            
            
            [self.view endEditing:YES];
            
        }
        
    }else if(keyboadeView.tag == 2)
    {
        
        NSTimeInterval timeInterval = [[df dateFromString:[df stringFromDate:self.endDP.date]] timeIntervalSinceDate:[df dateFromString:self.twoButtonView.leftTextField.text]];
        
        if (timeInterval<0) {
            
            [[[UIAlertView alloc]initWithTitle:@"结束日期不能早于开始日期" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else
        {
            
            self.twoButtonView.rightTextField.text = [df stringFromDate:self.endDP.date];
            
            [df setDateFormat:@"MM-dd"];
            
            
            self.endMonthDay = [df stringFromDate:self.endDP.date];
            
            [self.view endEditing:YES];
            
        }
        
    }
    
}

- (void)setTimeType:(YFIsRegisterTimeType)timeType
{
    _timeType = timeType;
    
    
    
    for (YFLastestTimeModel *timeModel in self.baseDataArray)
    {
        
        if (timeType == YFIsRegisterTimeTypeToday) {
            if([timeModel.valueStr isEqualToString:@"今日"])
            {
                [self setSelectModelToModel:timeModel];
                
                [self showLeftView];
            }
        }else  if (timeType == YFIsRegisterTimeTypeSeven) {
            if([timeModel.valueStr isEqualToString:@"最近7天"])
            {
               [self setSelectModelToModel:timeModel];
                
                [self showLeftView];
            }
        }else  if (timeType == YFIsRegisterTimeTypeThirty) {
            if([timeModel.valueStr isEqualToString:@"最近30天"])
            {
               [self setSelectModelToModel:timeModel];
                [self showLeftView];
            }
        }else
        {
            if([timeModel.valueStr isEqualToString:@"自定义"])
            {
               [self setSelectModelToModel:timeModel];
                
                self.twoButtonView.leftTextField.text = self.start;
                self.twoButtonView.rightTextField.text = self.end;
                
                
                NSDate *startDate = [YFDateService getDateFromDateString:self.start formatString:nil];

                NSDate *endDate = [YFDateService getDateFromDateString:self.end formatString:nil];

                
                NSDateFormatter *df = [YFDateService dateformatter];
                
                [df setDateFormat:@"MM-dd"];
                
                self.startMonthDay = [df stringFromDate:startDate];
                self.endMonthDay = [df stringFromDate:endDate];
                [self showRightView];
            }
        }
    }
    [self.baseTableView reloadData];
}


-(YFTBBaseDelegate *)delegateTBYF
{
    weakTypesYF
    return [YFTBSectionLineEdgeDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
        
    } currentVC:self];
}


@end
