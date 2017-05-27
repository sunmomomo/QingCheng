//
//  YFStudentFilterTimeModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentFilterTimeModel.h"

#import "YFDateService.h"

#import "YFStudentFilterStateCell.h"

#import "YFDateService.h"

static NSString *yFStudentFilterTimeCell = @"YFStudentFilterTimeCell";

@interface YFStudentFilterTimeModel()

@property(nonatomic, strong)UIButton *selectButton;

@end

@implementation YFStudentFilterTimeModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentFilterTimeCell;
        self.cellClass = [YFStudentFilterTimeCell class];
        self.cellHeight = XFrom6YF(125);
    }
    return self;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    self.weakCell = baseCell;
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    YFStudentFilterTimeCell *cell = (YFStudentFilterTimeCell *)baseCell;
    cell.startKV.delegate = self;
    cell.startKV.tag = 201;
    cell.endKV.delegate = self;
    cell.endKV.tag = 202;
    
    [cell.todayButton addTarget:self action:@selector(todayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.sevenDayButton addTarget:self action:@selector(sevenDayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.thirtyDayButton addTarget:self action:@selector(thirtyDayButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cellHeight = cell.todayButton.bottom + 22.0;

   }

- (void)todayButtonAction:(UIButton *)button
{
    self.timeType = YFIsRegisterTimeTypeToday;
    
    self.selectButton = button;
    
    YFStudentFilterTimeCell *cell = (YFStudentFilterTimeCell *)self.weakCell;
    
    cell.startTimeTF.text = [YFDateService getDateFromDays:0 formating:nil];
    
    cell.endTimeTF.text = cell.startTimeTF.text;
    
    [self getTimeFromTextFieldCell:cell];
}

- (void)selectTodayButton
{
    YFStudentFilterTimeCell *cell = (YFStudentFilterTimeCell *)self.weakCell;

    [self todayButtonAction:cell.todayButton];
}

- (void)unSelectAllButton
{
    self.selectButton = nil;
    
//    [cell.todayButton setSelected:NO];
//    
//    [cell.sevenDayButton setSelected:NO];
//    
//    [cell.thirtyDayButton setSelected:NO];
//
}

- (void)sevenDayButtonAction:(UIButton *)button
{
    
    self.timeType = YFIsRegisterTimeTypeSeven;
    
    self.selectButton = button;
    
    YFStudentFilterTimeCell *cell = (YFStudentFilterTimeCell *)self.weakCell;

    cell.startTimeTF.text = [YFDateService getDateFromDays:-6 formating:nil];
    
    cell.endTimeTF.text = [YFDateService getDateFromDays:0 formating:nil];
    
    [self getTimeFromTextFieldCell:cell];
}

- (void)thirtyDayButtonAction:(UIButton *)button
{
    self.selectButton = button;
    
    self.timeType = YFIsRegisterTimeTypeThirty;

    YFStudentFilterTimeCell *cell = (YFStudentFilterTimeCell *)self.weakCell;
    
    cell.startTimeTF.text = [YFDateService getDateFromDays:-29 formating:nil];
    
    cell.endTimeTF.text = [YFDateService getDateFromDays:0 formating:nil];
    
    [self getTimeFromTextFieldCell:cell];
}

- (void)getTimeFromTextFieldCell:(YFStudentFilterTimeCell *)cell
{
    self.startTime = cell.startTimeTF.text;
    self.endTime = cell.endTimeTF.text;
}


-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFStudentFilterTimeCell *cell = (YFStudentFilterTimeCell *)baseCell;
    cell.startTimeTF.text = self.startTime;
    cell.endTimeTF.text = self.endTime;
    
    if (self.timeType == YFIsRegisterTimeTypeToday)
    {
        [self selectTodayButton];
    }
    else if (self.timeType == YFIsRegisterTimeTypeSeven)
    {
        [self sevenDayButtonAction:cell.sevenDayButton];
    }
    else if (self.timeType == YFIsRegisterTimeTypeThirty)
    {
        [self thirtyDayButtonAction:cell.thirtyDayButton];
    }
    else
    {
        [self unSelectAllButton];
    }

}

-(void)keyboardConfirm:(QCKeyboardView *)keyboadeView
{
    YFStudentFilterTimeCell *cell = (YFStudentFilterTimeCell *)self.weakCell;
    
    NSDateFormatter *df = [YFDateService dateformatter];
    [df setDateFormat:@"yyyy-MM-dd"];
    if (keyboadeView.tag == 201){
        
        NSTimeInterval timeInterval = [[df dateFromString:[df stringFromDate:cell.startDP.date]] timeIntervalSinceDate:[df dateFromString:cell.endTimeTF.text]];
        
        if (timeInterval>0 && cell.endTimeTF.text.length > 0) {
            
            [[[UIAlertView alloc]initWithTitle:@"开始日期不能晚于结束日期" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
        }else
        {
            
            cell.startTimeTF.text = [df stringFromDate:cell.startDP.date];
            self.startTime = cell.startTimeTF.text;
            [self.weakCell.currentVC.view endEditing:YES];
            self.selectButton = nil;
        }

    }else if(keyboadeView.tag == 202)
    {
        
        NSTimeInterval timeInterval = [[df dateFromString:[df stringFromDate:cell.endDP.date]] timeIntervalSinceDate:[df dateFromString:cell.startTimeTF.text]];
        
        if (timeInterval<0) {
            
            [[[UIAlertView alloc]initWithTitle:@"结束日期不能早于开始日期" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
        }else
        {
            
            cell.endTimeTF.text = [df stringFromDate:cell.endDP.date];
            self.endTime = cell.endTimeTF.text;

            [self.weakCell.currentVC.view endEditing:YES];
            self.selectButton = nil;
        }
        
    }
    self.timeType = YFIsRegisterTimeTypeNone;

    
}


- (void)setSelectButton:(UIButton *)selectButton
{
    if (_selectButton) {
        _selectButton.selected = NO;
        [self setButtonStateSetting:_selectButton];
    }
    _selectButton = selectButton;
    _selectButton.selected = YES;
    [self setButtonStateSetting:_selectButton];
}


- (void)setButtonStateSetting:(UIButton *)button
{
    if (button.selected)
    {
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderColor = YFSelectedButtonColor.CGColor;
        button.layer.borderWidth = 1.0;
    }else
    {
        button.backgroundColor = YFCellButtonBaColor;
        button.layer.borderColor = [UIColor clearColor].CGColor;
        button.layer.borderWidth = 0.0;
    }
}


@end
