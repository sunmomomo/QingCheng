//
//  CheckinSettingController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/30.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinSettingController.h"

#import "MOCell.h"

#import "CheckinWaySettingController.h"

#import "CheckinChestSettingController.h"

#import "CheckinScreenSettingController.h"

#import "CheckinSettingInfo.h"

#import "WebViewController.h"

#import "CheckinSettingInfo.h"

#import "MOSwitchCell.h"

#import "MOTableView.h"

#import "CheckinCardSettingController.h"

#define HelpURL @"http://cloud.qingchengfit.cn/mobile/urls/96904e55171146ed909ea4aeb90e5ead/"

@interface CheckinSettingController ()<MOSwitchCellDelegate>

@property(nonatomic,strong)MOSwitchCell *usedCell;

@property(nonatomic,strong)UIView *cellView;

@property(nonatomic,strong)MOCell *wayCell;

@property(nonatomic,assign)BOOL openCheckin;

@property(nonatomic,strong)MOLoadingView *mainView;

@end

@implementation CheckinSettingController

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
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    CheckinSettingInfo *usedInfo = [[CheckinSettingInfo alloc]init];
    
    [usedInfo requestUsedResult:^(BOOL success, NSString *error) {
        
        self.openCheckin = usedInfo.openCheckin;
        
        [self reloadUI];
        
        CheckinSettingInfo *info = [[CheckinSettingInfo alloc]init];
        
        [info requestCardKindsResult:^(BOOL success, NSString *error) {
            
            BOOL used = NO;
            
            for (CardKind *cardKind in info.cardKinds) {
                
                if (cardKind.isUsed) {
                    
                    used = YES;
                    
                    break;
                    
                }
                
            }
            
            self.wayCell.subtitle = used?@"已设置":@"未设置";
            
            self.mainView.dataSuccess = YES;
            
            if (!self.setting && !used && self.openCheckin) {
                
                CheckinWaySettingController *wayVC = [[CheckinWaySettingController alloc]init];
                
                wayVC.setting = YES;
                
                wayVC.info = [info copy];
                
                if ([((UINavigationController*)[MOAppDelegate getCurrentVC]).visibleViewController isKindOfClass:[CheckinSettingController class]]) {
                    
                    [self.navigationController pushViewController:wayVC animated:!AppGym.pro];
                    
                    if (AppGym.pro) {
                        
                        CheckinCardSettingController *cardVC = [[CheckinCardSettingController alloc]init];
                        
                        cardVC.info = wayVC.info;
                        
                        [self.navigationController pushViewController:cardVC animated:YES];
                        
                    }
                    
                }
                
            }
            
        }];
        
    }];
    
}

-(void)reloadUI
{
    
    self.cellView.hidden = !self.openCheckin;
    
    self.usedCell.on = self.openCheckin;
    
}

-(void)createUI
{
    
    self.title = @"入场签到设置";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.mainView = [[MOLoadingView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    [self.view addSubview:self.mainView];
    
    UIView *switchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(44))];
    
    switchView.backgroundColor = UIColorFromRGB(0xffffff);
    
    switchView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    switchView.layer.borderWidth = OnePX;
    
    [self.mainView addSubview:switchView];
    
    self.usedCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(15), 0, MSW-Width(30), Height(44))];
    
    self.usedCell.titleLabel.text = @"入场签到";
    
    self.usedCell.delegate = self;
    
    [switchView addSubview:self.usedCell];
    
    self.cellView = [[UIView alloc]initWithFrame:CGRectMake(0, switchView.bottom+Height320(12), MSW, Height(44)*3)];
    
    self.cellView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.cellView.layer.borderWidth = OnePX;
    
    self.cellView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.mainView addSubview:self.cellView];
    
    self.wayCell = [[MOCell alloc]initWithFrame:CGRectMake(Width(15), 0, MSW-Width(30), Height(44))];
    
    self.wayCell.titleLabel.text = @"签到结算";
    
    self.wayCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    self.wayCell.titleLabel.font = AllFont(14);
    
    self.wayCell.tag = 0;
    
    [self.cellView addSubview:self.wayCell];
    
    [self.wayCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    MOCell *chestCell = [[MOCell alloc]initWithFrame:CGRectMake(Width(15), self.wayCell.bottom, MSW-Width(30), Height(44))];
    
    chestCell.titleLabel.text = @"更衣柜联动设置";
    
    chestCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    chestCell.titleLabel.font = AllFont(14);
    
    chestCell.tag = 1;
    
    [self.cellView addSubview:chestCell];
    
    [chestCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    MOCell *screenCell = [[MOCell alloc]initWithFrame:CGRectMake(Width(15), chestCell.bottom, MSW-Width(30), Height(44))];
    
    screenCell.titleLabel.text = @"签到大屏幕";
    
    screenCell.titleLabel.textColor = UIColorFromRGB(0x333333);
    
    screenCell.titleLabel.font = AllFont(14);
    
    screenCell.tag = 2;
    
    [self.cellView addSubview:screenCell];
    
    [screenCell addTarget:self action:@selector(cellClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    helpButton.frame = CGRectMake(MSW/2-Width320(77), MSH-64-Height320(38),Width320(154), Height320(27));
    
    [helpButton addTarget:self action:@selector(help) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainView addSubview:helpButton];
    
    UIImageView *helpImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(18), Height320(7), Width320(13), Height320(13))];
    
    helpImg.image = [[UIImage imageNamed:@"hint_circle"]imageWithTintColor:UIColorFromRGB(0xbbbbbb)];
    
    [helpButton addSubview:helpImg];
    
    UILabel *helpLabel = [[UILabel alloc]initWithFrame:CGRectMake(helpImg.right+Width320(4), 0, helpButton.width-helpImg.right-Width320(4), helpButton.height)];
    
    helpLabel.text = @"如设置入场签到？";
    
    helpLabel.textColor = UIColorFromRGB(0x888888);
    
    helpLabel.font = AllFont(12);
    
    [helpButton addSubview:helpLabel];
    
    self.cellView.hidden = YES;
    
}

-(void)help
{
    
    WebViewController *vc = [[WebViewController alloc]init];
    
    vc.url = [NSURL URLWithString:HelpURL];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)cellClick:(MOCell*)cell
{
    
    if (cell.tag == 0) {
        
        CheckinWaySettingController *svc = [[CheckinWaySettingController alloc]init];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if (cell.tag == 1){
        
        if ([PermissionInfo sharedInfo].permissions.checkinLockerPermission.readState) {
            
            CheckinChestSettingController *svc = [[CheckinChestSettingController alloc]init];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }else{
        
        if ([PermissionInfo sharedInfo].permissions.checkinScreenPermission.readState) {
            
            CheckinScreenSettingController *svc = [[CheckinScreenSettingController alloc]init];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [self showNoPermissionAlert];
            
        }
        
    }
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:hud];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    
    hud.label.text = @"";
    
    [hud showAnimated:YES];
    
    CheckinSettingInfo *info = [[CheckinSettingInfo alloc]init];
    
    [info changeCheckinUsed:cell.on result:^(BOOL success, NSString *error) {
        
        hud.mode = MBProgressHUDModeText;
        
        if (success) {
            
            self.openCheckin = cell.on;
            
            hud.label.text = @"修改成功";
            
            [hud hideAnimated:YES afterDelay:1.5];
            
            [self reloadUI];
            
            [self reloadData];
            
            for (MOViewController *vc in self.navigationController.viewControllers) {
                
                if ([NSStringFromClass([vc class])isEqualToString:@"CheckinController"]) {
                    
                    [vc reloadData];
                    
                }
                
            }
            
        }else{
            
            self.usedCell.on = !self.usedCell.on;
            
            hud.label.text = error;
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

@end
