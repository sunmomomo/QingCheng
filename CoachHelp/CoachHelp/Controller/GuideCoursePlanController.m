//
//  GuideCoursePlanController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideCoursePlanController.h"

#import "GuideCourseBatchAddController.h"

#import "GuideBatchCell.h"

#import "QCTextField.h"

#import "QCKeyboardView.h"

#import "GuideInfo.h"

#import "RootController.h"

#import "ServicesInfo.h"

static NSString *identifier = @"Cell";

@interface GuideCoursePlanController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,QCKeyboardViewDelegate,GuideBatchCellDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)Course *course;

@property(nonatomic,strong)QCTextField *startTF;

@property(nonatomic,strong)QCTextField *endTF;

@property(nonatomic,strong)UIDatePicker *startDP;

@property(nonatomic,strong)UIDatePicker *endDP;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSDateFormatter *dateFormatter;

@property(nonatomic,strong)UIButton *confirmButton;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation GuideCoursePlanController

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
    
    self.course = MOAppDelegate.guide.course;
    
    self.dateFormatter = [[NSDateFormatter alloc]init];
    
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    self.dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    if (!self.course.coursePlans.count) {
        
        if (self.course.type == CourseTypeGroup) {
            
            CoursePlan *plan1 = [[CoursePlan alloc]init];
            
            plan1.startTime = @"09:00";
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            
            dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
            
            dateFormatter.dateFormat = @"HH:mm";
            
            plan1.endTime = [dateFormatter stringFromDate:[NSDate dateWithTimeInterval:self.course.during*60 sinceDate:[dateFormatter dateFromString:@"09:00"]]];
            
            plan1.weeks = [@[@"周一",@"周三",@"周五",@"周日"]mutableCopy];
            
            CoursePlan *plan2 = [[CoursePlan alloc]init];
            
            plan2.startTime = @"14:00";
            
            plan2.endTime = [dateFormatter stringFromDate:[NSDate dateWithTimeInterval:self.course.during*60 sinceDate:[dateFormatter dateFromString:@"12:00"]]];
            
            plan2.weeks = [@[@"周二",@"周四",@"周六"]mutableCopy];
            
            self.course.coursePlans = [NSMutableArray array];
            
            [self.course.coursePlans addObject:plan1];
            
            [self.course.coursePlans addObject:plan2];
            
        }else{
            
            CoursePlan *plan1 = [[CoursePlan alloc]init];
            
            plan1.startTime = @"09:00";
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            
            dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
            
            dateFormatter.dateFormat = @"HH:mm";
            
            plan1.endTime = @"21:00";
            
            plan1.weeks = [@[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"]mutableCopy];
            
            self.course.coursePlans = [NSMutableArray array];
            
            [self.course.coursePlans addObject:plan1];
            
        }
        
    }
    
}

-(void)createUI
{
    
    self.title = @"新建健身房";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[GuideBatchCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(287))];
    
    self.tableView.tableHeaderView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIImageView *guideImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(16), MSW-Width320(42), Height320(42))];
    
    guideImg.image = [UIImage imageNamed:@"guide_step_2"];
    
    guideImg.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.tableView.tableHeaderView addSubview:guideImg];
    
    UILabel *guideLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, guideImg.bottom+Height320(20), MSW, Height320(17))];
    
    guideLabel.text = @"— 课程排期 —";
    
    guideLabel.textColor = UIColorFromRGB(0x999999);
    
    guideLabel.textAlignment = NSTextAlignmentCenter;
    
    guideLabel.font = AllFont(14);
    
    [self.tableView.tableHeaderView addSubview:guideLabel];
    
    UIButton *iconButton = [[UIButton alloc]initWithFrame:CGRectMake(0, Height320(110), MSW, Height320(72))];
    
    iconButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    iconButton.layer.borderWidth = OnePX;
    
    iconButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.tableView.tableHeaderView addSubview:iconButton];
    
    [iconButton addTarget:self action:@selector(iconClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *courseImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(48), Height320(48))];
    
    courseImg.layer.borderWidth = OnePX;
    
    courseImg.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    [courseImg sd_setImageWithURL:self.course.imgUrl];
    
    [iconButton addSubview:courseImg];
    
    UIImageView *typeImg = [[UIImageView alloc]initWithFrame:CGRectMake(iconButton.right-Width320(13), iconButton.bottom-Height320(13), Width320(14), Height320(14))];
    
    typeImg.image = [UIImage imageNamed:self.course.type == CourseTypeGroup?@"course_type_group":@"course_type_private"];
    
    [iconButton addSubview:typeImg];
    
    UILabel *courseNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(courseImg.right+Width320(8), Height320(15), MSW-courseImg.right-Width320(35), Height320(20))];
    
    courseNameLabel.text = self.course.name;
    
    courseNameLabel.textColor = UIColorFromRGB(0x333333);
    
    courseNameLabel.font = AllFont(16);
    
    [iconButton addSubview:courseNameLabel];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(courseNameLabel.left, courseNameLabel.bottom+Height320(2), courseNameLabel.width, Height320(15))];
    
    timeLabel.text = [NSString stringWithFormat:@"时长%ld分钟",(long)self.course.during];
    
    timeLabel.textColor = UIColorFromRGB(0xb2b2b2);
    
    timeLabel.font = AllFont(12);
    
    [iconButton addSubview:timeLabel];
    
    UIImageView *topArrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), Height320(30), Width320(7), Height320(12))];
    
    topArrow.image = [UIImage imageNamed:@"gray_arrow"];
    
    [iconButton addSubview:topArrow];
    
    UIView *tfView = [[UIView alloc]initWithFrame:CGRectMake(0, iconButton.bottom+Height320(12), MSW, Height320(40)*2)];
    
    tfView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    tfView.layer.borderWidth = OnePX;
    
    tfView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.tableView.tableHeaderView addSubview:tfView];
    
    self.startTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.startTF.type = QCTextFieldTypeCell;
    
    self.startTF.placeholder = @"开始日期";
    
    [tfView addSubview:self.startTF];
    
    QCKeyboardView *startKV = [QCKeyboardView defaultKeboardView];
    
    startKV.tag = 101;
    
    startKV.delegate = self;
    
    self.startTF.inputView = startKV;
    
    self.startDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.startDP.datePickerMode = UIDatePickerModeDate;
    
    startKV.keyboard = self.startDP;
    
    if (self.course.start.length) {
        
        self.startTF.text = self.course.start;
        
        self.startDP.date = [self.dateFormatter dateFromString:self.course.start];
        
    }else{
        
        self.startTF.text = [self.dateFormatter stringFromDate:[NSDate date]];
        
    }
    
    self.endTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.startTF.left, self.startTF.bottom, self.startTF.width, self.startTF.height)];
    
    self.endTF.type = QCTextFieldTypeCell;
    
    self.endTF.placeholder = @"结束日期";
    
    [tfView addSubview:self.endTF];
    
    QCKeyboardView *endKV = [QCKeyboardView defaultKeboardView];
    
    endKV.tag = 102;
    
    endKV.delegate = self;
    
    self.endTF.inputView = endKV;
    
    self.endDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.endDP.datePickerMode = UIDatePickerModeDate;
    
    endKV.keyboard = self.endDP;
    
    if (self.course.end.length) {
        
        self.endTF.text = self.course.end;
        
        self.endDP.date = [self.dateFormatter dateFromString:self.course.end];
        
    }else{
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
        
        NSInteger numberOfDaysInMonth = range.length;
        
        NSDate *nextMonthDate = [NSDate dateWithTimeInterval:86400 sinceDate:[self.dateFormatter dateFromString:[NSString stringWithFormat:@"%@%ld",[self.startTF.text substringToIndex:8],(long)numberOfDaysInMonth]]];
        
        NSString *startStr = [self.dateFormatter stringFromDate:[NSDate dateWithTimeInterval:86400 sinceDate:[self.dateFormatter dateFromString:[NSString stringWithFormat:@"%@%ld",[self.startTF.text substringToIndex:8],(long)numberOfDaysInMonth]]]];
        
        NSRange range1 = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:nextMonthDate];
        
        NSInteger numberOfDaysInMonth1 = range1.length;
        
        self.endTF.text = [NSString stringWithFormat:@"%@%ld",[startStr substringToIndex:8],(long)numberOfDaysInMonth1];
        
        self.endDP.date = [self.dateFormatter dateFromString:self.endTF.text];
        
    }
    
    UIView *tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(134))];
    
    tableFooterView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableFooterView = tableFooterView;
    
    UIView *footerTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(44))];
    
    footerTop.backgroundColor = UIColorFromRGB(0xffffff);
    
    [tableFooterView addSubview:footerTop];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(60), 0, Width320(120), Height320(44))];
    
    [addButton setTitle:@"+ 课程周期" forState:UIControlStateNormal];
    
    [addButton setTitleColor:kMainColor forState:UIControlStateNormal];
    
    addButton.titleLabel.font = AllFont(14);
    
    [addButton addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerTop addSubview:addButton];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, footerTop.height-1/[UIScreen mainScreen].scale, MSW, 1/[UIScreen mainScreen].scale)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [footerTop addSubview:sep];
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), footerTop.bottom+Height320(12), MSW-Width320(32), Height320(44))];
    
    self.confirmButton.backgroundColor = [kMainColor colorWithAlphaComponent:0.3];
    
    self.confirmButton.layer.cornerRadius = 2;
    
    [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [self.confirmButton setTitle:@"完  成" forState:UIControlStateNormal];
    
    self.confirmButton.titleLabel.font = AllFont(14);
    
    [tableFooterView addSubview:self.confirmButton];
    
    [self.confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    [self checkState];
    
}

-(void)iconClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)addClick:(UIButton*)button
{
    
    GuideCourseBatchAddController *svc = [[GuideCourseBatchAddController alloc]init];
    
    svc.course = self.course;
    
    __weak typeof(self)weakS = self;
    
    svc.addFinish = ^(CoursePlan* plan){
        
        [weakS.course.coursePlans addObject:plan];
        
        [weakS.tableView reloadData];
        
        [weakS checkState];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)confirm:(UIButton*)button
{
    
    self.course.coursePlanStart = self.startTF.text;
    
    self.course.coursePlanEnd = self.endTF.text;
    
    [MOAppDelegate saveGuide];
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"";
    
    [self.hud showAnimated:YES];

    [GuideInfo uploadResult:^(BOOL success,NSString *error) {
        
        if (success) {
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = @"创建成功";
            
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"guide"];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [[ServicesInfo shareInfo]requestSuccess:^{
                
                [self.hud hideAnimated:YES afterDelay:1.5f];
                
                AppGym = [[ServicesInfo shareInfo].services firstObject];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    MOAppDelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[RootController sharedSliderController]];
                    
                    [RootController sharedSliderController].navigationController.navigationBar.hidden = YES;
                    
                    [RootController sharedSliderController].selectIndex = 0;
                    
                    [[RootController sharedSliderController] showGuide];
                    
                    [[RootController sharedSliderController]reloadData];
                    
                });
                
            } Failure:^{
                
            }];
            
        }else
        {
            
            [self errorWithMsg:error];
            
        }
        
    }];
    
}

-(void)errorWithMsg:(NSString *)msg
{
    
    self.hud.mode = MBProgressHUDModeText;
    
    self.hud.label.text = msg;
    
    self.hud.label.numberOfLines = 0;
    
    [self.hud showAnimated:YES];
    
    [self.hud hideAnimated:YES afterDelay:1.5f];
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    if (keyboardView.tag == 101){
        
        self.startTF.text = [dateFormatter stringFromDate:self.startDP.date];
        
        self.course.coursePlanStart = self.startTF.text;
        
        [self.view endEditing:YES];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self.startDP.date];
        
        NSInteger numberOfDaysInMonth = range.length;
        
        self.endTF.text = [NSString stringWithFormat:@"%@%ld",[self.startTF.text substringToIndex:8],(long)numberOfDaysInMonth];
        
        self.course.coursePlanEnd = self.endTF.text;
        
    }else
    {
        
        NSTimeInterval timeIntervar = [self.endDP.date timeIntervalSinceDate:[dateFormatter dateFromString:self.startTF.text]];
        
        if (timeIntervar<=0) {
            
            [[[UIAlertView alloc]initWithTitle:@"结束日期须晚于开始日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        self.endTF.text = [dateFormatter stringFromDate:self.endDP.date];
        
        self.course.coursePlanEnd = self.endTF.text;
        
        [self.view endEditing:YES];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.course.coursePlans.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GuideBatchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    CoursePlan *plan = self.course.coursePlans[indexPath.row];
    
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
    
    return  cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(56);
    
}

-(void)batchCellDelete:(GuideBatchCell *)cell
{
    
    [self.course.coursePlans removeObjectAtIndex:cell.tag];
    
    [self.tableView reloadData];
    
    [self checkState];
    
}

-(void)checkState
{
    
    BOOL planOK = NO;
    
    for (CoursePlan* plan in self.course.coursePlans) {
        
        if (plan.weeks.count && plan.startTime.length) {
            
            planOK = YES;
            
            break;
            
        }
        
    }
    
    self.confirmButton.backgroundColor = [kMainColor colorWithAlphaComponent:planOK?1:0.3];
    
    self.confirmButton.userInteractionEnabled = planOK;
    
}

@end
