//
//  RootController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/15.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import "RootController.h"

#import "ProgrammeController.h"

#import "ManageController.h"

#import "DiscoverController.h"

#import "ChatListController.h"

#import "MyController.h"

#import "MessageInfo.h"

#import "DiscoverInfo.h"

#import "UserDetailInfo.h"

#import "SensorsAnalyticsSDK.h"

#import "QingChengHandler.h"

#import "WebViewController.h"

#import "BrandListInfo.h"

#import "GuideBrandSetController.h"

#import "BrandListController.h"

#import "ServicesInfo.h"

#import "ChatHeader.h"

#import "ManageEmptyController.h"

#import "ProgrammeEmptyController.h"

#import "LoginController.h"

@interface RootController ()

@property(nonatomic,strong)ProgrammeController *programVC;

@property(nonatomic,strong)ManageController *manageVC;

@property(nonatomic,strong)DiscoverController *discoverVC;

@property(nonatomic,strong)ChatListController *chatVC;

@property(nonatomic,strong)MyController *myVC;

@property(nonatomic,strong)ProgrammeEmptyController *programmeEmptyVC;

@property(nonatomic,strong)ManageEmptyController *manageEmptyVC;

@end

@implementation RootController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.selectedTitleColor = UIColorFromRGB(0x0db14b);
        
        self.unselectTitleColor = UIColorFromRGB(0xaaaaaa);
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    
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

+ (RootController*)sharedSliderController
{
    static RootController * sharedSVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSVC = [[self alloc] init];
    });
    return sharedSVC;
}

-(void)createData
{
    
    [self reloadData];
    
    UserDetailInfo *info = [[UserDetailInfo alloc]init];
    
    [info requestResult:^(BOOL success, NSString *error) {
        
        if (info.user.phone) {
            
            [[NSUserDefaults standardUserDefaults]setValue:info.user.phone forKey:@"userPhone"];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
        
    }];
    
    UserDetailInfo *orderInfo = [[UserDetailInfo alloc]init];
    
    [orderInfo requestOrder:^(BOOL success, NSString *error) {
        
        if (orderInfo.orderNumber) {
            
            BOOL firstOrder = [[NSUserDefaults standardUserDefaults]boolForKey:@"order_first"];
            
            if (!firstOrder) {
                
                [[RootController sharedSliderController] haveNew:YES AtIndex:4];
                
            }
            
        }
        
    }];
    
}

-(void)reloadData
{
    
    self.navigationController.navigationBar.hidden = YES;
    
    [[ServicesInfo shareInfo]requestSuccess:^{
        
        if (!AppGym && [ServicesInfo shareInfo].services.count) {
            
            AppGym = [[ServicesInfo shareInfo].services firstObject];
            
        }
        
        [self reloadSubData];
        
        if (self.callBack) {
            
            self.callBack();
            
            self.callBack = nil;
            
        }
        
    } Failure:^{
        
        [[NSUserDefaults standardUserDefaults]setInteger:0 forKey:@"coachId"];
        
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
        
        if (!self.programVC) {
            
            self.programVC = [[ProgrammeController alloc]init];
            
        }
        
        if (!self.manageVC) {
            
            self.manageVC = [ManageController sharedSliderController];
            
        }
        
        if (!self.discoverVC) {
            
            self.discoverVC = [[DiscoverController alloc]init];
            
        }
        
        if (!self.chatVC) {
            
            self.chatVC = [[ChatListController alloc]init];
            
        }
        
        if (!self.myVC) {
            
            self.myVC = [[MyController alloc]init];
            
        }
        
        self.viewControllers = @[_programVC,_manageVC,_discoverVC,_chatVC,_myVC];
        
    }else{
        
        if (!self.programmeEmptyVC) {
            
            self.programmeEmptyVC = [[ProgrammeEmptyController alloc]init];
            
        }
        
        if (!self.manageEmptyVC) {
            
            self.manageEmptyVC = [[ManageEmptyController alloc]init];
            
        }
        
        if (!self.discoverVC) {
            
            self.discoverVC = [[DiscoverController alloc]init];
            
        }
        
        if (!self.chatVC) {
            
            self.chatVC = [[ChatListController alloc]init];
            
        }
        
        if (!self.myVC) {
            
            self.myVC = [[MyController alloc]init];
            
        }
        
        self.viewControllers = @[_programmeEmptyVC,_manageEmptyVC,_discoverVC,_chatVC,_myVC];
        
    }
    
    for (MOViewController *vc in self.viewControllers) {
        
        [vc reloadData];
        
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self setHaveNew:YES atIndex:2];
        
    });
    
}

-(void)pushWithMessage:(Message *)message
{
    
    [self selectTheIndex:0];
    
    if (message.url.absoluteString.length){
        
        UIViewController *vc = [QingChengHandler handlerOpenURL:message.url];
        
        if (vc) {
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            WebViewController *svc = [[WebViewController alloc]init];
            
            svc.url = message.url;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
    }
    
}

-(void)createUI
{
    
    self.viewControllers = @[_programVC,_manageVC,_discoverVC,_chatVC,_myVC];
    
    self.selectedTitleColor = kMainColor;
    
    self.unselectTitleColor = UIColorFromRGB(0xaaaaaa);
    
}

-(void)haveNew:(BOOL)haveNew AtIndex:(NSInteger)index
{
    
    [self setHaveNew:haveNew atIndex:index];
    
}

-(void)didSelectIndex:(NSInteger)index
{
    
    if (index == 1) {
        
        [_programVC hideGuide];
        
    }
    
    if (index == 2) {
        
        [[SensorsAnalyticsSDK sharedInstance]track:@"IOS_discover_tab_click" withProperties:nil];
        
        [self setHaveNew:NO atIndex:2];
        
    }
    
}

-(void)showGuide
{
    
    [_programVC showGuide];
    
}

-(void)createDataResult:(void (^)())result
{
    
    self.callBack = result;
    
    [self createData];
    
}


-(void)pushGuide
{
    
    BrandListInfo *brandInfo = [[BrandListInfo alloc]init];
    
    [brandInfo requestResult:^(BOOL success, NSString *error) {
        
        if (!brandInfo.brands.count) {
            
            [self.navigationController pushViewController:[[GuideBrandSetController alloc]init] animated:YES];
            
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
