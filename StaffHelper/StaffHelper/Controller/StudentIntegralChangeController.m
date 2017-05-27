//
//  StudentIntegralChangeController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "StudentIntegralChangeController.h"

#import "QCTextFieldCell.h"

#import "SummaryController.h"

#import "MOCell.h"

#import "IntegralHistoryInfo.h"

@interface StudentIntegralChangeController ()

@property(nonatomic,strong)UILabel *currentLabel;

@property(nonatomic,strong)UILabel *changedLabel;

@property(nonatomic,strong)QCTextField *integralTF;

@property(nonatomic,strong)MOCell *summaryCell;

@end

@implementation StudentIntegralChangeController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
}

-(void)createUI
{
    
    self.title = self.isAdd?@"增加积分":@"扣除积分";
    
    self.rightTitle = @"确定";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *top = [[UIView alloc]initWithFrame:CGRectMake(0, 64+Height320(12), MSW, Height320(40))];
    
    top.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:top];
    
    self.integralTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.integralTF.placeholder = self.isAdd?@"增加积分值":@"扣除积分值";
    
    self.integralTF.noLine = YES;
    
    self.integralTF.keyboardType = UIKeyboardTypeDecimalPad;
    
    [top addSubview:self.integralTF];
    
    self.currentLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), top.bottom+Height320(8), Width320(141), Height320(14))];
    
    self.currentLabel.textColor = UIColorFromRGB(0x999999);
    
    self.currentLabel.font = AllFont(12);
    
    [self.view addSubview:self.currentLabel];
    
    self.changedLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(157), self.currentLabel.top, Width320(141), self.currentLabel.height)];
    
    self.changedLabel.textColor = UIColorFromRGB(0x999999);
    
    self.changedLabel.font = AllFont(12);
    
    self.changedLabel.textAlignment = NSTextAlignmentRight;
    
    [self.view addSubview:self.changedLabel];
    
    UIView *sec = [[UIView alloc]initWithFrame:CGRectMake(0, top.bottom+Height320(34), MSW, Height320(40))];
    
    sec.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:sec];
    
    self.summaryCell = [[MOCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.summaryCell.titleLabel.text = @"备注";
    
    self.summaryCell.placeholder = @"选填";
    
    [sec addSubview:self.summaryCell];
    
    [self.summaryCell addTarget:self action:@selector(summary) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)summary
{
    
    SummaryController *svc = [[SummaryController alloc]init];
    
    svc.title = @"备注";
    
    svc.text = self.summaryCell.subtitle;
    
    __weak typeof(self)weakS = self;
    
    svc.summaryFinish = ^(NSString *summary){
        
        weakS.summaryCell.subtitle = summary;
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)naviRightClick
{
    
    self.rightButtonEnable = NO;
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:hud];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
    [hud showAnimated:YES];
    
    IntegralHistoryInfo *info = [[IntegralHistoryInfo alloc]init];
    
    [info changeIntegral:self.isAdd?[self.integralTF.text floatValue]:-[self.integralTF.text floatValue] withStudent:self.student andSummary:self.summaryCell.subtitle result:^(BOOL success, NSString *error) {
        
        hud.mode = MBProgressHUDModeText;
        
        if (success) {
            
            hud.label.text = self.isAdd?@"增加成功":@"扣除成功";
            
            [hud hideAnimated:YES afterDelay:1.5];
            
            for(MOViewController *vc in self.navigationController.viewControllers){
                
                if ([NSStringFromClass([vc class])isEqualToString:@"StudentDetailController"]||[NSStringFromClass([vc class])isEqualToString:@"IntegralListController"]) {
                    
                    [vc reloadData];
                    
                }
                
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self popViewControllerAndReloadData];
                
            });
            
        }else{
            
            self.rightButtonEnable = YES;
            
            hud.label.text = error;
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}


@end
