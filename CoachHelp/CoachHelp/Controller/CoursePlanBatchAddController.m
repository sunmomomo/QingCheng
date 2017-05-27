//
//  CoursePlanBatchAddController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanBatchAddController.h"

#import "QCTextField.h"

#import "QCKeyboardView.h"

#import "MOTimePicker.h"

#import "ChooseCell.h"

@interface CoursePlanBatchAddController ()<UITextFieldDelegate,QCKeyboardViewDelegate>

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)QCTextField *startTF;

@property(nonatomic,strong)QCTextField *endTF;

@property(nonatomic,strong)NSArray *weekArray;

@property(nonatomic,strong)CoursePlan *plan;

@property(nonatomic,strong)MOTimePicker *startOP;

@property(nonatomic,strong)MOTimePicker *endOP;

@property(nonatomic,strong)UILabel *hintLabel;

@property(nonatomic,strong)UIView *secView;

@property(nonatomic,strong)UIButton *confirmButton;

@end

@implementation CoursePlanBatchAddController

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
    
    self.weekArray = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    
    self.plan = [[CoursePlan alloc]init];
    
    self.plan.startTime = @"08:00";
    
    if (self.course.type == CourseTypeGroup) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        
        dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        dateFormatter.dateFormat = @"HH:mm";
        
        self.plan.endTime = [dateFormatter stringFromDate:[NSDate dateWithTimeInterval:self.course.during*60 sinceDate:[dateFormatter dateFromString:@"08:00"]]];
        
    }else
    {
        
        self.plan.endTime = @"21:00";
        
    }
    
    self.plan.weeks = [self.weekArray mutableCopy];
    
}

-(void)createUI
{
    
    self.title = @"添加排期";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.mainView];
    
    if (self.course.type == CourseTypePrivate) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(36))];
        
        label.text = @"可约时间段";
        
        label.textColor = UIColorFromRGB(0x999999);
        
        label.font = AllFont(12);
        
        [self.mainView addSubview:label];
        
    }
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, self.course.type == CourseTypePrivate?Height320(36):0, MSW, self.course.type == CourseTypePrivate?Height320(40)*2:Height320(40))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.mainView addSubview:topView];
    
    self.startTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.startTF.placeholder = @"开始时间";
    
    self.startTF.delegate = self;
    
    self.startTF.text = @"08:00";
    
    self.startTF.noLine = self.course.type == CourseTypeGroup;
    
    [topView addSubview:self.startTF];
    
    QCKeyboardView *startKV = [QCKeyboardView defaultKeboardView];
    
    startKV.delegate = self;
    
    startKV.tag = 101;
    
    self.startOP = [[MOTimePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.startOP.timeGap = 5;
    
    startKV.keyboard = self.startOP;
    
    self.startTF.inputView = startKV;
    
    if (self.course.type == CourseTypePrivate) {
        
        self.endTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.startTF.bottom, self.startTF.width, self.startTF.height)];
        
        self.endTF.placeholder = @"结束时间";
        
        self.endTF.delegate = self;
        
        self.endTF.noLine = YES;
        
        self.endTF.text = @"21:00";
        
        [topView addSubview:self.endTF];
        
        QCKeyboardView *endKV = [QCKeyboardView defaultKeboardView];
        
        endKV.delegate = self;
        
        endKV.tag = 102;
        
        self.endOP = [[MOTimePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
        
        self.endOP.timeGap = 5;
        
        endKV.keyboard = self.endOP;
        
        self.endTF.inputView = endKV;
        
    }
    
    self.hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(10), MSW-Width320(32), Height320(30))];
    
    self.hintLabel.numberOfLines = 0;
    
    self.hintLabel.textColor = UIColorFromRGB(0x999999);
    
    self.hintLabel.font = AllFont(12);
    
    [self.hintLabel autoHeight];
    
    [self.mainView addSubview:self.hintLabel];
    
    self.secView = [[UIView alloc]initWithFrame:CGRectMake(0, self.hintLabel.bottom+Height320(5), MSW, Height320(40)*7)];
    
    self.secView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.secView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.secView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.mainView addSubview:self.secView];
    
    for (NSInteger i = 0; i<7; i++) {
        
        ChooseCell *cell = [[ChooseCell alloc]initWithFrame:CGRectMake(Width320(16), i*Height320(40), MSW-Width320(32), Height320(40))];
        
        if (i==6) {
            
            cell.noLine = YES;
            
        }
        
        cell.title = self.weekArray[i];
        
        cell.choosed = [self.plan.weeks containsObject:cell.title];
        
        cell.tag = i;
        
        [self.secView addSubview:cell];
        
        [cell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), self.secView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    self.confirmButton.backgroundColor = [kMainColor colorWithAlphaComponent:0.3];
    
    self.confirmButton.userInteractionEnabled = NO;
    
    self.confirmButton.layer.cornerRadius = 2;
    
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    self.confirmButton.titleLabel.font = AllFont(14);
    
    [self.mainView addSubview:self.confirmButton];
    
    self.mainView.contentSize = CGSizeMake(0, self.confirmButton.bottom+Height320(30));
    
    [self.confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    
    [self check];
    
}

-(void)cellClick:(ChooseCell*)cell
{
    
    cell.choosed = !cell.choosed;
    
    if (!cell.choosed) {
        
        if ([self.plan.weeks containsObject:self.weekArray[cell.tag]]) {
            
            [self.plan.weeks removeObject:self.weekArray[cell.tag]];
            
        }
        
    }else
    {
        
        if (![self.plan.weeks containsObject:self.weekArray[cell.tag]]) {
            
            [self.plan.weeks addObject:self.weekArray[cell.tag]];
            
            [self.plan.weeks sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                
                if ([self.weekArray indexOfObject:obj1]<[self.weekArray indexOfObject:obj2]) {
                    
                    return NSOrderedAscending;
                    
                }else
                {
                    
                    return NSOrderedDescending;
                    
                }
                
            }];
            
        }
        
    }
    
    [self check];
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    if (keyboardView.tag == 101) {
        
        self.startTF.text = self.startOP.time;
        
        self.plan.startTime = self.startTF.text;
        
        [self.view endEditing:YES];
        
        if (self.endTF) {
            
            self.endTF.text = @"21:00";
            
            self.plan.endTime = self.endTF.text;
            
        }
        
        [self check];
        
    }else
    {
        
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        
        df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        df.dateFormat = @"HH:mm";
        
        if ([[df dateFromString:self.endOP.time] timeIntervalSinceDate:[df dateFromString:self.startTF.text]]<=0) {
            
            [[[UIAlertView alloc]initWithTitle:@"结束时间须晚于开始时间" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        self.endTF.text = self.endOP.time;
        
        self.plan.endTime = self.endTF.text;
        
        [self.view endEditing:YES];
        
        [self check];
        
    }
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField == self.startTF) {
        
        self.startOP.time = self.startTF.text;
        
    }else
    {
        
        self.endOP.time = self.endTF.text;
        
    }
        
    return YES;
    
}

-(void)check
{
    
    NSString *weekStr = @"";
    
    for (NSInteger i = 0; i<self.plan.weeks.count; i++) {
        
        NSString *str = self.plan.weeks[i];
        
        weekStr = [weekStr stringByAppendingString:str];
        
        if (i<self.plan.weeks.count-1) {
            
            weekStr = [weekStr stringByAppendingString:@"、"];
            
        }
        
    }
    
    self.confirmButton.backgroundColor = self.plan.weeks.count?kMainColor:[kMainColor colorWithAlphaComponent:0.3];
    
    self.confirmButton.userInteractionEnabled = self.plan.weeks.count;
    
    self.hintLabel.text = weekStr.length?self.course.type == CourseTypeGroup?[NSString stringWithFormat:@"每个%@ %@有此课程。",weekStr,self.startTF.text]:[NSString stringWithFormat:@"每个%@ %@-%@可预约此课程。",weekStr,self.startTF.text,self.endTF.text]:@"";
    
    [self.hintLabel autoHeight];
    
    [self.secView changeTop:self.hintLabel.bottom+Height320(10)];
    
    [self.confirmButton changeTop:self.secView.bottom+Height320(12)];
    
}

-(void)confirm
{
    
    NSMutableArray *clashArray = [NSMutableArray array];
    
    for (CoursePlan *plan in self.course.coursePlans) {
        
        NSArray *array = [plan compareWithPlan:self.plan];
        
        for (NSString *clash in array) {
            
            if (![clashArray containsObject:clash]) {
                
                [clashArray addObject:clash];
                
            }
            
        }
        
    }
    
    if (clashArray.count) {
        
        NSString *error = @"";
        
        for (NSInteger i = 0;i<clashArray.count;i++) {
            
            NSString *clash = clashArray[i];
            
            error = [error stringByAppendingString:clash];
            
            if (i<clashArray.count-1) {
                
                error = [error stringByAppendingString:@"、"];
                
            }
            
        }
        
        error = [error stringByAppendingString:@"存在时间冲突，请安排其他时间"];
        
        [[[UIAlertView alloc]initWithTitle:error message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
        
        return;
        
    }else
    {
        
        if (self.addFinish) {
            self.addFinish(self.plan);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}


@end
