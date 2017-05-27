//
//  CardPayController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardPayController.h"

#import "QCTextField.h"

#import "MOSwitchCell.h"

#import "MOCell.h"

#import "SummaryController.h"

#import "SellersInfo.h"

#import "MOPickerView.h"

#import "QCKeyboardView.h"

#import "CardPayInfo.h"

#import "StudentDetailController.h"

#import "SellerChooseController.h"

#import "CardDetailController.h"

@interface CardPayController ()<UITextFieldDelegate,MOSwitchCellDelegate,QCKeyboardViewDelegate>

@property(nonatomic,strong)QCTextField *costTF;

@property(nonatomic,strong)QCTextField *returnTF;

@property(nonatomic,strong)UILabel *remainLabel;

@property(nonatomic,strong)QCTextField *startTF;

@property(nonatomic,strong)QCTextField *endTF;

@property(nonatomic,strong)UIDatePicker *startDP;

@property(nonatomic,strong)UIDatePicker *endDP;

@property(nonatomic,strong)MOSwitchCell *validCell;

@property(nonatomic,strong)QCTextField *sellerTF;

@property(nonatomic,strong)MOCell *summaryCell;

@property(nonatomic,strong)UIView *secView;

@property(nonatomic,strong)UIView *thirdView;

@property(nonatomic,strong)UIButton *confirmButton;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)Seller *seller;

@end

@implementation CardPayController

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
    
    self.seller = [[Seller alloc]init];
    
    self.seller.sellerId = -1;
    
}

-(void)createUI
{
    
    self.title = self.card.cardKind.type == CardKindTypePrepaid?@"储值卡扣费":self.card.cardKind.type == CardKindTypeTime?@"期限卡扣费":@"次卡扣费";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(40)*2)];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:topView];
    
    self.costTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.costTF.placeholder = self.card.cardKind.type == CardKindTypePrepaid?@"扣费金额（元）":self.card.cardKind.type == CardKindTypeTime?@"扣费天数（天）":@"扣费次数（次）";
    
    self.costTF.mustInput = YES;
    
    self.costTF.delegate = self;
    
    [self.costTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [topView addSubview:self.costTF];
    
    self.returnTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.costTF.left, self.costTF.bottom, self.costTF.width, self.costTF.height)];
    
    self.returnTF.placeholder = @"退款金额（元）";
    
    self.returnTF.mustInput = YES;
    
    self.returnTF.noLine = YES;
    
    self.returnTF.delegate = self;
    
    [topView addSubview:self.returnTF];
    
    self.remainLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(7), MSW-Width320(32), Height320(16))];
    
    self.remainLabel.textColor = UIColorFromRGB(0x666666);
    
    self.remainLabel.font = AllFont(12);
    
    [self.view addSubview:self.remainLabel];
    
    if (self.card.cardKind.type != CardKindTypeTime) {
        
        self.secView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(40), MSW, self.card.checkValid?Height320(40)*3:Height320(40))];
        
        self.secView.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.secView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.secView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        [self.view addSubview:self.secView];
        
        self.validCell = [[MOSwitchCell  alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
        
        self.validCell.titleLabel.text = @"设置有效期";
        
        self.validCell.delegate = self;
        
        self.validCell.on = self.card.checkValid;
        
        self.validCell.noLine = !self.card.checkValid;
        
        [self.secView addSubview:self.validCell];
        
        self.startTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.validCell.left, self.validCell.bottom, self.validCell.width, self.validCell.height)];
        
        self.startTF.placeholder = @"开始日期";
        
        self.startTF.textPlaceholder = @"请选择";
        
        self.startTF.type = QCTextFieldTypeCell;
        
        self.startTF.delegate = self;
        
        self.startTF.text = self.card.checkValid?self.card.validFrom:@"";
        
        [self.secView addSubview:self.startTF];
        
        self.startTF.hidden = !self.validCell.on;
        
        QCKeyboardView *startKV = [QCKeyboardView defaultKeboardView];
        
        startKV.tag = 101;
        
        startKV.delegate = self;
        
        self.startTF.inputView = startKV;
        
        self.startDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, MSW, 177)];
        
        self.startDP.datePickerMode = UIDatePickerModeDate;
        
        startKV.keyboard = self.startDP;
        
        self.endTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.validCell.left, self.startTF.bottom, self.validCell.width, self.validCell.height)];
        
        self.endTF.placeholder = @"结束日期";
        
        self.endTF.textPlaceholder = @"请选择";
        
        self.endTF.type = QCTextFieldTypeCell;
        
        self.endTF.delegate = self;
        
        self.endTF.text = self.card.checkValid?self.card.validTo:@"";
        
        [self.secView addSubview:self.endTF];
        
        self.endTF.hidden = !self.validCell.on;
        
        QCKeyboardView *endKV = [QCKeyboardView defaultKeboardView];
        
        endKV.tag = 102;
        
        endKV.delegate = self;
        
        self.endTF.inputView = endKV;
        
        self.endDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, MSW, 177)];
        
        self.endDP.datePickerMode = UIDatePickerModeDate;
        
        endKV.keyboard = self.endDP;
        
    }
    
    self.thirdView = [[UIView alloc]initWithFrame:CGRectMake(0,self.card.cardKind.type == CardKindTypeTime?topView.bottom+Height320(40):topView.bottom+self.secView.height+Height320(52), MSW, Height320(40)*2)];
    
    self.thirdView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.thirdView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    self.thirdView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    [self.view addSubview:self.thirdView];
    
    self.sellerTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.sellerTF.placeholder = @"销售";
        
    self.sellerTF.mustInput = YES;
    
    self.sellerTF.textPlaceholder = @"请选择";
    
    self.sellerTF.type = QCTextFieldTypeCell;
    
    self.sellerTF.delegate = self;
    
    [self.thirdView addSubview:self.sellerTF];
    
    self.summaryCell = [[MOCell alloc]initWithFrame:CGRectMake(Width320(16), self.sellerTF.bottom, self.sellerTF.width, self.sellerTF.height)];
    
    self.summaryCell.titleLabel.text = @"备注";
    
    self.summaryCell.noLine = YES;
    
    [self.thirdView addSubview:self.summaryCell];
    
    [self.summaryCell addTarget:self action:@selector(summaryClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), self.thirdView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    self.confirmButton.layer.cornerRadius = 2;
    
    self.confirmButton.backgroundColor = kMainColor;
    
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    self.confirmButton.titleLabel.font = AllFont(14);
    
    [self.view addSubview:self.confirmButton];
    
    [self.confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    [self.secView changeHeight:cell.on?Height320(40)*3:Height320(40)];
    
    self.validCell.noLine = !cell.on;
    
    self.startTF.hidden = !cell.on;
    
    self.endTF.hidden = !cell.on;
    
    [self.thirdView changeTop:self.secView.bottom+Height320(12)];
    
    [self.confirmButton changeTop:self.thirdView.bottom+Height320(12)];
    
}

-(void)summaryClick:(MOCell*)cell
{
    
    SummaryController *svc = [[SummaryController alloc]init];
    
    svc.title = @"扣费备注";
    
    svc.placeholder = @"扣费备注";
    
    __weak typeof(self)weakS = self;
    
    svc.summaryFinish = ^(NSString *summary){
        
        weakS.summaryCell.subtitle = summary;
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField == self.sellerTF) {
        
        SellerChooseController *svc = [[SellerChooseController alloc]init];
        
        __weak typeof(self)weakS = self;
        
        svc.chooseFinish = ^(Seller *seller){
            
            weakS.seller = seller;
            
            weakS.sellerTF.text = seller.name;
            
        };
        
        svc.seller = self.seller;
        
        svc.gym = self.gym;
        
        [self.navigationController pushViewController:svc animated:YES];
        
        return NO;
        
    }else
    {
        
        return YES;
        
    }
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    if (self.card.cardKind.type == CardKindTypeTime) {
        
        if (textField.text.length) {
            
            NSDateFormatter *df = [[NSDateFormatter alloc]init];
            
            df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
            
            df.dateFormat = @"yyyy-MM-dd";
            
            NSString *end = [df stringFromDate:[NSDate dateWithTimeInterval:-[self.costTF.text integerValue]*86400 sinceDate:[df dateFromString:self.card.end]]];
            
            self.remainLabel.text = [NSString stringWithFormat:@"扣费后有效期至：%@",end];
            
        }else{
            
            self.remainLabel.text = @"";
            
        }
        
    }else if(self.card.cardKind.type == CardKindTypePrepaid){
        
        if (textField.text.length) {
            
            self.remainLabel.text = [NSString stringWithFormat:@"扣费后卡内余额：%ld元",(long)self.card.remain-[self.costTF.text integerValue]];
            
        }else{
            
            self.remainLabel.text = @"";
            
        }
        
    }else{
        
        if (textField.text.length) {
            
            self.remainLabel.text = [NSString stringWithFormat:@"扣费后卡内剩余次数：%ld次",(long)self.card.remain-[self.costTF.text integerValue]];
            
        }else{
            
            self.remainLabel.text = @"";
            
        }
        
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)confirm
{
    
    if (!self.costTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"请填写%@",self.card.cardKind.type == CardKindTypePrepaid?@"扣费金额":self.card.cardKind.type == CardKindTypeTime?@"扣费天数":@"扣费次数"] message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (!self.returnTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请填写退款金额" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (!self.sellerTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请选择销售人员" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    self.card.checkValid = self.validCell.on;
    
    if (self.validCell.on) {
        
        self.card.validFrom = self.startTF.text;
        
        self.card.validTo = self.endTF.text;
        
    }
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"";
    
    [self.hud showAnimated:YES];
    
    CardPayInfo *info = [[CardPayInfo alloc]init];
    
    [info payCard:self.card withAccount:[self.costTF.text integerValue] andPrice:[self.returnTF.text integerValue] andSellerId:self.seller.sellerId andShopId:self.gym.shopId andRemark:self.summaryCell.subtitle result:^(BOOL success, NSString *error) {
        
        if (success) {
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = @"扣费成功";
            
            [self.hud hideAnimated:YES afterDelay:1.5];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                Student *stu = ((AppDelegate*)[UIApplication sharedApplication].delegate).student;
                
                if (stu) {
                    
                    for (MOViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[StudentDetailController class]]) {
                            
                            [vc reloadData];
                            
                        }
                        
                    }
                    
                }
                
                for (MOViewController *vc in self.navigationController.viewControllers) {
                    
                    if ([vc isKindOfClass:[CardDetailController class]]) {
                        
                        [vc reloadData];
                        
                        [self.navigationController popToViewController:vc animated:YES];
                        
                    }
                    
                }
                
            });
            
        }else
        {
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = error;
            
            self.hud.label.numberOfLines = 0;
            
            [self.hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    if (keyboardView.tag == 101) {
        
        if (self.endTF.text.length) {
            
            NSTimeInterval time = [[dateFormatter dateFromString:self.endTF.text] timeIntervalSinceDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:self.startDP.date]]];
            
            if (time<0) {
                
                [[[UIAlertView alloc]initWithTitle:@"开始日期不能晚于结束日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
                
            }
            
        }
        
        self.startTF.text = [dateFormatter stringFromDate:self.startDP.date];
        
        [self.view endEditing:YES];
        
    }else if (keyboardView.tag == 102){
        
        if (self.startTF.text.length) {
            
            NSTimeInterval time = [[dateFormatter dateFromString:self.startTF.text] timeIntervalSinceDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:self.endDP.date]]];
            
            if (time>0) {
                
                [[[UIAlertView alloc]initWithTitle:@"结束日期不能早于开始日期" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
                
            }
            
        }
        
        self.endTF.text = [dateFormatter stringFromDate:self.endDP.date];
        
        [self.view endEditing:YES];
        
    }
    
}

@end
