//
//  ChestBorrowController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestBorrowController.h"

#import "MOCell.h"

#import "ChestLongBorrowController.h"

#import "ChestBorrowChooseStudentController.h"

#import "ChestEditController.h"

#import "ChestBorrowInfo.h"

@interface ChestBorrowController ()

@property(nonatomic,strong)MOCell *userCell;

@property(nonatomic,strong)UILabel *chestNameLabel;

@property(nonatomic,strong)UILabel *areaLabel;

@property(nonatomic,strong)Student *user;

@property(nonatomic,strong)UIButton *confirmButton;

@end

@implementation ChestBorrowController

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
    
    
    
}

-(void)reloadData
{
    
    self.chestNameLabel.text = self.chest.name;
    
    self.areaLabel.text = self.chest.area.areaName;
    
}

-(void)createUI
{
    
    self.title = @"租用更衣柜";
    
    self.rightType = MONaviRightTypeEdit;
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.chestNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64+Height320(20), MSW, Height320(27))];
    
    self.chestNameLabel.text = self.chest.name;
    
    self.chestNameLabel.textColor = kMainColor;
    
    self.chestNameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.chestNameLabel.font = AllFont(24);
    
    [self.view addSubview:self.chestNameLabel];
    
    self.areaLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.chestNameLabel.bottom, self.chestNameLabel.width, Height320(14))];
    
    self.areaLabel.text = self.chest.area.areaName;
    
    self.areaLabel.textColor = kMainColor;
    
    self.areaLabel.textAlignment = NSTextAlignmentCenter;
    
    self.areaLabel.font = AllFont(12);
    
    [self.view addSubview:self.areaLabel];
    
    UIView *userView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(81)+64, MSW, Height320(40))];
    
    userView.backgroundColor = UIColorFromRGB(0xffffff);
    
    userView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    userView.layer.borderWidth = OnePX;
    
    [self.view addSubview:userView];
    
    self.userCell = [[MOCell alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.userCell.titleLabel.text = @"会员";
    
    self.userCell.placeholder = @"请选择";
    
    self.userCell.noLine = YES;
    
    [userView addSubview:self.userCell];
    
    [self.userCell addTarget:self action:@selector(userChoose) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), userView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    self.confirmButton.backgroundColor = kMainColor;
    
    self.confirmButton.layer.cornerRadius = Width320(2);
    
    [self.confirmButton setTitle:@"确定租用" forState:UIControlStateNormal];
    
    [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    self.confirmButton.titleLabel.font = AllFont(14);
    
    [self.view addSubview:self.confirmButton];
    
    [self.confirmButton addTarget:self action:@selector(borrowChest:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *longButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(40), self.confirmButton.bottom+Height320(12), Width320(80), Height320(40))];
    
    UILabel *longLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(4), Width320(62), Height320(18))];
    
    longLabel.text = @"长期租用";
    
    longLabel.textColor = kMainColor;
    
    longLabel.textAlignment = NSTextAlignmentRight;
    
    longLabel.font = AllFont(14);
    
    longLabel.center = CGPointMake(longLabel.center.x, longButton.height/2);
    
    [longButton addSubview:longLabel];
    
    UIImageView *longImg = [[UIImageView alloc]initWithFrame:CGRectMake(longLabel.right+Width320(6), Height320(6), Width320(7), Height320(12))];
    
    longImg.image = [[UIImage imageNamed:@"cellarrow"]imageWithTintColor:kMainColor];
    
    longImg.center = CGPointMake(longImg.center.x, longButton.height/2);
    
    [longButton addSubview:longImg];
    
    [self.view addSubview:longButton];
    
    [longButton addTarget:self action:@selector(longBorrow) forControlEvents:UIControlEventTouchUpInside];
    
    [self check];
    
}

-(void)longBorrow
{
    
    ChestLongBorrowController *svc = [[ChestLongBorrowController alloc]init];
    
    svc.chest = self.chest;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)userChoose
{
    
    ChestBorrowChooseStudentController *svc = [[ChestBorrowChooseStudentController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.chooseFinish = ^(Student *stu){
        
        weakS.user = stu;
        
        weakS.userCell.subtitle = stu.name;
        
        [weakS check];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)borrowChest:(UIButton*)button
{
    
    if (self.user) {
        
        button.userInteractionEnabled = NO;
        
        ChestBorrowInfo *info = [[ChestBorrowInfo alloc]init];
        
        [info borrowTempChest:self.chest withUser:self.user result:^(BOOL success, NSString *error) {
            
            button.userInteractionEnabled = YES;
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            hud.mode = MBProgressHUDModeText;
            
            [self.view addSubview:hud];
            
            if (success) {
                
                hud.label.text = @"租用成功";
                
                [hud showAnimated:YES];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self popViewControllerAndReloadData];
                    
                });
                
            }else{
                
                hud.label.text = error;
                
                hud.label.numberOfLines = 0;
                
                [hud showAnimated:YES];
                
                [hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:@"请选择会员" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}

-(void)check
{
    
    if (self.user) {
        
        self.confirmButton.alpha = 1;
        
    }else{
        
        self.confirmButton.alpha = 0.4;
        
    }
    
}

-(void)naviRightClick
{
    
    ChestEditController *svc = [[ChestEditController alloc]init];
    
    svc.isAdd = NO;
    
    svc.chest = [self.chest copy];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)dealloc
{
    
    self.chest.borrowUser = nil;
    
}

@end
