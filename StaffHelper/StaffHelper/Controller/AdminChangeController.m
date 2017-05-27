//
//  AdminChangeController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "AdminChangeController.h"

#import "CodeButton.h"

#import "QCTextField.h"

#import "CountryChooseTextField.h"

#import "StaffListInfo.h"

#import "ServicesInfo.h"

#import "BrandListInfo.h"

#import "GuideCreateBrandController.h"

#import "GuideSetGymController.h"

#import "RootController.h"

#import "HomeController.h"

#import "BrandListController.h"

#import "LoginController.h"

#define kGetCode @"/api/send/verify/"

@interface AdminChangeController ()<UITextFieldDelegate,UIScrollViewDelegate,UIAlertViewDelegate>

{
    
    //定时器的冷却事件和步长
    NSInteger _coolTime;
    NSInteger _stepTime;
    
}
@property(nonatomic,strong)NSTimer *coolDownTimer;//定时器

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *codeTF;

@property(nonatomic,strong)CountryChooseTextField *phoneTF;

@property(nonatomic,strong)CodeButton *codeView;

@property(nonatomic,strong)UILabel *freshAdminLabel;

@property(nonatomic,strong)UIButton *confirmButton;

@property(nonatomic,strong)UILabel *hintLabel;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation AdminChangeController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    
    
}

-(void)createUI
{
    
    self.title = @"填写新超级管理员信息";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.delegate = self;
    
    [self.view addSubview:self.mainView];
    
    UIView *hintView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(54))];
    
    hintView.backgroundColor = [UIColorFromRGB(0xEA6161) colorWithAlphaComponent:0.1];
    
    [self.mainView addSubview:hintView];
    
    UIImageView *hintImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(12), Width320(14), Height320(14))];
    
    hintImg.image = [[UIImage imageNamed:@"hint_circle"]imageWithTintColor:UIColorFromRGB(0xEA6161)];
    
    [hintView addSubview:hintImg];
    
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(10), MSW-Width320(32), Height320(34))];
    
    hintLabel.textColor = UIColorFromRGB(0xEA6161);
    
    hintLabel.font = AllFont(12);
    
    hintLabel.numberOfLines = 0;
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"      变更成功后，%@将自动从工作人员中移除，如有需要请重新添加",self.admin.name]];
    
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle1 setLineSpacing:Height320(4)];
    
    [astr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [astr length])];
    
    hintLabel.attributedText = astr;
    
    [hintView addSubview:hintLabel];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, hintView.bottom, MSW, Height320(128))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = OnePX;
    
    [self.mainView addSubview:topView];
    
    UIImageView *adminIconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(74), Height320(20), Width320(64), Height320(64))];
    
    if (self.admin.iconUrl.absoluteString.length) {
        
        [adminIconView sd_setImageWithURL:self.admin.iconUrl];
        
    }else{
        
        adminIconView.image = [UIImage imageNamed:self.admin.sex == SexTypeMan?@"img_default_staff_male":@"img_default_staff_female"];
        
    }
    
    [topView addSubview:adminIconView];
    
    UILabel *adminLabel = [[UILabel alloc]initWithFrame:CGRectMake(adminIconView.left-Width320(20), adminIconView.bottom+Height320(10), adminIconView.width+Width320(40), Height320(16))];
    
    adminLabel.text = self.admin.name;
    
    adminLabel.textColor = UIColorFromRGB(0x333333);
    
    adminLabel.font = AllFont(14);
    
    adminLabel.textAlignment = NSTextAlignmentCenter;
    
    [topView addSubview:adminLabel];
    
    UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(adminIconView.right+Width320(8), Height320(41), Width320(28), Height320(22))];
    
    arrowImg.image = [UIImage imageNamed:@"admin_change_arrow"];
    
    [topView addSubview:arrowImg];
    
    UIImageView *newImg = [[UIImageView alloc]initWithFrame:CGRectMake(arrowImg.right+Width320(8), adminIconView.top, adminIconView.width, adminIconView.height)];
    
    newImg.image = [UIImage imageNamed:@"admin_change_icon"];
    
    [topView addSubview:newImg];
    
    self.freshAdminLabel = [[UILabel alloc]initWithFrame:CGRectMake(newImg.left-Width320(20), newImg.bottom+Height320(10), newImg.width+Width320(40), Height320(16))];
    
    self.freshAdminLabel.text = @"新超级管理员";
    
    self.freshAdminLabel.textColor = UIColorFromRGB(0x333333);
    
    self.freshAdminLabel.font = AllFont(14);
    
    self.freshAdminLabel.textAlignment = NSTextAlignmentCenter;
    
    [topView addSubview:self.freshAdminLabel];
    
    UIImageView *secView = [[UIImageView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(8), MSW, Height320(40)*4+Height320(7))];
    
    secView.image = [UIImage imageNamed:@"admin_change_back"];
    
    secView.userInteractionEnabled = YES;
    
    [self.mainView addSubview:secView];
    
    UILabel *fLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(7), MSW-Width320(32), Height320(40))];
    
    fLabel.text = @"新超级管理员信息";
    
    fLabel.textColor = UIColorFromRGB(0x333333);
    
    fLabel.font = AllFont(12);
    
    [secView addSubview:fLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), fLabel.bottom-OnePX, MSW-Width320(32), OnePX)];
    
    line.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [secView addSubview:line];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), fLabel.bottom, MSW-Width320(32), Height320(40))];
    
    self.nameTF.placeholder = @"姓名";
    
    self.nameTF.textPlaceholder = @"新超级管理员的姓名";
    
    self.nameTF.delegate = self;
    
    [self.nameTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [secView addSubview:self.nameTF];
    
    self.phoneTF = [[CountryChooseTextField alloc]initWithFrame:CGRectMake(Width320(16), self.nameTF.bottom, MSW-Width320(32), Height320(40))];
    
    self.phoneTF.textPlaceholder = @"新超级管理员的手机号";
    
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.phoneTF.returnKeyType = UIReturnKeyDone;
    
    [self.phoneTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [secView addSubview:self.phoneTF];
    
    self.codeTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), self.phoneTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.codeTF.placeholder = @"验证码";
    
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.codeTF.returnKeyType = UIReturnKeyDone;
    
    self.codeTF.delegate = self;
    
    [self.codeTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [secView addSubview:self.codeTF];
    
    self.codeView = [[CodeButton alloc]initWithFrame:CGRectMake(self.phoneTF.width-Width320(80), 0, Width320(80), self.phoneTF.height)];
    
    [self.codeView setTitle:@"发送验证码"];
    
    self.codeTF.rightView = self.codeView;
    
    self.codeTF.rightViewMode = UITextFieldViewModeAlways;
    
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.codeView addTarget:self action:@selector(codeClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.codeTF.rightView = self.codeView;
    
    self.codeTF.rightViewMode = UITextFieldViewModeAlways;
    
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.codeTF.noLine = YES;
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), secView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    self.confirmButton.layer.cornerRadius = Width320(2);
    
    self.confirmButton.backgroundColor = kMainColor;
    
    [self.confirmButton setTitle:@"确认变更" forState:UIControlStateNormal];
    
    [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    self.confirmButton.titleLabel.font = AllFont(14);
    
    self.confirmButton.alpha = 0.4;
    
    self.confirmButton.userInteractionEnabled = NO;
    
    [self.mainView addSubview:self.confirmButton];
    
    [self.confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    
    self.hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), secView.bottom, MSW-Width320(32), Height320(40))];
    
    self.hintLabel.text = @"验证码已发送，请新超级管理员注意查收短信";
    
    self.hintLabel.textColor = UIColorFromRGB(0x999999);
    
    self.hintLabel.font = AllFont(12);
    
    self.hintLabel.hidden = YES;
    
    [self.mainView addSubview:self.hintLabel];
    
    self.mainView.contentSize = CGSizeMake(0, self.confirmButton.bottom+Height320(50));
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    if (textField == self.nameTF) {
        
        self.freshAdminLabel.text = textField.text.length?textField.text:@"新超级管理员";
        
    }
    
    if (textField == self.phoneTF && [textField.text isEqualToString:self.admin.phone]) {
        
        self.hintLabel.hidden = NO;
        
        self.hintLabel.text = @"请填写新超级管理员的手机号";
        
        self.hintLabel.textColor = UIColorFromRGB(0xEA6161);
        
        [self.confirmButton changeTop:self.hintLabel.bottom];
        
    }else{
        
        self.hintLabel.hidden = YES;
        
        [self.confirmButton changeTop:self.hintLabel.top+Height320(12)];
        
    }
    
    if (self.nameTF.text.length && self.phoneTF.text.length && self.codeTF.text.length && ![self.phoneTF.text isEqualToString:self.admin.phone]) {
        
        self.confirmButton.alpha = 1;
        
        self.confirmButton.userInteractionEnabled = YES;
        
    }else{
        
        self.confirmButton.alpha = 0.4;
        
        self.confirmButton.userInteractionEnabled = NO;
        
    }
    
}

//发送验证码
-(void)codeClick:(UIButton*)btn
{
    
    if ([self.phoneTF.text isEqualToString:self.admin.phone]) {
        
        [[[UIAlertView alloc]initWithTitle:@"新旧超级管理员手机号不能相同" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    [self.view endEditing:YES];
    
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
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"";
    
    [self.hud showAnimated:YES];
    
    self.codeView.userInteractionEnabled = NO;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:self.phoneTF.text forKey:@"phone"];
    
    [para setParameter:self.phoneTF.country.countryNo forKey:@"area_code"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:kGetCode postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.hintLabel.hidden = NO;
            
            self.hintLabel.text = @"验证码已发送，请新超级管理员注意查收短信";
            
            self.hintLabel.textColor = UIColorFromRGB(0x999999);
            
            [self.confirmButton changeTop:self.hintLabel.bottom];
            
            [self.hud hideAnimated:YES];
            
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

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
    
}

-(void)confirm
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"确定将超级管理员身份从%@(%@)变更为%@(%@)？",self.admin.name,self.admin.phone,self.nameTF.text,self.phoneTF.text] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    alert.tag = 101;
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 101) {
        
        if (buttonIndex == 1) {
            
            Staff *staff = [[Staff alloc]init];
            
            staff.name = self.nameTF.text;
            
            staff.phone = self.phoneTF.text;
            
            staff.country = self.phoneTF.country;
            
            StaffListInfo *info = [[StaffListInfo alloc]init];
            
            [info changeAdmin:staff andCode:self.codeTF.text result:^(BOOL success, NSString *error) {
                
                if (success) {
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"超级管理员身份变更成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    
                    alert.tag = 102;
                    
                    [alert show];
                    
                }else{
                    
                    [[[UIAlertView alloc]initWithTitle:error message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                    
                }
                
            }];
            
        }
        
    }else if(alertView.tag == 102){
        
        AppGym = nil;
        
        AppBrand = nil;
        
        [[RootController sharedSliderController]createDataResult:^{
            
            MOAppDelegate.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[RootController sharedSliderController]];
            
        }];
        
    }
    
}

@end
