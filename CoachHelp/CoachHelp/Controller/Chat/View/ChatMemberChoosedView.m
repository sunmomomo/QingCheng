//
//  ChatMemberChoosedView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/31.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatMemberChoosedView.h"

#import "ChatChoosedCell.h"

#import "User.h"

static NSString *identifier = @"Cell";

@interface ChatMemberChoosedView ()<UITableViewDelegate,UITableViewDataSource,ChatChoosedCellDelegate>

@property(nonatomic,strong)MembersChanged memberChanged;

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ChatMemberChoosedView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
        
        backView.backgroundColor = [UIColorFromRGB(0x000000)colorWithAlphaComponent:0.4];
        
        [self addSubview:backView];
        
        [backView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)]];
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, MSH, MSW, Height(200))];
        
        self.tableView.dataSource = self;
        
        self.tableView.delegate = self;
        
        [self.tableView registerClass:[ChatChoosedCell class] forCellReuseIdentifier:identifier];
        
        self.tableView.tableFooterView = [UIView new];
        
        [self addSubview:self.tableView];
        
    }
    
    return self;
    
}

-(void)setMembers:(NSMutableArray *)members
{
    
    _members = members;
    
    [self.tableView reloadData];
    
    NSInteger height = _members.count*Height(78)+Height(30);
    
    [self.tableView changeHeight:MIN(height, Height(450))];
    
    if (!self.hidden) {
        
        [self.tableView changeTop:MSH-self.tableView.height];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.members.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height(30);
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(30))];
    
    header.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), 0, Width(200), Height(30))];
    
    label.text = [NSString stringWithFormat:@"已选择%ld名联系人",(unsigned long)self.members.count];
    
    label.textColor = UIColorFromRGB(0x888888);
    
    label.font = AllFont(12);
    
    [header addSubview:label];
    
    return header;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height(78);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChatChoosedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    User *user = self.members[indexPath.row];
    
    cell.name = user.username;
    
    cell.phone = user.phone;
    
    cell.iconURL = user.iconURL;
    
    cell.tag = indexPath.row;
    
    cell.delegate = self;
    
    return cell;
    
}

-(void)deleteWithChatChoosedCell:(ChatChoosedCell *)cell
{
    
    User *user = self.members[cell.tag];
    
    for (User *tempUser in self.members) {
        
        if (user.userId == tempUser.userId) {
            
            [self.members removeObjectAtIndex:[self.members indexOfObject:tempUser]];
            
            break;
            
        }
        
    }
    
    [self.tableView reloadData];
    
    self.memberChanged(self.members);
    
    if (self.members.count <= 0) {
        
        [self close];
        
    }
    
}

-(void)show
{
    
    self.hidden = NO;
    
    [self.superview bringSubviewToFront:self];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        [self.tableView changeTop:MSH-self.tableView.height];
        
    }];
    
}

-(void)close
{
    
    [UIView animateWithDuration:0.3f animations:^{
        
        [self.tableView changeTop:MSH];
        
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
        
    }];
    
}

-(void)setMembersChanged:(MembersChanged)block
{
    
    self.memberChanged = block;
    
}

@end
