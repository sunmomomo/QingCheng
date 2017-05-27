//
//  AddStudentController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/17.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "AddStudentController.h"

#import "QCKeyboardView.h"

#import "QCTextField.h"

@interface AddStudentController ()<UIPickerViewDataSource,UIPickerViewDelegate,QCKeyboardViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *sexTF;

@property(nonatomic,strong)QCTextField *phoneTF;

@property(nonatomic,strong)UIButton *confirmBtn;

@property(nonatomic,strong)UILabel *hintLabel;

@property(nonatomic,strong)NSArray *sexArray;

@property(nonatomic,assign)NSInteger sexNum;

@property(nonatomic,assign)NSInteger currentSexNum;

@end

@implementation AddStudentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self createData];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.sexNum = 0;
    
    self.currentSexNum = 0;
    
    self.sexArray = @[@"男",@"女"];
    
}

-(void)createUI
{
    
    self.title = @"添加学员";
        
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(40)*3)];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
    
    self.nameTF.placeholder = @"姓名";
    
    self.nameTF.delegate = self;
    
    [topView addSubview:self.nameTF];
    
    self.sexTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.sexTF.placeholder = @"性别";
    
    self.sexTF.text = self.sexArray[self.currentSexNum];
    
    self.sexTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.sexTF.textColor = UIColorFromRGB(0x222222);
    
    [topView addSubview:self.sexTF];
    
    QCKeyboardView *sexKV = [[QCKeyboardView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(216))];
    
    sexKV.tag = 102;
    
    sexKV.delegate = self;
    
    UIPickerView *sexPV = [[UIPickerView alloc]initWithFrame:CGRectMake(0, Height320(39), MSW, Height320(177))];
    
    sexPV.dataSource = self;
    
    sexPV.delegate = self;
    
    sexPV.tag = 102;
    
    sexKV.keyboard = sexPV;
    
    self.sexTF.inputView = sexKV;
    
    self.phoneTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.sexTF.bottom, self.nameTF.width, self.nameTF.height)];
    
    self.phoneTF.placeholder = @"手机";
    
    self.phoneTF.delegate = self;
    
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [topView addSubview:self.phoneTF];
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.confirmBtn.frame = CGRectMake(Width320(27.1), topView.bottom+Height320(15.5), MSW-Width320(54.2), Height320(43));
    
    self.confirmBtn.backgroundColor = kMainColor;
    
    [self.confirmBtn setTitle:@"确  定" forState:UIControlStateNormal];
    
    [self.confirmBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    self.confirmBtn.layer.cornerRadius = 1;
    
    self.confirmBtn.layer.masksToBounds = YES;
    
    [self.confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.confirmBtn];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(void)confirm:(UIButton*)btn
{
    
    [self.view endEditing:YES];
    
    NSString *regex = @"^[1][34578][0-9]{9}$";
    
    if (!self.nameTF.text.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"姓名必须填写" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil]show];
        
        return;
        
    }else if(!self.phoneTF.text.length)
    {
        
        [[[UIAlertView alloc]initWithTitle:@"手机必须填写" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil]show];
        
        return;
        
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if (![pred evaluateWithObject:self.phoneTF.text]) {
        
        [[[UIAlertView alloc]initWithTitle:@"手机号输入错误" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil]show];
        
        return;
        
    }
    
    btn.userInteractionEnabled = NO;
    
    Parameters *para = [[Parameters alloc]init];
    
    NSDictionary *userDict = @{@"username":self.nameTF.text,@"phone":self.phoneTF.text,@"gender":[NSString stringWithFormat:@"%ld",(long)self.currentSexNum]};
    
    [para setParameter:@[userDict] forKey:@"users"];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    NSString *api = [NSString stringWithFormat:@"/api/v1/coaches/%ld/students/add/",CoachId];
    
    [MOAFHelp AFPostHost:ROOT bindPath:api postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        btn.userInteractionEnabled = YES;
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"创建成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            
            alert.delegate = self;
            
            [alert show];
            
        }else
        {
            
            [[[UIAlertView alloc]initWithTitle:@"创建失败" message:responseDic[@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        btn.userInteractionEnabled = YES;
        
        [[[UIAlertView alloc]initWithTitle:@"网络连接失败" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [self popViewControllerAndReloadData];
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboadeView
{
    
    if (self.sexNum>self.sexArray.count-1) {
        
        self.sexNum = self.sexArray.count-1;
        
    }
    
    self.currentSexNum = self.sexNum;
    
    self.sexTF.text = self.sexArray[self.currentSexNum];
    
    [self.sexTF resignFirstResponder];
    
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return 2;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return self.sexArray[row];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    self.sexNum = row;
    
}

@end
