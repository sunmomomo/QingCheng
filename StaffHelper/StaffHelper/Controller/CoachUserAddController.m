//
//  CoachUserAddController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/25.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "CoachUserAddController.h"

#import "SellerUserEditCell.h"

#import "SellerUserDeleteCell.h"

#import "StudentListInfo.h"

#import "UserChooseView.h"

#import "CoachDistributeInfo.h"

#import "StudentEditController.h"

#import "MOTableView.h"

#import "YFSearchResultAddSellerListVC.h"

static NSString *identifier = @"Cell";

static NSString *deleteIdentifier = @"Cell";

@interface CoachUserAddController ()<UITableViewDelegate,MOTableViewDatasource,UITextFieldDelegate,UserChooseViewDatasource,SellerUserDeleteCellDelegate,UIAlertViewDelegate>


@property(nonatomic,strong)NSArray *users;


@property(nonatomic,strong)StudentListInfo *info;

@property(nonatomic,strong)UIView *funcView;

@property(nonatomic,strong)UITextField *searchBar;

@property(nonatomic,strong)UILabel *numLabel;

@property(nonatomic,strong)UISwitch *allSwitch;


@property(nonatomic, strong)YFSearchResultAddSellerListVC *resultVC;



@end

@implementation CoachUserAddController
{
    UIView *_header;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kPostModifyOrAddStudentIdtifierYF object:nil];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.chooseArray = [NSMutableArray array];
    
    self.info = [[StudentListInfo alloc]init];
    self.info.fiterOtherModel = self.temFilterModel;
    
    weakTypesYF
    [self.info requestAddDataWithCoach:self.coach andGym:self.gym success:^{
        
        weakS.tableView.dataSuccess = YES;
        
        [weakS.tableView.mj_header endRefreshing];
        
        [weakS dealUsers];
        
        [weakS.tableView reloadData];
        
    } Failure:^{
        
        weakS.tableView.dataSuccess = NO;
        [weakS.tableView reloadData];
        [weakS.tableView.mj_header endRefreshing];
        
    }];
    
}

-(void)reloadData
{
    
    StudentListInfo *info = [[StudentListInfo alloc]init];
    info.fiterOtherModel = self.temFilterModel;
    
    weakTypesYF
    [info requestAddDataWithCoach:self.coach andGym:self.gym success:^{
        
        weakS.info = info;
        weakS.tableView.dataSuccess = YES;
        
        [weakS.tableView.mj_header endRefreshing];
        
        [weakS dealUsers];
        
        [weakS.tableView reloadData];
        
    } Failure:^{
        
        weakS.tableView.dataSuccess = NO;
        
        [weakS.tableView.mj_header endRefreshing];
    }];
    
}

-(void)createUI
{
    
    self.title = @"添加名下会员";
    
    self.rightTitle = @"完成";
    self.leftTitle = @"取消";
    self.leftColor = [UIColor whiteColor];
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(88))];
    
    header.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:header];
    
    UIView *switchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(36))];
    
    switchView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    switchView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    switchView.layer.borderWidth = OnePX;
    
    [header addSubview:switchView];
    
    UILabel *switchLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(12), 0, Width320(160), Height320(36))];
    
    switchLabel.text = @"仅显示未分配教练的会员";
    
    switchLabel.textColor = UIColorFromRGB(0x666666);
    
    switchLabel.font = AllFont(12);
    
    [switchView addSubview:switchLabel];
    
    self.allSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(MSW-Width320(51), Height320(6), Width320(39), Height320(24))];
    
    [switchView addSubview:self.allSwitch];
    
    [self.allSwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.searchBar = [[UITextField alloc]initWithFrame:CGRectMake(Width320(12), switchView.bottom+Height320(10), Width320(258), Height320(32))];
    
    self.searchBar.backgroundColor = UIColorFromRGB(0xfafafa);
    
    self.searchBar.layer.cornerRadius = 2;
    
    self.searchBar.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
    
    self.searchBar.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
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
    
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(self.searchBar.right+Width320(12), switchView.bottom+Height320(13), Width320(26), Height320(26))];
    
    [addButton setImage:[UIImage imageNamed:@"student_add"] forState:UIControlStateNormal];
    
    [header addSubview:addButton];
    
    [addButton addTarget:self action:@selector(addStudent) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *filterView = self.fiterViewModel.conditionButtonViews;
    [filterView changeTop:self.searchBar.bottom + Height320(10)];
    
    [header changeHeight:filterView.bottom];
    [header addSubview:filterView];
    _header = header;
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, header.bottom, MSW, MSH-header.bottom) style:UITableViewStylePlain];
    
    self.tableView.tag = 101;
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.sectionIndexColor = UIColorFromRGB(0x666666);
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.baseTableView =self.tableView;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, Width320(69), 0, 0);
    
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    MJRefreshNormalHeader *mjHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    mjHeader.lastUpdatedTimeLabel.hidden = YES;
    
    [mjHeader setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [mjHeader setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [mjHeader setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    mjHeader.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = mjHeader;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[SellerUserEditCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    self.funcView = [[UIView alloc]initWithFrame:CGRectMake(0, MSH, MSW, Height320(40))];
    
    self.funcView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.funcView.layer.borderWidth = OnePX;
    
    self.funcView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.funcView];
    
    self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(118), Height320(10), Width320(20), Height320(20))];
    
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
    
    self.chooseView = [[UserChooseView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    self.chooseView.datasource = self;
    
    self.chooseView.hidden = YES;
    
    self.chooseView.tag = 102;
    
    [self.view addSubview:self.chooseView];
    
}

-(void)addStudent
{
    
    if (AppGym && ![PermissionInfo sharedInfo].permissions.userPermission.addState && ![PermissionInfo sharedInfo].permissions.personalUserPermission.addState) {
        
        [self showNoPermissionAlert];
        
        return;
        
    }else if (!AppGym){
        
        for (Gym *gym in [PermissionInfo sharedInfo].gyms) {
            
            if (gym.shopId == self.gym.shopId) {
                
                if (!gym.permissions.userPermission.addState && !gym.permissions.personalUserPermission.addState) {
                    
                    [self showNoPermissionAlert];
                    
                    return;
                    
                }
                
                break;
                
            }
            
        }
        
    }
    
    StudentEditController *svc = [[StudentEditController alloc]init];
    
    weakTypesYF
    [svc setAddFinish:^{
        [weakS reloadData];
        [weakS.resultVC reloadData];
        [weakS naviLeftClick];
    }];
    
    svc.isAdd = YES;
    
    svc.gym = self.gym;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)showChoose
{
    
    [self.chooseView show];
    
}

-(void)dealUsers
{
    if (!self.allSwitch.on)
    {
        if (self.fiterViewModel.buttonOfLetterFilter.isSelected)
        {
            self.users = self.info.showArray;
        }else
        {
            self.users = self.info.showTimeArray;
        }
        [self setTableFootviewLabelNum:self.info.studentCount];
        
    }else
    {
        if (self.fiterViewModel.buttonOfLetterFilter.isSelected)
        {
            self.users = self.info.showNoCoachArray;
        }else
        {
            self.users = self.info.showNoCoachTimeArray;
        }
        [self setTableFootviewLabelNum:self.info.studentNoCoachCount];
        
    }
    
    
    return;
    //    if (!self.allSwitch.on && !self.searchBar.text.length) {
    //
    //        self.users = [self.info.showArray copy];
    //
    //    }else{
    //
    //        NSMutableArray *users = [NSMutableArray array];
    //
    //        for (NSDictionary *dict in self.info.showArray) {
    //
    //            NSMutableArray *tempArray = [NSMutableArray array];
    //
    //            for (Student *tempStu in dict[@"data"]) {
    //
    //                if (self.allSwitch.on && self.searchBar.text.length) {
    //
    //                    if (!tempStu.sellers.count &&([[tempStu.name lowercaseString] rangeOfString:[self.searchBar.text lowercaseString]].length||[tempStu.phone rangeOfString:self.searchBar.text].length)) {
    //
    //                        [tempArray addObject:tempStu];
    //
    //                    }
    //
    //                }else if (self.allSwitch.on){
    //
    //                    if (!tempStu.sellers.count) {
    //
    //                        [tempArray addObject:tempStu];
    //
    //                    }
    //
    //                }else{
    //
    //                    if ([[tempStu.name lowercaseString] rangeOfString:[self.searchBar.text lowercaseString]].length||[tempStu.phone rangeOfString:self.searchBar.text].length) {
    //
    //                        [tempArray addObject:tempStu];
    //
    //                    }
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
    }else
    {
        self.searchBar.clearButtonMode = UITextFieldViewModeNever;
    }
    
    [self.resultVC setSearchStr:textField.text];
    
    return;
    
    //    [self dealUsers];
    //
    //    [self.tableView reloadData];
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
            
        }];
        
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.funcView changeTop:MSH];
            
        } completion:^(BOOL finished) {
            
            [self.tableView changeHeight:MSH-_header.bottom];
            
        }];
        
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

-(void)switchChanged:(UISwitch*)aswitch
{
    
    self.resultVC.showAllSwitch = aswitch.on;
    [self dealUsers];
    
    [self.tableView reloadData];
    //    [self setTableFootviewLabelNum:self.]
    
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
    if (tableView.tag == 101) {
        if (self.fiterViewModel.buttonOfNewRegisterFilter.isSelected) {
            return nil;
        }
        NSMutableArray *array = [NSMutableArray array];
        
        [self.users enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [array addObject:obj[@"head"]];
        }];
        return array;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (tableView.tag == 101) {
        
        if (self.fiterViewModel.buttonOfLetterFilter.isSelected == NO) {
            return 0.0;
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 101) {
        
        SellerUserEditCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        Student *stu = [self.users[indexPath.section] valueForKey:@"data"][indexPath.row];
        
        cell.title = stu.name;
        
        cell.phone = stu.phone;
        
        cell.sex = stu.sex;
        
        cell.imgUrl = stu.avatar;
        
        NSString *coaches = @"";
        
        for (NSInteger i = 0; i<stu.coaches.count; i++) {
            
            Coach *tempCoach = stu.coaches[i];
            
            if (tempCoach.name.length) {
                
                coaches = [coaches stringByAppendingString:tempCoach.name];
                
            }
            
            if (i<stu.coaches.count-1) {
                
                coaches = [coaches stringByAppendingString:@"，"];
                
            }
            
        }
        
        cell.coaches = coaches;
        
        cell.userType = stu.type;
        
        
        BOOL chooseable = ![stu.coachesDic objectForKey:[NSString stringWithFormat:@"%ld",(long)self.coach.coachId]];
        
        if (chooseable) {
            
            BOOL contains = NO;
            
            for (Student *tempUser in self.chooseArray) {
                
                if (tempUser.stuId == stu.stuId) {
                    
                    contains = YES;
                    
                    break;
                    
                }
                
            }
            
            cell.choosed = contains;
            
            cell.unchoosedable = NO;
            
        }else{
            
            cell.choosed = YES;
            
            cell.unchoosedable = YES;
            
        }
        
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
        
        NSString *coaches = @"";
        
        for (NSInteger i = 0; i<stu.coaches.count; i++) {
            
            Coach *tempCoach = stu.coaches[i];
            
            coaches = [coaches stringByAppendingString:tempCoach.name];
            
            if (i<stu.coaches.count-1) {
                
                coaches = [coaches stringByAppendingString:@"，"];
                
            }
            
        }
        
        cell.coaches = coaches;
        
        cell.userType = stu.type;
        
        cell.tag = indexPath.row;
        
        cell.delegate = self;
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        return cell;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(75);
    
}

-(void)naviRightClick
{
    
    if (self.chooseArray.count) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"确定将所选会员添加到%@名下？",self.coach.name] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        alert.tag = 0;
        
        [alert show];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:@"至少选择一名会员" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView.tag == 101) {
        
        Student *user = self.users[indexPath.section][@"data"][indexPath.row];
        
        BOOL chooseable = YES;
        
        BOOL contains = NO;
        
        for (Coach *tempCoach in user.coaches) {
            
            if (tempCoach.coachId == self.coach.coachId) {
                
                chooseable = NO;
                
                break;
                
            }
            
        }
        
        if (chooseable) {
            
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
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 0) {
        
        if (buttonIndex == 1) {
            
            self.rightButtonEnable = NO;
            
            CoachDistributeInfo *info = [[CoachDistributeInfo alloc]init];
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [self.view addSubview:hud];
            
            [info addUsers:self.chooseArray withCoach:self.coach withGym:self.gym result:^(BOOL success, NSString *error) {
                
                if (success) {
                    
                    hud.label.text = @"添加成功";
                    
                    [hud showAnimated:YES];
                    
                    [hud hideAnimated:YES afterDelay:1.5];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kPostAddNewStudentToCoachIdtifierYF object:nil];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        [self naviLeftClick];
                        //                        [self popToViewControllerName:@"SellerBelongUserController" isReloadData:YES];
                        
                    });
                    
                }else{
                    
                    self.rightButtonEnable = YES;
                    
                    hud.label.text = error;
                    
                    [hud showAnimated:YES];
                    
                    [hud hideAnimated:YES afterDelay:1.5];
                    
                }
                
            }];
            
        }
        
    }else if (alertView.tag == 1){
        
        [self confirmClear];
        
    }
    
}

- (void)naviLeftClick
{
    //    [self.navigationController popViewControllerAnimated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)timeSort
{
    //    self.users = self.info.showTimeArray;
    
    [self dealUsers];
    [self.tableView reloadData];
}
- (void)letterSort
{
    [self dealUsers];
    [self.tableView reloadData];
}

#pragma mark Getter
- (YFSearchResultAddSellerListVC *)resultVC
{
    if (!_resultVC)
    {
        CGFloat yy = _header.top + self.searchBar.bottom;
        
        _resultVC = [[YFSearchResultAddSellerListVC alloc] initWithFrame:CGRectMake(0, yy, self.tableView.width, self.view.height - yy)];
        _resultVC.gym = self.gym;
        _resultVC.coach = self.coach;
        
        _resultVC.coachAddVC = self;
        [self.view addSubview:_resultVC.view];
        
        weakTypesYF
        [_resultVC setChooseArray:^NSMutableArray *{
            return weakS.chooseArray;
        }];
        [self.view bringSubviewToFront:self.funcView];
    }
    _resultVC.gym = self.gym;
    _resultVC.coach = self.coach;
    return _resultVC;
    
}
@end
