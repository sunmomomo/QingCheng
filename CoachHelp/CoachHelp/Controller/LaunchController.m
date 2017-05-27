//
//  LaunchController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/11/17.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "LaunchController.h"

#import "RootController.h"

#import "LoginController.h"

#import "AppDelegate.h"

#import "ServicesInfo.h"

#import "BrandListInfo.h"

#import "GuideBrandSetController.h"

#import "GuideGymSetController.h"

#import "GuideSyncGymController.h"

#import "QingChengHandler.h"

#import "WebViewController.h"

#import "BrandListController.h"

#define kPresentTime 5.0f

@interface LaunchController ()

@end

@implementation LaunchController

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
    
    [[RootController sharedSliderController]createDataResult:^{
        
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        
        appDelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[RootController sharedSliderController]];
        
        if (LaunchURL) {
            
            NSURL *url = LaunchURL;
            
            MOViewController *vc = [QingChengHandler handlerOpenURL:url];
            
            if (vc) {
                
                [[RootController sharedSliderController].navigationController pushViewController:vc animated:YES];
                
            }
            
        }
        
    }];
    
}

-(void)createUI
{
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:self.view.frame];
    
    img.image = [UIImage imageNamed:IPhone4_5_6_6P(@"loading-iphone4", @"loading-iphone5", @"loading-iphone6", @"loading-iphone6p")];
    
    [self.view addSubview:img];
    
}


@end
