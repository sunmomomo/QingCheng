//
//  SettingController.m
//  健身教练助手
//
//  Created by 馍馍帝😈 on 15/8/13.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import "SettingController.h"

#import "ChangeInfoController.h"

#import "ChangePasswordController.h"

#import "SuggestController.h"

#import "AboutController.h"

#import "LoginController.h"

#import "RemindSettingController.h"

#import "ChangePhoneController.h"

#import "QualityListController.h"

#import "WorkListController.h"

#import "SettingCell.h"

#import "BPush.h"

#import "AppDelegate.h"

#import "RootController.h"

#import "ShareActionSheet.h"

#import <TLSSDK/TLSHelper.h>

#import <QALSDK/QalSDKProxy.h>

#import <ImSDK/ImSDK.h>

static NSString *identifier = @"Cell";

@interface SettingController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,ShareActionSheetDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIButton *quitButton;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)UIView *shareView;

@end

@implementation SettingController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createData];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

-(void)createData
{
    self.titleArray = @[@[@"课程提醒设置"],@[@"修改密码",@"修改手机号"],@[@"意见反馈",@"关于我们",@"分享给朋友"]];
    
}

-(void)createUI
{
    
    self.title = @"设置";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.tableView registerClass:[SettingCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.scrollEnabled = NO;
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    UIView *tableFooter = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(87))];
    
    self.tableView.tableFooterView = tableFooter;
    
    self.quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.quitButton.frame = CGRectMake(0, 0, MSW, Height320(40));
    
    self.quitButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.quitButton.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.quitButton.layer.borderWidth = OnePX;
    
    self.quitButton.titleLabel.font = AllFont(15);
    
    [self.quitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    
    [self.quitButton setTitleColor:UIColorFromRGB(0xff5252) forState:UIControlStateNormal];
    
    [self.quitButton addTarget:self action:@selector(quit:) forControlEvents:UIControlEventTouchUpInside];
    
    [tableFooter addSubview:self.quitButton];
    
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.quitButton.bottom+Height320(15), MSW, Height320(15))];
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.titleArray[section] count];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.titleArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.title = self.titleArray[indexPath.section][indexPath.row];
    
    cell.subtitle = indexPath.section == 2 && indexPath.row == 3?VERSION:@"";
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(40);
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return Height320(12);
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(12))];
    
    footer.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    return footer;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    __weak typeof(self)weakS = self;
    
    if (indexPath.section == 0){
        
        if (indexPath.row == 0)
        {
            
            RemindSettingController *svc = [[RemindSettingController alloc]init];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0) {
            
            [self.navigationController pushViewController:[[ChangePasswordController alloc]init] animated:YES];
            
        }else
        {
            
            ChangePhoneController *svc = [[ChangePhoneController alloc]init];
            
            [self.navigationController pushViewController:svc animated:YES];
            
            svc.edit = ^{
                
                if (weakS.edit) {
                    weakS.edit();
                }
                
            };
            
        }
        
    }else
    {
        
        if (indexPath.row == 0) {
            
            [self.navigationController pushViewController:[[SuggestController alloc]init] animated:YES];
            
        }else if(indexPath.row == 1)
        {
            
            [self.navigationController pushViewController:[[AboutController alloc]init] animated:YES];
            
        }else if (indexPath.row == 2){
            
            ShareActionSheet *sheet = [[ShareActionSheet alloc]init];
            
            sheet.delegate = self;
            
            sheet.title = @"健身教练助手";
            
            sheet.content = @"我发现了一个特别好用的[健身教练助手app]，推荐使用";
            
            sheet.url = @"http://fir.im/qingchengfit";
            
            sheet.imageName = @"trainer_icon";
            
            [sheet show];
            
        }
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(void)quitConfirm
{
    
    AppGym = nil;
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"order_first"];
    
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"sessionId"];
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"phone"];
    
    [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"coachId"];
    
    [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"userId"];
    
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"userSig"];
    
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"pushVersion"];
    
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"eventDate"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    [[TIMManager sharedInstance]logout:^{
        
    } fail:^(int code, NSString *msg) {
        
    }];
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    
    [BPush unbindChannelWithCompleteHandler:^(id result, NSError *error) {}];
    
    [self popViewControllerAndReloadData];
    
}

-(void)quit:(UIButton*)btn
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否退出登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
    
    alert.tag = 101;
    
    [alert show];
    
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag == 101){
        
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


@end
