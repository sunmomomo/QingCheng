//
//  CardKindEditController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardKindEditController.h"

#import "QCTextField.h"

#import "MOSwitchCell.h"

#import "MOCell.h"

#import "QCKeyboardView.h"

#import "SummaryController.h"

#import "MOPickerView.h"

#import "MONumberPickerView.h"

#import "CardKindSuitGymController.h"

@interface CardKindEditController ()<MOSwitchCellDelegate,UITextFieldDelegate,UIActionSheetDelegate,QCKeyboardViewDelegate>

@property(nonatomic,strong)QCTextField *nameTF;

@property(nonatomic,strong)QCTextField *typeTF;

@property(nonatomic,strong)QCTextField *suitTF;

@property(nonatomic,strong)MOCell *summaryCell;

@property(nonatomic,strong)MOSwitchCell *setConditionCell;

@property(nonatomic,strong)QCTextField *orderNumTF;

@property(nonatomic,strong)QCTextField *courseNumTF;

@property(nonatomic,strong)QCTextField *maxCardCountTF;

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UIView *secondView;

@property(nonatomic,strong)MOPickerView *gapPV;

@property(nonatomic,strong)MONumberPickerView *countPV;

@property(nonatomic,strong)MOPickerView *cardCountPV;

@property(nonatomic,strong)CardKindInfo *info;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)UILabel *suitLabel;

@end

@implementation CardKindEditController

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
    
    self.info = [[CardKindInfo alloc]init];
    
    if (self.isAdd) {
        
        self.cardKind = [[CardKind alloc]init];
        
    }
    
}

-(void)createUI
{
    self.title = self.isAdd?@"添加会员卡种类":@"编辑会员卡种类";
    
    self.rightTitle = self.isAdd?@"完成":@"保存";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, self.isAdd?Height320(40)*4:self.cardKind.isLimit?Height320(40)*6:Height320(40)*3)];
    
    self.topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [self.view addSubview:self.topView];
    
    if (!self.isAdd&&((AppGym && self.cardKind.gyms.count>1)||(AppGym && ![PermissionInfo sharedInfo].permissions.cardKindPermission.editState)||(!AppGym&&[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.cardKind.gyms andPermission:[PermissionInfo sharedInfo].permissions.cardKindPermission andType:PermissionTypeEdit]!=PermissionStateAll))) {
        
        UIImageView *hintImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), 64+Height320(12), Width320(14), Height320(14))];
        
        hintImg.image = [UIImage imageNamed:@"hint_circle"];
        
        [self.view addSubview:hintImg];
        
        UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(hintImg.right+Width320(6), hintImg.top, MSW-hintImg.right-Width320(22), Height320(40))];
        
        if (AppGym) {
            
            hintLabel.text = @"该会员卡种类适用于多个场馆，请到连锁运营中进行修改";
            
        }else{
            
            hintLabel.text = @"仅在全部适用场馆下都具有编辑会员卡种类权限的用户才能编辑基本信息";
            
        }
        
        hintLabel.textColor = UIColorFromRGB(0x999999);
        
        hintLabel.font = AllFont(12);
        
        hintLabel.numberOfLines = 0;
        
        CGSize size = [hintLabel.text boundingRectWithSize:CGSizeMake(hintLabel.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:hintLabel.font} context:nil].size;
        
        [hintLabel changeSize:size];
        
        [self.view addSubview:hintLabel];
        
        [self.topView changeTop:hintLabel.bottom+Height320(10)];
        
        CGSize titleSize = [@"名称" boundingRectWithSize:CGSizeMake(MAXFLOAT, Height320(18)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
        
        UILabel *nameTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(16), titleSize.width, titleSize.height)];
        
        nameTitleLabel.text = @"名称";
        
        nameTitleLabel.textColor = UIColorFromRGB(0x999999);
        
        nameTitleLabel.font = AllFont(14);
        
        [self.topView addSubview:nameTitleLabel];
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameTitleLabel.right+Width320(12), nameTitleLabel.top, MSW-Width320(28)-nameTitleLabel.right, Height320(100))];
        
        nameLabel.textColor = UIColorFromRGB(0x333333);
        
        nameLabel.font = AllFont(14);
        
        nameLabel.text = self.cardKind.cardKindName;
        
        if (self.cardKind.cardKindName.length) {
            
            CGSize nameSize = [self.cardKind.cardKindName boundingRectWithSize:nameLabel.frame.size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:nameLabel.font} context:nil].size;
            
            [nameLabel changeSize:nameSize];
            
            nameLabel.text = self.cardKind.cardKindName;
            
        }
        
        [self.topView addSubview:nameLabel];
        
        UILabel *summaryTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameTitleLabel.left, nameLabel.bottom+Height320(8), titleSize.width, titleSize.height)];
        
        summaryTitleLabel.text = @"简介";
        
        summaryTitleLabel.textColor = UIColorFromRGB(0x999999);
        
        summaryTitleLabel.font = AllFont(14);
        
        [self.topView addSubview:summaryTitleLabel];
        
        UILabel *summaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.left, summaryTitleLabel.top, MSW-Width320(28)-nameTitleLabel.right, Height320(100))];
        
        summaryLabel.textColor = UIColorFromRGB(0x333333);
        
        summaryLabel.font = AllFont(14);
        
        summaryLabel.numberOfLines = 0;
        
        if (self.cardKind.summary.length) {
            
            CGSize summarySize = [self.cardKind.summary boundingRectWithSize:summaryLabel.frame.size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:summaryLabel.font} context:nil].size;
            
            [summaryLabel changeSize:summarySize];
            
            summaryLabel.text = self.cardKind.summary;
            
        }else{
            
            summaryLabel.text = @"无";
            
            CGSize summarySize = [@"无" boundingRectWithSize:summaryLabel.frame.size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:summaryLabel.font} context:nil].size;
            
            [summaryLabel changeSize:summarySize];
            
        }
        
        [self.topView addSubview:summaryLabel];
        
        UILabel *astrictTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(summaryTitleLabel.left, summaryTitleLabel.bottom+Height320(8), titleSize.width, titleSize.height)];
        
        astrictTitleLabel.text = @"限制";
        
        astrictTitleLabel.textColor = UIColorFromRGB(0x999999);
        
        astrictTitleLabel.font = AllFont(14);
        
        [self.topView addSubview:astrictTitleLabel];
        
        UILabel *astrictLabel = [[UILabel alloc]initWithFrame:CGRectMake(summaryLabel.left, astrictTitleLabel.top, MSW-Width320(28)-nameTitleLabel.right, Height320(100))];
        
        astrictLabel.textColor = UIColorFromRGB(0x333333);
        
        astrictLabel.font = AllFont(13);
        
        astrictLabel.numberOfLines = 0;
        
        if (self.cardKind.astrict.length) {
            
            CGSize astrictSize = [self.cardKind.astrict boundingRectWithSize:astrictLabel.frame.size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:astrictLabel.font} context:nil].size;
            
            [astrictLabel changeSize:astrictSize];
            
            astrictLabel.text = self.cardKind.astrict;
            
        }else{
            
            astrictLabel.text = @"无";
            
            CGSize astrictSize = [@"无" boundingRectWithSize:astrictLabel.frame.size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:astrictLabel.font} context:nil].size;
            
            [astrictLabel changeSize:astrictSize];
            
        }
        
        [self.topView addSubview:astrictLabel];
        
        [self.topView changeHeight:astrictLabel.bottom+Height320(12)];
        
    }else{
        
        self.nameTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
        
        self.nameTF.placeholder = @"名称";
        
        self.nameTF.mustInput = YES;
        
        self.nameTF.delegate = self;
        
        self.nameTF.textPlaceholder = @"请填写";
        
        self.nameTF.text = self.cardKind.cardKindName;
        
        [self.topView addSubview:self.nameTF];
        
        if (self.isAdd) {
            
            self.typeTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.nameTF.left, self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
            
            self.typeTF.placeholder = @"类型";
            
            self.typeTF.mustInput = YES;
            
            self.typeTF.delegate = self;
            
            self.typeTF.textPlaceholder = @"请选择";
            
            self.typeTF.type = QCTextFieldTypeCell;
            
            [self.topView addSubview:self.typeTF];
            
        }
        
        self.summaryCell = [[MOCell alloc]initWithFrame:CGRectMake(self.nameTF.left, self.isAdd?self.typeTF.bottom:self.nameTF.bottom, self.nameTF.width, self.nameTF.height)];
        
        self.summaryCell.titleLabel.text = @"简介";
        
        self.summaryCell.placeholder = @"选填";
        
        self.summaryCell.subtitle = self.cardKind.summary;
        
        [self.summaryCell addTarget:self action:@selector(summaryClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.topView addSubview:self.summaryCell];
        
        self.setConditionCell = [[MOSwitchCell alloc]initWithFrame:CGRectMake(Width320(16), self.summaryCell.bottom, MSW-Width320(32), Height320(40))];
        
        self.setConditionCell.titleLabel.text = @"设置限制条件";
        
        self.setConditionCell.noLine = YES;
        
        self.setConditionCell.delegate = self;
        
        [self.topView addSubview:self.setConditionCell];
        
        self.orderNumTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.setConditionCell.left, self.setConditionCell.bottom, self.setConditionCell.width, self.setConditionCell.height)];
        
        self.orderNumTF.placeholder = @"可提前预约课程数（节）";
        
        self.orderNumTF.textPlaceholder = @"请填写";
        
        self.orderNumTF.keyboardType = UIKeyboardTypeNumberPad;
        
        self.orderNumTF.hidden = YES;
        
        self.orderNumTF.delegate = self;
        
        [self.topView addSubview:self.orderNumTF];
        
        self.courseNumTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.orderNumTF.left, self.orderNumTF.bottom, self.orderNumTF.width, self.orderNumTF.height)];
        
        self.courseNumTF.placeholder = @"单位时间可上课程数（节）";
        
        self.courseNumTF.type = QCTextFieldTypeCell;
        
        self.courseNumTF.textPlaceholder = @"请选择";
        
        self.courseNumTF.hidden = YES;
        
        self.courseNumTF.delegate = self;
        
        [self.topView addSubview:self.courseNumTF];
        
        QCKeyboardView *numberKV = [QCKeyboardView defaultKeboardView];
        
        numberKV.delegate = self;
        
        numberKV.tag = 101;
        
        self.courseNumTF.inputView = numberKV;
        
        self.gapPV = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW/2, 177)];
        
        self.gapPV.titleArray = @[@"每天",@"每周",@"每月"];
        
        [numberKV addSubview:self.gapPV];
        
        UILabel *numberLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(Width320(104), self.gapPV.center.y-13.5, Width320(80), 27)];
        
        numberLabel1.text = @"共计可上";
        
        numberLabel1.textColor = UIColorFromRGB(0x999999);
        
        numberLabel1.font = STFont(14);
        
        [numberKV addSubview:numberLabel1];
        
        self.countPV = [[MONumberPickerView alloc]initWithFrame:CGRectMake(MSW/2, 39, MSW/2, 177)];
        
        self.countPV.minNumber = 1;
        
        self.countPV.maxNumber = 100;
        
        [numberKV addSubview:self.countPV];
        
        UILabel *numberLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(Width320(253), self.gapPV.center.y-13.5, Width320(80), 27)];
        
        numberLabel2.text = @"节课";
        
        numberLabel2.textColor = UIColorFromRGB(0x999999);
        
        numberLabel2.font = STFont(14);
        
        [numberKV addSubview:numberLabel2];
        
        self.maxCardCountTF = [[QCTextField alloc]initWithFrame:CGRectMake(self.courseNumTF.left, self.courseNumTF.bottom, self.courseNumTF.width, self.courseNumTF.height)];
        
        self.maxCardCountTF.placeholder = @"每个会员限购张数";
        
        self.maxCardCountTF.type = QCTextFieldTypeCell;
        
        self.maxCardCountTF.textPlaceholder = @"请选择";
        
        self.maxCardCountTF.hidden = YES;
        
        self.maxCardCountTF.noLine = YES;
        
        self.maxCardCountTF.delegate = self;
        
        [self.topView addSubview:self.maxCardCountTF];
        
        QCKeyboardView *cardCountKV = [QCKeyboardView defaultKeboardView];
        
        cardCountKV.delegate = self;
        
        cardCountKV.tag = 102;
        
        self.maxCardCountTF.inputView = cardCountKV;
        
        self.cardCountPV = [[MOPickerView alloc]initWithFrame:CGRectMake(0, 39, MSW, 177)];
        
        NSMutableArray *cardCountArray = [NSMutableArray array];
        
        [cardCountArray addObject:@"不限张数"];
        
        for (NSInteger i = 1; i<=100; i++) {
            
            NSString *str = [NSString stringWithFormat:@"%ld张",(long)i];
            
            [cardCountArray addObject:str];
            
        }
        
        self.cardCountPV.titleArray = cardCountArray;
        
        cardCountKV.keyboard = self.cardCountPV;
        
        [self checkCardKind];
        
    }
    
    if (!AppGym) {
        
        self.suitLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), self.topView.bottom+Height320(10), Width320(200), Height320(14))];
        
        self.suitLabel.text = @"适用场馆";
        
        self.suitLabel.textColor = UIColorFromRGB(0x999999);
        
        self.suitLabel.font = AllFont(12);
        
        [self.view addSubview:self.suitLabel];
        
        self.secondView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topView.bottom+Height320(36), MSW, Height320(40))];
        
        self.secondView.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.secondView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.secondView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        [self.view addSubview:self.secondView];
        
        self.suitTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(16), 0, MSW-Width320(32), Height320(40))];
        
        self.suitTF.text = self.cardKind.gyms.count?[NSString stringWithFormat:@"%ld家",(unsigned long)self.cardKind.gyms.count]:@"";
        
        self.suitTF.placeholder = @"适用场馆";
        
        self.suitTF.textPlaceholder = @"请选择";
        
        self.suitTF.noLine = YES;
        
        self.suitTF.delegate = self;
        
        self.suitTF.mustInput = YES;
        
        self.suitTF.type = QCTextFieldTypeCell;
        
        [self.secondView addSubview:self.suitTF];
        
    }
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)checkCardKind
{
    
    if (!self.isAdd) {
        
        self.setConditionCell.on = self.cardKind.isLimit;
        
        if (self.cardKind.preTimes) {
            
            self.orderNumTF.text = [NSString stringWithInteger:self.cardKind.preTimes];
            
        }
        
        if (self.cardKind.dayTimes) {
            
            self.courseNumTF.text = [NSString stringWithFormat:@"每天，%ld节",(long)self.cardKind.dayTimes];
            
        }else if (self.cardKind.weekTimes){
            
            self.courseNumTF.text = [NSString stringWithFormat:@"每周，%ld节",(long)self.cardKind.weekTimes];
            
        }else if (self.cardKind.monthTimes){
            
            self.courseNumTF.text = [NSString stringWithFormat:@"每月，%ld节",(long)self.cardKind.monthTimes];
            
        }else
        {
            
            self.courseNumTF.text = @"";
            
        }
        
        if (self.cardKind.maxCardCount) {
            
            self.maxCardCountTF.text = [NSString stringWithFormat:@"%ld张",(long)self.cardKind.maxCardCount];
            
        }
        
    }
    
    [self check];
    
}

-(void)naviRightClick
{
    
    if (!self.isAdd&&((AppGym && self.cardKind.gyms.count>1)||(AppGym && ![PermissionInfo sharedInfo].permissions.cardKindPermission.editState)||(!AppGym&&[[PermissionInfo sharedInfo]getPermissionStateWithGyms:self.cardKind.gyms andPermission:[PermissionInfo sharedInfo].permissions.cardKindPermission andType:PermissionTypeEdit]!=PermissionStateAll))) {
        
        if ((AppGym && self.cardKind.gyms.count>1)||(AppGym && ![PermissionInfo sharedInfo].permissions.cardKindPermission.editState)) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
            self.hud.mode = MBProgressHUDModeIndeterminate;
            
            self.hud.label.text = @"";
            
            [self.hud showAnimated:YES];
            
            [self.info updateCardKindGyms:self.cardKind result:^(BOOL success, NSString *error) {
                
                self.hud.mode = MBProgressHUDModeText;
                
                if (success) {
                    
                    self.hud.label.text = @"修改成功";
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        if (self.editFinish) {
                            self.editFinish();
                        }
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    });
                    
                }else
                {
                    
                    self.hud.label.text = error;
                    
                    self.hud.label.numberOfLines = 0;
                    
                    [self.hud hideAnimated:YES afterDelay:1.0];
                    
                }
                
            }];
            
        }
        
    }else{
        
        if (!self.typeTF.text.length && self.isAdd == YES) {
            
            [[[UIAlertView alloc]initWithTitle:@"信息填写不完全" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        if (!AppGym && !self.suitTF.text.length) {
            
            [[[UIAlertView alloc]initWithTitle:@"请选择适应场馆" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        if(!self.nameTF.text.length){
            
            [[[UIAlertView alloc]initWithTitle:@"请填写会员卡种类名称" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
        if (self.setConditionCell.on) {
            
            self.cardKind.preTimes = [self.orderNumTF.text integerValue];
            
        }
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"";
        
        [self.hud showAnimated:YES];
        
        self.cardKind.cardKindName = self.nameTF.text;
        
        if (AppGym) {
            
            self.cardKind.gyms = [@[AppGym] mutableCopy];
            
        }
        
        if (self.isAdd) {
            
            self.cardKind.type = [self.typeTF.text isEqualToString:@"储值类型"]?CardKindTypePrepaid:[self.typeTF.text isEqualToString:@"次卡类型"]?CardKindTypeCount:CardKindTypeTime;
            
        }
        
        self.cardKind.summary = self.summaryCell.subtitle;
        
        if(self.isAdd)
        {
            
            [self.info createCardKind:self.cardKind result:^(BOOL success, NSString *error) {
                
                self.hud.mode = MBProgressHUDModeText;
                
                if (success) {
                    
                    self.hud.label.text = @"添加成功";
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        if (self.editFinish) {
                            self.editFinish();
                        }
                        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    });
                    
                }else
                {
                    
                    self.hud.label.text = error;
                    
                    self.hud.label.numberOfLines = 0;
                    
                    [self.hud hideAnimated:YES afterDelay:1.0];
                    
                }
                
            }];
            
        }else
        {
            
            [self.info updateCardKind:self.cardKind result:^(BOOL success, NSString *error) {
                
                self.hud.mode = MBProgressHUDModeText;
                
                if (success) {
                    
                    CardKindInfo *info = [[CardKindInfo alloc]init];
                    
                    [info updateCardKindGyms:self.cardKind result:^(BOOL success, NSString *error) {
                        
                        if (success) {
                            
                            self.hud.label.text = @"修改成功";
                            
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                
                                if (self.editFinish) {
                                    self.editFinish();
                                }
                                
                                [self.navigationController popViewControllerAnimated:YES];
                                
                            });
                            
                        }else
                        {
                            
                            self.hud.label.text = error;
                            
                            self.hud.label.numberOfLines = 0;
                            
                            [self.hud hideAnimated:YES afterDelay:1.0];
                            
                        }
                        
                    }];
                    
                }else
                {
                    
                    self.hud.label.text = error;
                    
                    self.hud.label.numberOfLines = 0;
                    
                    [self.hud hideAnimated:YES afterDelay:1.0];
                    
                }
                
            }];
            
        }
        
    }
    
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboardView
{
    
    [self.view endEditing:YES];
    
    if (keyboardView.tag == 101) {
        
        self.courseNumTF.text = [NSString stringWithFormat:@"%@，%ld节",self.gapPV.titleArray[self.gapPV.currentRow],(long)self.countPV.currentNumber];
        
        switch (self.gapPV.currentRow) {
            case 0:
                
                self.cardKind.dayTimes = self.countPV.currentNumber;
                
                self.cardKind.weekTimes = 0;
                
                self.cardKind.monthTimes = 0;
                
                break;
                
            case 1:
                
                self.cardKind.dayTimes = 0;
                
                self.cardKind.weekTimes = self.countPV.currentNumber;
                
                self.cardKind.monthTimes = 0;
                
                break;
                
            case 2:
                
                self.cardKind.dayTimes = 0;
                
                self.cardKind.weekTimes = 0;
                
                self.cardKind.monthTimes = self.countPV.currentNumber;
                
                break;
                
            default:
                break;
        }
        
    }else{
        
        self.maxCardCountTF.text = self.cardCountPV.titleArray[self.cardCountPV.currentRow];
        
        self.cardKind.maxCardCount = self.cardCountPV.currentRow;
        
    }
    
}

-(void)switchCellSwitchChanged:(MOSwitchCell *)cell
{
    
    [self.view endEditing:YES];
    
    self.cardKind.isLimit = cell.on;
    
    [self check];
    
}

-(void)check
{
    
    if (self.setConditionCell.on) {
        
        [self.topView changeHeight:self.isAdd?Height320(40)*7:Height320(40)*6];
        
        if (self.secondView) {
            
            [self.suitLabel changeTop:self.topView.bottom+Height320(10)];
            
            [self.secondView changeTop:self.topView.bottom+Height320(36)];
            
        }
        
        self.setConditionCell.noLine = NO;
        
        self.orderNumTF.hidden = NO;
        
        self.courseNumTF.hidden = NO;
        
        self.maxCardCountTF.hidden = NO;
        
    }else
    {
        
        [self.topView changeHeight:self.isAdd?Height320(40)*4:Height320(40)*3];
        
        if (self.secondView) {
            
            [self.suitLabel changeTop:self.topView.bottom+Height320(10)];
            
            [self.secondView changeTop:self.topView.bottom+Height320(36)];
            
        }
        
        self.setConditionCell.noLine = YES;
        
        self.orderNumTF.hidden = YES;
        
        self.courseNumTF.hidden = YES;
        
        self.maxCardCountTF.hidden = YES;
        
        self.cardKind.dayTimes = 0;
        
        self.cardKind.preTimes = 0;
        
        self.cardKind.weekTimes = 0;
        
        self.cardKind.monthTimes = 0;
        
        self.cardKind.maxCardCount = 0;
        
        self.orderNumTF.text = @"";
        
        self.courseNumTF.text = @"";
        
        self.maxCardCountTF.text = @"";
        
        self.cardCountPV.currentRow = 0;
        
        self.countPV.currentNumber = 0;
        
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (textField == self.typeTF){
        
        [self.view endEditing:YES];
     
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"类型" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"储值类型",@"次卡类型",@"期限类型", nil];
        
        [sheet showInView:self.view];
        
        return NO;
        
    }else if (textField == self.suitTF){
     
        CardKindSuitGymController *svc = [[CardKindSuitGymController alloc]init];
        
        if (self.cardKind.gyms) {
            
            svc.gyms = [self.cardKind.gyms mutableCopy];
            
        }else
        {
            
            svc.gyms = [NSMutableArray array];
            
        }
        
        svc.isAdd = self.isAdd;
        
        __weak typeof(self)weakS = self;
        
        svc.chooseFinish = ^(NSMutableArray *gyms){
            
            weakS.cardKind.gyms = gyms;
            
            weakS.suitTF.text = [NSString stringWithFormat:@"%ld家",(unsigned long)weakS.cardKind.gyms.count];
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
        return NO;
        
    }else
    {
        
        return YES;
        
    }
    
}

-(void)summaryClick:(MOCell*)cell
{
    
    SummaryController *svc = [[SummaryController alloc]init];
    
    svc.title = @"编辑简介";
    
    svc.placeholder = @"会员卡种类描述";
    
    svc.text = self.summaryCell.subtitle;
    
    __weak typeof(self)weakS = self;
    
    svc.summaryFinish = ^(NSString *summary){
       
        weakS.summaryCell.subtitle = summary;
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    self.typeTF.text = [actionSheet buttonTitleAtIndex:buttonIndex];
    
}


@end
