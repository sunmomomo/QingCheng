//
//  CoachUserBatchEditController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/25.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "CoachUserBatchEditController.h"

#import "SellerUserEditCell.h"

#import "SellerUserDeleteCell.h"

#import "UserChooseView.h"

#import "CoachChangeController.h"

#import "CoachDistributeInfo.h"

#import "MOTableView.h"

#import "YFSearchResultSellerListBatchVC.h"

static NSString *identifier = @"Cell";

static NSString *deleteIdentifier = @"DeleteCell";

@interface CoachUserBatchEditController ()<UITableViewDelegate,MOTableViewDatasource,UserChooseViewDatasource,UITextFieldDelegate,UIAlertViewDelegate,SellerUserDeleteCellDelegate>


@property(nonatomic,strong)NSArray *users;



@property(nonatomic,strong)UITextField *searchBar;

@property(nonatomic,strong)UIView *funcView;

@property(nonatomic,strong)UILabel *numLabel;

@property(nonatomic, strong)YFSearchResultSellerListBatchVC *resultVC;

@end

@implementation CoachUserBatchEditController
{
    UIView *_header;
    UIView *_filterView;
}
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kPostAddNewCoachIdtifierYF object:nil];
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
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    if (self.chooseArray == nil)
    {
        self.chooseArray = [NSMutableArray array];
    }
    // 短信模块 进来 会传编辑的信息
    if (self.chooseArray.count)
    {
        [self.chooseView reloadData];
        [self checkFunc];
        
        if (self.isShowSelectView)
        {
            [self showChoose];
        }
    }
    
    //
    //    self.tableView.dataSuccess = YES;
    //
    //    self.users = self.info.showArray;
    //
    //    [self.tableView reloadData];
    
    [self reloadData];
}

-(void)reloadData
{
    
    StudentListInfo *info = [[StudentListInfo alloc]init];
    info.fiterOtherModel = self.temFilterModel;
    
    weakTypesYF
    
    if (self.isChooseStudent)
    {
        // 选择会员 请求所有的会员
        info.isCannotReadContent = YES;
        [info requestAllDataWithGym:self.gym success:^{
            [weakS requestSuccessData:info];
            [weakS fullChoosearrayStuAvatar];
            [weakS.chooseView reloadData];
        } Failure:^{
            [weakS requestFailData:info];
        }];
    }else
    {
        [info requestWithCoach:self.coach andGym:self.gym success:^{
            [weakS requestSuccessData:info];
            
        } Failure:^{
            [weakS requestFailData:info];
        }];
    }
}

- (void)requestFailData:(StudentListInfo *)info
{
    self.tableView.dataSuccess = NO;
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}
- (void)requestSuccessData:(StudentListInfo *)info
{
    self.tableView.dataSuccess = YES;
    
    [self.tableView.mj_header endRefreshing];
    
    self.info = info;
    
    if (self.fiterViewModel.buttonOfLetterFilter.isSelected)
    {
        self.users = self.info.showArray;
    }else
    {
        self.users = self.info.showTimeArray;
    }
    [self setTableFootviewLabelNum:info.students.count];
    
    [self.tableView reloadData];
    
}

-(void)createUI
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    if (self.isChooseStudent) {
        self.title = @"选择会员";
    }else
    {
        self.title = self.coach.type == CoachDistributeTypeNormal?@"批量修改":@"批量分配";
    }
    
    self.leftType = MONaviLeftTypeAllChoose;
    
    self.rightTitle = @"取消";
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(52))];
    
    header.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:header];
    
    self.searchBar = [[UITextField alloc]initWithFrame:CGRectMake(Width320(12), Height320(10), MSW-Width320(24), Height320(32))];
    
    self.searchBar.backgroundColor = UIColorFromRGB(0xfafafa);
    
    self.searchBar.layer.cornerRadius = 2;
    
    self.searchBar.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
    
    self.searchBar.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    self.searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(30), Height320(32))];
    
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(10), Height320(10), Width320(12), Height320(12))];
    
    searchImg.image = [UIImage imageNamed:@"student_search"];
    
    [leftView addSubview:searchImg];
    
    self.searchBar.leftView = leftView;
    
    self.searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    self.searchBar.placeholder = @"会员姓名、手机号";
    
    self.searchBar.font = AllFont(12);
    
    self.searchBar.returnKeyType = UIReturnKeySearch;
    
    self.searchBar.delegate = self;
    
    [self.searchBar addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [header addSubview:self.searchBar];
    
    UIView *filterView = self.fiterViewModel.conditionButtonViews;
    [filterView changeTop:self.searchBar.bottom + Height320(10)];
    _filterView = filterView;
    
    [header changeHeight:filterView.bottom];
    [header addSubview:filterView];
    
    _header = header;
    
    
    
    //    self.tableView.frame = CGRectMake(0, 64 + filterView.height, MSW, MSH-64 - filterView.height);
    
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, header.bottom, MSW, MSH-header.bottom) style:UITableViewStylePlain];
    
    self.baseTableView =self.tableView;
    
    self.tableView.tag = 101;
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.sectionIndexColor = UIColorFromRGB(0x666666);
    
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, Width320(96), 0, 0);
    
    [self.tableView registerClass:[SellerUserEditCell class] forCellReuseIdentifier:identifier];
    
    MJRefreshNormalHeader *mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    
    [mjHeader setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [mjHeader setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [mjHeader setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    mjHeader.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = mjHeader;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    self.funcView = [[UIView alloc]initWithFrame:CGRectMake(0, MSH, MSW, Height320(40))];
    
    self.funcView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.funcView.layer.borderWidth = OnePX;
    
    self.funcView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.funcView];
    
    self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(10), Width320(20), Height320(20))];
    
    self.numLabel.backgroundColor = kMainColor;
    
    self.numLabel.layer.cornerRadius = self.numLabel.width/2;
    
    self.numLabel.layer.masksToBounds = YES;
    
    self.numLabel.textColor = UIColorFromRGB(0xffffff);
    
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    
    self.numLabel.font = AllFont(12);
    
    [self.funcView addSubview:self.numLabel];
    
    UIButton *showButton = [[UIButton alloc]initWithFrame:CGRectMake(self.numLabel.right, 0, Width320(60), Height320(40))];
    
    [self.funcView addSubview:showButton];
    
    [showButton addTarget:self action:@selector(showChoose) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *showLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(4), 0, Width320(40), Height320(40))];
    
    showLabel.text = @"已选择";
    
    showLabel.textColor = UIColorFromRGB(0x333333);
    
    showLabel.textAlignment = NSTextAlignmentCenter;
    
    showLabel.font = AllFont(12);
    
    [showButton addSubview:showLabel];
    
    UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(showLabel.right+Width320(3), Height320(17), Width320(12), Height320(7))];
    
    arrowImg.image = [UIImage imageNamed:@"down_arrow"];
    
    arrowImg.transform = CGAffineTransformMakeRotation(M_PI);
    
    [showButton addSubview:arrowImg];
    
    if (self.isChooseStudent)
    {
        
        UIButton *distributeButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(242), Height320(6), Width320(68), Height320(28))];
        
        distributeButton.layer.cornerRadius = 2;
        
        distributeButton.layer.borderColor = kMainColor.CGColor;
        
        distributeButton.layer.borderWidth = OnePX;
        
        [distributeButton setTitle:@"完成" forState:UIControlStateNormal];
        
        [distributeButton setTitleColor:kMainColor forState:UIControlStateNormal];
        
        distributeButton.titleLabel.font = AllFont(13);
        
        distributeButton.tag = 3;
        
        [distributeButton addTarget:self action:@selector(doneChooseStudentsAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.funcView addSubview:distributeButton];
    }else if (self.coach.type == CoachDistributeTypeNone) {
        
        UIButton *distributeButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(242), Height320(6), Width320(68), Height320(28))];
        
        distributeButton.layer.cornerRadius = 2;
        
        distributeButton.layer.borderColor = kMainColor.CGColor;
        
        distributeButton.layer.borderWidth = OnePX;
        
        [distributeButton setTitle:@"分配教练" forState:UIControlStateNormal];
        
        [distributeButton setTitleColor:kMainColor forState:UIControlStateNormal];
        
        distributeButton.titleLabel.font = AllFont(13);
        
        distributeButton.tag = 3;
        
        [distributeButton addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.funcView addSubview:distributeButton];
        
    }else{
        
        UIButton *changeButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(164), Height320(6), Width320(68), Height320(28))];
        
        changeButton.layer.cornerRadius = 2;
        
        changeButton.layer.borderColor = kMainColor.CGColor;
        
        changeButton.layer.borderWidth = OnePX;
        
        [changeButton setTitle:@"变更教练" forState:UIControlStateNormal];
        
        [changeButton setTitleColor:kMainColor forState:UIControlStateNormal];
        
        changeButton.titleLabel.font = AllFont(13);
        
        changeButton.tag = 1;
        
        [changeButton addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.funcView addSubview:changeButton];
        
        UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(242), Height320(6), Width320(68), Height320(28))];
        
        deleteButton.layer.cornerRadius = 2;
        
        deleteButton.layer.borderColor = kMainColor.CGColor;
        
        deleteButton.layer.borderWidth = OnePX;
        
        [deleteButton setTitle:@"移除" forState:UIControlStateNormal];
        
        [deleteButton setTitleColor:kMainColor forState:UIControlStateNormal];
        
        deleteButton.titleLabel.font = AllFont(13);
        
        deleteButton.tag = 2;
        
        [deleteButton addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.funcView addSubview:deleteButton];
        
    }
    
    self.chooseView = [[UserChooseView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    self.chooseView.hidden = YES;
    
    self.chooseView.tag = 102;
    
    //    self.chooseView.backgroundColor = [UIColor whiteColor];
    
    self.chooseView.datasource = self;
    
    [self.view addSubview:self.chooseView];
    
}

- (void)setButtonStyle:(UIButton *)button
{
    
}

-(void)func:(UIButton*)button
{
    
    if (button.tag == 1) {
        
        CoachChangeController *svc = [[CoachChangeController alloc]init];
        
        svc.coach = self.coach;
        
        svc.users = self.chooseArray;
        
        svc.gym = self.gym;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if (button.tag == 2){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"确定将所选会员从%@名下移除？",self.coach.name] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        alert.tag = 0;
        
        [alert show];
        
    }else{
        
        CoachChangeController *svc = [[CoachChangeController alloc]init];
        
        svc.coach = self.coach;
        
        svc.users = self.chooseArray;
        
        svc.gym = self.gym;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

-(void)showChoose
{
    
    [self.chooseView show];
    
}

-(void)checkFunc
{
    
    if (self.chooseArray.count) {
        
        if (self.chooseArray.count<=99) {
            
            self.numLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)self.chooseArray.count];
            
        }else{
            
            self.numLabel.text = @"...";
            
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.funcView changeTop:MSH-Height320(40)];
            
        } completion:^(BOOL finished) {
            
            [self.tableView changeHeight:MSH-_header.bottom-Height320(40)];
            
            [self.resultVC changeToFrame:CGRectMake(0, self.resultVC.view.mj_y, self.resultVC.view.width, self.view.height - _header.top - self.searchBar.bottom - self.funcView.height)];
            
        }];
        
        NSInteger count = 0;
        
        for (NSDictionary *dict in self.info.showArray) {
            
            count += [dict[@"data"] count];
            
        }
        
        if (count > 0)
        {
            self.leftChoosed = self.chooseArray.count >= count;
        }
        
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.funcView changeTop:MSH];
            
        } completion:^(BOOL finished) {
            
            [self.tableView changeHeight:MSH-_header.bottom];
            
            [self.resultVC changeToFrame:CGRectMake(0, self.resultVC.view.mj_y, self.resultVC.view.width, self.view.height - self.resultVC.view.mj_y)];
        }];
        self.leftChoosed = NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.resultVC reloadData];
    return YES;
}
-(void)textFieldDidChanged:(UITextField*)textField
{
    if (textField.text.length) {
        self.searchBar.clearButtonMode = UITextFieldViewModeAlways;
        self.leftButtonEnable = NO;
    }else
    {
        self.searchBar.clearButtonMode = UITextFieldViewModeNever;
        self.leftButtonEnable = YES;
    }
    
    [self.resultVC setSearchStr:textField.text];
    
    return;
    
    //    if (textField.text.length==0) {
    //
    //        self.leftButtonEnable = YES;
    //
    //        self.users = self.info.showArray;
    //
    //    }else if(textField.text.length != 0)
    //    {
    //
    //        self.leftButtonEnable = NO;
    //
    //        NSMutableArray *users = [NSMutableArray array];
    //
    //        for (NSDictionary *dict in self.info.showArray) {
    //
    //            NSMutableArray *tempArray = [NSMutableArray array];
    //
    //            for (Student *tempStu in dict[@"data"]) {
    //
    //                if ([[tempStu.name lowercaseString] rangeOfString:[textField.text lowercaseString]].length||[tempStu.phone rangeOfString:textField.text].length) {
    //
    //                    [tempArray addObject:tempStu];
    //
    //                }
    //
    //            }
    //
    //            if (tempArray.count) {
    //
    //                [users addObject:@{@"head":dict[@"head"],@"data":tempArray}];
    //
    //            }
    //
    //        }
    //
    //        self.users = users;
    //
    //    }
    //
    //    [self.tableView reloadData];
    
}

-(void)clearChooseData
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认清空当前选中的会员？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    alert.tag = 1;
    
    [alert show];
    
}

-(void)confirmClear
{
    
    [self.tableView reloadData];
    
    [self.chooseArray removeAllObjects];
    
    [self.chooseView close];
    
    [self checkFunc];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (tableView.tag == 101) {
        
        return self.users.count;
        
    }else{
        
        return 1;
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag == 101) {
        
        return [self.users[section][@"data"]count];
        
    }else{
        
        return self.chooseArray.count;
        
    }
    
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    if (tableView.tag == 101 && self.fiterViewModel.buttonOfLetterFilter.isSelected) {
        
        NSMutableArray *array = [NSMutableArray array];
        
        [self.users enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [array addObject:obj[@"head"]];
            
        }];
        
        return array;
        
    }else{
        
        return nil;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 101) {
        
        SellerUserEditCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (self.users.count <= indexPath.section) {
            return cell;
        }
        Student *stu = [self.users[indexPath.section] valueForKey:@"data"][indexPath.row];
        
        cell.title = stu.name;
        
        cell.phone = stu.phone;
        
        cell.sex = stu.sex;
        
        cell.imgUrl = stu.avatar;
        
        NSString *coachesStr = @"";
        
        for (NSInteger i = 0; i<stu.coaches.count; i++) {
            
            Coach *tempCoach = stu.coaches[i];
            
            if (tempCoach.name.length) {
                
                coachesStr = [coachesStr stringByAppendingString:tempCoach.name];
                
            }
            
            if (i<stu.coaches.count-1) {
                
                coachesStr = [coachesStr stringByAppendingString:@"，"];
                
            }
            
        }
        
        cell.coaches = coachesStr;
        
        cell.userType = stu.type;
        
        BOOL contains = NO;
        
        for (Student *tempUser in self.chooseArray) {
            
            if (tempUser.stuId == stu.stuId) {
                
                contains = YES;
                
                break;
                
            }
            
        }
        
        cell.choosed = contains;
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        return cell;
        
    }else{
        
        SellerUserDeleteCell *cell = [tableView dequeueReusableCellWithIdentifier:deleteIdentifier];
        
        if (!cell) {
            
            cell = [[SellerUserDeleteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deleteIdentifier];
            
        }
        
        Student *stu = self.chooseArray[indexPath.row];
        
        cell.title = stu.name;
        
        cell.phone = stu.phone;
        
        cell.sex = stu.sex;
        
        cell.imgUrl = stu.avatar;
        
        NSString *coachesStr = @"";
        
        for (NSInteger i = 0; i<stu.coaches.count; i++) {
            
            Coach *tempCoach = stu.coaches[i];
            
            coachesStr = [coachesStr stringByAppendingString:tempCoach.name];
            
            if (i<stu.coaches.count-1) {
                
                coachesStr = [coachesStr stringByAppendingString:@"，"];
                
            }
            
        }
        
        cell.sellers = coachesStr;
        
        cell.userType = stu.type;
        
        cell.tag = indexPath.row;
        
        cell.delegate = self;
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        return cell;
        
    }
    
}

-(void)deleteWithCell:(SellerUserDeleteCell *)cell
{
    
    if (cell.tag <self.chooseArray.count) {
        
        [self.chooseArray removeObjectAtIndex:cell.tag];
        
        [self.chooseView reloadData];
        
        if (!self.chooseArray.count) {
            
            [self.chooseView close];
            
        }
        
        [self.tableView reloadData];
        
        [self checkFunc];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(75);
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (tableView.tag == 101) {
        
        if (self.fiterViewModel.buttonOfNewRegisterFilter.isSelected == YES) {
            return 0;
        }
        return Height320(20);
        
    }else{
        
        return Height320(32);
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView.tag == 101) {
        
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(20))];
        
        header.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(200), header.height)];
        
        label.text = [self.users[section] valueForKey:@"head"];
        
        label.textColor = UIColorFromRGB(0xFF5252);
        
        label.font = AllFont(12);
        
        [header addSubview:label];
        
        return header;
        
    }else{
        
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(32))];
        
        header.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UILabel *numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, Width320(150), Height320(32))];
        
        numberLabel.text = [NSString stringWithFormat:@"已选择%ld名会员",(unsigned long)self.chooseArray.count];
        
        numberLabel.textColor = UIColorFromRGB(0x999999);
        
        numberLabel.font = AllFont(12);
        
        [header addSubview:numberLabel];
        
        UIButton *clearButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(88), 0, Width320(88), Height320(32))];
        
        [header addSubview:clearButton];
        
        UIImageView *clearImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(10), Width320(12), Height320(12))];
        
        clearImg.image = [UIImage imageNamed:@"user_choose_trash"];
        
        [clearButton addSubview:clearImg];
        
        UILabel *clearLabel = [[UILabel alloc]initWithFrame:CGRectMake(clearImg.right+Width320(4), 0, Width320(55), Height320(32))];
        
        clearLabel.text = @"清空选择";
        
        clearLabel.textColor = UIColorFromRGB(0x666666);
        
        clearLabel.font = AllFont(12);
        
        [clearButton addSubview:clearLabel];
        
        [clearButton addTarget:self action:@selector(clearChooseData) forControlEvents:UIControlEventTouchUpInside];
        
        return header;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView.tag == 101) {
        
        Student *user = self.users[indexPath.section][@"data"][indexPath.row];
        
        BOOL contains = NO;
        
        for (Student *tempUser in self.chooseArray) {
            
            if (user.stuId == tempUser.stuId) {
                
                contains = YES;
                
                [self.chooseArray removeObject:tempUser];
                
                break;
                
            }
            
        }
        
        if (!contains) {
            
            [self.chooseArray addObject:user];
            
        }
        
        [self.tableView reloadData];
        
        [self.chooseView reloadData];
        
        [self checkFunc];
        
    }
    
}

-(void)naviLeftClick
{
    
    self.leftChoosed = !self.leftChoosed;
    
    if (self.leftChoosed) {
        
        [self.chooseArray removeAllObjects];
        
        for (NSDictionary *userDict in self.users) {
            
            for (Student *stu in userDict[@"data"]) {
                
                [self.chooseArray addObject:stu];
                
            }
            
        }
        
    }else{
        
        [self.chooseArray removeAllObjects];
        
    }
    
    [self.tableView reloadData];
    
    [self.chooseView reloadData];
    
    [self checkFunc];
    
}

-(void)naviRightClick
{
    if (self.isChooseStudent)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 0) {
        
        if (buttonIndex == 1) {
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [self.view addSubview:hud];
            
            CoachDistributeInfo *info = [[CoachDistributeInfo alloc]init];
            
            [info deleteUsers:self.chooseArray withCoach:self.coach withGym:self.gym result:^(BOOL success, NSString *error) {
                
                if (success) {
                    
                    hud.label.text = @"移除成功";
                    
                    [hud showAnimated:YES];
                    
                    [hud hideAnimated:YES afterDelay:1.5];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
                        
                        [self  naviRightClick];
                        
                    });
                    
                    for (MOViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([NSStringFromClass([vc class]) isEqualToString:@"CoachDistributeListController"]) {
                            
                            [vc reloadData];
                            
                        }
                        
                    }
                    
                }else{
                    
                    hud.label.text = error;
                    
                    [hud showAnimated:YES];
                    
                    [hud hideAnimated:YES afterDelay:1.5];
                    
                }
                
            }];
            
        }
        
    }else if (alertView.tag == 1){
        
        if (buttonIndex == 1) {
            
            [self confirmClear];
            
        }
        
    }
}

- (void)timeSort
{
    self.users =self.info.showTimeArray;
    
    [self.tableView reloadData];
}

- (void)letterSort
{
    self.users = self.info.showArray;
    
    [self.tableView reloadData];
}

- (YFSearchResultSellerListBatchVC *)resultVC
{
    if (!_resultVC)
    {
        CGFloat yy = _header.top + self.searchBar.bottom;
        
        _resultVC = [[YFSearchResultSellerListBatchVC alloc] initWithFrame:CGRectMake(0, yy, self.tableView.width, self.view.height - yy)];
        
        _resultVC.gym = self.gym;
        _resultVC.coach = self.coach;
        
        _resultVC.coachBatchEditVC = self;
        [self.view addSubview:_resultVC.view];
        
        weakTypesYF
        [_resultVC setChooseArray:^NSMutableArray *{
            return weakS.chooseArray;
        }];
        [self.view bringSubviewToFront:self.funcView];
    }
    _resultVC.isChooseStudent = self.isChooseStudent;
    _resultVC.gym = self.gym;
    _resultVC.coach = self.coach;
    return _resultVC;
}

#pragma mark action
- (void)doneChooseStudentsAction:(UIButton *)sender
{
    if (self.chooseStudentsBlock)
    {
        self.chooseStudentsBlock(self.chooseArray);
    }
}
// 补全 头像
- (void)fullChoosearrayStuAvatar
{
    Student *firstStu = self.chooseArray.firstObject;
    
    if (firstStu.avatar) {
        return;
    }
    for (NSDictionary *stuDic in self.users)
    {
        NSArray*dataArray = [stuDic[@"data"] guardArrayYF];
        
        for (Student *stu in dataArray)
        {
            for (Student *tempUser in self.chooseArray) {
                if (tempUser.stuId == stu.stuId)
                {
                    tempUser.avatar = stu.avatar;
                }
            }
        }
        
    }
}
@end

