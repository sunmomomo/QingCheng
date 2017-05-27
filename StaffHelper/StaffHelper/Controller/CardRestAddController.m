//
//  CardRestAddController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardRestAddController.h"

#import "QCTextField.h"

#import "MOCell.h"

#import "QCKeyboardView.h"

#import "SummaryController.h"

#import "CardRestListInfo.h"

#import "CardDetailController.h"

#import "CardListController.h"

#import "CardRestListController.h"

@interface CardRestAddController ()<UITextFieldDelegate,QCKeyboardViewDelegate>

@property(nonatomic,strong)QCTextField *reasonTF;

@property(nonatomic,strong)QCTextField *startTF;

@property(nonatomic,strong)UIDatePicker *startDP;

@property(nonatomic,strong)UIDatePicker *endDP;

@property(nonatomic,strong)QCTextField *endTF;

@property(nonatomic,strong)QCTextField *payTF;

@property(nonatomic,strong)MOCell *remarkCell;

@property(nonatomic,strong)UIButton *confirmButton;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)CardRest *rest;

@property(nonatomic,strong)CardRestListInfo *info;

@end

@implementation CardRestAddController

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
    
    self.rest = [[CardRest alloc]init];
    
    self.rest.card = self.card;
    
    self.info = [[CardRestListInfo alloc]init];
    
}

-(void)createUI
{
    
    self.title = @"添加请假";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(200))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:topView];
    
    self.reasonTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.reasonTF.placeholder = @"请假事由";
    
    self.reasonTF.mustInput = YES;
    
    self.reasonTF.textPlaceholder = @"请填写";
    
    self.reasonTF.delegate = self;
    
    [topView addSubview:self.reasonTF];
    
    self.startTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.reasonTF.bottom, MSW-Width320(32), Height320(40))];
    
    self.startTF.placeholder = @"开始日期";
    
    self.startTF.mustInput = YES;
    
    self.startTF.textPlaceholder = @"请选择";
    
    self.startTF.type = QCTextFieldTypeCell;
    
    self.startTF.delegate = self;
    
    [topView addSubview:self.startTF];
    
    QCKeyboardView *startKV = [QCKeyboardView defaultKeboardView];
    
    startKV.delegate = self;
    
    startKV.tag = 101;
    
    self.startDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.startDP.datePickerMode = UIDatePickerModeDate;
    
    startKV.keyboard = self.startDP;
    
    self.startTF.inputView = startKV;
    
    self.endTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.startTF.left, self.startTF.bottom, self.startTF.width, self.startTF.height)];
    
    self.endTF.placeholder = @"结束日期";
    
    self.endTF.mustInput = YES;
    
    self.endTF.textPlaceholder = @"请选择";
    
    self.endTF.type = QCTextFieldTypeCell;
    
    self.endTF.delegate = self;
    
    [topView addSubview:self.endTF];
    
    QCKeyboardView *endKV = [QCKeyboardView defaultKeboardView];
    
    endKV.delegate = self;
    
    endKV.tag = 102;
    
    self.endDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.endDP.datePickerMode = UIDatePickerModeDate;
    
    endKV.keyboard = self.endDP;
    
    self.endTF.inputView = endKV;
    
    self.payTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.reasonTF.left, self.endTF.bottom, self.reasonTF.width, self.reasonTF.height)];
    
    self.payTF.placeholder = @"收费（元）";
    
    self.payTF.textPlaceholder = @"请填写";
    
    self.payTF.mustInput = YES;
    
    self.payTF.keyboardType = UIKeyboardTypeDecimalPad;
    
    self.payTF.delegate = self;
    
    [topView addSubview:self.payTF];
    
    self.remarkCell = [[MOCell alloc]initWithFrame:CGRectMake(self.reasonTF.left, self.payTF.bottom, self.payTF.width, self.payTF.height)];
    
    self.remarkCell.titleLabel.text = @"备注";
    
    self.remarkCell.placeholder = @"选填";
    
    self.remarkCell.noLine = YES;
    
    [topView addSubview:self.remarkCell];
    
    [self.remarkCell addTarget:self action:@selector(remark) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    self.confirmButton.backgroundColor = kMainColor;
    
    self.confirmButton.layer.cornerRadius = 2;
    
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    self.confirmButton.titleLabel.font = AllFont(14);
    
    [self.view addSubview:self.confirmButton];
    
    [self.confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    self.hud.mode = MBProgressHUDModeText;
    
    [self.view addSubview:self.hud];
    
    [self.hud hideAnimated:YES];
    
}

-(void)confirm
{
    
    if (self.reasonTF.text.length && self.startTF.text.length && self.endTF.text.length && self.payTF.text.length) {
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"";
        
        [self.hud showAnimated:YES];
        
        self.rest.message = self.reasonTF.text;
        
        self.rest.start = self.startTF.text;
        
        self.rest.end = self.endTF.text;
        
        self.rest.price = [self.payTF.text integerValue];
        
        self.rest.remark = self.remarkCell.subtitle;
        
        __weak typeof(self)weakS = self;
        
        [self.info addRest:self.rest result:^(BOOL success, NSString *result) {
            
            if (success) {
                
                weakS.hud.mode = MBProgressHUDModeText;
                
                weakS.hud.label.text = @"添加成功";
                
                [weakS.hud showAnimated:YES];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [weakS.hud hideAnimated:YES];
                    
                    for (MOViewController *vc in weakS.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[CardListController class]]) {
                            
                            [vc reloadData];
                            
                        }
                        
                        if ([vc isKindOfClass:[CardDetailController class]]) {
                            
                            [vc reloadData];
                            
                        }
                        
                    }
                    
                    [weakS popViewControllerAndReloadData];
                    
                });
                
            }else
            {
                
                weakS.hud.mode = MBProgressHUDModeText;
                
                weakS.hud.label.text = result;
                
                [weakS.hud showAnimated:YES];
                
                [weakS.hud hideAnimated:YES afterDelay:1.5f];
                
            }
            
        }];

    }else
    {
        
        [[[UIAlertView alloc]initWithTitle:@"信息填写不完全" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"yyyy-MM-dd";
    
    if (keyboardView.tag == 101) {
        
        if (self.endTF.text) {
            
            if ([self.startDP.date timeIntervalSinceDate:[df dateFromString:self.endTF.text]]>=0) {
                
                [[[UIAlertView alloc]initWithTitle:@"开始日期须早于结束日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
                
            }
            
        }
        
        self.startTF.text = [df stringFromDate:self.startDP.date];
        
    }else
    {
        
        if (self.startTF.text) {
            
            if ([self.endDP.date timeIntervalSinceDate:[df dateFromString:self.startTF.text]]<=0) {
                
                [[[UIAlertView alloc]initWithTitle:@"结束日期须晚于开始日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
                
            }
            
        }
        
        self.endTF.text = [df stringFromDate:self.endDP.date];
        
    }
    
    [self.view endEditing:YES];
    
}

-(void)remark
{
    
    SummaryController *svc = [[SummaryController alloc]init];
    
    svc.placeholder = @"请填写请假备注";
    
    svc.title = @"请假备注";
    
    svc.text = self.rest.remark;
    
    __weak typeof(self)weakS = self;
    
    svc.summaryFinish = ^(NSString *summary){
        
        if (summary.length) {
            
            weakS.rest.remark = summary;
            
            weakS.remarkCell.subtitle = summary;
            
        }
       
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
        
    [self.view endEditing:YES];
    
    return YES;
    
}

@end
