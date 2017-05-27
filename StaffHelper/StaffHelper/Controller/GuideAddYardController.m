//
//  GuideAddYardController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideAddYardController.h"

#import "QCTextField.h"

#import "QCKeyboardView.h"

#import "MOPickerView.h"

@interface GuideAddYardController ()<QCKeyboardViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)Yard *yard;

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *capacityTF;

@property(nonatomic,strong)QCTextField *typeTF;

@property(nonatomic,strong)NSArray *typeArray;

@property(nonatomic,strong)MOPickerView *typePV;

@property(nonatomic,strong)UIButton *confirmButton;

@end

@implementation GuideAddYardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.typeArray = @[@"私教课",@"团课",@"不限"];
        
        self.yard = [[Yard alloc]init];
        
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
}

-(void)createUI
{
    
    self.title = @"添加新场地";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(40)*3)];
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.nameTF.placeholder = @"名称";
    
    self.nameTF.delegate = self;
    
    [self.nameTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [topView addSubview:self.nameTF];
    
    self.capacityTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.capacityTF.placeholder = @"可容纳人数";
    
    self.capacityTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.capacityTF.delegate = self;
    
    [self.capacityTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [topView addSubview:self.capacityTF];
    
    self.typeTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.capacityTF.bottom, self.nameTF.width, self.nameTF.height)];
    
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
    
    self.confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), topView.bottom+Height320(12), MSW-Width320(32), Height320(44))];
    
    self.confirmButton.backgroundColor = kMainColor;
    
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    
    [self.confirmButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    self.confirmButton.titleLabel.font = AllFont(14);
    
    [self.view addSubview:self.confirmButton];
    
    [self.confirmButton addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self check];
    
}

-(void)check
{
    
    if (self.nameTF.text.length && self.capacityTF.text.length) {
        
        self.confirmButton.backgroundColor = kMainColor;
        
        self.confirmButton.userInteractionEnabled = YES;
        
    }else
    {
        
        self.confirmButton.backgroundColor = [kMainColor colorWithAlphaComponent:0.3];
        
        self.confirmButton.userInteractionEnabled = NO;
        
    }
    
}

-(void)confirmClick:(UIButton*)button
{
    
    if ([self.capacityTF.text integerValue]<=0) {
        
        [[[UIAlertView alloc]initWithTitle:@"可容纳人数须大于0" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (self.nameTF.text.length && self.capacityTF.text.length) {
        
        AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        
        NSMutableArray *array = [delegate.course.yards mutableCopy];
        
        [array addObject:self.yard];
        
        delegate.course.yards = array;
        
        if (self.addSuccess) {
            self.addSuccess();
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    self.typeTF.text = self.typeArray[self.typePV.currentRow];
    
    self.yard.type = [self.typeArray indexOfObject:self.typeTF.text];;
    
    [self.typeTF resignFirstResponder];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    self.yard.name = self.nameTF.text;
    
    self.yard.capacity = [self.capacityTF.text integerValue];
    
    [textField resignFirstResponder];
    
    [self check];
    
    return YES;
    
}

-(void)textFieldDidChanged:(UITextField *)textField
{
    
    if (textField == self.nameTF) {
        
        self.yard.name = self.nameTF.text;
        
    }
    
    if (textField == self.capacityTF) {
        
        self.yard.capacity = [self.capacityTF.text integerValue];
        
    }
    
    [self check];
        
}


@end
