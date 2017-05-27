//
//  IntegralSettingAddController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "IntegralSettingAddController.h"

@interface IntegralSettingAddController ()<UITextFieldDelegate>

@property(nonatomic,strong)UITextField *fromTF;

@property(nonatomic,strong)UITextField *toTF;

@property(nonatomic,strong)QCTextField *integralTF;

@end

@implementation IntegralSettingAddController

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
    
    self.title = self.isRecharge?@"添加充值积分":@"添加购卡积分";
    
    self.rightTitle = @"确定";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(17), Height320(14)+64, Width320(200), Height320(16))];
    
    hintLabel.text = @"实收金额区间（元）";
    
    hintLabel.textColor = UIColorFromRGB(0x999999);
    
    hintLabel.font = AllFont(12);
    
    [self.view addSubview:hintLabel];
    
    self.fromTF = [[UITextField alloc]initWithFrame:CGRectMake(Width320(16), hintLabel.bottom+Height320(9), Width320(111), Height320(37))];
    
    self.fromTF.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.fromTF.layer.cornerRadius = Width320(2);
    
    self.fromTF.layer.borderWidth = OnePX;
    
    self.fromTF.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    
    self.fromTF.textColor = UIColorFromRGB(0x333333);
    
    self.fromTF.textAlignment = NSTextAlignmentCenter;
    
    self.fromTF.font = AllFont(15);
    
    self.fromTF.placeholder = @"请输入金额";
    
    self.fromTF.keyboardType = UIKeyboardTypeDecimalPad;
    
    [self.fromTF setValue:UIColorFromRGB(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.view addSubview:self.fromTF];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.fromTF.right, self.fromTF.top, Width320(66), self.fromTF.height)];
    
    label.text = @"至";
    
    label.textColor = UIColorFromRGB(0x999999);
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = AllFont(12);
    
    [self.view addSubview:label];
    
    self.toTF = [[UITextField alloc]initWithFrame:CGRectMake(label.right,self.fromTF.top,self.fromTF.width,self.fromTF.height)];
    
    self.toTF.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.toTF.layer.cornerRadius = Width320(2);
    
    self.toTF.layer.borderWidth = OnePX;
    
    self.toTF.layer.borderColor = UIColorFromRGB(0xeeeeee).CGColor;
    
    self.toTF.textColor = UIColorFromRGB(0x333333);
    
    self.toTF.textAlignment = NSTextAlignmentCenter;
    
    self.toTF.font = AllFont(15);
    
    self.toTF.placeholder = @"请输入金额";
    
    self.toTF.keyboardType = UIKeyboardTypeDecimalPad;
    
    [self.toTF setValue:UIColorFromRGB(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    
    [self.view addSubview:self.toTF];
    
    UIView *tfView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(96)+64, MSW, Height320(40))];
    
    tfView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    tfView.layer.borderWidth = OnePX;
    
    tfView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:tfView];
    
    self.integralTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.integralTF.placeholder = @"每1元实收金额获得积分";
    
    self.integralTF.delegate = self;
    
    self.integralTF.keyboardType = UIKeyboardTypeDecimalPad;
    
    [tfView addSubview:self.integralTF];
    
}

-(void)naviRightClick
{
    
    if (!self.fromTF.text.length || !self.toTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请完整填写奖励金额区间" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (!self.integralTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请填写获得积分数额" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    IntegralCardSetting *cardSetting = [[IntegralCardSetting alloc]init];
    
    cardSetting.fromPrice = MIN([self.fromTF.text floatValue], [self.toTF.text floatValue]);
    
    cardSetting.toPrice = MAX([self.fromTF.text floatValue], [self.toTF.text floatValue]);
    
    BOOL can = YES;
    
    for (IntegralCardSetting *item in self.settings) {
        
        if (cardSetting.fromPrice<=item.toPrice && cardSetting.toPrice>=item.toPrice) {
            
            can = NO;
            
            break;
            
        }else if (cardSetting.toPrice>=item.fromPrice && cardSetting.fromPrice<=item.fromPrice){
            
            can = NO;
            
            break;
            
        }
        
    }
    
    if (!can) {
        
        [[[UIAlertView alloc]initWithTitle:@"实收金额区间有冲突，请检查后再提交" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    cardSetting.integral = [self.integralTF.text floatValue];
    
    if (self.setFinish) {
        
        self.setFinish(cardSetting);
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
