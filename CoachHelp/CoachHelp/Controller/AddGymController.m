//
//  AddGymController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/26.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "AddGymController.h"

#import "QCTextField.h"

#import "QCTextView.h"

#import "DistrictInfo.h"

#import "QCKeyboardView.h"

#define API @"/api/gym/"

@interface AddGymController ()<QCKeyboardViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)QCTextField *brandTF;

@property(nonatomic,strong)QCTextField *gymTF;

@property(nonatomic,strong)QCTextField *cityTF;

@property(nonatomic,strong)QCTextField *phoneTF;

@property(nonatomic,strong)QCTextView *introTV;

@property(nonatomic,strong)DistrictInfo *districtInfo;

@property(nonatomic,strong)UIPickerView *pickView;

@property(nonatomic,assign)NSInteger provinceNum;

@property(nonatomic,assign)NSInteger cityNum;

@property(nonatomic,copy)NSString *districtCode;

@property(nonatomic,assign)NSInteger districtNum;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UIView *touchView;

@end

@implementation AddGymController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.districtInfo = [DistrictInfo sharedDistrictInfo];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUI
{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(286))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    self.brandTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(21.3), 0, MSW-Width320(42.6), Height320(38))];
    
    self.brandTF.placeholder = @"健身房品牌";
    
    self.brandTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.brandTF.mustInput = YES;
    
    self.brandTF.delegate = self;
    
    [topView addSubview:self.brandTF];
    
    self.gymTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(21.3), self.brandTF.bottom, MSW-Width320(42.6), Height320(38))];
    
    self.gymTF.placeholder = @"场馆名";
    
    self.gymTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.gymTF.mustInput = YES;
    
    self.gymTF.delegate = self;
    
    [topView addSubview:self.gymTF];
    
    self.phoneTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.gymTF.left, self.gymTF.bottom, self.gymTF.width, self.gymTF.height)];
    
    self.phoneTF.placeholder = @"联系方式";
    
    self.phoneTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.phoneTF.mustInput = YES;
    
    self.phoneTF.delegate = self;
    
    self.phoneTF.keyboardType = UIKeyboardTypeASCIICapable;
    
    [topView addSubview:self.phoneTF];
    
    self.cityTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.gymTF.left, self.phoneTF.bottom, self.gymTF.width, self.gymTF.height)];
    
    self.cityTF.placeholder = @"城市";
    
    self.cityTF.placeholderColor = UIColorFromRGB(0x999999);
    
    self.cityTF.mustInput = YES;
    
    self.cityTF.delegate = self;
    
    QCKeyboardView *keyboardView = [[QCKeyboardView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(216))];
    
    keyboardView.delegate = self;
    
    _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, Width320(39), MSW, Height320(177))];
    
    _pickView.dataSource = self;
    
    _pickView.delegate = self;
    
    [keyboardView addSubview:_pickView];
    
    self.cityTF.inputView = keyboardView;
    
    [topView addSubview:self.cityTF];
   
    self.introTV = [[QCTextView alloc]initWithFrame:CGRectMake(self.gymTF.left-5, self.cityTF.bottom, self.phoneTF.width+10, topView.height-self.cityTF.bottom)];
    
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
    
    self.touchView = [[UIView alloc]initWithFrame:self.view.frame];
    
    [self.touchView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchBegan:)]];
    
    [self.view addSubview:self.touchView];
    
    self.touchView.hidden = YES;
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    self.touchView.hidden = NO;
    
    return YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    self.touchView.hidden = YES;
    
    [self.view bringSubviewToFront:self.touchView];
    
    return YES;
    
}

-(void)touchBegan:(UITapGestureRecognizer*)tap
{
    
    [self.gymTF resignFirstResponder];
    
    [self.cityTF resignFirstResponder];
    
    [self.phoneTF resignFirstResponder];
    
    [self.introTV resignFirstResponder];
    
    self.touchView.hidden = YES;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        self.provinceNum = row;
        
        if (self.cityNum>= [((Province *)self.districtInfo.provinces[self.provinceNum]).cities count]) {
            
            self.cityNum = [((Province *)self.districtInfo.provinces[self.provinceNum]).cities count]-1;
            
        }
        
        if (self.districtNum >=  [((City*)((Province *)self.districtInfo.provinces[self.provinceNum]).cities[self.cityNum]).districts count]) {
            
            self.districtNum = [((City*)((Province *)self.districtInfo.provinces[self.provinceNum]).cities[self.cityNum]).districts count]-1;
            
        }
        
        [_pickView reloadAllComponents];
        
    }else if (component == 1)
    {
        
        self.cityNum = row;
        
        if (self.districtNum >=  [((City*)((Province *)self.districtInfo.provinces[self.provinceNum]).cities[self.cityNum]).districts count]) {
            
            self.districtNum = [((City*)((Province *)self.districtInfo.provinces[self.provinceNum]).cities[self.cityNum]).districts count]-1;
            
        }
        
        [_pickView reloadAllComponents];
        
    }else
    {
        
        self.districtNum = row;
        
    }
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{

    return 3;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        return self.districtInfo.provinces.count;
        
    }else if (component == 1)
    {
        
        Province *province = self.districtInfo.provinces[self.provinceNum];
        
        return province.cities.count;
        
    }else
    {
        
        City *city = ((Province *)self.districtInfo.provinces[self.provinceNum]).cities[self.cityNum];
        
        return city.districts.count;
        
    }
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        Province *province = self.districtInfo.provinces[row];
        
        return province.name;
        
    }else if (component == 1)
    {
        
        Province *province = self.districtInfo.provinces[self.provinceNum];
        
        City *city = province.cities[row];
        
        return city.name;
        
    }else
    {
        
        Province *province = self.districtInfo.provinces[self.provinceNum];
        
        City *city = province.cities[self.cityNum];
        
        District *district = city.districts[row];
        
        return district.name;
        
    }
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboadeView
{
    
    Province *province = self.districtInfo.provinces[self.provinceNum];
    
    City *city = province.cities[self.cityNum];
    
    District *district = city.districts[self.districtNum];
    
    self.districtCode = district.districtCode;
    
    self.cityTF.text = [DistrictInfo nameForDistrictCode:self.districtCode];
    
    [self.cityTF resignFirstResponder];
    
    self.touchView.hidden = YES;
    
}

-(void)errorWithInfo:(NSString *)info
{
    
    self.hud.mode = MBProgressHUDModeText;
    
    self.hud.label.text = info;
    
    [self.hud showAnimated:YES];
    
    [self.hud hideAnimated:YES afterDelay:1.0f];
    
}

-(void)add:(UIButton*)btn
{
    
    if (self.brandTF.text.length == 0 || self.gymTF.text.length==0 ||!self.districtCode.length) {
        
        [[[UIAlertView alloc]initWithTitle:@"信息填写不完全" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }else if(self.gymTF.text.length<3)
    {
        
        [[[UIAlertView alloc]initWithTitle:@"健身房名称不得少于3个字符" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
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
    
    [para setParameter:self.brandTF.text forKey:@"brand_name"];
    
    [para setParameter:self.gymTF.text forKey:@"name"];
    
    [para setParameter:[NSString stringWithFormat:@"%@",self.districtCode] forKey:@"code"];
    
    [para setParameter:self.phoneTF.text forKey:@"contact"];
    
    [para setParameter:self.introTV.text forKey:@"description"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:API postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        btn.userInteractionEnabled = YES;
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            self.hud.mode = MBProgressHUDModeText;
            
            self.hud.label.text = @"添加成功";
            
            [self.hud showAnimated:YES];
            
            [self.hud hideAnimated:YES afterDelay:1.0f];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if (self.addSuccess) {
                    
                    Gym *gym = [[Gym alloc]init];
                    
                    gym.name = self.gymTF.text;
                    
                    gym.brandName = self.brandTF.text;
                    
                    gym.gymId = [responseDic[@"data"][@"gym"][@"id"] integerValue];
                    
                    gym.contact = self.phoneTF.text;
                    
                    gym.summary = self.introTV.text;
                    
                    gym.imgUrl = [NSURL URLWithString:responseDic[@"data"][@"gym"][@"photo"]];
                    
                    self.addSuccess(gym);
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    
                }else{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
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

-(void)naviLeftClick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
