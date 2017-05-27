//
//  ChangePhoneController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/26.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import "ChangePhoneController.h"

#import "QCTextField.h"

#import "CodeButton.h"

#import "CountryChooseTextField.h"

#define kGetCode @"/api/send/verify/"

#define kChangePhone @"/api/staffs/%ld/change/phone/"

@interface ChangePhoneController ()<UITextFieldDelegate>
{
    
    //定时器的冷却事件和步长
    NSInteger _coolTime;
    NSInteger _stepTime;
    
}
@property(nonatomic,strong)NSTimer *coolDownTimer;//定时器

@property(nonatomic,strong)CodeButton *codeView;

@property(nonatomic,strong)QCTextField *oldTF;

@property(nonatomic,strong)CountryChooseTextField *phoneTF;

@property(nonatomic,strong)QCTextField *codeTF;

@property(nonatomic,strong)UIButton *confirmBtn;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation ChangePhoneController

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
    
    self.title = @"修改手机号码";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(40)*3)];
    
    topView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:topView];
    
    self.oldTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.oldTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.oldTF.placeholder = @"请输入密码";
    
    self.oldTF.secureTextEntry = YES;
    
    self.oldTF.delegate = self;
    
    self.oldTF.font = STFont(14);
    
    [topView addSubview:self.oldTF];
    
    self.phoneTF = [[CountryChooseTextField alloc]initWithFrame:CGRectMake(Width320(16), self.oldTF.bottom, MSW-Width320(32), Height320(40))];
    
    self.phoneTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.phoneTF.font = STFont(14);

    self.phoneTF.delegate = self;
    
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [topView addSubview:self.phoneTF];
    
    self.codeTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.phoneTF.bottom, MSW-Width320(32), Height320(40))];
    
    self.codeTF.placeholderColor = UIColorFromRGB(0x999999);
        
    self.codeTF.placeholder = @"手机验证码";
    
    self.codeTF.delegate = self;
    
    self.codeTF.noLine = YES;
    
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.codeTF.font = STFont(14);
    
    [topView addSubview:self.codeTF];
    
    self.codeView = [[CodeButton alloc]initWithFrame:CGRectMake(self.codeTF.width-Width320(80), 0, Width320(80), self.codeTF.height)];
    
    [self.codeView addTarget:self action:@selector(codeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.codeView setTitle:@"发送验证码"];
    
    self.codeTF.rightView = self.codeView;
    
    self.codeTF.rightViewMode = UITextFieldViewModeAlways;
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.confirmBtn.frame = CGRectMake(Width320(16), topView.bottom+Height320(12), MSW-Width320(32), Height320(40));
    
    self.confirmBtn.backgroundColor = kMainColor;
    
    [self.confirmBtn setTitle:@"确  定" forState:UIControlStateNormal];
    
    [self.confirmBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [self.confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirmBtn.titleLabel.font = STFont(16);
    
    self.confirmBtn.layer.cornerRadius = 2;
    
    self.confirmBtn.layer.masksToBounds = YES;
    
    [self.view addSubview:self.confirmBtn];
    
    NSString *hintStr = @"注意：手机号须与在场馆预留的手机号一致，否则将无法同步场馆数据。";
    
    CGSize size = [hintStr boundingRectWithSize:CGSizeMake(MSW-Width320(32), CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: AllFont(12)} context:nil].size;
    
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), self.confirmBtn.bottom+Height320(12), MSW-Width320(32), size.height)];
    
    hintLabel.text = hintStr;
    
    hintLabel.textColor = UIColorFromRGB(0xff5252);
    
    hintLabel.numberOfLines = 0;
    
    hintLabel.font = AllFont(12);
    
    [self.view addSubview:hintLabel];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    self.hud.mode = MBProgressHUDModeText;
    
    [self.view addSubview:self.hud];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)confirm:(UIButton *)btn
{
    
    NSString *regex;
    
    if ([self.phoneTF.country.countryNo isEqualToString:@"+886"]) {
        
        regex = @"^[0][9][0-9]{8}$";
        
    }else if ([self.phoneTF.country.countryNo isEqualToString:@"+86"]) {
        
        regex = @"^[1][34578][0-9]{9}$";
        
    }
    
    regex = @"^[1][34578][0-9]{9}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (!self.oldTF.text.length){
        
        [self errorWithInfo:@"请输入密码"];
        
    }else if (!self.phoneTF.text.length) {
        
        [self errorWithInfo:@"请输入手机号"];
        
    }else if (![pred evaluateWithObject:self.phoneTF.text]){
        
        [self errorWithInfo:@"请输入正确手机号"];
        
    }else if (!self.codeTF.text.length){
        
        [self errorWithInfo:@"请输入验证码"];
        
    }else{
        
        self.confirmBtn.userInteractionEnabled = NO;
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"请稍候";
        
        [self.hud showAnimated:YES];
        
        Parameters *para = [[Parameters alloc]init];
        
        [para setParameter:self.oldTF.text forKey:@"password"];
        
        [para setParameter:self.phoneTF.text forKey:@"phone"];
        
        [para setParameter:self.codeTF.text forKey:@"code"];
        
        [para setParameter:self.phoneTF.country.countryNo forKey:@"area_code"];
        
        NSString *api = [NSString stringWithFormat:kChangePhone,StaffId];
        
        [MOAFHelp AFPostHost:ROOT bindPath:api postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue]==200) {
                
                self.hud.label.text = @"修改成功";
                
                self.hud.mode = MBProgressHUDModeText;
                
                [self.hud showAnimated:YES];
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                    if (self.edit) {
                        self.edit();
                    }
                    
                });
                
            }else
            {
                
                [self errorWithInfo:responseDic[@"msg"]];
                
                self.confirmBtn.userInteractionEnabled = YES;
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            [self errorWithInfo:error];
            
            self.confirmBtn.userInteractionEnabled = YES;
            
        }];
        
    }
    
}

//发送验证码
-(void)codeClick:(UIButton*)btn
{
    
    [self.phoneTF resignFirstResponder];
    
    NSString *regex;
    
    if ([self.phoneTF.country.countryNo isEqualToString:@"+886"]) {
        
        regex = @"^[0][9][0-9]{8}$";
        
    }else if ([self.phoneTF.country.countryNo isEqualToString:@"+86"]) {
        
        regex = @"^[1][34578][0-9]{9}$";
        
    }
    
    regex = @"^[1][34578][0-9]{9}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![pred evaluateWithObject:self.phoneTF.text]) {
        
        [self errorWithInfo:@"手机号输入错误"];
        
        return;
        
    }
    
    self.codeView.userInteractionEnabled = NO;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:self.phoneTF.text forKey:@"phone"];
    
    [para setParameter:self.phoneTF.country.countryNo forKey:@"area_code"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:kGetCode postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            [self startTimer];
            
        }else
        {
            
            [self errorWithInfo:responseDic[@"msg"]];
            
            self.codeView.userInteractionEnabled = YES;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        [self errorWithInfo:error];
        
        self.codeView.userInteractionEnabled = YES;
        
    }];
    
}

- (void)startTimer
{
    _coolTime = 60.;
    _stepTime = 1;
    self.coolDownTimer = [NSTimer scheduledTimerWithTimeInterval:_stepTime target:self selector:@selector(coolDownCount) userInfo:nil repeats:YES];
}

- (void)coolDownCount
{
    _coolTime = _coolTime - _stepTime;
    [self.codeView setTitle:[NSString stringWithFormat:@"%lds后重新发送", (long)_coolTime]];
    if (_coolTime <= 0) {
        [self.codeView setTitle:@"发送验证码"];
        self.codeView.userInteractionEnabled = YES;
        [self.coolDownTimer invalidate];
        self.coolDownTimer = nil;
    }
}

-(void)errorWithInfo:(NSString *)info
{
    
    self.hud.mode = MBProgressHUDModeText;
    
    self.hud.label.text = info;
    
    [self.hud showAnimated:YES];
    
    [self.hud hideAnimated:YES afterDelay:1.0f];
    
}

@end
