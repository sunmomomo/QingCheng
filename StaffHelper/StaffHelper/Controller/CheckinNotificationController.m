//
//  CheckinNotificationController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinNotificationController.h"

#import "CheckinNotificationInfo.h"

#import "MOSwitchCell.h"

@interface CheckinNotificationController ()<MOSwitchCellDelegate>


@property(nonatomic,strong)UIScrollView *mainView;

@end

@implementation CheckinNotificationController

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
    if (!self.info)
    {
        self.info = [[CheckinNotificationInfo alloc]init];
        
        [self.info requsetDataResult:^(BOOL success, NSString *error) {
            
            [self createSwitchView];
        }];
    }else
    {
        [self createSwitchView];
    }
   
}

-(void)createSwitchView
{
    
    UIView *switchView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(56), MSW, self.info.gyms.count*Height320(40))];
    
    switchView.backgroundColor = UIColorFromRGB(0xffffff);
    
    switchView.layer.borderWidth = OnePX;
    
    switchView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    [self.mainView addSubview:switchView];
    
    self.mainView.contentSize = CGSizeMake(0, switchView.bottom+Height320(20));
    
    for (NSInteger i = 0; i<self.info.gyms.count; i++) {
        
        Gym *gym = self.info.gyms[i];
        
        MOSwitchCell *cell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), i*Height320(40), MSW-Width320(32), Height320(40))];
        
        cell.titleLabel.text = gym.name;
        
        cell.on = gym.receiveNotification;
        
        cell.tag = i;
        
        cell.delegate = self;
        
        [switchView addSubview:cell];
    }
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    Gym *gym = self.info.gyms[cell.tag];
    
    gym.receiveNotification = cell.on;
    
    [self.info editNotificationSettingWithGym:gym result:^(BOOL success, NSString *error) {
        
        if (error) {
            
            [[[UIAlertView alloc]initWithTitle:error message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            cell.on = !cell.on;
            
        }
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"设置签到/签出通知";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.mainView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(8), MSW, Height320(36))];
    
    label.text = @"开启通知后，会员在该场馆扫描二维码签到时\n你的手机将收到通知以便处理";
    
    label.textColor = UIColorFromRGB(0x999999);
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.numberOfLines = 2;
    
    label.font = AllFont(12);
    
    [self.mainView addSubview:label];
    
}


@end
