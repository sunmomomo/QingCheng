//
//  ChatChooseMemberGroupController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatChooseMemberGroupController.h"

#import "MOTableView.h"

#import "ChatHeader.h"

static NSString *identifier = @"Cell";

@interface ChatChooseMemberGroupController ()<MOTableViewDatasource,UITableViewDelegate,ChatChooseViewDelegate,ChooseMemberGroupHeaderDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSArray *groups;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *numberLabel;

@property(nonatomic,strong)ChatChooseView *chooseView;

@property(nonatomic,strong)UITableView *chooseTableView;

@property(nonatomic,strong)ChatMemberChoosedView *memberChoosedView;

@end

@implementation ChatChooseMemberGroupController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    self.tableView.dataSuccess = YES;
    
}

-(void)reloadUI
{
    
    [self.tableView reloadData];
    
    self.chooseView.chooseNumber = self.chooseArray.count;
    
    if (self.chooseArray.count) {
        
        self.chooseView.hidden = NO;
        
        [self.tableView changeHeight:self.chooseView.top-self.tableView.top];
        
    }else{
        
        self.chooseView.hidden = YES;
        
        [self.tableView changeHeight:MSH-self.tableView.top];
        
    }
    
}

-(void)createUI
{
    
    self.title = @"选择联系人";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.leftTitle = @"返回";
    
    self.leftColor = UIColorFromRGB(0xffffff);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height(78))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = OnePX;
    
    [self.view addSubview:topView];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width(15), Height(15), Width(48), Height(48))];
    
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:self.gym.iconURL]];
    
    [topView addSubview:self.iconView];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconView.right+Width(15), Height(18), MSW-Width(30)-self.iconView.right, Height(21))];
    
    self.nameLabel.textColor = UIColorFromRGB(0x333333);
    
    self.nameLabel.font = AllFont(14);
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ | %@",self.gym.gymName,self.gym.brandName];
    
    [topView addSubview:self.nameLabel];
    
    self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom+Height(3), self.nameLabel.width, Height(18))];
    
    self.numberLabel.textColor = UIColorFromRGB(0x888888);
    
    self.numberLabel.font = AllFont(12);
    
    self.numberLabel.text = [NSString stringWithFormat:@"%ld人",(long)self.gym.userCount];
    
    [topView addSubview:self.numberLabel];
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height(12), MSW, MSH-topView.bottom-Height(12)) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[ChatChooseMemberGroupCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    self.chooseView = [[ChatChooseView alloc]initWithFrame:CGRectMake(0, MSH-Height(50), MSW, Height(50))];
    
    self.chooseView.layer.shadowOffset = CGSizeMake(0, -2);
    
    self.chooseView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
    
    self.chooseView.layer.shadowOpacity = 0.06;
    
    self.chooseView.delegate = self;
    
    [self.view addSubview:self.chooseView];
    
    self.chooseView.hidden = YES;
    
    self.memberChoosedView = [[ChatMemberChoosedView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    __weak typeof(self)weakS = self;
    
    [self.memberChoosedView setMembersChanged:^(NSMutableArray *array) {
        
        weakS.chooseArray = array;
        
        [weakS reloadUI];
        
    }];
    
    [self.view addSubview:self.memberChoosedView];
    
    self.memberChoosedView.hidden = YES;
    
    [self reloadUI];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.gym.positions.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    ChatMemberGroupModel *group = self.gym.positions[section];
    
    return group.showing?group.users.count:0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height(50);
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    ChooseMemberGroupHeader *header = [[ChooseMemberGroupHeader alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(50))];
    
    header.backgroundColor = UIColorFromRGB(0xffffff);
    
    ChatMemberGroupModel *group = self.gym.positions[section];
    
    header.title = [NSString stringWithFormat:@"%@（%ld人）",group.position,(unsigned long)group.users.count];
    
    NSInteger containNumber = 0;
    
    for (User *tempUser in group.users) {
        
        BOOL contains = NO;
        
        for (User *chooseUser in self.chooseArray) {
            
            if (chooseUser.userId == tempUser.userId) {
                
                contains = YES;
                
                break;
                
            }
            
        }
        
        if (contains) {
            
            containNumber ++;
            
        }
        
    }
    
    if (section == 0) {
        
        header.noTopLine = NO;
        
    }else{
        
        ChatMemberGroupModel *lastGroup = self.gym.positions[section-1];
        
        header.noTopLine = !lastGroup.showing;
        
    }
    
    header.type = containNumber == group.users.count?ChooseMemberGroupHeaderChooseTypeAll:containNumber == 0?ChooseMemberGroupHeaderChooseTypeNone:ChooseMemberGroupHeaderChooseTypePart;
    
    header.showing = group.showing;
    
    header.tag = section;
    
    header.delegate = self;
    
    return header;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height(68);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChatChooseMemberGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    ChatMemberGroupModel *group = self.gym.positions[indexPath.section];
    
    User *user = group.users[indexPath.row];
    
    BOOL contains = NO;
    
    for (User *tempUser in self.chooseArray) {
        
        if (tempUser.userId == user.userId) {
            
            contains = YES;
            
            break;
            
        }
        
    }
    
    cell.choosed = contains;
    
    cell.iconURL = user.iconURL;
    
    cell.name = user.username;
    
    cell.phone = user.phone;
    
    cell.noline = indexPath.row == group.users.count-1;
    
    NSMutableArray *positions = [NSMutableArray array];
    
    for (GymPosition *position in user.positions) {
        
        if (position.gymId == self.gym.gymId) {
            
            [positions addObject:position.name];
            
        }
        
    }
    
    NSString *positionStr = [positions componentsJoinedByString:@"，"];
    
    cell.position = positionStr;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    User *user = ((ChatMemberGroupModel*)self.gym.positions[indexPath.section]).users[indexPath.row];
    
    BOOL contains = NO;
    
    for (User *tempUser in self.chooseArray) {
        
        if (tempUser.userId == user.userId) {
            
            [self.chooseArray removeObject:tempUser];
            
            contains = YES;
            
            break;
            
        }
        
    }
    
    if (!contains) {
        
        [self.chooseArray addObject:user];
        
    }
    
    [self reloadUI];
    
}

-(void)groupHeaderShow:(ChooseMemberGroupHeader *)header
{
    
    ChatMemberGroupModel *group = self.gym.positions[header.tag];
    
    group.showing = !group.showing;
    
    [self.tableView reloadData];
    
}

-(void)groupHeaderChoosed:(ChooseMemberGroupHeader *)header
{
    
    ChatMemberGroupModel *group = self.gym.positions[header.tag];
    
    BOOL contains = NO;
    
    for (User *user in group.users) {
        
        for (User *chooseUser in self.chooseArray) {
            
            if (chooseUser.userId == user.userId) {
                
                contains = YES;
                
                break;
                
            }
            
            if (contains) {
                
                break;
                
            }
            
        }
        
    }
    
    if (contains) {
        
        for (User *user in group.users) {
            
            for (User *chooseUser in self.chooseArray) {
                
                if (chooseUser.userId == user.userId) {
                    
                    [self.chooseArray removeObject:chooseUser];
                    
                    break;
                    
                }
                
            }
            
        }
        
    }else{
        
        for (User *user in group.users) {
            
            BOOL contains = NO;
            
            for (User *chooseUser in self.chooseArray) {
                
                if (chooseUser.userId == user.userId) {
                    
                    contains = YES;
                    
                    break;
                    
                }
                
            }
            
            if (!contains) {
                
                [self.chooseArray addObject:user];
                
            }
            
        }
        
    }
    
    [self reloadUI];
    
}

-(void)showChooseView
{
    
    self.memberChoosedView.members = self.chooseArray;
    
    [self.memberChoosedView show];
    
}

-(void)naviLeftClick
{
    
    [self chooseViewConfirm];
    
}

-(void)chooseViewConfirm
{
    
    if (self.chooseFinish) {
        
        self.chooseFinish(self.chooseArray);
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
