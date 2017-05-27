//
//  ChatListController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/15.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatListController.h"

#import "MOTableView.h"

#import "ChatHeader.h"

#import "RootController.h"

#import "ReplyReceivedController.h"

#import "MessageController.h"

#import "ChatChooseMemberController.h"

#import "StaffUserInfo.h"

static NSString *topIdentifier = @"Top";

static NSString *botIdentifier = @"Bot";

@interface ChatListController ()<MOTableViewDatasource,UITableViewDelegate,UIAlertViewDelegate,TIMMessageListener,TIMUserStatusListener>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)UIButton *addButton;

@property(nonatomic,strong)NSMutableArray *chatArray;

@property(nonatomic,strong)NSMutableArray *systemArray;

@property(nonatomic,assign)NSInteger unReadNumber;

@property(nonatomic,assign)BOOL systemRequesting;

@property(nonatomic,assign)BOOL chatRequesting;

@property(nonatomic,strong)UILabel *emptyLabel;

@property(nonatomic,strong)UILabel *emptyHintLabel;

@end

@implementation ChatListController

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        self.tabTitle = @"消息";
        
        self.unselectImg = [UIImage imageNamed:@"chat_unselect"];
        
        self.selectedImg = [UIImage imageNamed:@"chat_selected"];
        
        self.leftType = MONaviLeftTypeNO;
        
    }
    
    return self;
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    [self reloadData];
    
    [[TIMManager sharedInstance]addMessageListener:self];
    
    [[TIMManager sharedInstance]setUserStatusListener:self];
    
}

-(void)onNewMessage:(NSArray *)msgs
{
    
    [self reloadData];
    
}

-(void)onForceOffline
{
    
    
    
}

-(void)reloadData
{
    
    if (![self isKindOfClass:[ChatListController class]]) {
        
        return;
        
    }
    
    self.addButton.hidden = self.emptyHintLabel.hidden = !UserId;
    
    if (UserId) {
        
        self.emptyLabel.text = @"暂无消息";
        
    }else{
        
        self.emptyLabel.text = @"还没有任何消息";
        
    }
    
    self.unReadNumber = 0;
    
    if (!self.systemRequesting) {
        
        self.systemRequesting = YES;
        
        ChatListInfo *systemInfo = [[ChatListInfo alloc]init];
        
        [systemInfo requestSystemResult:^(BOOL success, NSString *error) {
            
            self.systemRequesting = NO;
            
            self.unReadNumber += systemInfo.unReadNumber;
            
            [UIApplication sharedApplication].applicationIconBadgeNumber = self.unReadNumber;
            
            [[RootController sharedSliderController]setNewNumber:self.unReadNumber atIndex:2];
            
            self.systemArray = systemInfo.systemArray;
            
            self.tableView.dataSuccess = YES;
            
            [self.tableView.mj_header endRefreshing];
            
            [self.tableView reloadData];
            
        }];
        
    }
    
    if (!self.chatRequesting) {
        
        self.chatRequesting = YES;
        
        ChatListInfo *chatInfo = [[ChatListInfo alloc]init];
        
        [chatInfo requestChatResult:^(BOOL success, NSString *error) {
            
            self.chatRequesting = NO;
            
            self.unReadNumber += chatInfo.unReadNumber;
            
            [UIApplication sharedApplication].applicationIconBadgeNumber = self.unReadNumber;
            
            [[RootController sharedSliderController]setNewNumber:self.unReadNumber atIndex:2];
            
            self.chatArray = chatInfo.chatArray;
            
            self.tableView.dataSuccess = YES;
            
            [self.tableView.mj_header endRefreshing];
            
            [self.tableView reloadData];
            
        }];
        
    }
    
}

-(void)createUI
{
    
    self.title = @"消息";
    
    self.rightColor = UIColorFromRGB(0xffffff);
    
    self.rightTitle = @"全部已读";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-49-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[ChatListTopCell class] forCellReuseIdentifier:topIdentifier];
    
    [self.tableView registerClass:[ChatListBotCell class] forCellReuseIdentifier:botIdentifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    self.addButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(74), self.tableView.bottom-Height320(75), Width320(48), Height320(48))];
    
    [self.addButton setImage:[UIImage imageNamed:@"chat_add"] forState:UIControlStateNormal];
    
    self.addButton.layer.shadowOffset = CGSizeMake(0, Height320(2));
    
    self.addButton.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
    
    self.addButton.layer.shadowOpacity = 0.3;
    
    [self.view addSubview:self.addButton];
    
    [self.addButton addTarget:self action:@selector(chatAdd:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height(15);
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(15))];
    
    return header;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.systemArray.count?self.chatArray.count?2:1:self.chatArray.count?1:0;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.systemArray.count && section == 0) {
        
        return self.systemArray.count;
        
    }else{
        
        return self.chatArray.count;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height(68);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.systemArray.count && indexPath.section == 0) {
        
        ChatListTopCell *cell = [tableView dequeueReusableCellWithIdentifier:topIdentifier];
        
        ChatListModel *model = self.systemArray[indexPath.row];
        
        cell.type = model.type;
        
        cell.content = model.content;
        
        if (model.shopName) {
            
            cell.shopName = model.shopName;
            
        }
        
        cell.time = model.time;
        
        cell.unRead = model.unreadCount;
        
        cell.topLine = indexPath.row == 0;
        
        cell.botLine = indexPath.row==self.systemArray.count-1;
        
        cell.editing = NO;
        
        return cell;
        
    }else{
        
        ChatListBotCell *cell = [tableView dequeueReusableCellWithIdentifier:botIdentifier];
        
        ChatListModel *model = self.chatArray[indexPath.row];
        
        if (model.type == ChatListModelTypeChatSingle) {
            
            cell.iconURL = model.user.iconURL;
            
            cell.title = model.user.username;
            
        }else{
            
            cell.iconURL = [NSURL URLWithString:model.group.iconURL];
            
            cell.title = model.group.name;
            
        }
        
        cell.content = model.content;
        
        cell.time = model.time;
        
        cell.unRead = model.unreadCount;
        
        cell.topLine = indexPath.row == 0;
        
        cell.botLine = indexPath.row==self.chatArray.count-1;
        
        cell.editing = NO;
        
        return cell;
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.systemArray.count && indexPath.section == 0) {
        
        ChatListModel *model = self.systemArray[indexPath.row];
        
        if (model.type != ChatListModelTypeReply) {
            
            MessageController *vc = [[MessageController alloc]init];
            
            vc.type = (long)model.type;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            ReplyReceivedController *vc = [[ReplyReceivedController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            MessageInfo *info = [[MessageInfo alloc]init];
            
            info.type = MessageInfoTypeReply;
            
            [info readAllMessageResult:^(BOOL success, NSString *error) {
                
                [self reloadData];
                
            }];
            
        }
        
    }else{
        
        ChatController *svc = [[ChatController alloc]init];
        
        ChatListModel *model = self.chatArray[indexPath.row];
        
        svc.chatListModel = model;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

-(void)chatAdd:(UIButton*)button
{
    
    ChatChooseMemberController *vc = [[ChatChooseMemberController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    vc.chooseFinish = ^(NSArray *members) {
        
        ChatListInfo *info = [[ChatListInfo alloc]init];
        
        [info createChatWithUsers:members result:^(BOOL success, NSString *error,NSArray*users) {
           
            if (success) {
                
                ChatController *vc = [[ChatController alloc]init];
                
                ChatListModel *model = [[ChatListModel alloc]init];
                
                if (users.count == 1) {
                    
                    model.user = [users firstObject];
                    
                    model.type = ChatListModelTypeChatSingle;
                    
                    model.identifier = info.chatId;
                    
                }else{
                    
                    model.group = info.group;
                    
                    model.type = ChatListModelTypeChatGroup;
                    
                    model.identifier = info.group.groupId;
                    
                }
                
                vc.chatListModel = model;
                
                [weakS.navigationController pushViewController:vc animated:YES];
                
            }
            
        }];
        
    };
    
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:vc] animated:YES completion:nil];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    
    return @"  删 除  ";
    
}

-(NSArray*)tableView:(UITableView* )tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=8.0) {
        
        UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"  删 除  " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            
            if (indexPath.section == 0 && self.systemArray.count) {
                
                ChatListModel *model = self.systemArray[indexPath.row];
                
                [ChatListInfo setDeleteModelIdWithType:model.type andNotificationId:model.notificationId];
                
                MessageInfo *info = [[MessageInfo alloc]init];
                
                info.type = (long)model.type;
                
                [info readAllMessageResult:^(BOOL success, NSString *error) {
                    
                    [self reloadData];
                    
                }];
                
                [self.systemArray removeObjectAtIndex:indexPath.row];
                
                [self.tableView reloadData];
                
            }else{
                
                ChatListModel *model = self.chatArray[indexPath.row];
                
                [model.conversation setReadMessage];
                
                [[TIMManager sharedInstance]deleteConversationAndMessages:model.conversation.getType receiver:model.conversation.getReceiver];
                
                [self.chatArray removeObjectAtIndex:indexPath.row];
                
                [self.tableView reloadData];
                
                [self reloadData];
                
            }
            
        }];
        
        editRowAction.backgroundColor = UIColorFromRGB(0xea6161);
        
        return @[editRowAction];
        
    }else{
        
        return nil;
        
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (indexPath.section == 0 && self.systemArray.count) {
            
            ChatListModel *model = self.systemArray[indexPath.row];
            
            MessageInfo *info = [[MessageInfo alloc]init];
            
            info.type = (long)model.type;
            
            [info readAllMessageResult:^(BOOL success, NSString *error) {
                
                [self reloadData];
                
            }];
            
            [ChatListInfo setDeleteModelIdWithType:model.type andNotificationId:model.notificationId];
            
            [self.systemArray removeObjectAtIndex:indexPath.row];
            
            [self.tableView reloadData];
            
        }else{
            
            ChatListModel *model = self.chatArray[indexPath.row];
            
            [model.conversation setReadMessage];
            
            [[TIMManager sharedInstance]deleteConversationAndMessages:model.type == ChatListModelTypeChatSingle?TIM_C2C:TIM_GROUP receiver:model.conversation.getReceiver];
            
            [self.chatArray removeObjectAtIndex:indexPath.row];
            
            [self.tableView reloadData];
            
            [self reloadData];
            
        }
    }
    
}

-(void)naviRightClick
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"全部标为已读？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        ChatListInfo *info = [[ChatListInfo alloc]init];
        
        [info readAllResult:^(BOOL success, NSString *error) {
            
            if (success) {
                
                [[RootController sharedSliderController]setNewNumber:0 atIndex:2];
                
                [self reloadData];
                
            }
            
        }];
        
    }
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64-44)];
    
    emptyView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width(83), Height(110), Width(209), Height(168))];
    
    emptyImg.image = [UIImage imageNamed:@"chat_list_empty"];
    
    [emptyView addSubview:emptyImg];
    
    self.emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height(20), MSW, Height(24))];
    
    self.emptyLabel.font = AllBFont(16);
    
    if (UserId) {
        
        self.emptyLabel.text = @"暂无消息";
        
    }else{
        
        self.emptyLabel.text = @"还没有任何消息";
        
    }
    
    self.emptyLabel.textColor = UIColorFromRGB(0x333333);
    
    self.emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    [emptyView addSubview:self.emptyLabel];
    
    self.emptyHintLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.emptyLabel.bottom+Height(10), MSW, Height(20))];
    
    self.emptyHintLabel.text = @"您可以点击右下角按钮发起会话";
    
    self.emptyHintLabel.textColor = UIColorFromRGB(0x888888);
    
    self.emptyHintLabel.textAlignment = NSTextAlignmentCenter;
    
    self.emptyHintLabel.font = AllFont(13);
    
    [emptyView addSubview:self.emptyHintLabel];
    
    self.emptyHintLabel.hidden = !UserId;
    
    return emptyView;
    
}

-(void)dealloc
{
    
}

@end
