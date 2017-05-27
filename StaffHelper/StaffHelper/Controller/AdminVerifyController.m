//
//  AdminVerifyController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "AdminVerifyController.h"

#import "QCTextField.h"

#import "AdminChangeController.h"

#import "KeyboardManager.h"

#define kGetCode @"/api/send/verify/"

#define kCheckAPI @"/api/check/verify/"

@interface AdminVerifyController ()<UITextFieldDelegate>

{
    
    //定时器的冷却事件和步长
    NSInteger _coolTime;
    NSInteger _stepTime;
    
}
@property(nonatomic,strong)NSTimer *coolDownTimer;//定时器

@property(nonatomic,strong)UIButton *nextButton;

@property(nonatomic,strong)UIButton *sendButton;

@property(nonatomic,strong)QCTextField *codeTF;

@end

@implementation AdminVerifyController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    
}

-(void)dealloc
{
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
}

-(void)createUI
{
    
    self.title = @"身份验证";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *hintView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(34))];
    
    hintView.backgroundColor = [UIColorFromRGB(0xEA6161) colorWithAlphaComponent:0.1];
    
    [self.view addSubview:hintView];
    
    UIImageView *hintImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(10), Width320(14), Height320(14))];
    
    hintImg.image = [[UIImage imageNamed:@"hint_circle"]imageWithTintColor:UIColorFromRGB(0xEA6161)];
    
    [hintView addSubview:hintImg];
    
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(hintImg.right+Width320(6), 0, Width320(210), Height320(34))];
    
    hintLabel.text = @"为了保证安全，请先进行身份验证";
    
    hintLabel.textColor = UIColorFromRGB(0xEA6161);
    
    hintLabel.font = AllFont(12);
    
    [hintView addSubview:hintLabel];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, hintView.bottom, MSW, Height320(128))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = OnePX;
    
    [self.view addSubview:topView];
    
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), Width320(48), Height320(48))];
    
    if (self.admin.iconUrl.absoluteString.length) {
        
        [iconView sd_setImageWithURL:self.admin.iconUrl];
        
    }else{
        
        iconView.image = [UIImage imageNamed:self.admin.sex == SexTypeMan?@"img_default_staff_male":@"img_default_staff_female"];
        
    }
    
    [topView addSubview:iconView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(iconView.right+Width320(12), Height320(22), Width320(220), Height320(18))];
    
    nameLabel.text = self.admin.name;
    
    nameLabel.textColor = UIColorFromRGB(0x333333);
    
    nameLabel.font = AllFont(14);
    
    [topView addSubview:nameLabel];
    
    [nameLabel autoWidth];
    
    UIImageView *sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(nameLabel.right+Width320(6), Height320(24), Width320(12), Height320(12))];
    
    if (self.admin.sex == SexTypeMan) {
        
        sexImg.image = [UIImage imageNamed:@"sex_male"];
        
    }else
    {
        
        sexImg.image = [UIImage imageNamed:@"sex_female"];
        
    }
    
    [topView addSubview:sexImg];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), Height320(80)-OnePX, MSW-Width320(32), OnePX)];
    
    line.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [topView addSubview:line];
    
    UILabel *phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(80), Width320(170), Height320(48))];
    
    phoneLabel.text = [NSString stringWithFormat:@"向%@发送验证码",self.admin.phone];
    
    [topView addSubview:phoneLabel];
    
    self.sendButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(93), Height320(91), Width320(77), Height320(28))];
    
    self.sendButton.layer.cornerRadius = Width320(2);
    
    self.sendButton.layer.borderColor = kMainColor.CGColor;
    
    self.sendButton.layer.borderWidth = OnePX;
    
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    
    [self.sendButton setTitleColor:kMainColor forState:UIControlStateNormal];
    
    self.sendButton.titleLabel.font = AllFont(14);
    
    [topView addSubview:self.sendButton];
    
    [self.sendButton addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *codeView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(12), MSW, Height320(40))];
    
    codeView.backgroundColor = UIColorFromRGB(0xffffff);
    
    codeView.layer.borderWidth = OnePX;
    
    codeView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    [self.view addSubview:codeView];
    
    self.codeTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.codeTF.placeholder = @"验证码";
    
    self.codeTF.textPlaceholder = @"输入收到的验证码";
    
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.codeTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [codeView addSubview:self.codeTF];
    
    self.nextButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), codeView.bottom+Height320(15), MSW-Width320(32), Height320(40))];
    
    self.nextButton.backgroundColor = kMainColor;
    
    self.nextButton.alpha = 0.4;
    
    self.nextButton.userInteractionEnabled = NO;
    
    [self.nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    
    [self.nextButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    self.nextButton.titleLabel.font = AllFont(14);
    
    [self.view addSubview:self.nextButton];
    
    [self.nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)next
{
    
    self.nextButton.userInteractionEnabled = NO;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:self.codeTF.text forKey:@"code"];
    
    [para setParameter:UserPhone forKey:@"phone"];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    hud.mode = MBProgressHUDModeText;
    
    [self.view addSubview:hud];
    
    [MOAFHelp AFPostHost:ROOT bindPath:kCheckAPI postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        self.nextButton.userInteractionEnabled = YES;
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            AdminChangeController *svc = [[AdminChangeController alloc]init];
            
            svc.admin = self.admin;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            hud.label.text = responseDic[@"msg"];
            
            [hud showAnimated:YES];
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        hud.label.text = error;
        
        [hud showAnimated:YES];
        
        [hud hideAnimated:YES afterDelay:1.5];
        
    }];
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    self.nextButton.alpha = textField.text.length?1:0.4;
    
    self.nextButton.userInteractionEnabled = textField.text.length?YES:NO;
    
}

-(void)sendClick
{
    
    self.sendButton.userInteractionEnabled = NO;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:self.admin.phone forKey:@"phone"];
    
    [para setParameter:self.admin.country.countryNo forKey:@"area_code"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:kGetCode postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            [self startTimer];
            
        }else
        {
            
            MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
            
            [self.view addSubview:hud];
            
            hud.mode = MBProgressHUDModeText;
            
            hud.label.text = responseDic[@"msg"];
            
            [hud showAnimated:YES];
            
            [hud hideAnimated:YES afterDelay:1.5];
            
            self.sendButton.userInteractionEnabled = YES;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        
        [self.view addSubview:hud];
        
        hud.mode = MBProgressHUDModeText;
        
        hud.label.text = error;
        
        [hud showAnimated:YES];
        
        [hud hideAnimated:YES afterDelay:1.5];
        
        self.sendButton.userInteractionEnabled = YES;
        
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
    
    self.sendButton.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
    
    [self.sendButton setTitleColor:UIColorFromRGB(0xcccccc) forState:UIControlStateNormal];
    
    [self.sendButton setTitle:[NSString stringWithFormat:@"已发送(%ld)", (long)_coolTime] forState:UIControlStateNormal];
    
    if (_coolTime <= 0) {
        
        self.sendButton.layer.borderColor = kMainColor.CGColor;
        
        [self.sendButton setTitleColor:kMainColor forState:UIControlStateNormal];
        
        [self.sendButton setTitle:@"重新发送" forState:UIControlStateNormal];
        self.sendButton.userInteractionEnabled = YES;
        
        [self.coolDownTimer invalidate];
        
        self.coolDownTimer = nil;
    }
}


@end
