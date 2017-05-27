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

#import "GuideCreateBrandController.h"

#import "GuideSetGymController.h"

#import "HomeController.h"

#import "BrandListInfo.h"

#import "ServicesInfo.h"

#import "GymDetailController.h"

#import "QingChengHandler.h"

#import "WebViewController.h"

#import "BrandListController.h"

#import "QingChengHandler.h"

#define kPresentTime 1.0f

@interface LaunchController ()

@property(nonatomic,strong)BrandListInfo *brandInfo;

@property(nonatomic,strong)ServicesInfo *servicesInfo;

@end

@implementation LaunchController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self performSelector:@selector(createData) withObject:nil afterDelay:kPresentTime];
    
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
    
    img.image = [UIImage imageNamed:IPhone4_5_6_6P(@"loading_iphone4", @"loading_iphone5", @"loading_iphone6", @"loading_iphone6p")];
    
    [self.view addSubview:img];
    
}


@end
