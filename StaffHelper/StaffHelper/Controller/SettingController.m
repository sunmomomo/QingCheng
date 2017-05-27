//
//  SettingController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/15.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SettingController.h"

#import "ChangePasswordController.h"

#import "ChangePhoneController.h"

#import "ChangeInfoController.h"

#import "StaffUserInfo.h"

#import "LoginController.h"

#import "AboutController.h"

#import "SuggestController.h"

#import "ShareActionSheet.h"

#import "RootController.h"

#import "ServicesInfo.h"

#import "CheckUpdateInfo.h"

#import "SendMessageController.h"

#import "BrandManagerController.h"

#import "MessageController.h"

#import "CheckinNotificationController.h"

#import "BPush.h"

#import "GuideCreateBrandController.h"

#import "YFMesNotiSettingVC.h"

#import "MOTableView.h"

#import "ChatHeader.h"

static NSString *identifier = @"Cell";

@interface SettingController ()<UITableViewDelegate,MOTableViewDatasource,UIAlertViewDelegate,ShareActionSheetDelegate>

@property(nonatomic,strong)StaffUserInfo *userInfo;

@property(nonatomic,strong)UIView *shareView;

@property(nonatomic,copy)NSURL *updateURL;

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSArray *titleArray;

@end

@implementation SettingController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabTitle = @"我";
        
        self.unselectImg = [UIImage imageNamed:@"my_unselect"];
        
        self.selectedImg = [UIImage imageNamed:@"my_selected"];
        
        BOOL local = [[NSUserDefaults standardUserDefaults]boolForKey:@"localServer"];
        
        self.titleArray = AppDebug?@[@[@"修改密码",@"修改手机号"],@[@"消息推送设置"],@[@"关于我们",@"意见反馈",@"分享给朋友",@"网页端地址",local?@"切换至Cloudtest":@"切换至Dev",@"创建健身房"]]:@[@[@"修改密码",@"修改手机号"],@[@"消息推送设置"],@[@"关于我们",@"意见反馈",@"分享给朋友",@"网页端地址"]];
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    
}

-(void)createData
{
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    BOOL local = [[NSUserDefaults standardUserDefaults]boolForKey:@"localServer"];
    
    StaffUserInfo *info = [[StaffUserInfo alloc]init];
    
    [info requestResult:^(BOOL success, NSString *error) {
        
        [self.tableView.mj_header endRefreshing];
        
        if (success) {
            
            self.userInfo = info;
            
        }
        
        self.tableView.dataSuccess = YES;
        
        if (self.userInfo.staff) {
            
            self.titleArray = AppDebug?@[@[@"修改密码",@"修改手机号"],@[@"消息推送设置"],@[@"关于我们",@"意见反馈",@"分享给朋友",@"网页端地址",local?@"切换至Cloudtest":@"切换至Dev",@"创建健身房"]]:@[@[@"修改密码",@"修改手机号"],@[@"消息推送设置"],@[@"关于我们",@"意见反馈",@"分享给朋友",@"网页端地址"]];
            
        }else{
            
            self.titleArray = AppDebug?@[@[@"关于我们",@"意见反馈",@"分享给朋友",@"网页端地址",local?@"切换至Cloudtest":@"切换至Dev",@"创建健身房"]]:@[@[@"关于我们",@"意见反馈",@"分享给朋友",@"网页端地址"]];
            
        }
        
        [self.tableView reloadData];
        
        [self reloadHeader];
        
    }];
    
}

-(void)reloadHeader
{
    
    if (self.userInfo.staff) {
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(86))];
        
        headerView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UIButton *topView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(86))];
        
        topView.backgroundColor = UIColorFromRGB(0xffffff);
        
        topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        [topView addTarget:self action:@selector(topClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [headerView addSubview:topView];
        
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(53), Height320(54))];
        
        icon.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        icon.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        icon.layer.cornerRadius = icon.width/2;
        
        icon.layer.masksToBounds = YES;
        
        [topView addSubview:icon];
        
        if (self.userInfo.staff.iconUrl.absoluteString) {
            
            if ([self.userInfo.staff.iconUrl.absoluteString rangeOfString:@"!"].length) {
                
                [icon sd_setImageWithURL:[NSURL URLWithString:self.userInfo.staff.iconUrl.absoluteString]];
                
            }else{
                
                if ([self.userInfo.staff.iconUrl.absoluteString rangeOfString:@"!/watermark/"].length) {
                    
                    [icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@!small/watermark/%@",[[self.userInfo.staff.iconUrl.absoluteString componentsSeparatedByString:@"!/watermark/"]firstObject],[[self.userInfo.staff.iconUrl.absoluteString componentsSeparatedByString:@"!/watermark/"]lastObject]]]];
                    
                }else if ([self.userInfo.staff.iconUrl.absoluteString rangeOfString:@"/watermark/"].length){
                    
                    [icon sd_setImageWithURL:[NSURL URLWithString:self.userInfo.staff.iconUrl.absoluteString]];
                    
                }else{
                    
                    [icon sd_setImageWithURL:[NSURL URLWithString:[self.userInfo.staff.iconUrl.absoluteString stringByAppendingString:@"!small"]]];
                    
                }
                
            }
            
        }
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(icon.right+Width320(10), topView.height/2-Height320(9), Width320(200), Height320(18))];
        
        nameLabel.text = self.userInfo.staff.name;
        
        nameLabel.textColor = UIColorFromRGB(0x333333);
        
        nameLabel.font = AllFont(13);
        
        [topView addSubview:nameLabel];
        
        UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23.4), topView.height/2-Height320(6), Width320(7.4), Height320(12))];
        
        arrow.image = [UIImage imageNamed:@"gray_arrow"];
        
        [topView addSubview:arrow];
        
        self.tableView.tableHeaderView = headerView;
        
    }else{
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(116))];
        
        headerView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(116))];
        
        topView.backgroundColor = UIColorFromRGB(0xffffff);
        
        [headerView addSubview:topView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(12), MSW, Height320(36))];
        
        label.text = @"登录您的青橙账号\n使用健身房管理等更多功能";
        
        label.textColor = UIColorFromRGB(0x888888);
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.numberOfLines = 0;
        
        label.font = AllFont(13);
        
        [topView addSubview:label];
        
        UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), label.bottom+Height320(12), MSW-Width320(32), Height320(38))];
        
        loginButton.layer.cornerRadius = 2;
        
        loginButton.layer.borderColor = kMainColor.CGColor;
        
        loginButton.layer.borderWidth = OnePX;
        
        [loginButton setTitle:@"注册或登录" forState:UIControlStateNormal];
        
        [loginButton setTitleColor:kMainColor forState:UIControlStateNormal];
        
        loginButton.titleLabel.font = AllFont(16);
        
        [topView addSubview:loginButton];
        
        [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        
        self.tableView.tableHeaderView = headerView;
        
    }
    
    self.tableView.tableFooterView.hidden = self.userInfo.staff?NO:YES;
    
}

-(void)login
{
    
    LoginController *vc = [[LoginController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)createUI
{
    
    if (self.oneGym) {
        
        self.leftType = MONaviLeftTypeBack;
        
    }else{
        
        self.leftType = MONaviLeftTypeNO;
        
    }
    
    if (!self.oneGym) {
        
        self.rightNum = self.rightNum;
        
    }
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, self.oneGym?MSH-64:MSH-64-49) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, Width320(16), 0, Width320(16));
    
    [self.view addSubview:self.tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    UIView *tableFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(87))];
    
    self.tableView.tableFooterView = tableFooter;
    
    UIButton *quitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, Height320(12), MSW, Height320(40))];
    
    quitButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    quitButton.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    quitButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    [quitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    
    [quitButton setTitleColor:UIColorFromRGB(0xea6161) forState:UIControlStateNormal];
    
    quitButton.titleLabel.font = AllFont(14);
    
    [tableFooter addSubview:quitButton];
    
    [quitButton addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, quitButton.bottom+Height320(15), MSW, Height320(15))];
    
    versionLabel.text = [NSString stringWithFormat:@"v%@",VERSION];
    
    versionLabel.textColor = UIColorFromRGB(0x666666);
    
    versionLabel.font = STFont(12);
    
    versionLabel.textAlignment = NSTextAlignmentCenter;
    
    [tableFooter addSubview:versionLabel];
    
    self.shareView = [[UIView alloc]initWithFrame:CGRectMake(MSW/2-Width320(67), Height320(230), Width320(134), Height320(93))];
    
    self.shareView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.45];
    
    self.shareView.layer.cornerRadius = 2;
    
    self.shareView.layer.masksToBounds = YES;
    
    [self.view addSubview:self.shareView];
    
    self.shareView.hidden = YES;
    
    UIImageView *shareImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height320(17), Width320(28), Height320(28))];
    
    shareImg.image = [UIImage imageNamed:@"share_success"];
    
    shareImg.center = CGPointMake(self.shareView.width/2, shareImg.center.y);
    
    [self.shareView addSubview:shareImg];
    
    UILabel *shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, shareImg.bottom+Height320(13.8), self.shareView.width, Height320(17))];
    
    shareLabel.textColor = UIColorFromRGB(0xffffff);
    
    shareLabel.text = @"分享成功";
    
    shareLabel.textAlignment = NSTextAlignmentCenter;
    
    shareLabel.font = STFont(13);
    
    [self.shareView addSubview:shareLabel];
    
}

-(void)topClick:(UIButton *)button
{
    
    if (self.userInfo.staff) {
        
        ChangeInfoController *svc = [[ChangeInfoController alloc]init];
        
        __weak typeof(self)weakS = self;
        
        svc.editFinish = ^{
            
            [weakS reloadData];
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self quitConfirm];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(40);
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.titleArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.titleArray[section] count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        
    }
    
    cell.textLabel.textColor = UIColorFromRGB(0x333333);
    
    cell.textLabel.font = AllFont(14);
    
    cell.detailTextLabel.textColor = UIColorFromRGB(0x999999);
    
    cell.detailTextLabel.font = AllFont(14);
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSString *title = self.titleArray[indexPath.section][indexPath.row];
    
    cell.textLabel.text = title;
    
    if (indexPath.section == 2) {
        
        if (indexPath.row == 3) {
            
            cell.detailTextLabel.text = @"http://cloud.qingchengfit.cn...";
            
        }else if (indexPath.row == 4){
            
            cell.detailTextLabel.text = VERSION;
            
        }
        
    }
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height320(12);
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(12))];
    
    return view;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *identifier = self.titleArray[indexPath.section][indexPath.row];
    
    if ([identifier isEqualToString:@"品牌管理"]) {
        
        if (indexPath.row == 0) {
            
            BrandManagerController *svc = [[BrandManagerController alloc]init];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
    }else if ([identifier isEqualToString:@"修改手机号"]) {
        
        if (self.userInfo.staff) {
            
            ChangePhoneController *svc = [[ChangePhoneController alloc]init];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self needLogin];
            
        }
        
    }else if([identifier isEqualToString:@"修改密码"]){
        
        if (self.userInfo.staff) {
            
            ChangePasswordController *svc = [[ChangePasswordController alloc]init];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self needLogin];
            
        }
        
    }else if([identifier isEqualToString:@"消息推送设置"]){
        
        if (self.userInfo.staff) {
            
            YFMesNotiSettingVC *svc = [[YFMesNotiSettingVC alloc]init];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self needLogin];
            
        }
        
    }else if([identifier isEqualToString:@"关于我们"]){
        
        AboutController *svc = [[AboutController alloc]init];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if([identifier isEqualToString:@"意见反馈"]){
        
        SuggestController *svc = [[SuggestController alloc]init];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if([identifier isEqualToString:@"分享给朋友"]){
        
        ShareActionSheet *sheet = [[ShareActionSheet alloc]init];
        
        sheet.delegate = self;
        
        sheet.title = @"健身房管理";
        
        sheet.content = @"我发现了一个特别好用的[健身房管理app]，推荐使用";
        
        sheet.url = @"http://fir.im/qcfit";
        
        sheet.imageName = @"qcicon";
        
        [sheet show];
        
    }else if([identifier isEqualToString:@"网页端地址"]){
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网页端地址" message:@"http://cloud.qingchengfit.cn/backend/settings/" delegate:self cancelButtonTitle:@"复制链接" otherButtonTitles:@"确定", nil];
        
        alert.tag = 102;
        
        [alert show];
        
    }else if([identifier isEqualToString:@"切换至Dev"] ||[identifier isEqualToString:@"切换至Cloudtest"]){
        
        BOOL local = [[NSUserDefaults standardUserDefaults]boolForKey:@"localServer"];
        
        [[NSUserDefaults standardUserDefaults]setBool:!local forKey:@"localServer"];
        
        [self.tableView reloadData];
        
        [self quitConfirm];
        
    }else if ([identifier isEqualToString:@"创建健身房"]){
        
        MOAppDelegate.course = [[Course alloc]initNewCourse];
        
        GuideCreateBrandController *svc = [[GuideCreateBrandController alloc]init];
        
        MOAppDelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:svc];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)shareResult:(NSInteger)result
{
    
    if (result == WXSuccess) {
        
        self.shareView.hidden = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.shareView.hidden = YES;
        });
        
    }
    
}

-(void)quit
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否退出登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
    
    alert.tag = 101;
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 999) {
        
        if (buttonIndex == 1) {
            
            [[UIApplication sharedApplication]openURL:_updateURL];
            
        }
        
    }else if(alertView.tag == 101){
        
        if (buttonIndex == 1) {
            
            [self quitConfirm];
            
        }
        
    }else if (alertView.tag == 102){
        
        if (buttonIndex == 0) {
            
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            
            pasteboard.string = @"http://cloud.qingchengfit.cn/backend/settings/";
            
            [[[UIAlertView alloc]initWithTitle:@"链接已复制到剪贴板" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
    }
    
}

-(void)quitConfirm
{
    
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"sessionId"];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"phone"];
    
    [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"staffId"];
    
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"pushVersion"];
    
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"course"];
    
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"userSig"];
    
    [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"userId"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    [[TIMManager sharedInstance]logout:^{
        
        [[RootController sharedSliderController]reloadNoPush];
        
        [BPush unbindChannelWithCompleteHandler:^(id result, NSError *error) {}];
        
    } fail:^(int code, NSString *msg) {
        
        [[RootController sharedSliderController]reloadNoPush];
        
        [BPush unbindChannelWithCompleteHandler:^(id result, NSError *error) {}];
        
    }];
    
    [ServicesInfo shareInfo].services = [NSArray array];
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    
    MOAppDelegate.course = [[Course alloc]initNewCourse];
    
    [MOAppDelegate saveCourse];
    
    AppBrand = nil;
    
    AppGym = nil;
    
}

-(void)naviRightClick
{
    
    MessageController *svc = [[MessageController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)needLogin
{
    
    [[[UIAlertView alloc]initWithTitle:@"请先登录" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    
}

@end
