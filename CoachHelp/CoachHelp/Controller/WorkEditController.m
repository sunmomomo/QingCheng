//
//  WorkEditController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/26.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "WorkEditController.h"

#import "QCTextField.h"

#import "QCTextView.h"

#import "Gym.h"

#import "QCKeyboardView.h"

#import "ChooseGymController.h"

#define API @"/api/experiences/"

@interface WorkEditController ()<UITextFieldDelegate,QCKeyboardViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *subtitleLabel;

@property(nonatomic,strong)UIScrollView *mainView;

@property(nonatomic,strong)QCTextField *startTF;

@property(nonatomic,strong)QCTextField *endTF;

@property(nonatomic,strong)QCTextField *jobTF;

@property(nonatomic,strong)QCTextView *introTV;

@property(nonatomic,strong)QCTextField *groupUserTF;

@property(nonatomic,strong)QCTextField *groupCourseTF;

@property(nonatomic,strong)QCTextField *privateUserTF;

@property(nonatomic,strong)QCTextField *privateCourseTF;

@property(nonatomic,strong)QCTextField *saleTF;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UIDatePicker *startDP;

@property(nonatomic,strong)UIDatePicker *endDP;

@property(nonatomic,strong)NSDate *startDate;

@property(nonatomic,strong)NSDate *endDate;

@property(nonatomic,assign)BOOL endDPCanShow;

@property(nonatomic,strong)UIView *touchView;

@end

@implementation WorkEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑工作经历";
    
    if (_isAdd) {
        self.title = @"添加工作经历";
    }
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self createUI];
    
    [self createData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.work = [[Work alloc]init];
        
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    if (self.work.startTime) {
        
        self.startDate = [df dateFromString:self.work.startTime];
        
    }
    
    if (self.work.endTime) {
        
        self.endDate = [df dateFromString:self.work.endTime];
        
    }
    
    [self.iconView sd_setImageWithURL:self.work.gym.imgUrl];
    
    self.titleLabel.text = self.work.gym.name;
    
    self.subtitleLabel.text = [NSString stringWithFormat:@"%@%@",self.work.gym.city.length?[self.work.gym.city stringByAppendingString:@"    "]:@"",self.work.gym.brandName.length?self.work.gym.brandName:@""];
    
}

-(void)createUI
{
    
    self.title = self.title;
    
    self.mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.mainView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    [self.view addSubview:self.mainView];
    
    UIButton *topView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(66))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.mainView addSubview:topView];
    
    [topView addTarget:self action:@selector(topClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.iconView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(13), Width320(40), Height320(40))];
    
    self.iconView.layer.cornerRadius = self.iconView.width/2;
    
    self.iconView.layer.masksToBounds = YES;
    
    [self.iconView sd_setImageWithURL:self.work.gym.imgUrl];
    
    [topView addSubview:self.iconView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.iconView.right+Width320(8), Height320(16), Width320(240), Height320(18))];
    
    self.titleLabel.textColor = UIColorFromRGB(0x222222);
    
    self.titleLabel.font = STFont(16);
    
    self.titleLabel.text = self.work.gym.name;
    
    [topView addSubview:self.titleLabel];
    
    self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+Height320(3), self.titleLabel.width, Height320(18))];
    
    self.subtitleLabel.textColor = UIColorFromRGB(0x999999);
    
    self.subtitleLabel.font = STFont(14);
    
    self.subtitleLabel.text = [NSString stringWithFormat:@"%@%@",self.work.gym.city.length?[self.work.gym.city stringByAppendingString:@"    "]:@"",self.work.gym.brandName.length?self.work.gym.brandName:@""];
    
    [topView addSubview:self.subtitleLabel];
    
    UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(25), Height320(19.5), Width320(6.7), Height320(10.7))];
    
    arrowImg.image = [UIImage imageNamed:@"cellarrow"];
    
    arrowImg.center = CGPointMake(arrowImg.center.x, Height320(33));
    
    [topView addSubview:arrowImg];
    
    UIView *secView = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+Height320(10), MSW, Height320(224))];
    
    secView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.mainView addSubview:secView];
    
    self.startTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(21.3), 0, MSW-Width320(42.6), Height320(37))];
    
    self.startTF.placeholder = @"入职时间";
    
    self.startTF.text = _work.startTime;
    
    self.startTF.delegate = self;
    
    self.startTF.placeholderColor = UIColorFromRGB(0x999999);
    
    [secView addSubview:self.startTF];
    
    QCKeyboardView *startKV = [[QCKeyboardView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(216))];
    
    startKV.delegate = self;
    
    self.startDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, Height320(39), MSW, Height320(177))];
    
    self.startDP.datePickerMode = UIDatePickerModeDate;
    
    self.startDP.maximumDate = [NSDate date];
    
    [startKV addSubview:self.startDP];
    
    startKV.tag = 101;
    
    self.startTF.inputView = startKV;
    
    self.endTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.startTF.left, self.startTF.bottom, self.startTF.width, self.startTF.height)];
    
    self.endTF.placeholder = @"离职时间";
    
    self.endTF.text = [_work.endTime isEqualToString:@"3000-01-01"]?@"至今":_work.endTime;
    
    self.endTF.delegate = self;
    
    self.endTF.placeholderColor = UIColorFromRGB(0x999999);
    
    [secView addSubview:self.endTF];
    
    QCKeyboardView *endKV = [[QCKeyboardView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(216))];
    
    endKV.delegate = self;
    
    self.endDP = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, Height320(39), MSW, Height320(177))];
    
    self.endDP.datePickerMode = UIDatePickerModeDate;
    
    self.endDP.maximumDate = [NSDate date];
    
    [endKV addSubview:self.endDP];
    
    endKV.tag = 102;
    
    self.endTF.inputView = endKV;
    
    self.jobTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.startTF.left, self.endTF.bottom, self.startTF.width, self.startTF.height)];
    
    self.jobTF.placeholder = @"职位";
    
    self.jobTF.text = _work.job;
    
    self.jobTF.delegate = self;
    
    self.jobTF.placeholderColor = UIColorFromRGB(0x999999);
    
    [secView addSubview:self.jobTF];
    
    self.introTV = [[QCTextView alloc]initWithFrame:CGRectMake(self.jobTF.left-5, self.jobTF.bottom, self.jobTF.width, secView.height-self.jobTF.bottom)];
    
    self.introTV.placeholder = @"描述";
    
    self.introTV.placeholderColor = UIColorFromRGB(0x999999);
    
    self.introTV.text = _work.descriptions;
    
    [secView addSubview:self.introTV];
    
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(21.3), secView.bottom, Width320(200), Height320(37))];
    
    firstLabel.text = @"团课业绩（选填）";
    
    firstLabel.textColor = UIColorFromRGB(0x999999);
    
    firstLabel.font = STFont(14);
    
    [self.mainView addSubview:firstLabel];
    
    UIView *sec = [[UIView alloc]initWithFrame:CGRectMake(0, firstLabel.bottom, MSW, Height320(37)*2)];
    
    sec.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.mainView addSubview:sec];
    
    self.groupCourseTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.startTF.left, 0, self.startTF.width, self.startTF.height)];
    
    self.groupCourseTF.placeholder = @"团课数量(节)";
    
    self.groupCourseTF.text = _work.group_course?[NSString stringWithFormat:@"%ld",(long)_work.group_course]:@"";
    
    self.groupCourseTF.delegate = self;
    
    self.groupCourseTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.groupCourseTF.placeholderColor = UIColorFromRGB(0x999999);
    
    [sec addSubview:self.groupCourseTF];
    
    self.groupUserTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.startTF.left, self.groupCourseTF.bottom, self.startTF.width, self.startTF.height)];
    
    self.groupUserTF.placeholder = @"团课服务(人次)";
    
    self.groupUserTF.text = _work.group_user?[NSString stringWithFormat:@"%ld",(long)_work.group_user]:@"";
    
    self.groupUserTF.delegate = self;
    
    self.groupUserTF.noLine = YES;
    
    self.groupUserTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.groupUserTF.placeholderColor = UIColorFromRGB(0x999999);
    
    [sec addSubview:self.groupUserTF];
    
    UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(21.3), sec.bottom, Width320(200), Height320(37))];
    
    secondLabel.text = @"私教业绩（选填）";
    
    secondLabel.textColor = UIColorFromRGB(0x999999);
    
    secondLabel.font = STFont(14);
    
    [self.mainView addSubview:secondLabel];
    
    UIView *third = [[UIView alloc]initWithFrame:CGRectMake(0, secondLabel.bottom, MSW, Height320(37)*2)];
    
    third.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.mainView addSubview:third];
    
    self.privateCourseTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.startTF.left, 0, self.startTF.width, self.startTF.height)];
    
    self.privateCourseTF.placeholder = @"私教数量(节)";
    
    self.privateCourseTF.text = _work.private_course?[NSString stringWithFormat:@"%ld",(long)_work.private_course]:@"";
    
    self.privateCourseTF.delegate = self;
    
    self.privateCourseTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.privateCourseTF.placeholderColor = UIColorFromRGB(0x999999);
    
    [third addSubview:self.privateCourseTF];
    
    self.privateUserTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.startTF.left, self.privateCourseTF.bottom, self.startTF.width, self.startTF.height)];
    
    self.privateUserTF.placeholder = @"私教服务(人次)";
    
    self.privateUserTF.text = _work.private_user?[NSString stringWithFormat:@"%ld",(long)_work.private_user]:@"";
    
    self.privateUserTF.delegate = self;
    
    self.privateUserTF.noLine = YES;
    
    self.privateUserTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.privateUserTF.placeholderColor = UIColorFromRGB(0x999999);
    
    [third addSubview:self.privateUserTF];
    
    UILabel *thirdLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(21.3), third.bottom, Width320(200), Height320(37))];
    
    thirdLabel.text = @"销售业绩（选填）";
    
    thirdLabel.textColor = UIColorFromRGB(0x999999);
    
    thirdLabel.font = STFont(14);
    
    [self.mainView addSubview:thirdLabel];
    
    UIView *forth = [[UIView alloc]initWithFrame:CGRectMake(0, thirdLabel.bottom, MSW, Height320(37))];
    
    forth.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self.mainView addSubview:forth];
    
    self.saleTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.startTF.left, 0, self.startTF.width, self.startTF.height)];
    
    self.saleTF.placeholder = @"销售额(元)";
    
    self.saleTF.text = _work.sale?[NSString stringWithFormat:@"%ld",(long)_work.sale]:@"";
    
    self.saleTF.delegate = self;
    
    self.saleTF.noLine = YES;
    
    self.saleTF.keyboardType = UIKeyboardTypeNumberPad;
    
    self.saleTF.placeholderColor = UIColorFromRGB(0x999999);
    
    [forth addSubview:self.saleTF];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    confirmBtn.frame = CGRectMake(Width320(21.3), forth.bottom+Height320(14), MSW-Width320(42.6), Height320(43));
    
    confirmBtn.backgroundColor = kMainColor;
    
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    
    [confirmBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    confirmBtn.layer.cornerRadius = 2;
    
    confirmBtn.layer.masksToBounds = YES;
    
    [confirmBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainView addSubview:confirmBtn];
    
    self.mainView.contentSize = CGSizeMake(0, confirmBtn.bottom+Height320(19));
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    self.hud.mode = MBProgressHUDModeText;
    
    [self.view addSubview:self.hud];
    
    self.touchView = [[UIView alloc]initWithFrame:self.view.frame];
    
    [self.view addSubview:self.touchView];
    
    [self.touchView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchTap:)]];
    
    self.touchView.hidden = YES;
    
    [self.view sendSubviewToBack:self.mainView];
    
}

-(void)touchTap:(UITapGestureRecognizer*)tap
{
    
    [self.startTF resignFirstResponder];
    
    [self.endTF resignFirstResponder];
    
    [self.jobTF resignFirstResponder];
    
    [self.introTV resignFirstResponder];
    
    [self.groupCourseTF resignFirstResponder];
    
    [self.groupUserTF resignFirstResponder];
    
    [self.privateCourseTF resignFirstResponder];
    
    [self.privateUserTF resignFirstResponder];
    
    [self.saleTF resignFirstResponder];
    
    self.endDPCanShow = NO;
    
    self.touchView.hidden = YES;
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    self.touchView.hidden = YES;
    
    return YES;
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboadeView
{
    
    self.touchView.hidden = YES;
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    if (keyboadeView.tag == 101) {
        
        NSDate *date = [df dateFromString:[df stringFromDate:self.startDP.date]];
        
        if (self.endDate) {
            
            NSTimeInterval timeInterval = [date timeIntervalSinceDate:self.endDate];
            
            if (timeInterval>=0&&self.endDate) {
                
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"入职时间必须早于离职时间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil]show];
                
                return;
                
            }
            
        }
        
        self.startDate = date;
        
        self.startTF.text = [df stringFromDate:date];
        
        [self.startTF resignFirstResponder];
        
    }else
    {
        
        NSDate *date = [df dateFromString:[df stringFromDate:self.endDP.date]];
        
        if (self.startDate) {
            
            NSTimeInterval timeInterval = [self.startDate timeIntervalSinceDate:date];
            
            if (timeInterval>=0&&self.endDate) {
                
                [[[UIAlertView alloc]initWithTitle:@"提示" message:@"离职时间必须晚于入职时间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil]show];
                
                return;
                
            }
            
        }
        
        self.endDate = date;
        
        self.endTF.text = [df stringFromDate:date];
        
        [self.endTF resignFirstResponder];
        
    }
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField == self.endTF)
    {
        
        self.touchView.hidden = NO;
        
        [self.view bringSubviewToFront:self.touchView];
        
        if (self.endDPCanShow) {
            
            self.endDPCanShow = NO;
            
            return YES;
            
        }
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"至今",@"选择日期", nil];
        
        [actionSheet showInView:self.view];
        
        return NO;
        
    }
    else{
        
        self.touchView.hidden = NO;
        
        [self.view bringSubviewToFront:self.touchView];
        
        return YES;
        
    }
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    self.touchView.hidden = YES;
    
    if (buttonIndex == 0) {
        
        self.work.endTime = @"3000-01-01";
        
        self.endTF.text = @"至今";
        
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        
        df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        [df setDateFormat:@"yyyy-MM-dd"];
        
        self.endDate = [df dateFromString:self.work.endTime];
        
        
    }else if(buttonIndex == 1)
    {
        
        self.endDPCanShow = YES;
        
        [self.endTF becomeFirstResponder];
        
    }
    
}


-(void)confirm:(UIButton*)btn
{
    
    if (self.startTF.text.length && self.endTF.text.length && self.work.gym.gymId && self.jobTF.text.length) {
        
        btn.userInteractionEnabled = NO;
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"";
        
        [self.hud showAnimated:YES];
        
        Parameters *para = [[Parameters alloc]init];
        
        [para setParameter:self.startTF.text forKey:@"start"];
        
        [para setParameter:[NSString stringWithFormat:@"%ld",CoachId] forKey:@"coach_id"];
        
        [para setParameter:[self.endTF.text isEqualToString:@"至今"]?@"3000-01-01":self.endTF.text forKey:@"end"];
        
        [para setParameter:[NSString stringWithFormat:@"%ld",(long)self.work.gym.gymId] forKey:@"gym_id"];
        
        [para setParameter:self.jobTF.text forKey:@"position"];
        
        [para setParameter:self.introTV.text forKey:@"description"];
        
        [para setParameter:self.groupCourseTF.text forKey:@"group_course"];
        
        [para setParameter:self.groupUserTF.text forKey:@"group_user"];
        
        [para setParameter:self.privateCourseTF.text forKey:@"private_course"];
        
        [para setParameter:self.privateUserTF.text forKey:@"private_user"];
        
        [para setParameter:self.saleTF.text forKey:@"sale"];
        
        if (_isAdd) {
            
            [MOAFHelp AFPostHost:ROOT bindPath:API postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
                
                btn.userInteractionEnabled = YES;
                
                if ([responseDic[@"status"]integerValue]==200) {
                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    self.hud.label.text = @"添加成功";
                    
                    [self.hud showAnimated:YES];
                    
                    [self.hud hideAnimated:YES afterDelay:1.0f];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        if (self.editFinish) {
                            self.editFinish(self.work);
                        }
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    });
                    
                }else
                {
                    
                    [self errorWithInfo:responseDic[@"msg"]];
                    
                }
                
            } failure:^(AFHTTPSessionManager *operation, NSString *error) {
                
                btn.userInteractionEnabled = YES;
                
                [self errorWithInfo:error];
                
            }];
            
        }else
        {
            
            NSString *api = [NSString stringWithFormat:@"%@%ld/",API,(long)self.work.workId];
            
            [MOAFHelp AFPutHost:ROOT bindPath:api putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
                
                btn.userInteractionEnabled = YES;
                
                if ([responseDic[@"status"]integerValue]==200) {
                    
                    self.hud.mode = MBProgressHUDModeText;
                    
                    self.hud.label.text = @"修改成功";
                    
                    [self.hud showAnimated:YES];
                    
                    [self.hud hideAnimated:YES afterDelay:1.0f];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        self.work.job = self.jobTF.text;
                        
                        self.work.summary = self.introTV.text;
                        
                        self.work.group_course = [self.groupCourseTF.text integerValue];
                        
                        self.work.group_user = [self.groupUserTF.text integerValue];
                        
                        self.work.private_course = [self.privateCourseTF.text integerValue];
                        
                        self.work.private_user = [self.privateUserTF.text integerValue];
                        
                        if (self.editFinish) {
                            self.editFinish(self.work);
                        }
                        
                        for (MOViewController *vc in self.navigationController.viewControllers) {
                            
                            if ([NSStringFromClass([vc class]) isEqualToString:@"MineResumeController"]) {
                                
                                [vc reloadData];
                                
                            }
                            
                        }
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
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
        
        
    }else
    {
        
        [[[UIAlertView alloc]initWithTitle:@"信息填写不完全" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}

-(void)errorWithInfo:(NSString *)info
{
    
    self.hud.mode = MBProgressHUDModeText;
    
    self.hud.label.text = info;
    
    [self.hud showAnimated:YES];
    
    [self.hud hideAnimated:YES afterDelay:1.0f];
    
}

-(void)naviRightClick
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"删除此条工作经历" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    alert.delegate = self;
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        
        NSString *api = [NSString stringWithFormat:@"%@%ld/",API,(long)self.work.workId];
        
        [MOAFHelp AFDeleteHost:ROOT bindPath:api deleteParam:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue]== 200) {
                
                [self.navigationController popViewControllerAnimated:YES];
                
                if (self.editFinish) {
                    self.editFinish(self.work);
                }
                
            }else
            {
                
                [[[UIAlertView alloc]initWithTitle:@"删除失败" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            [[[UIAlertView alloc]initWithTitle:error message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }];
    }
    
}

-(void)topClick{
    
    ChooseGymController *svc = [[ChooseGymController alloc]init];
    
    svc.title = @"修改健身房";
    
    __weak typeof(self)weakS = self;
    
    svc.addSuccess = ^(Gym *gym){
        
        weakS.work.gym = gym;
        
        [weakS createData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}


@end
