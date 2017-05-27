//
//  CoachBelongUserController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/25.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "CoachBelongUserController.h"

#import "StudentListInfo.h"

#import "SellerUserCell.h"

#import "StudentDetailController.h"

#import "CoachUserBatchEditController.h"

#import "CoachUserAddController.h"

#import "CoachDistributeInfo.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CoachBelongUserController ()<UITableViewDelegate,MOTableViewDatasource,UIAlertViewDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSArray *users;

@property(nonatomic,strong)NSIndexPath *deleteIndexPath;

@property(nonatomic,strong)UILabel *numberLabel;

@property(nonatomic,strong)StudentListInfo *info;

@end

@implementation CoachBelongUserController
{
    UIView *_header;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kPostAddNewCoachIdtifierYF object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kPostAddNewStudentToCoachIdtifierYF object:nil];
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
    
    [self reloadData];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
}

-(void)reloadData
{
    
    StudentListInfo *info = [[StudentListInfo alloc]init];
    
    info.fiterOtherModel = self.temFilterModel;
    
    weakTypesYF
    [info requestWithCoach:self.coach andGym:self.gym success:^{
        
        weakS.tableView.dataSuccess = YES;
        
        weakS.info = info;
        
        [weakS.tableView.mj_header endRefreshing];
        
        if (weakS.fiterViewModel.buttonOfLetterFilter.isSelected)
        {
            weakS.users = weakS.info.showArray;
        }else
        {
            weakS.users = weakS.info.showTimeArray;
        }
        
        //        weakS.numberLabel.text = [NSString stringWithFormat:@"名下会员（%ld）",(unsigned long)info.studentCount];
        
        [weakS.tableView reloadData];
        
        [weakS setTableFootviewLabelNum:info.students.count];
        
    } Failure:^{
        
        weakS.tableView.dataSuccess = NO;
        
        [weakS.tableView reloadData];
        
        [weakS.tableView.mj_header endRefreshing];
        
    }];
    
}

-(void)createUI
{
    
    self.title = self.coach.type == CoachDistributeTypeNormal?[NSString stringWithFormat:@"%@的名下会员",self.coach.name]:@"未分配";
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.rightTitle = self.coach.type == CoachDistributeTypeNormal?@"批量修改":@"批量分配";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.sectionIndexColor = UIColorFromRGB(0x666666);
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[SellerUserCell class] forCellReuseIdentifier:identifier];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    self.tableView.tableFooterView = [UIView new];
    self.fiterViewModel.baseTableView = self.tableView;
    self.baseTableView = self.tableView;
    
    [self.view addSubview:self.tableView];
    
    if (self.coach.type == CoachDistributeTypeNormal) {
        
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
        _header = header;
        header.backgroundColor = YFGrayViewColor;
        
        
        //        UIView *headerTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(20))];
        //
        //        headerTop.backgroundColor = UIColorFromRGB(0xf4f4f4);
        //
        //        [header addSubview:headerTop];
        //
        //        self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(200), Height320(20))];
        //
        //        self.numberLabel.text = [NSString stringWithFormat:@"名下会员（%ld）",(long)self.seller.userCount];
        //
        //        self.numberLabel.textColor = UIColorFromRGB(0x999999);
        //
        //        self.numberLabel.font = AllFont(11);
        //
        //        [headerTop addSubview:self.numberLabel];
        
        UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
        
        addButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        [header addSubview:addButton];
        
        [addButton addTarget:self action:@selector(addUser:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *addImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(13), Width320(14), Height320(14))];
        
        addImg.image = [UIImage imageNamed:@"seller_add"];
        
        [addButton addSubview:addImg];
        
        UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(addImg.right+Width320(6), 0, Width320(200), Height320(40))];
        
        addLabel.text = @"添加名下会员";
        
        addLabel.textColor = kMainColor;
        
        addLabel.font = AllFont(13);
        
        [addButton addSubview:addLabel];
        
        UIView *filterView = self.fiterViewModel.conditionButtonViews;
        
        [filterView changeTop:header.height + 12];
        
        [header changeHeight:filterView.bottom];
        [header addSubview:filterView];
        
        self.tableView.tableHeaderView = header;
        
    }else
    {
        UIView *filterView = self.fiterViewModel.conditionButtonViews;
        [filterView changeTop:64.0];
        
        [self.view addSubview:filterView];
        self.tableView.frame = CGRectMake(0, 64 + filterView.height, MSW, MSH-64 - filterView.height);
    }
}

-(void)addUser:(UIButton*)button
{
    CoachUserAddController *svc = [[CoachUserAddController alloc]init];
    
    svc.coach = self.coach;
    if (self.coach.type == CoachDistributeTypeNone)
    {
        svc.coach_id = @"0";
    }else
    {
        svc.coach_id = [NSString stringWithFormat:@"%ld",(long)self.coach.coachId];
    }
    
    svc.gym = self.gym;
    
    UIViewController *willPushVC = [YFSellerFiterViewModel  setFilterRightVcToVC:svc gym:self.gym fiterViewModel:nil];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:willPushVC];
    navi.navigationBar.hidden = YES;
    
    
    [self.navigationController presentViewController:navi animated:YES completion:nil];
    
    //    [self.navigationController pushViewController: animated:YES];
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (!self.fiterViewModel.buttonOfLetterFilter.isSelected)
    {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    
    [self.users enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [array addObject:obj[@"head"]];
        
    }];
    
    return array;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.users.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.users.count?[[self.users[section] valueForKey:@"data"]count]:0;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SellerUserCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
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
    
    cell.editing = self.coach.type == CoachDistributeTypeNormal;
    
    cell.noLine = indexPath.row>= [[self.users[indexPath.section] valueForKey:@"data"] count]-1;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return self.coach.type == CoachDistributeTypeNormal?Height320(76):Height320(64);
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.fiterViewModel.buttonOfNewRegisterFilter.isSelected) {
        return 0.0;
    }
    return Height320(20);
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(20))];
    
    header.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(200), header.height)];
    
    label.text = [self.users[section] valueForKey:@"head"];
    
    label.textColor = UIColorFromRGB(0xFF5252);
    
    label.font = AllFont(12);
    
    [header addSubview:label];
    
    return header;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    StudentDetailController *svc = [[StudentDetailController alloc]init];
    
    svc.student = self.users[indexPath.section][@"data"][indexPath.row];
    
    ((AppDelegate *)[UIApplication sharedApplication].delegate).student = svc.student;
    
    svc.gym = self.gym;
    
    [self.navigationController pushViewController:svc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.coach.type == CoachDistributeTypeNormal) {
        
        return YES;
        
    }else{
        
        return NO;
        
    }
    
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    
    return @"      移 除      ";
    
}

-(NSArray*)tableView:(UITableView* )tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0) {
        
        UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"      移 除      " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            
            self.deleteIndexPath = indexPath;
            
            [self deleteStudent];
            
        }];
        
        editRowAction.backgroundColor = UIColorFromRGB(0xaaaaaa);
        
        return @[editRowAction];
        
    }else{
        
        return nil;
        
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        self.deleteIndexPath = indexPath;
        
        [self deleteStudent];
        
    }
    
}

-(void)deleteStudent
{
    
    [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"确认将选中会员从%@名下移除？",self.coach.name] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil]show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        CoachDistributeInfo *info = [[CoachDistributeInfo alloc]init];
        
        Student *stu = self.users[self.deleteIndexPath.section][@"data"][self.deleteIndexPath.row];
        
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        
        hud.mode = MBProgressHUDModeText;
        
        [self.view addSubview:hud];
        
        [info deleteUser:stu withCoach:self.coach withGym:self.gym result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                hud.label.text = @"移除成功";
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
                BOOL sectionEmpty = NO;
                
                NSMutableDictionary *dict = [self.users[self.deleteIndexPath.section] mutableCopy];
                
                NSMutableArray *stuArray = [dict[@"data"] mutableCopy];
                
                NSMutableArray *array = [self.users mutableCopy];
                
                [stuArray removeObjectAtIndex:self.deleteIndexPath.row];
                
                if (stuArray.count) {
                    
                    [dict setObject:stuArray forKey:@"data"];
                    
                    [array replaceObjectAtIndex:self.deleteIndexPath.section withObject:dict];
                    
                }else{
                    
                    sectionEmpty = YES;
                    
                    [array removeObjectAtIndex:self.deleteIndexPath.section];
                    
                }
                
                self.users = [array copy];
                
                if (sectionEmpty) {
                    
                    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:self.deleteIndexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
                    
                }else{
                    
                    [self.tableView deleteRowsAtIndexPaths:@[self.deleteIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
                    
                }
                
                [self reloadData];
                
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
    
}

- (void)naviRightClick
{
    
    CoachUserBatchEditController *svc = [[CoachUserBatchEditController alloc]init];
    
    svc.coach = self.coach;
    if (self.coach.type == CoachDistributeTypeNormal)
    {
        svc.coach_id = @"0";
    }else
    {
        svc.coach_id = [NSString stringWithFormat:@"%ld",(long)self.coach.coachId];
    }
    
    svc.gym = self.gym;
    
    svc.info = self.info;
    
    [self.navigationController pushViewController:[YFSellerFiterViewModel  setFilterRightVcToVC:svc gym:self.gym fiterViewModel:self.fiterViewModel] animated:NO];
    
}
- (void)naviLeftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.coach.type != CoachDistributeTypeNormal) {
        return;
    }
    CGFloat offsetXX = _header.height - self.fiterViewModel.conditionButtonViews.height;
    
    if (offsetXX <= scrollView.contentOffset.y)
    {
        if ([self.fiterViewModel.conditionButtonViews.superview isEqual:self.view] == NO)
        {
            [self.fiterViewModel.conditionButtonViews changeTop:64.0];
            [self.view addSubview:self.fiterViewModel.conditionButtonViews];
        }
    }else
    {
        if ([self.fiterViewModel.conditionButtonViews.superview isEqual:_header] == NO)
        {
            [self.fiterViewModel.conditionButtonViews changeTop:_header.height - self.fiterViewModel.conditionButtonViews.height];
            [_header addSubview:self.fiterViewModel.conditionButtonViews];
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


@end
