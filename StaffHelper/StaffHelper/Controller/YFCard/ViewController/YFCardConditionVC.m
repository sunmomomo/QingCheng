//
//  YFCardConditionVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardConditionVC.h"

#import "YFCardConditonModel.h"

#import "NSMutableDictionary+YFExtension.h"

#import "YFTBSectionLineEdgeDelegate.h"

#import "CardListInfo.h"



@interface YFCardConditionVC ()

@end

@implementation YFCardConditionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseTableView.tableHeaderView = [self tableTopHeadView];
    [self.navi removeFromSuperview];
    
    [self requestData];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.baseTableView.frame = CGRectMake(0, 0, self.view.width, XFrom5To6YF(40) * 4 + 15 + YFDonwnButtonSHeight);
    self.baseTableView.backgroundColor = RGB_YF(244, 244, 244);
    self.baseTableView.scrollEnabled = NO;
    
    [self.view addSubview:self.clearAllFilterConditionButton];
    [self.view addSubview:self.sureButton];
}
- (void)requestData
{
    
}

- (YFCardConditonModel *)modelWithconName:(NSString *)conName unit:(NSString *)unit value:(NSString *)string
{
    YFCardConditonModel *model = [YFCardConditonModel defaultWithYYModelDic:nil];
    model.conditionName = conName;
    model.valueStringFY = string;
    model.conditionUnit = unit;
    return model;
}

- (UIView *)tableTopHeadView
{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW,XFrom5To6YF(40.0))];
    
    header.backgroundColor = RGB_YF(244, 244, 244);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12.0, 0, header.width - 24, header.height)];
    
    label.textColor = RGB_YF(153, 153, 153);
    
    label.font = FontSizeFY(XFrom5To6YF(12));
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.numberOfLines = 0;
    
    label.backgroundColor = [UIColor clearColor];
    
    [header addSubview:label];
    
    label.text = @"— 显示符合以下条件的会员卡 —";
    
    return header;
}

#pragma mark Getter
- (UIButton *)clearAllFilterConditionButton
{
    if (!_clearAllFilterConditionButton)
    {
        CGFloat buttonWidth = MSW / 2.0;
        _clearAllFilterConditionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _clearAllFilterConditionButton.frame = CGRectMake(0, self.baseTableView.height -  YFDonwnButtonSHeight, buttonWidth, YFDonwnButtonSHeight);
        [_clearAllFilterConditionButton setTitle:@"重置" forState:UIControlStateNormal];
        [_clearAllFilterConditionButton setTitleColor:YFCellTitleColor forState:UIControlStateNormal];
        [_clearAllFilterConditionButton.titleLabel setFont:AllFont(14)];
        _clearAllFilterConditionButton.backgroundColor = YFMainBackColor;
        [_clearAllFilterConditionButton addTarget:self action:@selector(clearAllFilterConditionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearAllFilterConditionButton;
}

- (UIButton *)sureButton
{
    if (!_sureButton)
    {
        CGFloat buttonWidth = MSW  / 2.0;
        
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _sureButton.frame = CGRectMake(buttonWidth, self.baseTableView.height -  YFDonwnButtonSHeight, buttonWidth, YFDonwnButtonSHeight);
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureButton.titleLabel setFont:AllFont(14)];
        _sureButton.backgroundColor = RGB_YF(11, 177, 75.0);
        [_sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _sureButton;
}

- (void)clearAllFilterConditionButtonAction:(UIButton *)button
{
    if (self.baseDataArray.count == 3)
    {
        YFCardConditonModel *model = self.baseDataArray[0];
        model.valueStringFY = @"500";
        model = self.baseDataArray[1];
        model.valueStringFY = @"5";
        model = self.baseDataArray[2];
        model.valueStringFY = @"15";
    }
    [self.baseTableView reloadData];
}

- (void)sureButtonAction:(UIButton *)button
{
    
    if (self.sureBlock) {
        self.sureBlock();
    }
}

- (NSDictionary *)paramOfCondition
{
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    
    if (self.baseDataArray.count == 3)
    {
        YFCardConditonModel *model = self.baseDataArray[0];
        [paraDic setObje_FY:model.valueStringFY toKey:@"pay"];

        model = self.baseDataArray[1];
        [paraDic setObje_FY:model.valueStringFY toKey:@"count"];

        model = self.baseDataArray[2];
        [paraDic setObje_FY:model.valueStringFY toKey:@"time"];
    }
    return paraDic;
}

-(YFTBBaseDelegate *)delegateTBYF
{
    weakTypesYF
    return [YFTBSectionLineEdgeDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
        
    } currentVC:self];
}

-(void)setCardListSetting:(CardListInfo *)cardSetInfo
{
    self.baseDataArray = [NSMutableArray array];
    
    [self.baseDataArray addObject:[self modelWithconName:@"储值卡余额小于" unit:@"元" value:cardSetInfo.balancePayModel.value]];
    [self.baseDataArray addObject:[self modelWithconName:@"次卡余额小于" unit:@"次" value:cardSetInfo.remandTimesModel.value]];

    YFCardConditonModel *model = [self modelWithconName:@"剩余有效期小于" unit:@"天" value:cardSetInfo.remindDaysModel.value];
    model.edgeInsets = UIEdgeInsetsZero;
    [self.baseDataArray addObject:model];
    
    [self.baseTableView reloadData];
}
@end
