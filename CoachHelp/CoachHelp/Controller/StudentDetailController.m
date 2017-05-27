//
//  StudentDetailController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/11/18.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "StudentDetailController.h"

#import "EditTestController.h"

#import "TestShowController.h"

#import "StudentDetailInfo.h"

#import "ChooseView.h"

#import "ReportCell.h"

#import "CardCell.h"

#import "WebViewController.h"

static NSString *reportIdentifier = @"Report";

static NSString *cardIdentifier = @"Card";

static NSString *testIdentifier = @"Test";

@interface StudentDetailController ()<ChooseViewDatasource,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)StudentDetailInfo *studentInfo;

@property(nonatomic,strong)UIImageView *icon;

@property(nonatomic,strong)UIImageView *sexImg;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)ChooseView *chooseView;

@property(nonatomic,strong)UITableView *recordTableView;

@property(nonatomic,strong)UITableView *cardTableView;

@property(nonatomic,strong)UITableView *testTableView;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation StudentDetailController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
    if ([self.testTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.testTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.testTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.testTableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    __weak typeof(self)weakS = self;
    
    [self.icon sd_setImageWithURL:self.student.photo];
    
    self.sexImg.image = [UIImage imageNamed:[self.student.gender isEqualToString:@"男"]?@"sex_male":@"sex_female"];
    
    self.nameLabel.text = self.student.name;
    
    self.studentInfo = [[StudentDetailInfo alloc]initWithStudent:self.student];
    
    self.studentInfo.stuData = ^(BOOL success){
        
        if (success) {
            
            weakS.student = weakS.studentInfo.student;
            
            [weakS.chooseView reloadData];
            
        }
        
    };
    
    self.studentInfo.recordData = ^(BOOL success){
       
        if (success) {
            
            [weakS.recordTableView reloadData];
            
        }
        
    };
    
    self.studentInfo.cardData = ^(BOOL success){
       
        if (success) {
            [weakS.cardTableView reloadData];
        }
        
    };
    
    self.studentInfo.bodyTestData = ^(BOOL success){
       
        if (success) {
            [weakS.testTableView reloadData];
        }
        
    };
    
}

-(void)createTestData
{
    
    [self.studentInfo reloadTestData];
    
    __weak typeof(self)weakS = self;
    
    self.studentInfo.bodyTestData = ^(BOOL success){
       
        [weakS.testTableView reloadData];
        
    };
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.title = @"学员详情";
    
    self.rightType = MONaviRightTypeTrash;
        
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(125))];
    
    topView.backgroundColor = kMainColor;
    
    [self.view addSubview:topView];
    
    self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/2-Width320(35), Height320(10.3), Width320(70), Height320(70))];
    
    self.icon.layer.cornerRadius = self.icon.width/2;
    
    self.icon.layer.masksToBounds = YES;
    
    self.icon.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
    
    self.icon.layer.borderWidth = 1;
    
    [topView addSubview:self.icon];
    
    self.sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.icon.right-Width320(21.3), self.icon.bottom-Height320(16), Width320(14.2), Height320(14.2))];
    
    self.sexImg.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.sexImg.layer.borderWidth = 1;
    
    self.sexImg.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
    
    self.sexImg.layer.cornerRadius = self.sexImg.width/2;
    
    self.sexImg.layer.masksToBounds = YES;
    
    [topView addSubview:self.sexImg];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(30), self.icon.bottom+Height320(10.2), MSW-Width320(60), Height320(16))];
    
    self.nameLabel.textColor = UIColorFromRGB(0xffffff);
    
    self.nameLabel.font = STFont(15);
    
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    
    [topView addSubview:self.nameLabel];
    
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
    
}

-(NSInteger)numberOfRowInChooseView
{
    
    return 4;
    
}

-(NSString *)titleForButtonAtRow:(NSInteger)row
{
    
    return @[@"基本信息",@"上课记录",@"会员卡",@"体测信息"][row];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (tableView.tag == 101) {
        
        return Height320(25);
        
    }else
    {
        
        return 0;
        
    }
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView.tag == 101) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(25))];
        
        label.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.textColor = UIColorFromRGB(0x999999);
        
        label.font = AllFont(14);
        
        label.text = [NSString stringWithFormat:@"%@年上课记录",self.studentInfo.recordArray[section][@"year"]];
        
        return label;
        
    }else
    {
        
        return nil;
        
    }
    
}

-(UIScrollView *)viewForRow:(NSInteger)row
{
    
    UIScrollView *testView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.chooseView.height-self.chooseView.rowHeight)];
    
    self.testTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MSW, testView.height-Height320(42.6)) style:UITableViewStylePlain];
    
    self.testTableView.dataSource = self;
    
    self.testTableView.delegate = self;
    
    self.testTableView.tag = 103;
    
    self.testTableView.tableFooterView = [UIView new];
    
    self.testTableView.separatorColor = UIColorFromRGB(0xeeeeee);
    
    [self.testTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:testIdentifier];
    
    UIButton *testButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.testTableView.bottom, MSW, Height320(42.6))];
    
    testButton.backgroundColor = kMainColor;
    
    [testButton setTitle:@"添加体测信息" forState:UIControlStateNormal];
    
    [testButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    testButton.titleLabel.font = STFont(IPhone4_5_6_6P(16, 16, 17, 18));
    
    [testView addSubview:testButton];
    
    [testButton addTarget:self action:@selector(addTest:) forControlEvents:UIControlEventTouchUpInside];
    
    [testView addSubview:self.testTableView];
    
    if (row == 0) {
        
        UIScrollView *basicView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.chooseView.height-self.chooseView.rowHeight)];
        
        UIImageView *phoneImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(22), Height320(23.5), Width320(15), Height320(15))];
        
        phoneImg.image = [UIImage imageNamed:@"phoneinfo"];
        
        phoneImg.contentMode = UIViewContentModeScaleAspectFit;
        
        [basicView addSubview:phoneImg];
        
        UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(phoneImg.right+Width320(17.7), phoneImg.top, Width320(30), Height320(15))];
        
        phoneLabel.text = @"手机";
        
        phoneLabel.textColor = UIColorFromRGB(0x999999);
        
        phoneLabel.font = STFont(14);
        
        [basicView addSubview:phoneLabel];
        
        UILabel *phoneDetail = [[UILabel alloc]initWithFrame:CGRectMake(phoneLabel.right+Width320(8), phoneLabel.top, MSW-Width320(44)-phoneLabel.right, phoneLabel.height)];
        
        phoneDetail.text = self.student.phone;
        
        phoneDetail.textColor = UIColorFromRGB(0x222222);
        
        phoneDetail.font = STFont(14);
        
        [basicView addSubview:phoneDetail];
        
        UIImageView *birthImg = [[UIImageView alloc]initWithFrame:CGRectMake(phoneImg.left, phoneDetail.bottom+Height320(22), phoneImg.width, phoneImg.height)];
        
        birthImg.image = [UIImage imageNamed:@"cake"];
        
        birthImg.contentMode = UIViewContentModeScaleAspectFit;
        
        [basicView addSubview:birthImg];
        
        UILabel *birthLabel = [[UILabel alloc]initWithFrame:CGRectMake(phoneLabel.left, birthImg.top, phoneLabel.width, phoneLabel.height)];
        
        birthLabel.text = @"生日";
        
        birthLabel.textColor = UIColorFromRGB(0x999999);
        
        birthLabel.font = STFont(14);
        
        [basicView addSubview:birthLabel];
        
        UILabel *birthDetail = [[UILabel alloc]initWithFrame:CGRectMake(phoneDetail.left, birthLabel.top, phoneDetail.width, phoneDetail.height)];
        
        birthDetail.text = self.student.birth.length?self.student.birth:@"  ";
        
        birthDetail.textColor = UIColorFromRGB(0x222222);
        
        birthDetail.font = STFont(14);
        
        [basicView addSubview:birthDetail];
        
        UIImageView *cityImg = [[UIImageView alloc]initWithFrame:CGRectMake(phoneImg.left, birthDetail.bottom+Height320(22), phoneImg.width, phoneImg.height)];
        
        cityImg.image = [UIImage imageNamed:@"cityinfo"];
        
        cityImg.contentMode = UIViewContentModeScaleAspectFit;
        
        [basicView addSubview:cityImg];
        
        UILabel *cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(phoneLabel.left, cityImg.top, phoneLabel.width, phoneLabel.height)];
        
        cityLabel.text = @"地址";
        
        cityLabel.textColor = UIColorFromRGB(0x999999);
        
        cityLabel.font = STFont(14);
        
        [cityLabel autoHeight];
        
        [cityImg changeTop:cityLabel.top];
        
        [basicView addSubview:cityLabel];
        
        UILabel *cityDetail = [[UILabel alloc]initWithFrame:CGRectMake(phoneDetail.left, cityLabel.top, phoneDetail.width, phoneDetail.height)];
        
        cityDetail.text = self.student.address.length?self.student.address:@"  ";
        
        cityDetail.textColor = UIColorFromRGB(0x222222);
        
        cityDetail.font = STFont(14);
        
        [cityDetail autoHeight];

        [basicView addSubview:cityDetail];
        
        UIImageView *timeImg = [[UIImageView alloc]initWithFrame:CGRectMake(phoneImg.left, cityDetail.bottom+Height320(22), phoneImg.width, phoneImg.height)];
        
        timeImg.image = [UIImage imageNamed:@"gettime"];
        
        timeImg.contentMode = UIViewContentModeScaleAspectFit;
        
        [basicView addSubview:timeImg];
        
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(phoneImg.right+Width320(17.7), timeImg.top, Width320(60), phoneLabel.height)];
        
        timeLabel.text = @"注册时间";
        
        timeLabel.textColor = UIColorFromRGB(0x999999);
        
        timeLabel.font = STFont(14);
        
        [basicView addSubview:timeLabel];
        
        UILabel *timeDetail = [[UILabel alloc]initWithFrame:CGRectMake(timeLabel.right+Width320(8), timeLabel.top, MSW-Width320(44)-timeLabel.right, phoneDetail.height)];
        
        timeDetail.text = self.student.createDate;
        
        timeDetail.textColor = UIColorFromRGB(0x222222);
        
        timeDetail.font = STFont(14);
        
        [basicView addSubview:timeDetail];
        
        return basicView;
        
    }else if(row == 1)
    {
        
        UIScrollView *reportView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.chooseView.height-self.chooseView.rowHeight)];
        
        self.recordTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MSW, reportView.height-Height320(42.7)) style:UITableViewStylePlain];
        
        self.recordTableView.tag = 101;
        
        self.recordTableView.dataSource = self;
        
        self.recordTableView.delegate = self;
        
        [self.recordTableView registerClass:[ReportCell class] forCellReuseIdentifier:reportIdentifier];
        
        self.recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [reportView addSubview:self.recordTableView];
        
        UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, self.recordTableView.bottom, MSW, Height320(42.7))];
        
        buttonView.backgroundColor = kMainColor;
        
        [reportView addSubview:buttonView];
        
        UIButton *groupButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, buttonView.width/2, buttonView.height)];
        
        groupButton.backgroundColor = kMainColor;
        
        [groupButton setTitle:@"代约团课" forState:UIControlStateNormal];
        
        [groupButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        groupButton.titleLabel.font = AllFont(16);
        
        groupButton.tag = 101;
        
        [groupButton addTarget:self action:@selector(courseClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [buttonView addSubview:groupButton];
        
        UIButton *privateButton = [[UIButton alloc]initWithFrame:CGRectMake(buttonView.width/2, 0, buttonView.width/2, buttonView.height)];
        
        privateButton.backgroundColor = kMainColor;
        
        [privateButton setTitle:@"代约私教" forState:UIControlStateNormal];
        
        [privateButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        privateButton.titleLabel.font = AllFont(16);
        
        privateButton.tag = 102;
        
        [buttonView addSubview:privateButton];
        
        [privateButton addTarget:self action:@selector(courseClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(buttonView.width/2-0.5,Height320(14.7) , 1, buttonView.height-Height320(29.4))];
        
        sep.backgroundColor = UIColorFromRGB(0xffffff);
        
        [buttonView addSubview:sep];
        
        return reportView;
        
    }else if (row == 2){
        
        self.cardTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.chooseView.height-self.chooseView.rowHeight) style:UITableViewStylePlain];
        
        self.cardTableView.delegate = self;
        
        self.cardTableView.dataSource = self;
        
        self.cardTableView.tag = 102;
        
        self.cardTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        self.cardTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.cardTableView registerClass:[CardCell class] forCellReuseIdentifier:cardIdentifier];
        
        return self.cardTableView;
        
    }else
    {
        return testView;
        
    }
    
}

-(void)courseClick:(UIButton*)button
{
    
    WebViewController *svc = [[WebViewController alloc]init];
    
    if (button.tag == 101) {
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/fitness/redirect/coach/group/?model=%@&id=%ld&student_id=%ld",ROOT,AppGym.type,(long)AppGym.gymId,(long)self.student.stuId]];
        
        svc.url = url;
        
    }else
    {
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/fitness/redirect/coach/private/?model=%@&id=%ld&student_id=%ld",ROOT,AppGym.type,(long)AppGym.gymId,(long)self.student.stuId]];
        
        svc.url = url;
        
    }
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)addTest:(UIButton*)btn
{
    
    if ([PermissionInfo sharedInfo].permissions.userPermission.editState || [PermissionInfo sharedInfo].permissions.personalUserPermission.editState) {
        
        EditTestController *svc = [[EditTestController alloc]init];
        
        svc.stu = self.student;
        
        svc.isAdd = YES;
        
        __weak typeof(self)weakS = self;
        
        svc.editFinish = ^(BodyTestInfo *testInfo){
            
            [weakS createTestData];
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (tableView.tag == 101) {
        
        return self.studentInfo.recordArray.count;
        
    }else
    {
        
        return 1;
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (tableView.tag) {
        case 101:
            return [self.studentInfo.recordArray[section][@"data"] count];
            break;
        case 102:
            return self.studentInfo.cardArray.count;
            break;
        case 103:
            return self.studentInfo.testArray.count;
            break;
        default:
            return 0;
            break;
    }
    
}


-(void)naviRightClick
{
    
   UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否删除该学员" message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
    
    alert.tag = 101;
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1 &&alertView.tag == 101) {
        
        [self.studentInfo deleteWithStudentId:self.student.shipId];
        
        [self.hud showAnimated:YES];
        
        __weak typeof(self)weakS = self;
        
        self.studentInfo.deleteFinish = ^(BOOL success){
            
            [weakS.hud hideAnimated:YES];
            
            if (success) {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"删除成功" message:nil delegate:weakS cancelButtonTitle:@"确定" otherButtonTitles:nil];
                
                alert.tag = 102;
                
                [alert show];
                
            }
            
        };
        
    }else if(alertView.tag == 102)
    {
        
        [self popViewControllerAndReloadData];
        
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 103) {
        
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [cell setSeparatorInset:UIEdgeInsetsZero];
            
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [cell setLayoutMargins:UIEdgeInsetsZero];
            
        }
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 101) {
        
        return Height320(63.5);
        
    }else if (tableView.tag == 102)
    {
        
        CardCell *cell = (CardCell *)[self tableView:self.cardTableView cellForRowAtIndexPath:indexPath];
        
        return [cell getHeight];
        
    }else
    {
        
        return Height320(46);
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 101) {
        
        ReportCell *cell = [tableView dequeueReusableCellWithIdentifier:reportIdentifier];
        
        Record *record = self.studentInfo.recordArray[indexPath.section][@"data"][indexPath.row];
        
        cell.title = record.course.name;
        
        cell.subtitle = [NSString stringWithFormat:@"%@-%@  教练：%@",record.startTime,record.endTime,record.coachName];
        
        cell.sectionFirst = record.showDate;

        cell.month = record.month;
        
        cell.day = record.date;
        
        cell.imgUrl = record.course.imgUrl;
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        return cell;
        
    }else if (tableView.tag == 102){
        
        CardCell *cell = [tableView dequeueReusableCellWithIdentifier:cardIdentifier];
        
        Card *card = self.studentInfo.cardArray[indexPath.row];
        
        cell.card = card;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return  cell;
        
    }else
    {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:testIdentifier];
        
        BodyTest *test = self.studentInfo.testArray[indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@体测数据",test.date];
        
        cell.textLabel.font = STFont(IPhone4_5_6_6P(14, 14, 15, 16));
        
        cell.textLabel.textColor = UIColorFromRGB(0x222222);
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        return cell;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (tableView.tag == 101) {
        
        WebViewController *svc = [[WebViewController alloc]init];
        
        Record *record = self.studentInfo.recordArray[indexPath.section][@"data"][indexPath.row];
        
        svc.url = record.url;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if (tableView.tag == 102)
    {
        
        WebViewController *svc = [[WebViewController alloc]init];
        
        Card *card = self.studentInfo.cardArray[indexPath.row];
        
        svc.url = card.url;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else
    {
        
        TestShowController *svc = [[TestShowController alloc]init];
        
        BodyTest *test = self.studentInfo.testArray[indexPath.row];
        
        svc.bodyTest = test;
        
        __weak typeof(self)weakS = self;
        
        svc.editFinish = ^{
            
            [weakS createTestData];
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

@end
