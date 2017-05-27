//
//  StaffListController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "StaffListController.h"

#import "MOTableView.h"

#import "StaffCell.h"

#import "AdminCell.h"

#import "StaffListInfo.h"

#import "StaffEditController.h"

#import "AdminController.h"

#import "MOMenuView.h"

#import "FunctionHintController.h"

static NSString *identifier = @"Cell";

@interface StaffListController ()<MOTableViewDatasource,UITableViewDelegate,UITextFieldDelegate,MOMenuDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)StaffListInfo *info;

@property(nonatomic,strong)UIView *searchView;

@property(nonatomic,strong)UITextField *searchBar;

@property(nonatomic,strong)Staff *admin;

@property(nonatomic,strong)NSMutableArray *staffs;

@end

@implementation StaffListController

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
    
    StaffListInfo *info = [[StaffListInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    __weak typeof(StaffListInfo *)weakInfo = info;
    
    info.requestFinish = ^(BOOL success){
        
        weakS.tableView.dataSuccess = success;
        
        weakS.info = weakInfo;
        
        weakS.staffs = [NSMutableArray array];
        
        for (Staff *staff in weakS.info.staffs) {
            
            if (staff.admin) {
                
                weakS.admin = staff;
                
            }else{
                
                [weakS.staffs addObject:staff];
                
            }
            
        }
        
        [weakS.tableView reloadData];
        
        [weakS.tableView.mj_header endRefreshing];
        
        [weakS.tableView.mj_footer endRefreshing];
        
    };
    
    [info requestWithGym:self.gym andSearchStr:self.searchBar.text];
    
}

-(void)createUI
{
    
    self.title = @"工作人员";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.rightType = MONaviRightTypeMore;
    
    self.rightSubType = MONaviRightSubTypeSearch;
    
    self.searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 64)];
    
    self.searchView.backgroundColor = UIColorFromRGB(0x4e4e4e);
    
    [self.view addSubview:self.searchView];
    
    self.searchView.hidden = YES;
    
    self.searchBar = [[UITextField alloc]initWithFrame:CGRectMake(Width320(7.5), 23.1, Width320(257), 35.7)];
    
    [self.searchView addSubview:self.searchBar];
    
    self.searchBar.returnKeyType = UIReturnKeySearch;
    
    self.searchBar.layer.cornerRadius = 2;
    
    self.searchBar.layer.masksToBounds = YES;
    
    self.searchBar.backgroundColor = UIColorFromRGB(0xfafafa);
    
    self.searchBar.font = AllFont(14);
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, self.searchBar.height)];
    
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(16.8, 10.3, 15.5, 15.5)];
    
    searchImg.image = [UIImage imageNamed:@"search"];
    
    [leftView addSubview:searchImg];
    
    self.searchBar.leftView = leftView;
    
    self.searchBar.leftViewMode = UITextFieldViewModeAlways;
    
    self.searchBar.delegate = self;
    
    self.searchBar.placeholder = @"搜索工作人员";
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    clearButton.frame = CGRectMake(self.searchBar.right-Width320(24), 0, Width320(24), self.searchBar.height);
    
    self.searchBar.rightView = clearButton;
    
    UIImageView *clearImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(3), 0, Width320(12.4), Height320(12.4))];
    
    clearImg.image = [UIImage imageNamed:@"clear"];
    
    clearImg.center = CGPointMake(clearImg.center.x, clearButton.height/2);
    
    [clearButton addSubview:clearImg];
    
    [clearButton addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.searchBar addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    
    cancel.frame = CGRectMake(self.searchBar.right, 20, MSW-self.searchBar.right, 44);
    
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancel setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    cancel.backgroundColor = [UIColor clearColor];
    
    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.searchView addSubview:cancel];
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, Width320(72), 0, 0);
    
    [self.tableView registerClass:[StaffCell class] forCellReuseIdentifier:identifier];
    
    [self.tableView registerClass:[AdminCell class] forCellReuseIdentifier:@"admin"];
    
    self.tableView.tableFooterView = [UIView new];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    [self.view addSubview:self.tableView];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(74), MSH-Height320(75), Width320(48), Height320(48))];
    
    [addButton setImage:[UIImage imageNamed:@"user_list_add"] forState:UIControlStateNormal];
    
    addButton.layer.shadowOffset = CGSizeMake(0, Height320(2));
    
    addButton.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
    
    addButton.layer.shadowOpacity = 0.3;
    
    [self.view addSubview:addButton];
    
    [addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (self.admin && self.staffs.count) {
        
        return 2;
        
    }else if (self.admin || self.staffs.count){
        
        return 1;
        
    }else{
        
        return 0;
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.admin) {
        
        if (section == 0) {
            
            return 1;
            
        }else{
            
            return self.staffs.count;
            
        }
        
    }else{
        
        return self.staffs.count;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.admin && indexPath.section == 0) {
        
        AdminCell *cell = [tableView dequeueReusableCellWithIdentifier:@"admin"];
        
        cell.name = self.admin.name;
        
        cell.iconURL = self.admin.iconUrl;
        
        cell.phone = self.admin.phone;
        
        cell.sex = self.admin.sex;
        
        return cell;
        
    }else{
        
        StaffCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        Staff *staff = self.staffs[indexPath.row];
        
        cell.name = staff.name;
        
        cell.iconURL = staff.iconUrl;
        
        cell.position = staff.position.name;
        
        cell.phone = staff.phone;
        
        cell.sex = staff.sex;
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        return cell;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && self.admin) {
        
        return Height320(105);
        
    }else{
        
        return Height320(85);
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && self.admin) {
        
        if ([self.admin.phone isEqualToString:UserPhone]) {
            
            AdminController *svc = [[AdminController alloc]init];
            
            svc.admin = self.admin;
            
            __weak typeof(self)weakS = self;
            
            svc.editFinish = ^{
                
                [weakS createData];
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [[[UIAlertView alloc]initWithTitle:@"仅超级管理员本人有权限查看其基本信息" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
    }else{
        
        Staff *staff = self.staffs[indexPath.row];
        
        StaffEditController *svc = [[StaffEditController alloc]init];
        
        svc.staff = staff;
        
        svc.gym = self.gym;
        
        __weak typeof(self)weakS = self;
        
        svc.editFinish = ^{
            
            [weakS createData];
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

-(void)naviRightClick
{
    
    MOMenuView *sheet = [MOMenuView menuWithTitie:nil delegate:self destructiveButtonTitle:nil cancelButtonTitle:nil otherButtonTitles:@"工作人员职位与权限设置",nil];
    
    sheet.textAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [sheet show];
    
}

-(void)actionSheet:(MOMenuView *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        if ([PermissionInfo sharedInfo].permissions.staffPositionPermission.readState) {
            
            FunctionHintController *svc = [[FunctionHintController alloc]init];
            
            svc.module = @"/position/setting";
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }
    
}

-(void)addClick
{
    
    if ([PermissionInfo sharedInfo].gym.permissions.staffPermission.addState) {
        
        StaffEditController *svc = [[StaffEditController alloc]init];
        
        svc.staff = [[Staff alloc]init];
        
        svc.gym = self.gym;
        
        svc.isAdd = YES;
        
        __weak typeof(self)weakS = self;
        
        svc.editFinish = ^{
            
            [weakS createData];
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)naviRightSubClick
{
    
    self.searchView.hidden = NO;
    
    [self.view bringSubviewToFront:self.searchView];
    
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
    [self.searchBar resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    [self createData];
    
    return YES;
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    if (textField.text.length) {
        
        self.searchBar.rightViewMode = UITextFieldViewModeAlways;
        
    }else
    {
        
        self.searchBar.rightViewMode = UITextFieldViewModeNever;
        
    }
    
}

-(void)clear:(UIButton*)btn
{
    
    self.searchBar.text = @"";
    
    [self createData];
    
    [self.searchBar resignFirstResponder];
    
}
-(void)cancel:(UIButton*)btn
{
    
    [self.searchBar resignFirstResponder];
    
    self.searchView.hidden = YES;
    
    self.searchBar.text = @"";
    
    [self createData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 1) {
        
        return Height320(36);
        
    }else{
        
        return 0;
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 1) {
        
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(36))];
        
        header.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(12), Width320(150), Height320(17))];
        
        label1.text = @"工作人员";
        
        label1.textColor = UIColorFromRGB(0x999999);
        
        label1.font = AllFont(12);
        
        [header addSubview:label1];
        
        return header ;
        
    }else{
        
        return nil;
        
    }
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64)];
    
    emptyView.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/2-Width320(50), Height320(75.5), Width320(100), Height320(100))];
    
    emptyImg.image = [UIImage imageNamed:@"emptyreport"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(16), MSW, Height320(15))];
    
    emptyLabel.text = @"暂无工作人员";
    
    emptyLabel.numberOfLines = 1;
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(13);
    
    [emptyView addSubview:emptyLabel];
    
    return emptyView;
    
}


@end
