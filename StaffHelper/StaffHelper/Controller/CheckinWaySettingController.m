//
//  CheckinSettingController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/30.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinWaySettingController.h"

#import "MOCell.h"

#import "CheckinCardSettingController.h"

#import "GymProHintView.h"

@interface CheckinWaySettingController ()<GymProHintViewDelegate,GymTrySuccessAlertDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)MOCell *cardKindCell;

@end

@implementation CheckinWaySettingController

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
    
    if (!self.info) {
        
        self.info = [[CheckinSettingInfo alloc]init];
        
        [self.info requestCardKindsResult:^(BOOL success, NSString *error) {
            
            [self reloadData];
            
        }];
        
    }else{
        
        [self reloadData];
        
    }
    
}

-(void)reloadData
{
    
    BOOL used = NO;
    
    for (CardKind *cardKind in self.info.cardKinds) {
        
        if (cardKind.isUsed) {
            
            used = YES;
            
            break;
            
        }
        
    }
    
    self.cardKindCell.subtitle = used?@"已设置":@"未设置";
    
}

-(void)createUI
{
    
    self.title = @"签到结算设置";
    
    self.rightTitle = @"保存";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 64+Height320(12), MSW, Height320(40))];
    
    cellView.backgroundColor = UIColorFromRGB(0xffffff);
    
    cellView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    cellView.layer.borderWidth = OnePX;
    
    [self.view addSubview:cellView];
    
    self.cardKindCell = [[MOCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.cardKindCell.titleLabel.text = @"会员卡结算";
    
    self.cardKindCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.cardKindCell.titleLabel.font = AllFont(14);
    
    self.cardKindCell.tag = 0;
    
    self.cardKindCell.pro = !AppGym.pro;
    
    self.cardKindCell.noLine = YES;
    
    [cellView addSubview:self.cardKindCell];
    
    [self.cardKindCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)cellClick:(MOCell *)cell
{
    
    if (cell.tag == 0) {
        
        if (!AppGym.pro) {
            
            GymProHintView *hintView = [GymProHintView defaultView];
            
            hintView.delegate = self;
            
            hintView.title = @"会员卡签到";
            
            hintView.canTry = !AppGym.haveTried;
            
            [hintView showInView:self.view];
            
        }else{
            
            [self trySuccessAlertStart];
            
        }
        
    }
    
}

-(void)trySuccessAlertStart
{
    
    self.cardKindCell.pro = NO;
    
    CheckinCardSettingController *svc = [[CheckinCardSettingController alloc]init];
    
    svc.info = self.info;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)naviRightClick
{
    
    if ([self.cardKindCell.subtitle isEqualToString:@"未设置"]) {
        
        [[[UIAlertView alloc]initWithTitle:@"请至少设置一种签到结算" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else if ([self.cardKindCell.subtitle isEqualToString:@"已设置"]){
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"";
        
        [self.hud showAnimated:YES];
        
        self.rightButtonEnable = NO;
        
        [self.info editCardKindsResult:^(BOOL success, NSString *error) {
            
            self.rightButtonEnable = YES;
            
            if (success) {
                
                CheckinSettingInfo *usedInfo = [[CheckinSettingInfo alloc]init];
                
                [usedInfo changeCheckinUsed:YES result:^(BOOL success, NSString *error) {
                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    self.hud.label.text = @"修改成功";
                    
                    [self.hud hideAnimated:YES afterDelay:1.5];
                    
                    if (!self.setting) {
                        
                        for (MOViewController *vc in self.navigationController.viewControllers) {
                            
                            if ([NSStringFromClass([vc class])isEqualToString:@"CheckinController"]) {
                                
                                [vc reloadData];
                                
                            }
                            
                        }
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [self popViewControllerAndReloadData];
                            
                        });
                        
                    }else{
                        
                        BOOL contains = NO;
                        
                        for (MOViewController *vc in self.navigationController.viewControllers) {
                            
                            if ([NSStringFromClass([vc class])isEqualToString:@"CheckinController"]) {
                                
                                contains = YES;
                                
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    
                                    [self popToViewControllerName:@"CheckinController" isReloadData:YES];
                                    
                                });
                                
                            }
                            
                        }
                        
                        if (!contains) {
                            
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                
                                [self popViewControllerAndReloadData];
                                
                            });
                            
                        }
                        
                    }
                    
                }];
                
            }else{
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = error;
                
                self.hud.label.numberOfLines = 0;
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}



-(void)naviLeftClick
{
    
    [[[UIAlertView alloc]initWithTitle:@"是否放弃本次设置？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil]show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1){
        
        if (self.setting) {
            
            BOOL used = NO;
            
            for (CardKind *cardKind in self.info.cardKinds) {
                
                if (cardKind.isUsed) {
                    
                    used = YES;
                    
                    break;
                    
                }
                
            }
            
            if (!used) {
                
                CheckinSettingInfo *info = [[CheckinSettingInfo alloc]init];
                
                [info changeCheckinUsed:NO result:^(BOOL success, NSString *error) {
                    
                    for (MOViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([NSStringFromClass([vc class])isEqualToString:@"CheckinController"]) {
                                                    
                            [vc reloadData];
                            
                        }
                        
                    }
                    
                    [self popViewControllerAndReloadData];
                    
                }];
                
            }else{
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
        }else{
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    }
    
}

@end
