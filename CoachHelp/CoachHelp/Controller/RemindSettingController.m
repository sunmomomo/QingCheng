//
//  RemindSettingController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "RemindSettingController.h"

#import "QCTextField.h"

#import <EventKit/EventKit.h>

#import "QCKeyboardView.h"

@interface RemindSettingController ()<QCKeyboardViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>

{
    
    NSInteger _selectPickerNum;
    
    NSInteger _pickerNum;
    
    BOOL _syncCalendar;
    
    NSArray *_remindTimeArray;
    
}

@property(nonatomic,strong)UISwitch *calendarSwitch;

@property(nonatomic,strong)QCTextField *remindTF;

@property(nonatomic,strong)UIPickerView *remindPV;

@property(nonatomic,strong)UIView *touchView;

@end

@implementation RemindSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    _syncCalendar = ![[NSUserDefaults standardUserDefaults]boolForKey:@"noCalendar"];
    
    self.calendarSwitch.on = _syncCalendar;
    
    self.remindTF.hidden = !_syncCalendar;
    
    EKEventStore *store = [[EKEventStore alloc]init];
    
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        
        if (!granted) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"noCalendar"];
                
                [[NSUserDefaults standardUserDefaults]setInteger:-1 forKey:@"remindTime"];
                
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                self.calendarSwitch.on = NO;
                
                _syncCalendar = NO;
                
                self.remindTF.hidden = YES;
                
            });
            
        }
        
    }];

    NSInteger remindTime = [[NSUserDefaults standardUserDefaults]integerForKey:@"remindTime"];
    
    if (remindTime == 0) {
        
        remindTime = 60;
        
    }
    
    _remindTimeArray = @[
  @{@"show":@"不提醒",@"time":[NSNumber numberWithInteger:-1]},
  @{@"show":@"15分钟提醒",@"time":[NSNumber numberWithInteger:15]},
  @{@"show":@"30分钟提醒",@"time":[NSNumber numberWithInteger:30]},
  @{@"show":@"1小时提醒",@"time":[NSNumber numberWithInteger:60]},
  @{@"show":@"2小时提醒",@"time":[NSNumber numberWithInteger:120]},
  @{@"show":@"24小时提醒",@"time":[NSNumber numberWithInteger:1440]}
  ];
    
    for (NSDictionary *dict in _remindTimeArray) {
        
        if ([dict[@"time"] integerValue] == remindTime) {
            
            _selectPickerNum = [_remindTimeArray indexOfObject:dict];
            
            _pickerNum = _selectPickerNum;
            
            self.remindTF.text = dict[@"show"];
            
            [self.remindPV selectRow:_pickerNum inComponent:0 animated:NO];
            
        }
        
    }
    
}

-(void)createUI
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"课程提醒设置";
        
    QCTextField *label = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(21.3), 64+Height320(5), MSW-Width320(42.3), Height320(43))];
    
    label.placeholderColor = UIColorFromRGB(0x666666);
    
    label.placeholder = @"同步到日历";
    
    label.userInteractionEnabled = NO;
    
    [self.view addSubview:label];
    
    self.calendarSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(MSW-Width320(21.3)-51, 0, 51, 31)];
    
    self.calendarSwitch.center = CGPointMake(self.calendarSwitch.center.x, label.center.y);
    
    [self.view addSubview:self.calendarSwitch];
    
    [self.calendarSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    
    self.remindTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(21.3), label.bottom, MSW-Width320(42.6), Height320(43))];
    
    self.remindTF.placeholder = @"上课前";
    
    self.remindTF.placeholderColor = UIColorFromRGB(0x666666);
    
    self.remindTF.textColor = UIColorFromRGB(0x222222);
    
    self.remindTF.delegate = self;
    
    [self.view addSubview:self.remindTF];
    
    QCKeyboardView *keyboardView = [[QCKeyboardView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(216))];
    
    keyboardView.delegate = self;
    
    self.remindTF.inputView = keyboardView;
    
    self.remindPV = [[UIPickerView alloc]initWithFrame:CGRectMake(0, Height320(39), MSW, Height320(177))];
    
    self.remindPV.delegate = self;
    
    self.remindPV.dataSource = self;
    
    keyboardView.keyboard = self.remindPV;
    
    self.touchView = [[UIView alloc]initWithFrame:self.view.frame];
    
    [self.touchView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchViewHidden)]];
    
    [self.view addSubview:self.touchView];
    
    self.touchView.hidden = YES;
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    self.touchView.hidden = NO;
    
    [self.view bringSubviewToFront:self.touchView];
    
    return YES;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    self.touchView.hidden = YES;
    
    return YES;
    
}

-(void)touchViewHidden
{
    
    self.touchView.hidden = YES;
    
    [self.remindTF resignFirstResponder];
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboadeView
{
    
    [self.remindTF resignFirstResponder];
    
    self.touchView.hidden = YES;
    
    _selectPickerNum = _pickerNum;
    
    self.remindTF.text = _remindTimeArray[_selectPickerNum][@"show"];
    
    [[NSUserDefaults standardUserDefaults]setInteger:[_remindTimeArray[_selectPickerNum][@"time"] integerValue] forKey:@"remindTime"];
    
}

-(void)switchChange:(UISwitch*)sw
{
    
    [[NSUserDefaults standardUserDefaults]setBool:!sw.isOn forKey:@"noCalendar"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    _syncCalendar = sw.isOn;
    
    self.remindTF.hidden = !_syncCalendar;
    
    if (sw.isOn) {
        
        EKEventStore *store = [[EKEventStore alloc]init];
        
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            
            if (!granted) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[NSUserDefaults standardUserDefaults]setBool:!sw.isOn forKey:@"noCalendar"];
                    
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    sw.on = NO;
                    
                    _syncCalendar = NO;
                    
                    self.remindTF.hidden = YES;
                    
                    if (IOS8) {
                        
                        [[[UIAlertView alloc]initWithTitle:@"尚未开启日历权限" message:@"请在iPhone的“设置-隐私-日历”选项中，允许健身教练助手访问你的通讯录。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置",nil]show];
                        
                    }else
                    {

                        [[[UIAlertView alloc]initWithTitle:@"尚未开启日历权限，是否现在去设置" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置",nil]show];

                    }
                    
                });
                
            }
            
        }];
        
    }
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return _remindTimeArray[row][@"show"];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        if (IOS8) {
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            
        }else
        {
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"prefs:root"]];
            
        }
        
    }
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return _remindTimeArray.count;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    _pickerNum = row;
    
}

@end
