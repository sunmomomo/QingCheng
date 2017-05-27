//
//  RootController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "RootController.h"

#import "HomeController.h"

#import "GymListController.h"

#import "SettingController.h"

#import "GymDetailController.h"

#import "MessageInfo.h"

#import "CheckinController.h"

#import "CheckinHistoryController.h"

#import "QCPrivilegeController.h"

#import "GymDetailInfo.h"

#import "StaffUserInfo.h"

#import "SensorsAnalyticsSDK.h"

#import "WebViewController.h"

#import "HomePageEmptyController.h"

#import "ServicesInfo.h"

#import "GuideCreateBrandController.h"

#import "BrandListController.h"

#import "LoginController.h"

#import "ChatListController.h"

#import "ChatHeader.h"

#import "QingChengHandler.h"

@interface RootController ()

@property(nonatomic,strong)HomeController *homeVC;

@property(nonatomic,strong)SettingController *settingVC;

@property(nonatomic,strong)GymDetailController *gymDetailVC;

@property(nonatomic,strong)QCPrivilegeController *privilegeVC;

@property(nonatomic,strong)ChatListController *chatVC;

@property(nonatomic,strong)HomePageEmptyController *emptyController;

@property(nonatomic,assign)BOOL noPush;

@end

@implementation RootController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.isChooseGymToCreatNewGym = NO;
        
        self.selectedTitleColor = UIColorFromRGB(0x333333);
        
        self.unselectTitleColor = UIColorFromRGB(0xaaaaaa);
        
        if (AppOneGym) {
            
            self.gymDetailVC = [[GymDetailController alloc]init];
            
            self.privilegeVC = [[QCPrivilegeController alloc]init];
            
            self.chatVC = [[ChatListController alloc]init];
            
            self.settingVC = [[SettingController alloc]init];
            
        }else{
            
            self.homeVC = [HomeController sharedController];
            
            self.privilegeVC = [[QCPrivilegeController alloc]init];
            
            self.chatVC = [[ChatListController alloc]init];
            
            self.settingVC = [[SettingController alloc]init];
            
        }
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.haveNew = YES;
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (AppMessage) {
        
        [self pushWithMessage:AppMessage];
        
        AppMessage = nil;
    }
}

-(void)reloadMessageData
{
    
    [_chatVC reloadData];
    
}

-(void)firstIn
{
    
    if (AppOneGym) {
        
        self.selectIndex = 0;
        
        self.gymDetailVC.gym = ((AppDelegate*)[UIApplication sharedApplication].delegate).gym;
        
        self.gymDetailVC.firstIn = YES;
        
    }else{
        
        self.selectIndex = 0;
        
        GymDetailController *svc = [[GymDetailController alloc]init];
        
        svc.firstIn = YES;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

+ (RootController*)sharedSliderController
{
    static RootController * sharedSVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSVC = [[self alloc] init];
    });
    return sharedSVC;
}

-(void)createDataResult:(void (^)())result
{
    
    self.callBack = result;
    
    [self createData];
    
}

-(void)createData
{
    
    [self reloadData];
    
}

-(void)reloadPrivilege
{
    
    for (MOViewController *vc in self.viewControllers) {
        
        if ([vc isKindOfClass:[QCPrivilegeController class]]) {
            
            [vc reloadData];
            
        }
        
    }
    
}

-(void)reloadNoPush
{
    
    self.noPush = YES;
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    self.navigationController.navigationBar.hidden = YES;
    
    StaffUserInfo *info = [[StaffUserInfo alloc]init];
    
    [info requestResult:^(BOOL success, NSString *error) {
        
        if (info.staff.phone) {
            
            [[NSUserDefaults standardUserDefaults]setValue:info.staff.phone forKey:@"userPhone"];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
    }];
    
    [[ServicesInfo shareInfo]requestSuccess:^{
        
        AppOneGym = [ServicesInfo shareInfo].services.count == 1;
        
        [self reloadSubData];
        
        if (self.callBack) {
            
            self.callBack();
            
            self.callBack = nil;
            
        }
        
    } Failure:^{
        
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"staffId"];
        
        [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"sessionId"];
        
        [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"userSig"];
        
        [[TIMManager sharedInstance]logout:^{
            
        } fail:^(int code, NSString *msg) {
            
        }];
        
        [self reloadSubData];
        
        if (self.callBack) {
            
            self.callBack();
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)reloadSubData
{
    
    if ([ServicesInfo shareInfo].services.count) {
        
        if (AppOneGym) {
            
            AppGym = [[ServicesInfo shareInfo].services firstObject];
            
            if (!self.gymDetailVC) {
                
                self.gymDetailVC = [[GymDetailController alloc]init];
                
            }
            
            if (!self.privilegeVC) {
                
                self.privilegeVC = [[QCPrivilegeController alloc]init];
                
            }
            
            if (!self.chatVC) {
                
                self.chatVC = [[ChatListController alloc]init];
                
            }
            
            if (!self.settingVC) {
                
                self.settingVC = [[SettingController alloc]init];
                
            }
            
            self.viewControllers = @[_gymDetailVC,_privilegeVC,_chatVC,_settingVC];
            
        }else{
            
            self.homeVC = [HomeController sharedController];
            
            if (!self.privilegeVC) {
                
                self.privilegeVC = [[QCPrivilegeController alloc]init];
                
            }
            
            if (!self.chatVC) {
                
                self.chatVC = [[ChatListController alloc]init];
                
            }
            
            if (!self.settingVC) {
                
                self.settingVC = [[SettingController alloc]init];
                
            }
            
            self.viewControllers = @[_homeVC,_privilegeVC,_chatVC,_settingVC];
            
        }
        
        if (!self.noPush) {
            
            [self selectTheIndex:0];
            
        }else{
            
            [self selectTheIndex:self.selectIndex];
            
            self.noPush = NO;
            
        }
        
    }else{
        
        if (!self.emptyController) {
            
            self.emptyController = [[HomePageEmptyController alloc]init];
            
        }
        
        if (!self.privilegeVC) {
            
            self.privilegeVC = [[QCPrivilegeController alloc]init];
            
        }
        
        if (!self.chatVC) {
            
            self.chatVC = [[ChatListController alloc]init];
            
        }
        
        if (!self.settingVC) {
            
            self.settingVC = [[SettingController alloc]init];
            
        }
        
        self.viewControllers = @[_emptyController,_privilegeVC,_chatVC,_settingVC];
        
        if (!self.noPush) {
            
            [self selectTheIndex:0];
            
        }else{
            
            [self selectTheIndex:self.selectIndex];
            
            self.noPush = NO;
            
        }
        
    }
    
    for (MOViewController *vc in self.viewControllers) {
        
        [vc reloadData];
        
    }
}

-(void)pushWithMessage:(Message *)message
{
    
    if (AppOneGym) {
        
        if ([PermissionInfo sharedInfo].permissions) {
            
                [self.gymDetailVC pushWithMessage:message];
        }else
        {
            [[PermissionInfo sharedInfo]requestWithGym:AppGym result:^(BOOL success, NSString *error) {
                
                [self.gymDetailVC pushWithMessage:message];
                
            }];
        }
    }else{
        
        [self selectTheIndex:0];
        
        if ([message canGoToNotWebVC]) {
            
            AppGym = message.gym;
            
            [[PermissionInfo sharedInfo]requestWithGym:AppGym result:^(BOOL success, NSString *error) {
                
                GymDetailController *svc = [[GymDetailController alloc]init];
                
                svc.gym = message.gym;
                
                [self.navigationController pushViewController:svc animated:NO];
                
                [svc pushWithMessage:message];
                
            }];
            
        }else if (message.url.absoluteString.length){
            
            UIViewController *vc = [QingChengHandler handlerOpenURL:message.url];
            
            if (vc) {
                
                [self.navigationController pushViewController:vc animated:YES];
                
                AppMessage = nil;
                
            }else{
                
                WebViewController *svc = [[WebViewController alloc]init];
                
                svc.url = message.url;
                
                [self.navigationController pushViewController:svc animated:YES];
                
                AppMessage = nil;
                
            }
            
        }
        
    }
    
}

-(void)createUI
{
    
    if (AppOneGym) {
        
        self.viewControllers = @[_gymDetailVC,_privilegeVC,_chatVC,_settingVC];
        
    }else{
        
        self.viewControllers = @[_homeVC,_privilegeVC,_chatVC,_settingVC];

        
    }
    
    self.selectedTitleColor = UIColorFromRGB(0x333333);
    
    self.unselectTitleColor = UIColorFromRGB(0xaaaaaa);
    
}

-(void)setHaveNew:(BOOL)haveNew
{
    
    _haveNew = haveNew;
    
    [self setHaveNew:haveNew atIndex:1];
    
}

-(void)didSelectIndex:(NSInteger)index
{
    
    if (index == 1) {
        
        [[SensorsAnalyticsSDK sharedInstance]track:@"ios_discover_tab_click" withProperties:nil];
        
        self.haveNew = NO;
        
    }
    
}

-(void)pushGuide
{
    
    BrandListInfo *brandInfo = [[BrandListInfo alloc]init];
    
    [brandInfo requestResult:^(BOOL success, NSString *error) {
        
        if (!brandInfo.brands.count) {
            
            [self.navigationController pushViewController:[[GuideCreateBrandController alloc]init] animated:YES];
            
        }else{
            
            BrandListController *vc = [[BrandListController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }];
    
}

-(void)pushLogin
{
    
    LoginController *vc = [[LoginController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
