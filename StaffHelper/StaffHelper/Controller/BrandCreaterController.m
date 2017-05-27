//
//  BrandCreaterController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "BrandCreaterController.h"

#import "QCTextField.h"

#import "CodeButton.h"

#import "MOPickerView.h"

#import "QCKeyboardView.h"

#import "BrandListInfo.h"

#import "CountryChooseTextField.h"

#define kGetCode @"/api/send/verify/"

@interface BrandCreaterController ()<UITextFieldDelegate,QCKeyboardViewDelegate>
{
    
    //定时器的冷却事件和步长
    NSInteger _coolTime;
    NSInteger _stepTime;
    
}

@property(nonatomic,strong)NSTimer *coolDownTimer;//定时器

@property(nonatomic,strong)CodeButton *codeView;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *sexTF;

@property(nonatomic,strong)MOPickerView *sexPV;

@property(nonatomic,strong)CountryChooseTextField *phoneTF;

@property(nonatomic,strong)QCTextField *codeTF;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation BrandCreaterController

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
    
    self.title = @"修改创建人";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.rightTitle = @"确定";
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(40)*4)];
    
    topView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:topView];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.nameTF.placeholder = @"姓名";
    
    self.nameTF.delegate = self;
    
    [topView addSubview:self.nameTF];
    
    self.sexTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.nameTF.bottom, MSW-Width320(32), Height320(40))];
    
    self.sexTF.placeholder = @"性别";
    
    self.sexTF.delegate = self;
    
    self.sexTF.text = @"男";
    
    [topView addSubview:self.sexTF];
    
    QCKeyboardView *sexKV = [QCKeyboardView defaultKeboardView];
    
    sexKV.delegate = self;
    
    self.sexTF.inputView = sexKV;
    
    self.sexPV = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.sexPV.titleArray = @[@"男",@"女"];
    
    sexKV.keyboard = self.sexPV;
    
    self.phoneTF = [[CountryChooseTextField alloc]initWithFrame:CGRectMake(Width320(16), self.sexTF.bottom, MSW-Width320(32), Height320(40))];

    self.phoneTF.delegate = self;
    
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [topView addSubview:self.phoneTF];
    
    self.codeTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.phoneTF.bottom, MSW-Width320(32), Height320(40))];
    
    self.codeTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.codeTF.placeholder = @"手机验证码";
    
    self.codeTF.delegate = self;
    
    self.codeTF.noLine = YES;
    
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [topView addSubview:self.codeTF];
    
    self.codeView = [[CodeButton alloc]initWithFrame:CGRectMake(self.codeTF.width-Width320(80), 0, Width320(80), self.codeTF.height)];
    
    [self.codeView setTitle:@"发送验证码"];
    
    self.codeTF.rightView = self.codeView;
    
    self.codeTF.rightViewMode = UITextFieldViewModeAlways;
    
    [self.codeView addTarget:self action:@selector(codeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    self.hud.mode = MBProgressHUDModeText;
    
    [self.view addSubview:self.hud];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
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

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    [self.view endEditing:YES];
    
    self.sexTF.text = self.sexPV.titleArray[self.sexPV.currentRow];
    
}

-(void)naviRightClick
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
    
    if (!self.nameTF.text.length || !self.phoneTF.text.length ||!self.codeTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"信息填写不完整" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }else if (![pred evaluateWithObject:self.phoneTF.text]){
        
        [[[UIAlertView alloc]initWithTitle:@"手机号格式不正确" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    Staff *owner = [[Staff alloc]init];
    
    owner.sex = [self.sexTF.text isEqualToString:@"女"]?SexTypeWoman:SexTypeMan;
    
    owner.name = self.nameTF.text;
    
    owner.phone = self.phoneTF.text;
    
    owner.country = self.phoneTF.country;
    
    self.brand.owner = owner;
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"";
    
    [self.hud showAnimated:YES];
    
    BrandListInfo *info = [[BrandListInfo alloc]init];
    
    [info changeCreaterOfBrand:self.brand withCode:self.codeTF.text result:^(BOOL success, NSString *error) {
        
        if (success) {
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = @"修改成功";
            
            [self.hud showAnimated:YES];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self popToViewControllerName:@"BrandManagerController" isReloadData:YES];
                
            });
            
        }else
        {
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = error;
            
            self.hud.label.numberOfLines = 0;
            
            [self.hud showAnimated:YES];
            
            [self.hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

@end
