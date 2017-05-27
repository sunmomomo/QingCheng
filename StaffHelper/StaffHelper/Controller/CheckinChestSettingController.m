//
//  CheckinSettingController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/30.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinChestSettingController.h"

#import "MOSwitchCell.h"

@interface CheckinChestSettingController ()<MOSwitchCellDelegate>

@property(nonatomic,strong)UIView *switchView;

@property(nonatomic,strong)MOSwitchCell *autoChestCell;

@property(nonatomic,strong)MOSwitchCell *autoReturnCell;

@property(nonatomic,strong)UILabel *setLabel;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)CheckinSettingInfo *info;

@end

@implementation CheckinChestSettingController

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
    
    self.info = [[CheckinSettingInfo alloc]init];
    
    [self.info requestSettingResult:^(BOOL success, NSString *error) {
        
        [self.switchView changeHeight:self.info.autoChest?Height320(80):Height320(40)];
        
        self.autoChestCell.noLine = !self.info.autoChest;
        
        self.autoChestCell.on = self.info.autoChest;
        
        self.autoReturnCell.on = self.info.autoReturn;
        
        self.autoReturnCell.hidden = !self.info.autoChest;
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"更衣柜联动设置";
    
    if ([PermissionInfo sharedInfo].permissions.checkinLockerPermission.editState) {
        
        self.rightTitle = @"保存";
        
    }
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 64, MSW-Width320(32), Height320(36))];
    
    firstLabel.text = @"设置与更衣柜联动：";
    
    firstLabel.textColor = UIColorFromRGB(0x999999);
    
    firstLabel.font = AllFont(12);
    
    [self.view addSubview:firstLabel];
    
    self.switchView = [[UIView alloc]initWithFrame:CGRectMake(0,64+Height320(36), MSW, self.info.autoChest?Height320(80):Height320(40))];
    
    self.switchView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.switchView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.switchView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:self.switchView];
    
    self.autoChestCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.autoChestCell.titleLabel.text = @"签到时分配更衣柜";
    
    self.autoChestCell.titleLabel.font = AllFont(14);
    
    self.autoChestCell.noLine = !self.info.autoChest;
    
    self.autoChestCell.tag = 0;
    
    self.autoChestCell.delegate = self;
    
    self.autoChestCell.on = self.info.autoChest;
    
    self.autoChestCell.titleLabel.textColor = UIColorFromRGB(0x666666);
    
    [self.switchView addSubview:self.autoChestCell];
    
    self.autoChestCell.userInteractionEnabled = [PermissionInfo sharedInfo].permissions.checkinLockerPermission.editState;
    
    self.autoReturnCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), Height320(40), MSW-Width320(32), Height320(40))];
    
    self.autoReturnCell.titleLabel.text = @"签出时自动归还更衣柜";
    
    self.autoReturnCell.titleLabel.font = AllFont(14);
    
    self.autoReturnCell.noLine = YES;
    
    self.autoReturnCell.tag = 1;
    
    self.autoReturnCell.delegate = self;
    
    self.autoReturnCell.on = self.info.autoReturn;
    
    self.autoReturnCell.titleLabel.textColor = UIColorFromRGB(0x666666);
    
    [self.switchView addSubview:self.autoReturnCell];
    
    self.autoReturnCell.userInteractionEnabled = [PermissionInfo sharedInfo].permissions.checkinLockerPermission.editState;
    
    self.autoReturnCell.hidden = !self.info.autoChest;
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
    if (![PermissionInfo sharedInfo].permissions.checkinLockerPermission.editState) {
        
        UIView *view = [[UIView alloc]initWithFrame:self.switchView.frame];
        
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showNoPermissionAlert)]];
        
        [self.view addSubview:view];
        
    }
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    if(cell.tag == 0){
        
        self.info.autoChest = cell.on;
        
        [self.switchView changeHeight:cell.on?Height320(80):Height320(40)];
        
        self.autoChestCell.noLine = !cell.on;
        
        if (cell.on) {
            
            self.info.autoReturn = YES;
            
            self.autoReturnCell.on = YES;
            
            self.autoReturnCell.hidden = NO;
            
            [self.switchView addSubview:self.autoReturnCell];
            
        }else{
            
            self.info.autoReturn = NO;
            
            self.autoReturnCell.on = NO;
            
            [self.autoReturnCell removeFromSuperview];
            
        }
        
        [self.setLabel changeTop:self.switchView.bottom];
        
    }else if(cell.tag == 1){
        
        self.info.autoReturn = cell.on;
        
    }
    
}

-(void)naviRightClick
{
    
    self.info.autoChest = self.autoChestCell.on;
    
    if (self.info.autoChest) {
        
        self.info.autoReturn = self.autoReturnCell.on;
        
    }else{
        
        self.info.autoReturn = NO;
        
    }
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"";
    
    [self.hud showAnimated:YES];
    
    self.rightButtonEnable = NO;
    
    CheckinSettingInfo *info = [[CheckinSettingInfo alloc]init];
    
    info.autoChest = self.info.autoChest;
    
    info.autoReturn = self.info.autoReturn;
    
    info.checkinId = self.info.checkinId;
    
    info.checkoutId = self.info.checkoutId;
    
    [info editSettingResult:^(BOOL success, NSString *error) {
        
        self.rightButtonEnable = YES;
        
        if (success) {
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = @"修改成功";
            
            [self.hud hideAnimated:YES afterDelay:1.5];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self popViewControllerAndReloadData];
                
            });
            
        }else{
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = error;
            
            self.hud.label.numberOfLines = 0;
            
            [self.hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

@end
