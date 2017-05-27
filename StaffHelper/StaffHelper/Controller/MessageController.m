//
//  MessageController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MessageController.h"

#import "ChooseView.h"

#import "MessageCell.h"

#import "CheckinController.h"

#import "RootController.h"

#import "GymDetailController.h"

#import "CheckinHistoryController.h"

#import "WebViewController.h"

#import "MOTableView.h"

#import "YFModuleManager.h"

#import "CardDetailController.h"

#import "GymDetailInfo.h"

static NSString *identifier = @"Cell";

@interface MessageController ()<UITableViewDelegate,MOTableViewDatasource,UIAlertViewDelegate>

@property(nonatomic,strong)MessageInfo *info;

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)Gym *tempGym;

@end

@implementation MessageController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        MOAppDelegate.gymBlock = NO;
                
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    [[RootController sharedSliderController]reloadMessageData];
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    self.info = [[MessageInfo alloc]init];
    
    self.info.type = self.type;
    
    [self.info requestResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView.mj_footer endRefreshing];
        
        if (self.type == MessageInfoTypeCheckin) {
            
            NSMutableArray *messages = [NSMutableArray array];
            
            for (Message *message in self.info.messages) {
                
                if (message.type == MessageTypeCheckin||message.type == MessageTypeCheckout){
                    
                    if (!message.readed) {
                        
                        [messages addObject:[NSNumber numberWithInteger:message.msgId]];
                        
                    }
                    
                }
            }
            
            if (messages.count) {
                
                MessageInfo *tempInfo = [[MessageInfo alloc]init];
                
                [tempInfo readMessages:messages result:^(BOOL success, NSString *error) {
                    
                    [[RootController sharedSliderController]reloadMessageData];
                    
                }];
                
            }
            
        }
        
    }];
    
}

-(void)updateData
{
    
    [self.info requestResult:^(BOOL success, NSString *error) {
        
        if (success && [error isEqualToString:@"无更多数据"]) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [self.tableView.mj_footer endRefreshing];
            
        }
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    }];
    
}

-(void)createUI
{
    
    switch (self.type) {
            
        case MessageInfoTypeGym:
            
            self.title = @"场馆信息";
            
            break;
            
        case MessageInfoTypeSystem:
            
            self.title = @"系统通知";
            
            break;
            
        case MessageInfoTypeStudy:
            
            self.title = @"学习培训";
            
            break;
            
        case MessageInfoTypeCheckin:
            
            self.title = @"签到处理";
            
            break;
            
        case MessageInfoTypeMatch:
            
            self.title = @"赛事训练营";
            
            break;
            
        default:
            break;
    }
    
    self.rightTitle = @"全部已读";
    
    self.rightColor = UIColorFromRGB(0xffffff);
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain ];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[MessageCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
    
    [footer setTitle:@"无更多数据" forState:MJRefreshStateNoMoreData];
    
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    
    self.tableView.mj_footer = footer;
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.messages.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Message *msg = nil;
    
    msg = self.info.messages[indexPath.row];
    
    cell.haveRead = msg.readed;
    
    cell.iconURL = msg.imgUrl;
    
    cell.title = msg.title;
    
    cell.descriptions = msg.content;
    
    cell.time = msg.time;
    
    cell.gymName = msg.gym.name;
    
    if (msg.type == MessageTypeChangeSeller || msg.type == MessageTypeWithoutSeller || msg.type == MessageTypeCardNoSufficient || msg.type == MessageTypeChangeCoach) {
        cell.haveArrow = YES;
    }else
    {
        cell.haveArrow = msg.url.absoluteString.length;
    }
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Message *msg = self.info.messages[indexPath.row];
    
    CGSize size = [msg.content boundingRectWithSize:CGSizeMake(Width320(225), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    return size.height+Height320(65);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row>=self.info.messages.count) {
        
        return;
        
    }
    
    Message *msg = self.info.messages[indexPath.row];
    
    MessageInfo *info = [[MessageInfo alloc]init];
    
    [info readMessage:msg result:^(BOOL success, NSString *error) {
        
        if (success) {
            
            if (!msg.readed) {
                
                self.info.unReadCount --;
                
            }
            
            msg.readed = YES;
            
            [tableView reloadData];
            
            [[RootController sharedSliderController]reloadMessageData];
            
        }
        
    }];
    
    if (msg.type == MessageTypeCheckinConfirm || msg.type == MessageTypeCheckoutConfirm) {
        
        if (![AppGym isEqualToGym:msg.gym] && AppGym) {
            
            self.tempGym = [AppGym copy];
            
        }
        
        AppGym = msg.gym;
        
        MOViewController *gymListVc = nil;
        
        if (![self.navigationController.viewControllers.firstObject isKindOfClass:[GymDetailController class]]) {
            
            for (MOViewController *tempVc in self.navigationController.viewControllers) {
                
                if ([tempVc isKindOfClass:[GymDetailController class]]) {
                    
                    NSInteger index = [self.navigationController.viewControllers indexOfObject:tempVc];
                    
                    if (index-1>=0) {
                        
                        gymListVc = (MOViewController*)self.navigationController.viewControllers[index-1];
                        
                        break;
                        
                    }
                    
                }
                
            }
            
        }
        
        [[PermissionInfo sharedInfo] requestWithGym:AppGym result:^(BOOL success, NSString *error) {
            
            CheckinController *svc = [[CheckinController alloc]init];
            
            svc.gym = msg.gym;
            
            if (msg.type == MessageTypeCheckoutConfirm){
                
                svc.shouldCheckout = YES;
                
            }
            
            if (!gymListVc) {
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }else{
                
                [self.navigationController popToViewController:gymListVc animated:NO];
                
                UINavigationController *currentVc = ((UINavigationController*)[((AppDelegate*)[UIApplication sharedApplication].delegate)getCurrentVC]);
                
                GymDetailController *gymVc = [[GymDetailController alloc]init];
                
                gymVc.gym = AppGym;
                
                [currentVc pushViewController:gymVc animated:NO];
                
                UINavigationController *currentVc1 = ((UINavigationController*)[((AppDelegate*)[UIApplication sharedApplication].delegate)getCurrentVC]);
                
                [currentVc1 pushViewController:svc animated:YES];
                
            }
            
        }];
        
    }else if (msg.type == MessageTypeCheckin || msg.type == MessageTypeCheckout){
        
        if (![AppGym isEqualToGym:msg.gym] && AppGym) {
            
            self.tempGym = [AppGym copy];
            
        }
        
        AppGym = msg.gym;
        
        MOViewController *gymListVc = nil;
        
        for (MOViewController *tempVc in self.navigationController.viewControllers) {
            
            if ([tempVc isKindOfClass:[GymDetailController class]]) {
                
                if ([self.navigationController.viewControllers indexOfObject:tempVc]) {
                    
                    gymListVc = (MOViewController*)self.navigationController.viewControllers[[self.navigationController.viewControllers indexOfObject:tempVc]-1];
                    
                    break;
                    
                }
                
            }
            
        }
        
        [[PermissionInfo sharedInfo] requestWithGym:AppGym result:^(BOOL success, NSString *error) {
            
            CheckinHistoryController *svc = [[CheckinHistoryController alloc]init];
            
            if (!gymListVc) {
                
                [self.navigationController pushViewController:svc animated:YES];
                
            }else{
                
                [self.navigationController popToViewController:gymListVc animated:NO];
                
                UINavigationController *currentVc = ((UINavigationController*)[((AppDelegate*)[UIApplication sharedApplication].delegate)getCurrentVC]);
                
                GymDetailController *gymVc = [[GymDetailController alloc]init];
                
                gymVc.gym = AppGym;
                
                [currentVc pushViewController:gymVc animated:NO];
                
                UINavigationController *currentVc1 = ((UINavigationController*)[((AppDelegate*)[UIApplication sharedApplication].delegate)getCurrentVC]);
                
                [currentVc1 pushViewController:svc animated:YES];
                
            }
            
        }];
        
    }else if (msg.type == MessageTypeChangeSeller || msg.type == MessageTypeChangeCoach)// 变更销售，给销售人员发送
    {
        
        if (![AppGym isEqualToGym:msg.gym] && AppGym) {
            
            self.tempGym = [AppGym copy];
            
        }
        
        AppGym = msg.gym;

        [[PermissionInfo sharedInfo] requestWithGym:AppGym result:^(BOOL success, NSString *error) {
            // 记录message，等权限 请求成功，再去, 会员模块
            if ([PermissionInfo sharedInfo].gym.permissions.userPermission.readState || [PermissionInfo sharedInfo].gym.permissions.personalUserPermission.readState) {
                
                GymDetailInfo *gymInfo = [[GymDetailInfo alloc]init];
                
                [gymInfo requestWithGym:AppGym result:^(BOOL success, NSString *error, NSInteger errorCode) {
                    
                    UIViewController *studentVC = [YFModuleManager memberFollowUpWithGym:AppGym dicArray:nil actionBlock:nil];
                    
                    [self.navigationController pushViewController:studentVC animated:YES];
                    
                }];
                
            }else{
                [self showNoPermissionAlert];
            }

        }];
    }else if  (msg.type == MessageTypeWithoutSeller)// 每天八点 推送 未分配销售的人员
    {
        
        if (![AppGym isEqualToGym:msg.gym] && AppGym) {
            
            self.tempGym = [AppGym copy];
            
        }
        
        AppGym = msg.gym;

        [[PermissionInfo sharedInfo] requestWithGym:AppGym result:^(BOOL success, NSString *error) {
           
            GymDetailInfo *gymInfo = [[GymDetailInfo alloc]init];
            
            [gymInfo requestWithGym:AppGym result:^(BOOL success, NSString *error, NSInteger errorCode) {
                
                Seller *seller = [[Seller alloc] init];
                seller.type = SellerTypeNone;
                [self.navigationController pushViewController:[YFModuleManager belongSellerViewControllerWith:seller gym:AppGym] animated:YES];
            }];
            
         }];

    }else if (msg.type == MessageTypeCardNoSufficient)
    {
        
        if (![AppGym isEqualToGym:msg.gym] && AppGym) {
            
            self.tempGym = [AppGym copy];
            
        }
        
        AppGym = msg.gym;

        CardDetailController *svc = [[CardDetailController alloc]init];
        
        svc.card = [[Card alloc] init];
        
        svc.card.cardId = [msg.cardId  integerValueYF];
        
        svc.gym = AppGym;
        
        [self.navigationController pushViewController:svc animated:YES];
    }

    else if (msg.url.absoluteString.length){
        
        WebViewController *svc = [[WebViewController alloc]init];
        
        svc.url = msg.url;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    emptyView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(73), Height320(107), Width320(174), Height320(146))];
    
    emptyImg.image = [UIImage imageNamed:@"message_empty"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(10), emptyImg.bottom+Height320(15), emptyView.width-Width320(20), Height320(15))];
    
    emptyLabel.text = @"暂无通知";
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(13);
    
    [emptyView addSubview:emptyLabel];
    
    return emptyView;
    
}

-(void)naviRightClick
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"全部标为已读？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        MessageInfo *info = [[MessageInfo alloc]init];
        
        info.type = self.type;
        
        [info readAllMessageResult:^(BOOL success, NSString *error) {
            
            if (success) {
                
                [self reloadData];
                
                [[RootController sharedSliderController]reloadMessageData];
                
            }
            
        }];
        
    }
    
}

-(void)dealloc
{
    
    self.tableView.mj_header = nil;
    
    self.tableView.mj_footer = nil;
    
    if (self.tempGym && !MOAppDelegate.gymBlock) {
        
        AppGym = self.tempGym;
        
        [[PermissionInfo sharedInfo]requestWithGym:AppGym result:^(BOOL success, NSString *error) {
            
            GymDetailInfo *gymInfo = [[GymDetailInfo alloc]init];
            
            [gymInfo requestWithGym:AppGym result:^(BOOL success, NSString *error, NSInteger errorCode) {
                
            }];
            
        }];
        
    }
    
}

@end
