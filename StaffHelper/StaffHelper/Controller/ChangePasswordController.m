//
//  ChangePasswordController.m
//  健身教练助手
//
//  Created by 馍馍帝😈 on 15/8/14.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import "ChangePasswordController.h"

#import "QCTextField.h"

#import "CodeButton.h"

#import "CountryChooseTextField.h"

#define kGetCode @"/api/send/verify/"

#define kChangePassword @"/api/staffs/%ld/change/password/"

@interface ChangePasswordController ()<MONaviDelegate,UITextFieldDelegate>
{
    
    //定时器的冷却事件和步长
    NSInteger _coolTime;
    NSInteger _stepTime;
    
}
@property(nonatomic,strong)NSTimer *coolDownTimer;//定时器

@property(nonatomic,strong)CountryChooseTextField *phoneTF;

@property(nonatomic,strong)QCTextField *codeTF;

@property(nonatomic,strong)QCTextField *nowTF;

@property(nonatomic,strong)QCTextField *confirmTF;

@property(nonatomic,strong)CodeButton *codeView;

@property(nonatomic,strong)UIButton *confirmBtn;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation ChangePasswordController

- (void)viewDidLoad {
    
    [super viewDidLoad];
        
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    
    self.title = @"更改密码";
        
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(160))];
    
    topView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:topView];
    
    self.phoneTF = [[CountryChooseTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.phoneTF.font = STFont(14);
    
    self.phoneTF.textColor = UIColorFromRGB(0x222222);
    
    self.phoneTF.placeholderColor = UIColorFromRGB(0x999999);

    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.phoneTF.delegate = self;
    
    [topView addSubview:self.phoneTF];
    
    self.codeTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.phoneTF.bottom, MSW-Width320(32), Height320(40))];
    
    self.codeTF.textColor = UIColorFromRGB(0x222222);
    
    self.codeTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.codeTF.font = STFont(14);
    
    self.codeTF.placeholder = @"手机验证码";
    
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.codeTF.delegate = self;
    
    [topView addSubview:self.codeTF];
    
    self.codeView = [[CodeButton alloc]initWithFrame:CGRectMake(self.codeTF.width-Width320(80), 0, Width320(80), self.codeTF.height)];
    
    self.codeView.title = @"发送验证码";
    
    self.codeTF.rightView = self.codeView;
    
    self.codeTF.rightViewMode = UITextFieldViewModeAlways;
    
    [self.codeView addTarget:self action:@selector(codeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nowTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.codeTF.bottom, MSW-Width320(32), Height320(40))];
    
    self.nowTF.textColor = UIColorFromRGB(0x222222);
    
    self.nowTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.nowTF.font = STFont(14);
    
    self.nowTF.placeholder = @"新密码";
    
    self.nowTF.secureTextEntry = YES;
    
    self.nowTF.delegate = self;
    
    [topView addSubview:self.nowTF];
    
    self.confirmTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.nowTF.bottom, MSW-Width320(32), Height320(40))];
    
    self.confirmTF.textColor = UIColorFromRGB(0x222222);
    
    self.confirmTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.confirmTF.font = STFont(14);
    
    self.confirmTF.placeholder = @"确认新密码";
    
    self.confirmTF.secureTextEntry = YES;
    
    self.confirmTF.delegate = self;
    
    self.confirmTF.noLine = YES;
    
    [topView addSubview:self.confirmTF];
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.confirmBtn.frame = CGRectMake(Width320(16), topView.bottom+Height320(17.5), MSW-Width320(32), Height320(40));
    
    self.confirmBtn.backgroundColor = kMainColor;
    
    [self.confirmBtn setTitle:@"确  定" forState:UIControlStateNormal];
    
    [self.confirmBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    self.confirmBtn.layer.cornerRadius = 2;
    
    self.confirmBtn.layer.masksToBounds = YES;
    
    [self.confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    
    self.confirmBtn.titleLabel.font = STFont(16);
    
    [self.view addSubview:self.confirmBtn];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    self.hud.mode = MBProgressHUDModeText;
    
    [self.view addSubview:self.hud];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.phoneTF resignFirstResponder];
    
    [self.codeTF resignFirstResponder];
    
    [self.nowTF resignFirstResponder];
    
    [self.confirmTF resignFirstResponder];
    
}

//发送验证码
-(void)codeClick:(UIButton*)btn
{
    
    [self.phoneTF resignFirstResponder];
    
    NSString *regex;
    
    if ([self.phoneTF.country.countryNo isEqualToString:@"+886"]) {
        
        regex = @"^[9][0-9]{8}$";
        
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


-(void)confirm:(UIButton *)btn
{
    
    if (![self.nowTF.text isEqualToString:self.confirmTF.text]) {
       
        [self errorWithInfo:@"两次输入密码不一致"];
        
        return;
       
    }
    
    self.confirmBtn.userInteractionEnabled = NO;
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"请稍候";
    
    [self.hud showAnimated:YES];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:self.phoneTF.text forKey:@"phone"];
    
    [para setParameter:self.codeTF.text forKey:@"code"];
    
    [para setParameter:self.nowTF.text forKey:@"password"];
    
    [para setParameter:self.phoneTF.country.countryNo forKey:@"area_code"];
    
    NSString *api = [NSString stringWithFormat:kChangePassword,StaffId];
    
   [MOAFHelp AFPostHost:ROOT bindPath:api postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
       
       if ([responseDic[@"status"]integerValue]==200) {
           
           self.hud.mode = MBProgressHUDModeText;
           
           self.hud.label.text = @"修改成功";
           
           [self.hud showAnimated:YES];
           
           [self.hud hideAnimated:YES afterDelay:1.5];
           
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               
               [self.navigationController popViewControllerAnimated:YES];
               
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

-(void)errorWithInfo:(NSString *)info
{
    
    self.hud.mode = MBProgressHUDModeText;
    
    self.hud.label.text = info;
    
    [self.hud showAnimated:YES];
    
    [self.hud hideAnimated:YES afterDelay:1.0f];
    
}


@end
