//
//  CardFilterController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardFilterController.h"

#import "QCTextField.h"

#import "MOPickerView.h"

#import "CardKindListInfo.h"

#import "QCKeyboardView.h"

#import "CardFilterChooseKindController.h"

@interface CardFilterController ()<QCKeyboardViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)MOPickerView *statePV;

@property(nonatomic,strong)QCTextField *cardKindTF;

@property(nonatomic,strong)QCTextField *stateTF;

@property(nonatomic,strong)CardKindListInfo *info;

@end

@implementation CardFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}

-(void)createUI
{
    
    self.title = @"筛选会员卡";
    
    self.leftImg = [UIImage imageNamed:@"black_close"];
    
    self.navigationTitleColor = UIColorFromRGB(0x666666);
    
    self.shadowType = MONaviShadowTypeLine;
    
    self.navigationBarColor = UIColorFromRGB(0xfafafa);
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(40)*2)];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    self.cardKindTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.cardKindTF.placeholder = @"会员卡种类";
    
    if (self.cardKind) {
        
        self.cardKindTF.text = self.cardKind.cardKindName;
        
    }else
    {
        
        self.cardKindTF.text = @"全部卡种类";
        
    }
    
    self.cardKindTF.delegate = self;
    
    self.cardKindTF.type = QCTextFieldTypeCell;
    
    [topView addSubview:self.cardKindTF];
    
    self.stateTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.cardKindTF.left, self.cardKindTF.bottom, self.cardKindTF.width, self.cardKindTF.height)];
    
    self.stateTF.placeholder = @"会员卡状态";
    
    self.stateTF.text = self.state == CardStateNo?@"默认":self.state == CardStateNormal?@"正常":self.state == CardStateRest?@"请假中":@"已停卡";
    
    self.stateTF.noLine = YES;
    
    self.stateTF.delegate = self;
    
    self.stateTF.type = QCTextFieldTypeCell;
    
    [topView addSubview:self.stateTF];
    
    QCKeyboardView *stateKV = [QCKeyboardView defaultKeboardView];
    
    stateKV.delegate = self;
    
    self.stateTF.inputView = stateKV;
    
    self.statePV = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
    
    self.statePV.titleArray = @[@"默认",@"正常",@"请假中",@"已停卡"];
    
    stateKV.keyboard = self.statePV;
    
    UIButton *confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(12), MSW-Width320(32), Height320(40))];
    
    confirmButton.backgroundColor = kMainColor;
    
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    confirmButton.titleLabel.font = AllFont(14);
    
    confirmButton.layer.cornerRadius = 2;
    
    [self.view addSubview:confirmButton];
    
    [confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *clearButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(42), confirmButton.bottom+Height320(28), Width320(84), Height320(28))];
    
    clearButton.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
    
    clearButton.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [clearButton setTitle:@"清除选项" forState:UIControlStateNormal];
    
    [clearButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    
    clearButton.titleLabel.font = AllFont(12);
    
    [clearButton addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:clearButton];
    
}

-(void)clear:(UIButton*)button
{
    
    self.cardKind = nil;
    
    self.state = CardStateNo;
    
    self.cardKindTF.text = @"全部卡种类";
    
    self.stateTF.text = @"默认状态";
    
}

-(void)confirm:(UIButton*)button
{
    
    if (self.filtered) {
        self.filtered(self.cardKind,self.state);
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{

    self.stateTF.text = @[@"默认",@"正常",@"请假中",@"已停卡"][self.statePV.currentRow];
    
    self.state = self.statePV.currentRow;
    
    [self.view endEditing:YES];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField == self.cardKindTF) {
        
        CardFilterChooseKindController *svc = [[CardFilterChooseKindController alloc]init];
        
        __weak typeof(self)weakS = self;
        
        svc.chooseFinish = ^(CardKind *cardKind){
           
            weakS.cardKind = cardKind;
            
            weakS.cardKindTF.text = cardKind.cardKindName;
            
        };
        
        [self presentViewController:svc animated:YES completion:nil];
        
        return NO;
        
    }else
    {
        
        return YES;
        
    }
    
}

-(void)naviLeftClick
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

@end
