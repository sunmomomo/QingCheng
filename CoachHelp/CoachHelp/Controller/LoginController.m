//
//  LoginController.m
//  健身教练助手
//
//  Created by 馍馍帝😈 on 15/8/10.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import "LoginController.h"

#import "LoginLineView.h"

#import "ServicesInfo.h"

#import "BrandListInfo.h"

#import "QCTextField.h"

#import "SettingController.h"

#import "GuideSyncGymController.h"

#import "CodeButton.h"

#import "QCKeyboardView.h"

#import "BPush.h"

#import "AppDelegate.h"

#import "CountryChooseTextField.h"

#import "GuideGymSetController.h"

#import "GuideBrandSetController.h"

#import "RootController.h"

#import "BrandListController.h"

#define kTFTop Height320(20)

#define kTFGap Height320(20)

#define kRegister @"/api/v1/coaches/register/"

#define kGetCode @"/api/send/verify/"

@interface LoginController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,QCKeyboardViewDelegate>

{
    
    //定时器的冷却事件和步长
    NSInteger _coolTime;
    NSInteger _stepTime;
    
}
@property(nonatomic,strong)NSTimer *coolDownTimer;//定时器

@property(nonatomic,strong)UIButton *loginTitleBtn;

@property(nonatomic,strong)UIButton *registerTitleBtn;

@property(nonatomic,strong)LoginLineView *lineView;

@property(nonatomic,strong)CountryChooseTextField *phoneTF;

@property(nonatomic,strong)QCTextField *pwdTF;

@property(nonatomic,strong)QCTextField *sexTF;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *codeTF;

@property(nonatomic,strong)QCTextField *pwdTF1;

@property(nonatomic,strong)CodeButton *codeView;

@property(nonatomic,assign)BOOL codeLogin;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UIButton *typeChooseBtn;

@property(nonatomic,strong)UIButton *nextBtn;

@property(nonatomic,strong)UIButton *registerBtn;

@property(nonatomic,strong)UIView *loginView;

@property(nonatomic,strong)UIView *registerView;

@property(nonatomic,strong)UIPickerView *sexPV;

@property(nonatomic,assign)NSInteger sexNum;

@property(nonatomic,strong)NSArray *sexArray;

@property(nonatomic,strong)UIImageView *pwdRightImg;

@end

@implementation LoginController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
        
    [self createData];
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.sexArray = @[@"男",@"女"];
    
    self.sexNum = 0;
    
    self.codeLogin = YES;
    
}

//创建UI
-(void)createUI
{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 64)];
    
    topView.backgroundColor = kMainColor;
    
    [self.view addSubview:topView];
    
    self.loginTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.loginTitleBtn setFrame:CGRectMake(0, 20+Height320(8), MSW/2, Height320(22.5))];
    
    self.loginTitleBtn.titleLabel.font = STFont(16);
    
    [self.loginTitleBtn setBackgroundColor:[UIColor clearColor]];
    
    [self.loginTitleBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    self.loginTitleBtn.tag = 0;
    
    [self.loginTitleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:self.loginTitleBtn];
    
    self.registerTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.registerTitleBtn setFrame:CGRectMake(MSW/2, self.loginTitleBtn.top,self.loginTitleBtn.width,self.loginTitleBtn.height)];
    
    self.registerTitleBtn.titleLabel.font = self.loginTitleBtn.titleLabel.font;
    
    [self.registerTitleBtn setBackgroundColor:[UIColor clearColor]];
    
    [self.registerTitleBtn setTitle:@"注册" forState:UIControlStateNormal];
    
    self.registerTitleBtn.tag = 1;
    
    [self.registerTitleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:self.registerTitleBtn];
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 48, 44)];
    
    [leftButton addTarget:self action:@selector(naviLeftClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, leftButton.width*0.4, leftButton.height*0.4)];
    
    leftImg.contentMode = UIViewContentModeScaleAspectFit;
    
    leftImg.userInteractionEnabled = NO;
    
    leftImg.center = CGPointMake(leftButton.width/2, leftButton.height/2);
    
    leftImg.image = [UIImage imageNamed:@"navi_back"];
    
    [leftButton addSubview:leftImg];
    
    [topView addSubview:leftButton];
    
    self.lineView = [[LoginLineView alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, 3)];
    
    [self.view addSubview:self.lineView];
    
    self.loginView = [[UIView alloc]initWithFrame:CGRectMake(0, self.lineView.bottom, MSW, MSH-self.lineView.bottom)];
    
    if (self.loginOrRegister == 0) {
        
         [self.lineView setLeftColor:UIColorFromRGB(0xffffff)];
        
        [self.lineView setRightColor:kMainColor];
        
    }else
    {
        
        [self.lineView setLeftColor:kMainColor];
        
        [self.lineView setRightColor:UIColorFromRGB(0xffffff)];
        
    }
    
    [self.view addSubview:self.loginView];
    
    self.registerView = [[UIView alloc]initWithFrame:self.loginView.frame];
    
    [self.view addSubview:self.registerView];
    
    self.phoneTF = [[CountryChooseTextField alloc]initWithFrame:CGRectMake(Width320(16), kTFTop, MSW-Width320(32), Height320(44))];
    
    self.phoneTF.delegate = self;
    
    self.phoneTF.leftImg = [UIImage imageNamed:@"phone"];
    
    [self.phoneTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.loginView addSubview:self.phoneTF];
    
    self.pwdTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.phoneTF.left, self.phoneTF.bottom+kTFGap, self.phoneTF.width, self.phoneTF.height)];
    
    self.pwdTF.placeholder = @"密码";
    
    self.pwdTF.delegate = self;
    
    self.pwdTF.leftImg = [UIImage imageNamed:@"lock"];
    
    [self.loginView addSubview:self.pwdTF];
    
    self.codeView = [[CodeButton alloc]initWithFrame:CGRectMake(self.phoneTF.width-Width320(80), 0, Width320(80), self.phoneTF.height)];
    
    [self.codeView setTitle:@"发送验证码"];
    
    self.pwdTF.rightView = self.codeView;
    
    self.pwdTF.rightViewMode = UITextFieldViewModeAlways;
    
    [self.codeView addTarget:self action:@selector(codeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.typeChooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.typeChooseBtn.frame = CGRectMake(34, self.pwdTF.bottom+Height320(30), Width320(150), Height320(35));
    
    self.typeChooseBtn.titleLabel.font = STFont(14);
    
    self.typeChooseBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self.typeChooseBtn setTitleColor:UIColorFromRGB(0x747474) forState:UIControlStateNormal];
    
    [self.typeChooseBtn addTarget:self action:@selector(typeChoose:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.loginView addSubview:self.typeChooseBtn];
    
    [self setLoginTypeWithType:self.codeLogin];
    
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.nextBtn.frame = CGRectMake(MSW-163, self.pwdTF.bottom+Height320(30), 133, 48);
    
    self.nextBtn.backgroundColor = kMainColor;
    
    [self.nextBtn setTitle:@"登 录" forState:UIControlStateNormal];
    
    self.nextBtn.titleLabel.font = STFont(16);
    
    self.nextBtn.layer.cornerRadius = 1;
    
    self.nextBtn.layer.masksToBounds = YES;
    
    [self.nextBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [self.loginView addSubview:self.nextBtn];
    
    [self.nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:self.phoneTF.frame];
    
    self.nameTF.placeholder = @"名字";
    
    self.nameTF.delegate = self;
    
    self.nameTF.leftImg = [UIImage imageNamed:@"user"];
    
    [self.registerView addSubview:self.nameTF];
    
    self.sexTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom+kTFGap, self.nameTF.width, self.nameTF.height)];
    
    self.sexTF.placeholder = @"性别";
    
    self.sexTF.text = @"男";
    
    self.sexTF.delegate = self;
    
    self.sexTF.leftImg = [UIImage imageNamed:@"sex"];
    
    [self.registerView addSubview:self.sexTF];
        
    self.sexPV = [[UIPickerView alloc]initWithFrame:CGRectMake(0, Height320(39), MSW, Height320(177))];
    
    self.sexPV.delegate = self;
    
    self.sexPV.dataSource = self;
    
    QCKeyboardView *keyboardView = [[QCKeyboardView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(216))];
    
    keyboardView.keyboard = self.sexPV;
    
    keyboardView.delegate = self;
    
    self.sexTF.inputView = keyboardView;
    
    self.codeTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.sexTF.bottom+2*kTFGap+self.nameTF.height, self.nameTF.width, self.nameTF.height)];
    
    self.codeTF.placeholder = @"手机验证码";
    
    self.codeTF.delegate = self;
    
    self.codeTF.leftImg = [UIImage imageNamed:@"pad"];
    
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.registerView addSubview:self.codeTF];
    
    self.pwdTF1 = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.codeTF.bottom+kTFGap, self.nameTF.width, self.nameTF.height)];
    
    self.pwdTF1.placeholder = @"登录密码";
    
    self.pwdTF1.delegate = self;
    
    self.pwdTF1.leftImg = [UIImage imageNamed:@"lock"];
    
    self.pwdTF1.secureTextEntry = YES;
    
    [self.registerView addSubview:self.pwdTF1];
    
    UIButton *pwdRightView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Width320(48), self.pwdTF1.height)];
    
    self.pwdTF1.rightView = pwdRightView;
    
    self.pwdTF1.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *pwdLine = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), pwdRightView.height/2-Height320(10), OnePX, Height320(20))];
    
    pwdLine.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [pwdRightView addSubview:pwdLine];
    
    self.pwdRightImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(26), pwdRightView.height/2-Height320(7.5), Width320(20), Height320(15))];
    
    self.pwdRightImg.image = [UIImage imageNamed:@"secure_enter"];
    
    self.pwdRightImg.contentMode = UIViewContentModeScaleAspectFit;
    
    [pwdRightView addSubview:self.pwdRightImg];
    
    [pwdRightView addTarget:self action:@selector(pwdTF1RightClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.registerBtn.frame = CGRectMake(MSW-Width320(144), self.pwdTF1.bottom+Height320(22), Width320(132), Height320(43));
    
    self.registerBtn.backgroundColor = kMainColor;
    
    [self.registerBtn setTitle:@"完成" forState:UIControlStateNormal];
    
    [self.registerBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    [self.registerBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.registerView addSubview:self.registerBtn];
    
    [self setBtnStyleWithNum:self.loginOrRegister];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    self.hud.mode = MBProgressHUDModeText;
    
    [self.view addSubview:self.hud];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboadeView
{
    
    self.sexTF.text = self.sexArray[self.sexNum];
    
    [self.sexTF resignFirstResponder];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    self.sexNum = row;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return self.sexArray.count;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
    
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return self.sexArray[row];
    
}

-(void)next:(UIButton*)btn
{
    
    [self.view endEditing:YES];
    
    NSString *regex;
    
    if ([self.phoneTF.country.countryNo isEqualToString:@"+886"]) {
        
        regex = @"^[0][9][0-9]{8}$";
        
    }else if ([self.phoneTF.country.countryNo isEqualToString:@"+86"]) {
        
        regex = @"^[1][34578][0-9]{9}$";
        
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (!self.phoneTF.text.length) {
        
        [self errorWithDesc:@"尚未输入手机号"];
        
    }else if (![pred evaluateWithObject:self.phoneTF.text])
    {
        
        [self errorWithDesc:@"手机号输入错误"];
        
    }
    else if (!self.pwdTF.text.length)
    {
        
        if (!self.codeLogin) {
            
            [self errorWithDesc:@"尚未输入密码"];
            
        }else
        {
            
            [self errorWithDesc:@"尚未输入验证码"];
            
        }
        
    }else
    {
        
        [self login];
        
    }
    
}

-(void)login
{
    
    self.nextBtn.userInteractionEnabled = NO;
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"登录中";
    
    [self.hud showAnimated:YES];
    
    if (self.codeLogin) {
        
        [Login loginWithPhone:self.phoneTF.text andCountryNo:self.phoneTF.country.countryNo andCode:self.pwdTF.text success:^(NSDictionary *responseDic) {
            
            self.nextBtn.userInteractionEnabled = YES;

            if ([responseDic[@"status"]integerValue] == 200) {
                
                [self loginSuccess];
                
            }else
            {
                
                [self errorWithDesc:responseDic[@"msg"]];
                
            }
            
        } failure:^(NSString *errorDesc) {
            
            self.nextBtn.userInteractionEnabled = YES;

            [self errorWithDesc:errorDesc];
            
        }];
        
    }else
    {
        
        [Login loginWithPhone:self.phoneTF.text andCountryNo:self.phoneTF.country.countryNo andPassword:self.pwdTF.text success:^(NSDictionary *responseDic) {
            
            self.nextBtn.userInteractionEnabled = YES;
            
            if ([responseDic[@"status"]integerValue] == 200) {
                
                [self loginSuccess];
                
            }else
            {
                
                [self errorWithDesc:responseDic[@"msg"]];
                
            }
            
        } failure:^(NSString *errorDesc) {
            
            self.nextBtn.userInteractionEnabled = YES;

            [self errorWithDesc:errorDesc];
            
        }];
        
    }
    

}

-(void)registerClick:(UIButton *)btn
{
    
    [self.view endEditing:YES];
    
    NSString *regex;
    
    if ([self.phoneTF.country.countryNo isEqualToString:@"+886"]) {
        
        regex = @"^[0][9][0-9]{8}$";
        
    }else if ([self.phoneTF.country.countryNo isEqualToString:@"+86"]) {
        
        regex = @"^[1][34578][0-9]{9}$";
        
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (!self.phoneTF.text.length) {
        
        [self errorWithDesc:@"尚未输入手机号"];
        
    }else if (![pred evaluateWithObject:self.phoneTF.text]) {
        
        [self errorWithDesc:@"请输入正确的手机号"];
        
    }else if (!self.codeTF.text.length)
    {
     
        [self  errorWithDesc:@"尚未输入验证码"];
        
    }else if (!self.pwdTF1.text.length) {
        
        [self errorWithDesc:@"尚未输入密码"];
        
    }else
    {
        
        [self registerCheck];
        
    }
    
}

-(void)loginSuccess
{
    
    [self.view endEditing:YES];
    
    self.hud.mode = MBProgressHUDModeText;
    
    self.hud.label.text = self.loginOrRegister==0?@"登录成功":@"注册成功";
    
    [self.hud showAnimated:YES];
    
    [self.hud hideAnimated:YES afterDelay:1.5];
    
    if (self.webLogin) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (self.webLoginSuccess) {
                
                self.webLoginSuccess();
                
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            
            [[RootController sharedSliderController]reloadData];
            
        });
        
    }else{
        
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        
        appDelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[RootController sharedSliderController]];
        
        [[RootController sharedSliderController]createDataResult:^{
            
            if (self.pushGuide && ![ServicesInfo shareInfo].services.count) {
                
                [[RootController sharedSliderController]pushGuide];
                
            }
            
        }];
        
    }
    
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    appDelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[RootController sharedSliderController]];
    
    [[RootController sharedSliderController]createDataResult:^{
        
        [[RootController sharedSliderController]setSelectIndex:0];
        
        if (self.pushGuide && ![ServicesInfo shareInfo].services.count) {
            
            [[RootController sharedSliderController]pushGuide];
            
        }
        
    }];
    
}


-(void)registerCheck
{
    
    self.registerBtn.userInteractionEnabled = NO;
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"注册中";
    
    [self.hud showAnimated:YES];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:self.phoneTF.text forKey:@"phone"];
    
    [para setParameter:self.codeTF.text forKey:@"code"];
    
    [para setParameter:[NSString stringWithFormat:@"%ld",(long)self.sexNum] forKey:@"gender"];
    
    [para setParameter:self.pwdTF1.text forKey:@"password"];
    
    [para setParameter:self.nameTF.text forKey:@"username"];
    
    [para setParameter:[BPush getChannelId] forKey:@"push_channel_id"];
    
    [para setParameter:[BPush getUserId] forKey:@"push_id"];
    
    [para setParameter:self.phoneTF.country.countryNo forKey:@"area_code"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:kRegister postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        self.registerBtn.userInteractionEnabled = YES;
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            [[NSUserDefaults standardUserDefaults]setInteger:[responseDic[@"data"][@"coach"][@"id"]integerValue] forKey:@"coachId"];
            
            [[NSUserDefaults standardUserDefaults]setValue:responseDic[@"data"][@"user"][@"username"] forKey:@"coachName"];
            
            [[NSUserDefaults standardUserDefaults]setValue:responseDic[@"data"][@"user"][@"avatar"] forKey:@"coachIcon"];
            
            [[NSUserDefaults standardUserDefaults]setInteger:[responseDic[@"data"][@"user"][@"id"] integerValue] forKey:@"userId"];
            
            [[NSUserDefaults standardUserDefaults]setValue:self.phoneTF.text forKey:@"phone"];
                                    
            [[NSUserDefaults standardUserDefaults] setValue:responseDic[@"data"][@"session_id"] forKey:@"sessionId"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self loginSuccess];

        }else
        {
            
             [self errorWithDesc:responseDic[@"msg"]];
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.registerBtn.userInteractionEnabled = YES;
        
         [self errorWithDesc:error];
        
    }];
}

-(void)pwdTF1RightClick
{
    
    self.pwdTF1.secureTextEntry = !self.pwdTF1.secureTextEntry;
    
    self.pwdRightImg.image = [UIImage imageNamed:self.pwdTF1.secureTextEntry?@"secure_enter":@"insecure_enter"];
    
}

-(void)typeChoose:(UIButton*)btn
{
    self.codeLogin = !self.codeLogin;
    
    self.pwdTF.text = @"";
    
    [self.view endEditing:YES];
    
    [self setLoginTypeWithType:self.codeLogin];
    
}

-(void)setLoginTypeWithType:(BOOL)codeLogin
{
    
    if (codeLogin) {
        
        self.pwdTF.placeholder = @"手机验证码";
        
        self.pwdTF.secureTextEntry = NO;
        
        self.pwdTF.keyboardType = UIKeyboardTypeNumberPad;
        
        self.pwdTF.leftImg = [UIImage imageNamed:@"pad"];
        
        self.pwdTF.rightViewMode = UITextFieldViewModeAlways;
        
        [self.typeChooseBtn setTitle:@"密码登录" forState:UIControlStateNormal];
        
    }else
    {
        self.pwdTF.placeholder = @"密码";
        
        self.pwdTF.secureTextEntry = YES;
        
        self.pwdTF.keyboardType = UIKeyboardTypeDefault;
        
        self.pwdTF.leftImg = [UIImage imageNamed:@"lock"];
        
        self.pwdTF.rightViewMode = UITextFieldViewModeNever;
        
        [self.typeChooseBtn setTitle:@"验证码登录" forState:UIControlStateNormal];
        
    }
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    if (textField == self.phoneTF) {
        
        if (textField.text.length >= 11) {
            
            textField.text = [textField.text substringToIndex:11];
            
        }
        
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
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![pred evaluateWithObject:self.phoneTF.text]) {
        
        [self errorWithDesc:@"手机号输入错误"];
        
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
            
            [self errorWithDesc:responseDic[@"msg"]];
            
            self.codeView.userInteractionEnabled = YES;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        [self errorWithDesc:error];
        
        self.codeView.userInteractionEnabled = YES;
        
    }];
    
}

-(void)errorWithDesc:(NSString *)desc
{
    
    self.hud.mode = MBProgressHUDModeText;
    
    self.hud.label.text = desc;
        
    [self.hud showAnimated:YES];
    
    [self.hud hideAnimated:YES afterDelay:1.0f];
    
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


-(void)titleBtnClick:(UIButton *)btn
{
    
    if (btn.tag == 0) {
        
        self.loginTitleBtn.userInteractionEnabled = NO;
        
        self.registerTitleBtn.userInteractionEnabled = YES;
        
        [self.lineView setLeftColor:UIColorFromRGB(0xffffff)];
        
        [self.lineView setRightColor:kMainColor];

    }else
    {
        
        self.loginTitleBtn.userInteractionEnabled = YES;
        
        self.registerTitleBtn.userInteractionEnabled = NO;
        
        [self.lineView setLeftColor:kMainColor];
        
        [self.lineView setRightColor:UIColorFromRGB(0xffffff)];

    }
    
    [self setBtnStyleWithNum:btn.tag];
}

-(void)setBtnStyleWithNum:(NSInteger)num
{
    
    if (num == 0)
    {
        
        self.codeTF.rightView = nil;
        
        self.pwdTF.rightView = self.codeView;
        
        if (num != self.loginOrRegister) {
            
            self.codeTF.text = @"";
            
            self.pwdTF.text = @"";
            
            [self.view endEditing:YES];
            
        }
        
        if (!self.codeLogin) {
            
            self.pwdTF.rightViewMode = UITextFieldViewModeNever;
            
        }
        
        self.typeChooseBtn.hidden = NO;
        
        [self.loginTitleBtn setTitleColor:RGBACOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
        
        [self.registerTitleBtn setTitleColor:RGBACOLOR(255, 255, 255, 0.6) forState:UIControlStateNormal];
        
        self.loginView.hidden = NO;
        
        self.registerView.hidden = YES;
        
        [self.phoneTF changeTop:kTFTop];
        
        [self.loginView addSubview:self.phoneTF];
        
        self.loginOrRegister = 0;
        
    }else
    {
        
        if (num != self.loginOrRegister) {
            
            self.codeTF.text = @"";
            
            self.pwdTF.text = @"";
            
            [self.view endEditing:YES];
            
        }
        
        self.pwdTF.rightView = nil;
        
        self.codeTF.rightView = self.codeView;
        
        self.codeTF.rightViewMode = UITextFieldViewModeAlways;
        
        self.typeChooseBtn.hidden = YES;
        
        
        [self.loginTitleBtn setTitleColor:RGBACOLOR(255, 255, 255, 0.6) forState:UIControlStateNormal];
        
        [self.registerTitleBtn setTitleColor:RGBACOLOR(255, 255, 255, 1) forState:UIControlStateNormal];
        
        self.loginView.hidden = YES;
        
        self.registerView.hidden = NO;
        
        [self.phoneTF changeTop:(kTFGap*2+self.phoneTF.height*2+kTFTop)];
        
        [self.registerView addSubview:self.phoneTF];
        
        self.loginOrRegister = 1;
        
    }
    
}

-(void)naviLeftClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
