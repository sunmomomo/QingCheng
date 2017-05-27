//
//  AddOrganizationController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/26.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "AddOrganizationController.h"

#import "QCTextField.h"

#import "QCTextView.h"

#define API @"/api/organizations/"

@interface AddOrganizationController ()<UITextFieldDelegate>

@property(nonatomic,strong)QCTextField *organTF;

@property(nonatomic,strong)QCTextField *phoneTF;

@property(nonatomic,strong)QCTextView *introTV;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation AddOrganizationController

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
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(215))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    self.organTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(21.3), 0, MSW-Width320(42.6), Height320(38))];
    
    self.organTF.placeholder = @"机构名";
    
    self.organTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.organTF.mustInput = YES;
    
    self.organTF.delegate = self;
    
    [topView addSubview:self.organTF];
    
    self.phoneTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.organTF.left, self.organTF.bottom, self.organTF.width, self.organTF.height)];
    
    self.phoneTF.placeholder = @"联系方式";
    
    self.phoneTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.phoneTF.mustInput = YES;
    
    self.phoneTF.delegate = self;
    
    self.phoneTF.keyboardType = UIKeyboardTypeASCIICapable;
    
    [topView addSubview:self.phoneTF];
    
    self.introTV = [[QCTextView alloc]initWithFrame:CGRectMake(self.organTF.left-5, self.phoneTF.bottom, self.phoneTF.width+10, topView.height-self.phoneTF.bottom)];
    
    self.introTV.placeholder = @"简介";
    
    self.introTV.placeholderColor = UIColorFromRGB(0x999999);
    
    [topView addSubview:self.introTV];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    addBtn.frame = CGRectMake(Width320(21.3), topView.bottom+Height320(13), MSW-Width320(42.6), Height320(43));
    
    addBtn.backgroundColor = kMainColor;
    
    [addBtn setTitle:@"确定添加" forState:UIControlStateNormal];
    
    [addBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    addBtn.layer.cornerRadius = 1;
    
    addBtn.layer.masksToBounds = YES;
    
    [addBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addBtn];
    
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
    
    [self.organTF resignFirstResponder];
    
    [self.phoneTF resignFirstResponder];
    
    [self.introTV resignFirstResponder];
    
}

-(void)add:(UIButton*)btn
{
    
    if (self.organTF.text.length<3) {
        
        [[[UIAlertView alloc]initWithTitle:@"组织机构名称必填且不得少于3个字符" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }else if (self.phoneTF.text.length<7)
    {
        
        [[[UIAlertView alloc]initWithTitle:@"请输入正确的联系方式" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    btn.userInteractionEnabled = NO;
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    
    self.hud.label.text = @"";
    
    [self.hud showAnimated:YES];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:self.organTF.text forKey:@"name"];
    
    [para setParameter:self.phoneTF.text forKey:@"contact"];
    
    [para setParameter:self.introTV.text forKey:@"description"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:API postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        btn.userInteractionEnabled = YES;
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = @"";
            
            [self.hud showAnimated:YES];
            
            [self.hud hideAnimated:YES afterDelay:1.0f];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (self.addSuccess) {
                    
                    Organization *ogn = [[Organization alloc]init];
                    
                    ogn.name = self.organTF.text;
                    
                    ogn.contact = self.phoneTF.text;
                    
                    ogn.summary = self.introTV.text;
                    
                    ogn.ognId = [responseDic[@"data"][@"organization"][@"id"] integerValue];
                    
                    ogn.imgUrl = [NSURL URLWithString:responseDic[@"data"][@"organization"][@"photo"]];
                    
                    self.addSuccess(ogn);
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                }
                
            });
            
        }else
        {
            
            [self errorWithInfo:responseDic[@"msg"]];
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        btn.userInteractionEnabled = YES;
        
        [self errorWithInfo:error];
        
    }];

    
}

-(void)errorWithInfo:(NSString *)info
{
    
    self.hud.mode = MBProgressHUDModeText;
    
    self.hud.label.text = info;
    
    [self.hud showAnimated:YES];
    
    [self.hud hideAnimated:YES afterDelay:1.0f];
    
}

-(void)naviLeftClick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
