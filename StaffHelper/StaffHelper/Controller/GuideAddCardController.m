//
//  GuideAddCardController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideAddCardController.h"

#import "QCTextField.h"

#import "MOTextView.h"

#import "QCKeyboardView.h"

#import "MOPickerView.h"

@interface GuideAddCardController () <QCKeyboardViewDelegate,UITextFieldDelegate,UITextViewDelegate>

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *typeTF;

@property(nonatomic,strong)MOTextView *summaryTV;

@property(nonatomic,strong)MOPickerView *typePV;

@property(nonatomic,strong)NSArray *typeArray;

@end

@implementation GuideAddCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createData];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.typeArray = @[@"储值类型",@"次卡类型",@"期限类型"];
    
}

-(void)createUI
{
    
    self.title = @"添加会员卡种类";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(186))];
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(42))];
    
    self.nameTF.placeholder = @"名称";
    
    self.nameTF.delegate = self;
    
    [topView addSubview:self.nameTF];
    
    self.typeTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.typeTF.delegate = self;
    
    self.typeTF.placeholder = @"类型";

    self.typeTF.text = self.typeArray[0];
    
    [topView addSubview:self.typeTF];
    
    QCKeyboardView *keyboard = [QCKeyboardView defaultKeboardView];
    
    keyboard.delegate = self;
    
    self.typeTF.inputView = keyboard;
    
    self.typePV = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 37, MSW, 177)];
    
    self.typePV.titleArray = self.typeArray;
    
    keyboard.keyboard = self.typePV;
    
    self.summaryTV = [[MOTextView alloc]initWithFrame:CGRectMake(Width320(16)-5, self.typeTF.bottom, MSW-Width320(32)+10, topView.height-self.typeTF.bottom)];
    
    self.summaryTV.placeholder = @"说明";
    
    self.summaryTV.delegate = self;
    
    self.summaryTV.font = AllFont(14);
    
    [topView addSubview:self.summaryTV];
    
    UIButton *confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(12), MSW-Width320(32), Height320(44))];
    
    confirmButton.backgroundColor = kMainColor;
    
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    confirmButton.titleLabel.font = AllFont(14);
    
    [self.view addSubview:confirmButton];
    
    [confirmButton addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    self.typeTF.text = self.typeArray[self.typePV.currentRow];
    
    [self.typeTF resignFirstResponder];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}


-(void)confirmClick:(UIButton*)button
{
    
    if (!self.nameTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"请填写会员卡名称" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    CardKind *cardKind = [[CardKind alloc]init];
    
    cardKind.cardKindName = self.nameTF.text;
    
    cardKind.summary = self.summaryTV.text;
    
    cardKind.type = [self.typeArray indexOfObject:self.typeTF.text]+1;
    
    if (self.addSuccess) {
        self.addSuccess(cardKind);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
