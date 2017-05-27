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

#import "CoursePlanYardController.h"

#import "CoursePlanWayController.h"

#import "CoursePlanBatch.h"

#import "CoursePlanDetailInfo.h"

#import "CourseArrangeController.h"

#import "CoursePlanCourseController.h"

static NSString *identifier = @"Cell";

@interface CoursePlanAddController ()<QCKeyboardViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,GuideBatchCellDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *subtitleLabel;

@property(nonatomic,strong)MOCell *topCell;

@property(nonatomic,strong)MOCell *yardCell;

@property(nonatomic,strong)MOCell *cardCell;

@property(nonatomic,strong)QCTextField *startTF;

@property(nonatomic,strong)QCTextField *endTF;

@property(nonatomic,strong)UIDatePicker *startDP;

@property(nonatomic,strong)UIDatePicker *endDP;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)CoursePlanBatch *batch;

@property(nonatomic,assign)BOOL endTFManual;

@end

@implementation CoursePlanAddController

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
    
    if (!self.course) {
        
        self.course = [[Course alloc]init];
        
        self.course.type = self.courseType;
        
    }
    
    if (self.course.coursePlans) {
        
        [self.course.coursePlans removeAllObjects];
        
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
    
    if (self.batch.course) {
        
        [self autoFill];
        
    }
    
}

-(void)createUI
{
    
    self.title = @"添加排期";
    
    self.rightTitle = @"完成";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[GuideBatchCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(337))];
    
    tableHeader.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableHeaderView = tableHeader;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(204))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [tableHeader addSubview:topView];
    
    UIButton *topButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(82))];
    
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
    
    if (self.courseType != CourseTypeGroup) {
        
        UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.5), Height320(35), Width320(7.5), Height320(12))];
        
        arrow.image = [UIImage imageNamed:@"gray_arrow"];
        
        [topButton addSubview:arrow];
        
    }
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), topButton.bottom-1/[UIScreen mainScreen].scale, MSW-Width320(32), 1/[UIScreen mainScreen].scale)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [topView addSubview:sep];
    
    self.topCell = [[MOCell alloc]initWithFrame:CGRectMake(Width320(16), topButton.bottom, MSW-Width320(32), Height320(40))];
    
    self.topCell.titleLabel.text = self.courseType == CourseTypeGroup?@"教练":@"课程";
    
    self.topCell.titleLabel.textColor = UIColorFromRGB(0x999999);
    
    self.topCell.subtitleColor = UIColorFromRGB(0x333333);
    
    self.topCell.tag = 101;
    
    if (self.courseType == CourseTypeGroup) {
        
        self.topCell.haveArrow = NO;
        
    }
    
    [self.topCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:self.topCell];
    
    self.yardCell = [[MOCell alloc]initWithFrame:CGRectMake(self.topCell.left, self.topCell.bottom, self.topCell.width, self.topCell.height)];
    
    self.yardCell.titleLabel.text = @"场地";
    
    self.yardCell.titleLabel.textColor = UIColorFromRGB(0x999999);
    
    self.yardCell.subtitleColor = UIColorFromRGB(0x333333);
    
    self.yardCell.tag = 102;
    
    [self.yardCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:self.yardCell];
    
    self.cardCell = [[MOCell alloc]initWithFrame:CGRectMake(self.topCell.left, self.yardCell.bottom, self.topCell.width, self.topCell.height)];
    
    self.cardCell.titleLabel.text = @"结算方式";
    
    self.cardCell.titleLabel.textColor = UIColorFromRGB(0x999999);
    
    self.cardCell.subtitleColor = UIColorFromRGB(0x333333);
    
    self.cardCell.noLine = YES;
    
    self.cardCell.placeholder = @"未设置";
    
    self.cardCell.tag = 103;
    
    [self.cardCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:self.cardCell];
    
    UILabel *courseLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(14), Width320(100), Height320(16))];
    
    courseLabel.text = @"课程排期";
    
    courseLabel.textColor = UIColorFromRGB(0x999999);
    
    courseLabel.font = AllFont(14);
    
    [tableHeader addSubview:courseLabel];
    
    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(40), MSW, Height320(40)*2)];
    
    timeView.backgroundColor = UIColorFromRGB(0xffffff);
    
    timeView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    timeView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [tableHeader addSubview:timeView];
    
    self.startTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.startTF.placeholder = @"开始日期";
    
    self.startTF.textPlaceholder = @"请选择";
    
    self.startTF.type = QCTextFieldTypeCell;
    
    self.startTF.delegate = self;
    
    [timeView addSubview:self.startTF];
    
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
    
    self.endTF.type = QCTextFieldTypeCell;
    
    self.endTF.noLine = YES;
    
    self.endTF.delegate = self;
    
    [timeView addSubview:self.endTF];
    
    QCKeyboardView *endKV = [QCKeyboardView defaultKeboardView];
    
    endKV.tag = 102;
    
    endKV.delegate = self;
    
    self.endTF.inputView = endKV;
    
    self.endDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.endDP.datePickerMode = UIDatePickerModeDate;
    
    endKV.keyboard = self.endDP;
    
    UIView *tableFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(56))];
    
    tableFooter.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableFooterView = tableFooter;
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0,Height320(8), MSW, Height320(40))];
    
    addButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    [addButton setTitle:@"+ 添加课程周期" forState:UIControlStateNormal];
    
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
            
            if ([[dateFormatter dateFromString:self.endTF.text]timeIntervalSinceDate:self.startDP.date]<0) {
                
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
    
    return cell;
    
}

-(void)batchCellDelete:(GuideBatchCell *)cell
{
    
    [self.course.coursePlans removeObjectAtIndex:cell.tag];
    
    [self.tableView reloadData];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(56);
    
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
        
    }
    
}

-(void)cellClick:(MOCell *)cell
{
    
    if (cell.tag == 101) {
        
        if (self.courseType == CourseTypeGroup) {
            
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
        
    }else
    {
        
        CoursePlanWayController *svc = [[CoursePlanWayController alloc]init];
        
        svc.isAdd = YES;
        
        svc.gym = self.gym;
        
        svc.batch = self.batch;
        
        __weak typeof(self)weakS = self;
        
        svc.setFinish = ^(CoursePlanBatch *batch){
            
            self.batch = batch;
            
            if ((weakS.batch.cardKinds.count || weakS.batch.onlinePays.count)&&!weakS.batch.isFree) {
                
                weakS.cardCell.subtitle = @"已设置";
                
            }else if (weakS.batch.isFree && weakS.batch.course.capacity){
                
                weakS.cardCell.subtitle = @"已设置";
                
            }
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

-(void)naviRightClick
{
    
    if (self.topCell.subtitle.length && self.yardCell.subtitle.length && self.cardCell.subtitle.length && self.startTF.text.length && self.endTF.text.length) {
        
        if (self.batch.course.capacity<=0) {
            
            [[[UIAlertView alloc]initWithTitle:@"当前课程可约人数非正数，请到结算方式页面重新设置" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
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
        
    }else if (!self.cardCell.subtitle.length){
        
        [[[UIAlertView alloc]initWithTitle:@"请设置结算方式" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
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
            
            [self popToViewControllerName:@"CourseArrangeController" isReloadData:YES];
            
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
        
        if ((self.batch.cardKinds.count || self.batch.onlinePays.count)&&!self.batch.isFree) {
            
            self.cardCell.subtitle = @"已设置";
            
        }else if (self.batch.isFree && self.batch.course.capacity){
            
            self.cardCell.subtitle = @"已设置";
            
        }
        
        [self.tableView reloadData];
        
    }];
    
}

@end
