
//
//  ChatChooseMemberController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatChooseMemberController.h"

#import "ChatHeader.h"

#import "MOTableView.h"

static NSString *gymIdentifier = @"Gym";

static NSString *userIdentifier = @"User";

static NSString *searchIdentifier = @"Search";

@interface ChatChooseMemberController ()<MOTableViewDatasource,UITableViewDelegate,ChatChooseViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)UITableView *searchTableView;

@property(nonatomic,strong)NSMutableArray *searchMembers;

@property(nonatomic,strong)NSMutableArray *chooseMembers;

@property(nonatomic,strong)NSArray *wholeUsers;

@property(nonatomic,strong)UITextField *searchTF;

@property(nonatomic,strong)ChatChooseView *chooseView;

@property(nonatomic,strong)ChatChooseMemberInfo *info;

@property(nonatomic,strong)ChatMemberChoosedView *memberChoosedView;

@end

@implementation ChatChooseMemberController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    self.chooseMembers = [NSMutableArray array];
    
    self.info = [[ChatChooseMemberInfo alloc]init];
    
    [self.info requestResult:^(BOOL success, NSString *error) {
        
        self.wholeUsers = self.info.groups;
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"选择联系人";
    
    self.leftTitle = @"取消";
    
    self.leftColor = UIColorFromRGB(0xffffff);
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height(60))];
    
    searchView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:searchView];
    
    self.searchTF = [[UITextField alloc]initWithFrame:CGRectMake(Width(12), Height(12), MSW-Width(24), Height(36))];
    
    self.searchTF.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.searchTF.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.searchTF.layer.borderWidth = OnePX;
    
    self.searchTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width(34), Height(36))];
    
    self.searchTF.placeholder = @"搜索联系人姓名/手机号";

    self.searchTF.font = AllFont(12);
    
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width(10), Height(11), Width(14), Height(14))];
    
    searchImg.image = [UIImage imageNamed:@"student_search"];
    
    [self.searchTF.leftView addSubview:searchImg];
    
    self.searchTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.searchTF.returnKeyType = UIReturnKeyDone;
    
    self.searchTF.delegate = self;
    
    [self.searchTF addTarget:self action:@selector(searchTFTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [searchView addSubview:self.searchTF];
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, searchView.bottom, MSW, MSH-searchView.bottom) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.sectionIndexColor = UIColorFromRGB(0x666666);
    
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[ChatChooseGymCell class] forCellReuseIdentifier:gymIdentifier];
    
    [self.tableView registerClass:[ChatChooseMemberCell class] forCellReuseIdentifier:userIdentifier];
    
    [self.view addSubview:self.tableView];
    
    self.searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, searchView.bottom, MSW, MSH-searchView.bottom) style:UITableViewStylePlain];
    
    self.searchTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.searchTableView.dataSource = self;
    
    self.searchTableView.delegate = self;
    
    self.searchTableView.tableFooterView = [UIView new];
    
    self.searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.searchTableView registerClass:[ChatChooseMemberCell class] forCellReuseIdentifier:searchIdentifier];
    
    [self.view addSubview:self.searchTableView];
    
    self.searchTableView.hidden = YES;
    
    self.chooseView = [[ChatChooseView alloc]initWithFrame:CGRectMake(0, MSH-Height(50), MSW, Height(50))];
    
    self.chooseView.delegate = self;
    
    [self.view addSubview:self.chooseView];
    
    self.chooseView.hidden = YES;
    
}

-(void)reloadUI
{
    
    [self.tableView reloadData];
    
    [self.searchTableView reloadData];
    
    self.chooseView.chooseNumber = self.chooseMembers.count;
    
    if (self.chooseMembers.count) {
        
        self.chooseView.hidden = NO;
        
        [self.tableView changeHeight:MSH-self.tableView.top-Height(50)];
        
        [self.searchTableView changeHeight:MSH-self.searchTableView.top-Height(50)];
        
    }else{
        
        self.chooseView.hidden = YES;
        
        [self.tableView changeHeight:MSH-self.tableView.top];
        
        [self.searchTableView changeHeight:MSH-self.searchTableView.top];
        
    }
    
}

-(void)showChooseView
{
    
    if (!self.memberChoosedView) {
        
        self.memberChoosedView = [[ChatMemberChoosedView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
        
    }
    
    self.memberChoosedView.members = self.chooseMembers;
    
    __weak typeof(self)weakS = self;
    
    [self.memberChoosedView setMembersChanged:^(NSMutableArray *array) {
        
        weakS.chooseMembers = array;
        
        [weakS reloadUI];
        
    }];
    
    [self.view addSubview:self.memberChoosedView];
    
    [self.view bringSubviewToFront:self.memberChoosedView];
    
    [self.memberChoosedView show];
    
}

-(void)searchTFTextDidChanged:(UITextField*)textfield
{
    
    self.searchMembers = [NSMutableArray array];
    
    for (UserGroup *group in self.wholeUsers) {
        
        for (User *user in group.users) {
            
            if ([user.username rangeOfString:textfield.text].length || [user.phone rangeOfString:textfield.text].length) {
                
                [self.searchMembers addObject:user];
                
            }
            
        }
        
    }
    
    [self.searchTableView reloadData];
    
    self.searchTableView.hidden = !textfield.text.length;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (tableView == self.tableView) {
        
        return self.wholeUsers.count?self.wholeUsers.count+1:0;
        
    }else{
        
        return 1;
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.tableView) {
        
        if (section == 0) {
            
            return self.info.gyms.count;
            
        }else{
            
            UserGroup *group = self.wholeUsers[section-1];
            
            return group.users.count;
            
        }
        
    }else{
        
        return self.searchMembers.count;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (tableView == self.tableView && section>0) {
        
        return Height320(20);
        
    }else{
        
        return 0;
        
    }
    
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView == self.tableView && section>0) {
        
        UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(20))];
        
        header.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(200), header.height)];
        
        label.text = self.info.heads[section];
        
        label.textColor = UIColorFromRGB(0xFF5252);
        
        label.font = AllFont(12);
        
        [header addSubview:label];
        
        return header;
        
    }else{
        
        return nil;
        
    }
    
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    if (tableView == self.tableView) {
        
        return self.info.heads;
        
    }else{
        
        return nil;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableView && indexPath.section == 0) {
        
        return Height(78);
        
    }else{
        
        return Height(68);
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableView && indexPath.section == 0) {
        
        ChatChooseGymCell *cell = [tableView dequeueReusableCellWithIdentifier:gymIdentifier];
        
        ChatMemberGymModel *gym = self.info.gyms[indexPath.row];
        
        cell.title = [NSString stringWithFormat:@"%@ | %@",gym.gymName.length>9?[[gym.gymName substringToIndex:9] stringByAppendingString:@"..."]:gym.gymName,gym.brandName];
        
        cell.subtitle = [NSString stringWithFormat:@"%ld人",(long)gym.userCount];
        
        cell.iconURL = [NSURL URLWithString:gym.iconURL];
        
        return cell;
        
    }else if (tableView == self.tableView){
        
        ChatChooseMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:userIdentifier];
        
        UserGroup *group = self.wholeUsers[indexPath.section-1];
        
        User *user = group.users[indexPath.row];
        
        BOOL contains = NO;
        
        for (User *tempUser in self.chooseMembers) {
            
            if (tempUser.userId == user.userId) {
                
                contains = YES;
                
                break;
                
            }
            
        }
        
        cell.choosed = contains;
        
        cell.name = user.username;
        
        cell.phone = user.phone;
        
        cell.iconURL = user.iconURL;
        
        return cell;
        
    }else{
        
        ChatChooseMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:searchIdentifier];
        
        User *user = self.searchMembers[indexPath.row];
        
        cell.name = user.username;
        
        cell.iconURL = user.iconURL;
        
        cell.phone = user.phone;
        
        BOOL contains = NO;
        
        for (User *tempUser in self.chooseMembers) {
            
            if (tempUser.userId == user.userId) {
                
                contains = YES;
                
                break;
                
            }
            
        }
        
        cell.choosed = contains;
        
        return cell;
        
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.tableView && indexPath.section==0) {
        
        ChatMemberGymModel *gym = self.info.gyms[indexPath.row];
        
        ChatChooseMemberGroupController *svc = [[ChatChooseMemberGroupController alloc]init];
        
        svc.gym = gym;
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (User *tempUser in self.chooseMembers) {
            
            [array addObject:[tempUser copy]];
            
        }
        
        svc.chooseArray = array;
        
        __weak typeof(self)weakS = self;
        
        svc.chooseFinish = ^(NSArray *members) {
           
            weakS.chooseMembers = [members mutableCopy];
            
            [weakS reloadUI];
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        User *user;
        
        if (tableView == self.tableView) {
            
            UserGroup *group = self.wholeUsers[indexPath.section-1];
            
            user = group.users[indexPath.row];
            
        }else{
            
            user = self.searchMembers[indexPath.row];
            
        }
        
        BOOL contains = NO;
        
        for (User *tempUser in self.chooseMembers) {
            
            if (tempUser.userId == user.userId) {
                
                contains = YES;
                
                [self.chooseMembers removeObject:tempUser];
                
                break;
                
            }
            
        }
        
        if (!contains) {
            
            [self.chooseMembers addObject:user];
            
        }
        
        self.chooseView.chooseNumber = self.chooseMembers.count;
        
        if (self.chooseMembers.count) {
            
            self.chooseView.hidden = NO;
            
            [self.tableView changeHeight:MSH-self.tableView.top-Height(50)];
            
            [self.searchTableView changeHeight:MSH-self.searchTableView.top-Height(50)];
            
        }else{
            
            self.chooseView.hidden = YES;
            
            [self.tableView changeHeight:MSH-self.tableView.top];
            
            [self.searchTableView changeHeight:MSH-self.searchTableView.top];
            
        }
        
        [self.tableView reloadData];
        
        [self.searchTableView reloadData];
        
    }
    
}

-(void)chooseViewConfirm
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if (self.chooseFinish) {
            
            self.chooseFinish(self.chooseMembers);
            
        }
        
    }];
    
}

-(void)naviLeftClick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.view endEditing:YES];
    
    return YES;
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64)];
    
    emptyView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height(180), MSW, Height(24))];
    
    titleLabel.text = @"暂无联系人";
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.font = AllBFont(16);
    
    titleLabel.textColor = UIColorFromRGB(0x333333);
    
    [emptyView addSubview:titleLabel];
    
    UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, titleLabel.bottom+Height(6), MSW, Height(20))];
    
    subLabel.text = @"请先在您的健身房里添加工作人员";
    
    subLabel.textColor = UIColorFromRGB(0x888888);
    
    subLabel.textAlignment = NSTextAlignmentCenter;
    
    subLabel.font = AllFont(13);
    
    [emptyView addSubview:subLabel];
    
    return emptyView;
    
}

@end
