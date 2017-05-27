//
//  CoursePlanAddController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanAddController.h"

#import "MOCell.h"

#import "QCTextField.h"

#import "QCKeyboardView.h"

#import "CoursePlan.h"

#import "GuideBatchCell.h"

#import "CoursePlanBatchAddController.h"

#import "CoursePlanCoachController.h"

#import "CoursePlanCourseController.h"

#import "CoursePlanYardController.h"

#import "CoursePlanWayController.h"

#import "CoursePlanBatch.h"

#import "CoursePlanDetailInfo.h"

#import "CoursePlanGroupController.h"

#import "CoursePlanPrivateController.h"

#import "CourseArrangeController.h"

#import "MOSwitchCell.h"

#import "CoursePlanPayCardController.h"

#import "CoursePlanPayOnlineController.h"

#import "GymProHintView.h"

#import "KeyboardManager.h"

static NSString *identifier = @"Cell";

@interface CoursePlanAddController ()<QCKeyboardViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,GuideBatchCellDelegate,MOSwitchCellDelegate,GymProHintViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *subtitleLabel;

@property(nonatomic,strong)MOCell *topCell;

@property(nonatomic,strong)MOCell *yardCell;

@property(nonatomic,strong)QCTextField *startTF;

@property(nonatomic,strong)QCTextField *endTF;

@property(nonatomic,strong)QCTextField *capacityTF;

@property(nonatomic,strong)UIDatePicker *startDP;

@property(nonatomic,strong)UIDatePicker *endDP;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)CoursePlanBatch *batch;

@property(nonatomic,assign)BOOL endTFManual;

@property(nonatomic,strong)UIView *needPayView;

@property(nonatomic,strong)MOSwitchCell *needPayCell;

@property(nonatomic,strong)MOCell *cardPayCell;

@property(nonatomic,strong)MOCell *onlinePayCell;

@property(nonatomic,strong)UILabel *coursePlanLabel1;

@property(nonatomic,strong)UILabel *coursePlanLabel2;

@property(nonatomic,strong)UIView *timeView;

@property(nonatomic,strong)UIView *clearView;

@property(nonatomic,strong)UIView *tableHeaderView;

@end

@implementation CoursePlanAddController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
}

-(void)dealloc
{
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
}

-(void)createData
{
    
    if (!self.course) {
        
        self.course = [[Course alloc]init];
        
        self.course.type = self.courseType;
        
    }
    
    if (self.course.coursePlans) {
        
        [self.course.coursePlans removeAllObjects];
        
    }else{
        
        self.course.coursePlans = [NSMutableArray array];
        
    }
    
    self.course.capacity = 0;
    
    self.batch = [[CoursePlanBatch alloc]init];
    
    self.batch.course = self.course;
    
    self.batch.coach = self.coach;
    
    self.batch.isFree = YES;
    
    [self.iconView sd_setImageWithURL:self.courseType == CourseTypeGroup?self.course.imgUrl:self.coach.iconUrl];
    
    self.titleLabel.text = self.courseType == CourseTypeGroup?self.course.name:self.coach.name;
    
    if (self.courseType == CourseTypeGroup) {
        
        self.subtitleLabel.text = [NSString stringWithFormat:@"%ldmin",(long)self.course.during];
        
    }
    
    self.topCell.subtitle = self.courseType == CourseTypeGroup?self.coach.name:self.course.name;
    
    [self.tableView reloadData];
    
}

-(void)reloadData
{
    
    self.needPayCell.on = !self.batch.isFree;
    
    self.needPayCell.noLine = self.batch.isFree;
    
    NSArray *onlinePays = self.batch.onlinePays;
    
    NSArray *cardKinds = self.batch.cardKinds;
    
    OnlinePay *pay = [onlinePays firstObject];
    
    self.onlinePayCell.subtitle = pay.isUsed?@"已开启":@"已关闭";
    
    self.cardPayCell.subtitle = cardKinds.count?[NSString stringWithFormat:@"可用%ld种卡结算",(unsigned long)cardKinds.count]:@"未设置可结算会员卡";
    
    [self.needPayView changeHeight:self.batch.isFree?Height(44):Height(44)*3];
    
    self.onlinePayCell.hidden = self.cardPayCell.hidden = self.batch.isFree;
    
    [self.coursePlanLabel1 changeTop:self.needPayView.bottom+Height(12)];
    
    [self.timeView changeTop:self.needPayView.bottom+Height(44)];
    
    [self.clearView changeTop:self.timeView.bottom];
    
    [self.coursePlanLabel2 changeTop:self.timeView.bottom+Height(12)];
    
    self.clearView.hidden = YES;
    
    for (CoursePlan *plan in self.batch.course.coursePlans) {
        
        if (plan.autoFill) {
            
            self.clearView.hidden = NO;
            
            break;
            
        }
        
    }
    
    [self.tableHeaderView changeHeight:self.clearView.bottom];
    
    self.tableView.tableHeaderView = self.tableHeaderView;
    
}

-(void)createUI
{
    
    self.title = self.courseType == CourseTypeGroup?@"新增团课排课":@"新增私教排期";
    
    self.rightTitle = @"完成";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[GuideBatchCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    self.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(90)+Height(44)*8+Height(12))];
    
    self.tableHeaderView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(90)+Height(44)*3)];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.tableHeaderView addSubview:topView];
    
    UIButton *topButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(90))];
    
    [topView addSubview:topButton];
    
    [topButton addTarget:self action:@selector(topClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(50), Height320(50))];
    
    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.iconView.layer.borderColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.1].CGColor;
    
    self.iconView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    if (self.courseType == CourseTypePrivate) {
        
        self.iconView.layer.cornerRadius = self.iconView.width/2;
        
        self.iconView.layer.masksToBounds = YES;
        
    }
    
    [topButton addSubview:self.iconView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconView.right+Width320(12), self.courseType == CourseTypePrivate?Height320(33):Height320(21), MSW-Width320(35.5)-self.iconView.right, Height320(17))];
    
    self.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.titleLabel.font = AllFont(15);
    
    [topButton addSubview:self.titleLabel];
    
    if (self.courseType == CourseTypeGroup) {
        
        self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+Height320(8), self.titleLabel.left, Height320(15))];
        
        self.subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        self.subtitleLabel.font = AllFont(13);
        
        [topButton addSubview:self.subtitleLabel];
        
    }
    
    UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.5), Height320(35), Width320(7.5), Height320(12))];
    
    arrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [topButton addSubview:arrow];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width(15), topButton.bottom-1/[UIScreen mainScreen].scale, MSW-Width(30), 1/[UIScreen mainScreen].scale)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [topView addSubview:sep];
    
    self.topCell = [[MOCell alloc]initWithFrame:CGRectMake(Width(15), topButton.bottom, MSW-Width(30), Height(44))];
    
    self.topCell.titleLabel.text = self.courseType == CourseTypeGroup?@"教练":@"课程";
    
    self.topCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.topCell.subtitleColor = UIColorFromRGB(0x888888);
    
    self.topCell.tag = 101;
    
    [self.topCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:self.topCell];
    
    self.yardCell = [[MOCell alloc]initWithFrame:CGRectMake(self.topCell.left, self.topCell.bottom, self.topCell.width, self.topCell.height)];
    
    self.yardCell.titleLabel.text = @"场地";
    
    self.yardCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.yardCell.subtitleColor = UIColorFromRGB(0x888888);
    
    self.yardCell.tag = 102;
    
    [self.yardCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:self.yardCell];
    
    self.capacityTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.topCell.left, self.yardCell.bottom, self.topCell.width, self.topCell.height)];
    
    self.capacityTF.placeholder = @"单节课可约人数";
    
    self.capacityTF.placeholderColor = UIColorFromRGB(0x333333);
    
    self.capacityTF.textColor = UIColorFromRGB(0x888888);
    
    self.capacityTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.capacityTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [topView addSubview:self.capacityTF];
    
    self.needPayView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height(12), MSW, Height(44))];
    
    self.needPayView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.needPayView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.needPayView.layer.borderWidth = OnePX;
    
    [self.tableHeaderView addSubview:self.needPayView];
    
    self.needPayCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width(15), 0, MSW-Width(30), Height(44))];
    
    self.needPayCell.titleLabel.text = @"需要结算";
    
    if (!AppGym.pro) {
        
        self.needPayCell.pro = YES;
        
    }
    
    self.needPayCell.noLine = YES;
    
    self.needPayCell.delegate = self;
    
    [self.needPayView addSubview:self.needPayCell];
    
    [self.needPayCell addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.onlinePayCell = [[MOCell alloc]initWithFrame:CGRectMake(self.needPayCell.left, self.needPayCell.bottom, self.needPayCell.width, self.needPayCell.height)];
    
    self.onlinePayCell.titleLabel.text = @"在线支付结算";
    
    self.onlinePayCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.onlinePayCell.subtitleColor = UIColorFromRGB(0x888888);
    
    self.onlinePayCell.placeholderColor = UIColorFromRGB(0xbbbbbb);
    
    self.onlinePayCell.tag = 103;
    
    [self.needPayView addSubview:self.onlinePayCell];
    
    self.onlinePayCell.hidden = YES;
    
    [self.onlinePayCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cardPayCell = [[MOCell alloc]initWithFrame:CGRectMake(self.needPayCell.left, self.onlinePayCell.bottom, self.needPayCell.width, self.needPayCell.height)];
    
    self.cardPayCell.titleLabel.text = @"会员卡结算";
    
    self.cardPayCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.cardPayCell.subtitleColor = UIColorFromRGB(0x888888);
    
    self.cardPayCell.placeholderColor = UIColorFromRGB(0xbbbbbb);
    
    self.cardPayCell.tag = 104;
    
    self.cardPayCell.hidden = YES;
    
    [self.needPayView addSubview:self.cardPayCell];
    
    [self.cardPayCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.coursePlanLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), self.needPayView.bottom+Height(12), Width320(100), Height320(16))];
    
    self.coursePlanLabel1.text = self.courseType == CourseTypeGroup?@"课程排期":@"课程日期";
    
    self.coursePlanLabel1.textColor = UIColorFromRGB(0x999999);
    
    self.coursePlanLabel1.font = AllFont(14);
    
    [self.tableHeaderView addSubview:self.coursePlanLabel1];
    
    self.timeView = [[UIView alloc]initWithFrame:CGRectMake(0, self.needPayView.bottom+Height(44), MSW, Height(44)*2)];
    
    self.timeView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.timeView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.timeView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.tableHeaderView addSubview:self.timeView];
    
    self.startTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width(15), 0, MSW-Width(30), Height(44))];
    
    self.startTF.placeholder = @"开始日期";
    
    self.startTF.textPlaceholder = @"请选择";
    
    self.startTF.placeholderColor = UIColorFromRGB(0x333333);
    
    self.startTF.textColor = UIColorFromRGB(0x888888);
    
    self.startTF.type = QCTextFieldTypeCell;
    
    self.startTF.delegate = self;
    
    [self.timeView addSubview:self.startTF];
    
    QCKeyboardView *startKV = [QCKeyboardView defaultKeboardView];
    
    startKV.tag = 101;
    
    startKV.delegate = self;
    
    self.startTF.inputView = startKV;
    
    self.startDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.startDP.datePickerMode = UIDatePickerModeDate;
    
    startKV.keyboard = self.startDP;
    
    self.endTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.startTF.left, self.startTF.bottom, self.startTF.width, self.startTF.height)];
    
    self.endTF.placeholder = @"结束日期";
    
    self.endTF.textPlaceholder = @"请选择";
    
    self.endTF.placeholderColor = UIColorFromRGB(0x333333);
    
    self.endTF.textColor = UIColorFromRGB(0x888888);
    
    self.endTF.type = QCTextFieldTypeCell;
    
    self.endTF.noLine = YES;
    
    self.endTF.delegate = self;
    
    [self.timeView addSubview:self.endTF];
    
    QCKeyboardView *endKV = [QCKeyboardView defaultKeboardView];
    
    endKV.tag = 102;
    
    endKV.delegate = self;
    
    self.endTF.inputView = endKV;
    
    self.endDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.endDP.datePickerMode = UIDatePickerModeDate;
    
    endKV.keyboard = self.endDP;
    
    self.coursePlanLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), self.timeView.bottom+Height(12), Width(210), Height(20))];
    
    self.coursePlanLabel2.text = @"课程周期";
    
    self.coursePlanLabel2.textColor = UIColorFromRGB(0x888888);
    
    self.coursePlanLabel2.font = AllFont(13);
    
    [self.tableHeaderView addSubview:self.coursePlanLabel2];
    
    self.clearView = [[UIView alloc]initWithFrame:CGRectMake(0, self.timeView.bottom, MSW, Height(44))];
    
    self.clearView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.tableHeaderView addSubview:self.clearView];
    
    self.clearView.hidden = YES;
    
    UILabel *clearLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), Height(12), Width(240), Height(20))];
    
    clearLabel.text = @"课程周期 (已根据历史信息自动填充)";
    
    clearLabel.textColor = UIColorFromRGB(0x888888);
    
    clearLabel.font = AllFont(12);
    
    [self.clearView addSubview:clearLabel];
    
    UIButton *clearButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width(109), 0, Width(109), Height(44))];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"清除自动填充"];
    
    NSRange strRange = {0,[str length]};
    
    [str addAttributes:@{NSFontAttributeName:AllFont(13),NSForegroundColorAttributeName:UIColorFromRGB(0xEA6161)} range:strRange];
    
    [clearButton setAttributedTitle:str forState:UIControlStateNormal];
    
    [self.clearView addSubview:clearButton];
    
    [clearButton addTarget:self action:@selector(clearAutoFill) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *tableFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(56))];
    
    tableFooter.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableFooterView = tableFooter;
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0, MSW, Height(44))];
    
    addButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    [addButton setTitle:self.courseType == CourseTypeGroup?@"+ 新增周期":@"+ 添加课程周期" forState:UIControlStateNormal];
    
    [addButton setTitleColor:kMainColor forState:UIControlStateNormal];
    
    addButton.titleLabel.font = AllFont(14);
    
    [tableFooter addSubview:addButton];
    
    [addButton addTarget:self action:@selector(addBatch:) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)addBatch:(UIButton*)button
{
    
    CoursePlanBatchAddController *svc = [[CoursePlanBatchAddController alloc]init];
    
    svc.course = self.course;
    
    __weak typeof(self)weakS = self;
    
    svc.addFinish = ^(CoursePlan *plan){
        
        [weakS.course.coursePlans addObject:plan];
        
        [weakS.tableView reloadData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    if (keyboardView.tag == 101) {
        
        if (self.endTFManual) {
            
            if ([[dateFormatter dateFromString:self.endTF.text]timeIntervalSinceDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:self.startDP.date]]]<0) {
                
                [[[UIAlertView alloc]initWithTitle:@"开始日期不能晚于结束日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
                
            }
            
        }
        
        self.startTF.text = [dateFormatter stringFromDate:self.startDP.date];
        
        [self.view endEditing:YES];
        
        if (!self.endTFManual) {
            
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            
            NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[dateFormatter dateFromString:self.startTF.text]];
            
            NSInteger numberOfDaysInMonth = range.length;
            
            self.endTF.text = [[self.startTF.text substringToIndex:8] stringByAppendingString:[NSString stringWithFormat:numberOfDaysInMonth<10?@"0%ld":@"%ld",(long)numberOfDaysInMonth]];
            
        }
        
    }else
    {
        
        if (self.startTF.text.length) {
            
            if ([[dateFormatter dateFromString:[dateFormatter stringFromDate:self.endDP.date]] timeIntervalSinceDate:[dateFormatter dateFromString:self.startTF.text]]<0) {
                
                [[[UIAlertView alloc]initWithTitle:@"结束日期不能早于开始日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
                
            }
            
        }
        
        self.endTF.text = [dateFormatter stringFromDate:self.endDP.date];
        
        self.endTFManual = YES;
        
        [self.view endEditing:YES];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.batch.course.coursePlans.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GuideBatchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    CoursePlan *plan = self.batch.course.coursePlans[indexPath.row];
    
    NSString *weekStr = @"每";
    
    for (NSString *week in plan.weeks) {
        
        if ([weekStr rangeOfString:@"周"].length) {
            
            weekStr = [weekStr stringByAppendingString:[[week componentsSeparatedByString:@"周"] lastObject]];
            
        }else{
            
            weekStr = [weekStr stringByAppendingString:week];
            
        }
        
        if ([plan.weeks indexOfObject:week]<plan.weeks.count-1) {
            
            weekStr = [weekStr stringByAppendingString:@"、"];
            
        }
        
    }
    
    cell.weeks = weekStr;
    
    cell.time = self.course.type == CourseTypeGroup?plan.startTime:plan.startTime.length?[NSString stringWithFormat:@"%@-%@",plan.startTime,plan.endTime]:@"";
    
    cell.tag = indexPath.row;
    
    cell.delegate = self;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

-(void)batchCellDelete:(GuideBatchCell *)cell
{
    
    [self.batch.course.coursePlans removeObjectAtIndex:cell.tag];
    
    [self reloadData];
    
    [self.tableView reloadData];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(56);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CoursePlanBatchAddController *svc = [[CoursePlanBatchAddController alloc]init];
    
    svc.course = self.course;
    
    svc.index = indexPath.row+1;
    
    svc.plan = self.course.coursePlans[indexPath.row];
    
    __weak typeof(self)weakS = self;
    
    svc.addFinish = ^(CoursePlan *plan){
        
        [weakS.course.coursePlans replaceObjectAtIndex:indexPath.row withObject:plan];
        
        [weakS.tableView reloadData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}


-(void)topClick
{
    
    if (self.courseType == CourseTypeGroup) {
        
        CoursePlanCourseController *svc = [[CoursePlanCourseController alloc]init];
        
        svc.batch = self.batch;
        
        svc.gym = self.gym;
        
        __weak typeof(self)weakS = self;
        
        svc.chooseFinish = ^(Course *course){
            
            weakS.batch.course = course;
            
            weakS.titleLabel.text = course.name;
            
            weakS.subtitleLabel.text = [NSString stringWithFormat:@"%ldmin",(long)course.during];
            
            [weakS.iconView sd_setImageWithURL:course.imgUrl];
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else
    {
        
        CoursePlanCoachController *svc = [[CoursePlanCoachController alloc]init];
        
        svc.title = @"选择私教教练";
        
        svc.batch = self.batch;
        
        svc.gym = self.gym;
        
        __weak typeof(self)weakS = self;
        
        svc.chooseFinish = ^(Coach *coach){
            
            weakS.batch.coach = coach;
            
            weakS.titleLabel.text = coach.name;
            
            [weakS.iconView sd_setImageWithURL:coach.iconUrl];
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

-(void)cellClick:(MOCell *)cell
{
    
    if (cell.tag == 101) {
        
        if (self.courseType == CourseTypeGroup) {
            
            CoursePlanCoachController *svc = [[CoursePlanCoachController alloc]init];
            
            svc.title = @"选择教练";
            
            svc.batch = self.batch;
            
            svc.gym = self.gym;
            
            svc.isAdd = YES;
            
            __weak typeof(self)weakS = self;
            
            svc.chooseFinish = ^(Coach *coach){
                
                weakS.batch.coach = coach;
                
                weakS.topCell.subtitle = coach.name;
                
                if (!weakS.startTF.text.length && !weakS.endTF.text.length) {
                    
                    [weakS autoFill];
                    
                }
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else
        {
            
            CoursePlanCourseController *svc = [[CoursePlanCourseController alloc]init];
            
            svc.batch = self.batch;
            
            svc.gym = self.gym;
            
            svc.isAdd = YES;
            
            __weak typeof(self)weakS = self;
            
            svc.chooseFinish = ^(Course *course){
                
                weakS.batch.course = course;
                
                weakS.topCell.subtitle = course.name;
                
                if (!weakS.startTF.text.length && !weakS.endTF.text.length) {
                    
                    [weakS autoFill];
                    
                }
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
    }else if (cell.tag == 102){
        
        CoursePlanYardController *svc = [[CoursePlanYardController alloc]init];
        
        svc.isAdd = YES;
        
        svc.batch = self.batch;
        
        svc.gym = self.gym;
        
        __weak typeof(self)weakS = self;
        
        svc.chooseFinish = ^(NSArray *yards){
            
            weakS.batch.yards = yards;
            
            if (weakS.batch.yards.count == 1) {
                
                weakS.yardCell.subtitle = ((Yard*)[weakS.batch.yards firstObject]).name;
                
            }else
            {
                
                weakS.yardCell.subtitle = [NSString stringWithFormat:@"%ld处场地",(unsigned long)weakS.batch.yards.count];
                
            }
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if(cell.tag == 103)
    {
        
        if ([self.capacityTF.text integerValue]>0) {
            
            weakTypesYF
            CoursePlanPayOnlineController *svc = [[CoursePlanPayOnlineController alloc]init];
            
            svc.batch = [self.batch copy];
            
            svc.setFinish = ^(CoursePlanBatch*batch){
                
                weakS.batch = batch;
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [[[UIAlertView alloc]initWithTitle:@"请先填写单节课可约人数" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
    }else if(cell.tag == 104){
        
        if ([self.capacityTF.text integerValue]>0) {
            
            weakTypesYF
            CoursePlanPayCardController *svc = [[CoursePlanPayCardController alloc]init];
            
            svc.batch = [self.batch copy];
            
            svc.setFinish = ^(CoursePlanBatch*batch){
                
                weakS.batch = batch;
                
                weakS.cardPayCell.placeholder = @"未设置可支付会员卡";
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [[[UIAlertView alloc]initWithTitle:@"请先填写单节课可约人数" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
    }
    
}

-(void)naviRightClick
{
    
    if (!self.batch.isFree) {
        
        NSArray *onlinePays = self.batch.onlinePays;
        
        NSArray *cardKinds = self.batch.cardKinds;
        
        OnlinePay *pay = [onlinePays firstObject];
        
        if (!pay.isUsed && !cardKinds.count) {
            
            [[[UIAlertView alloc]initWithTitle:@"请设置结算方式" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        if ([self.cardPayCell.placeholder isEqualToString:@"已修改可约人数，请重新设置"] && !self.cardPayCell.subtitle.length) {
            
            [[[UIAlertView alloc]initWithTitle:@"请重新设置会员卡支付" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
    }
    
    if (self.topCell.subtitle.length && self.yardCell.subtitle.length && self.startTF.text.length && self.endTF.text.length) {
        
        if (self.batch.course.capacity<=0) {
            
            [[[UIAlertView alloc]initWithTitle:@"请设置课程可约人数" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        if (!self.batch.course.coursePlans.count) {
            
            [[[UIAlertView alloc]initWithTitle:@"请添加课程周期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"";
        
        [self.hud showAnimated:YES];
        
        self.rightButtonEnable = NO;
        
        CoursePlanDetailInfo *info = [[CoursePlanDetailInfo alloc]init];
        
        self.batch.gym = self.gym;
        
        self.batch.start = self.startTF.text;
        
        self.batch.end = self.endTF.text;
        
        [info checkBatch:self.batch result:^(BOOL success,NSString *error) {
            
            if (success) {
                
                [self createBatch];
                
            }else{
                
                [self.hud hideAnimated:YES];
                
                self.rightButtonEnable = YES;
                
                [[[UIAlertView alloc]initWithTitle:error message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
            }
            
        }];
        
    }else if(!self.topCell.subtitle.length){
        
        [[[UIAlertView alloc]initWithTitle:self.batch.course.type == CourseTypeGroup?@"请选择教练":@"请选择课程" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else if (!self.yardCell.subtitle.length){
        
        [[[UIAlertView alloc]initWithTitle:@"请设置场地" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else if (!self.startTF.text.length){
        
        [[[UIAlertView alloc]initWithTitle:@"请选择开始日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else if (!self.endTF.text.length){
        
        [[[UIAlertView alloc]initWithTitle:@"请选择结束日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}

-(void)createBatch
{
    
    CoursePlanDetailInfo *info = [[CoursePlanDetailInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    [info createBatch:self.batch result:^(BOOL success, NSString *error) {
        
        self.rightButtonEnable = YES;
        
        if (success) {
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = @"添加成功";
            
            [self.hud hideAnimated:YES afterDelay:1.5f];
            
            if (weakS.addFinish) {
                
                weakS.addFinish();
                
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                BOOL hadPop = NO;
                
                for (MOViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[CoursePlanGroupController class]]) {
                        
                        hadPop = YES;
                        
                        [vc reloadData];
                        
                        [self.navigationController popToViewController:vc animated:YES];
                        
                    }
                    
                }
                
                if (!hadPop) {
                    
                    for (MOViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[CoursePlanPrivateController class]]) {
                            
                            hadPop = YES;
                            
                            [vc reloadData];
                            
                            [self.navigationController popToViewController:vc animated:YES];
                            
                        }
                        
                    }
                    
                }
                
                if (!hadPop) {
                    
                    for (MOViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[CourseArrangeController class]]) {
                            
                            hadPop = YES;
                            
                            [vc reloadData];
                            
                            [self.navigationController popToViewController:vc animated:YES];
                            
                        }
                        
                    }
                    
                }
                
            });
            
        }else{
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = error;
            
            self.hud.label.numberOfLines = 0;
            
            [self.hud hideAnimated:YES afterDelay:1.5f];
            
        }
        
    }];
    
}

-(void)autoFill
{
    
    self.batch.gym = self.gym;
    
    CoursePlanDetailInfo *info = [[CoursePlanDetailInfo alloc]init];
    
    [info requestAutoFillInfoWithBatch:self.batch result:^(BOOL success, NSString *error) {
        
        self.batch.course.coursePlans = info.batch.course.coursePlans;
        
        self.batch.course.capacity = info.batch.course.capacity;
        
        self.course.capacity = info.batch.course.capacity;
        
        self.course.coursePlans = self.batch.course.coursePlans;
        
        self.batch.cardKinds = info.batch.cardKinds;
        
        if (!info.batch.isFree) {
            
            if (AppGym.pro) {
                
                self.batch.isFree = info.batch.isFree;
                
            }
            
        }
        
        self.capacityTF.text = [NSString stringWithInteger:self.batch.course.capacity];
        
        self.cardPayCell.placeholder = @"未设置可支付会员卡";
        
        [self reloadData];
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)clearAutoFill
{
    
    NSMutableArray *plans = [self.batch.course.coursePlans mutableCopy];
    
    for (CoursePlan *plan in self.batch.course.coursePlans) {
        
        if (plan.autoFill) {
            
            [plans removeObject:plan];
            
        }
        
    }
    
    self.batch.course.coursePlans = plans;
    
    self.course.coursePlans = plans;
    
    [self reloadData];
    
    [self.tableView reloadData];
    
}

-(void)switchClick:(MOSwitchCell *)cell
{
    
    if (!AppGym.pro) {
        
        GymProHintView *hintView = [GymProHintView defaultView];
        
        hintView.title = @"课程需要结算";
        
        hintView.delegate = self;
        
        hintView.canTry = !AppGym.haveTried;
        
        [hintView showInView:self.view];
        
    }
    
}

-(void)trySuccessAlertStart
{
    
    self.needPayCell.pro = NO;
    
    self.needPayCell.userInteractionEnabled = YES;
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    if (self.courseType == CourseTypePrivate) {
        
        if (self.cardPayCell.subtitle.length && ![self.cardPayCell.subtitle isEqualToString:@"未设置可结算会员卡"]) {
            
            self.cardPayCell.subtitle = @"";
            
            self.cardPayCell.placeholder = @"已修改可约人数，请重新设置";
            
        }
        
    }else{
        
        for (CardKind *cardKind in self.batch.cardKinds) {
            
            if (cardKind.type != CardKindTypeTime) {
                
                if (cardKind.costs.count<[self.capacityTF.text integerValue]) {
                    
                    for (NSInteger i = cardKind.costs.count ; i<[self.capacityTF.text integerValue]; i++) {
                        
                        CardCost *cost = [[CardCost alloc]init];
                        
                        cost.fromNumber = i+1;
                        
                        cost.toNumber = i+2;
                        
                        CardCost *tempCost = [cardKind.costs firstObject];
                        
                        cost.perCost = tempCost.perCost;
                        
                        cost.costString = tempCost.costString;
                        
                        [cardKind.costs addObject:cost];
                        
                    }
                    
                }else if (cardKind.costs.count > [self.capacityTF.text integerValue]){
                    
                    cardKind.costs = [[cardKind.costs subarrayWithRange:NSMakeRange(0, [self.capacityTF.text integerValue])] mutableCopy];
                    
                }
                
            }
            
        }
        
    }
    
    self.batch.course.capacity = [textField.text integerValue];
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    self.batch.isFree = !cell.on;
    
    [self reloadData];
    
    [self.tableView reloadData];
    
}

-(void)naviLeftClick
{
    
    [[[UIAlertView alloc]initWithTitle:self.courseType == CourseTypeGroup?@"确定要放弃本次排课？":@"确定要放弃本次排期？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil]show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

@end
