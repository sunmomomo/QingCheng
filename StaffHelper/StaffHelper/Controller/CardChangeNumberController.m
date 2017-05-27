//
//  CardChangeNumberController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardChangeNumberController.h"

#import "CardDetailInfo.h"

#import "CardDetailController.h"

#import "QCTextField.h"

@interface CardChangeNumberController ()

@property(nonatomic,strong)QCTextField *textField;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation CardChangeNumberController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    
    
}

-(void)createUI
{
    
    self.title = @"修改实体卡号";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.rightTitle = @"保存";
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(40))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    self.textField = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.textField.placeholder = @"请输入实体卡号：";
    
    self.textField.font = AllFont(14);
    
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.textField.keyboardType = UIKeyboardTypeASCIICapable;
    
    self.textField.noLine = YES;
    
    if (self.card.cardNumber.length) {
        
        self.textField.text = self.card.cardNumber;
        
    }
    
    [topView addSubview:self.textField];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)naviRightClick
{
    
    self.card.cardNumber = self.textField.text;
    
    [self.view endEditing:YES];
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"";
    
    [self.hud showAnimated:YES];
    
    CardDetailInfo *info = [[CardDetailInfo alloc]init];
    
    [info changeCard:self.card withGym:nil Result:^(BOOL success, NSString *error) {
        
        if (success) {
            
            self.hud.label.text = @"修改成功";
            
            self.hud.mode = MBProgressHUDModeText;
            
            [self.hud hideAnimated:YES afterDelay:1.5];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                for (MOViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[CardDetailController class]]) {
                        
                        [vc reloadData];
                        
                        [self.navigationController popToViewController:vc animated:YES];
                        
                    }
                    
                }
                
            });
            
        }else{
            
            self.hud.label.text = error;
            
            self.hud.label.numberOfLines = 0;
            
            self.hud.mode = MBProgressHUDModeText;
            
            [self.hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

@end
