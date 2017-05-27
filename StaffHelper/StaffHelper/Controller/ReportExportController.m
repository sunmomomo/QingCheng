//
//  ReportExportController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/30.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ReportExportController.h"

#import "QCTextField.h"

#import "SummaryController.h"

#import "ORDetailInfo.h"

@interface ReportExportController ()<UITextFieldDelegate>

@property(nonatomic,strong)QCTextField *titleTF;

@property(nonatomic,strong)QCTextField *emailTF;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UIButton *confirmButton;

@end

@implementation ReportExportController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    
    self.title = @"导出Excel";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(52))];
    
    label.text = @"请填写邮件标题及您的邮箱地址\n提交后，报表将在10分钟内发送到您的邮箱";
    
    label.numberOfLines = 2;
    
    label.textColor = UIColorFromRGB(0x999999);
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = AllFont(12);
    
    [self.view addSubview:label];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64+Height320(56), MSW, Height320(40)*2)];
    
    view.backgroundColor = UIColorFromRGB(0xffffff);
    
    view.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    view.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:view];
    
    self.titleTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.titleTF.placeholder = @"邮件标题";
    
    self.titleTF.mustInput = YES;
    
    self.titleTF.type = QCTextFieldTypeCell;
    
    self.titleTF.delegate = self;
    
    self.titleTF.text = [NSString stringWithFormat:@"%@至%@%@%@%@",self.filter.startDate,self.filter.endDate,((AppDelegate*)[UIApplication sharedApplication].delegate).brand.name,self.gym?self.gym.name:@"",self.filter.infoType == ReportInfoTypeSchedule?@"课程报表":self.filter.infoType == ReportInfoTypeSell?@"销售报表":@"签到报表"];
    
    [view addSubview:self.titleTF];
    
    self.emailTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.titleTF.left, self.titleTF.bottom, self.titleTF.width, self.titleTF.height)];
    
    self.emailTF.placeholder = @"您的邮箱";
    
    self.emailTF.mustInput = YES;
    
    self.emailTF.type = QCTextFieldTypeCell;
    
    self.emailTF.noLine = YES;
    
    self.emailTF.keyboardType = UIKeyboardTypeURL;
    
    self.emailTF.delegate = self;
    
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"email"]) {
        
        self.emailTF.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
        
    }
    
    [view addSubview:self.emailTF];
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), view.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    self.confirmButton.backgroundColor = kMainColor;
    
    self.confirmButton.layer.cornerRadius = 2;
    
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [self.view addSubview:self.confirmButton];
    
    [self.confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.view endEditing:YES];
    
    return YES;
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField == self.titleTF) {
        
        SummaryController *svc = [[SummaryController alloc]init];
        
        svc.title = @"编辑邮件标题";
        
        svc.text = self.titleTF.text;
        
        __weak typeof(self)weakS = self;
        
        svc.summaryFinish = ^(NSString *summary){
            
            weakS.titleTF.text = summary;
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
        return NO;
        
    }else{
        
        return YES;
        
    }
    
}

-(void)confirm:(UIButton*)button
{
    
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (!self.titleTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请填写邮件标题" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else if (!self.emailTF.text.length){
        
        [[[UIAlertView alloc]initWithTitle:@"请输入您的邮箱" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else if (![pred evaluateWithObject:self.emailTF.text]){
        
        [[[UIAlertView alloc]initWithTitle:@"请输入正确的邮箱地址" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else{
        
        [self.view endEditing:YES];
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"";
        
        [self.hud showAnimated:YES];
        
        [[NSUserDefaults standardUserDefaults]setValue:self.emailTF.text forKey:@"email"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        self.confirmButton.userInteractionEnabled = NO;
        
        [ORDetailInfo exportExcelWithFilter:self.filter gym:self.gym title:self.titleTF.text email:self.emailTF.text result:^(BOOL success, NSString *error) {
            
            self.confirmButton.userInteractionEnabled = YES;
            
            if (success) {
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = @"邮件已发送";
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                });
                
            }else{
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = error;
                
                self.hud.label.numberOfLines = 0;
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}


@end
