//
//  YFStudentFilterBirthdayModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/16.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudentFilterBirthdayModel.h"

#import "YFDateService.h"

static NSString *yFStudentFilterTimeCell = @"YFStudentFilterTimeCellBirthday";

@interface YFStudentFilterBirthdayModel ()<PTXDatePickerViewDelegate>

@end

@implementation YFStudentFilterBirthdayModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentFilterTimeCell;
        self.cellClass = [YFStudentFilterTimeCell class];
        self.cellHeight = XFrom6YF(95);
        
    }
    return self;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    YFStudentFilterTimeCell *cell = (YFStudentFilterTimeCell *)baseCell;
    cell.startTimeTF.inputView = cell.startMonthDatePickerView;
    cell.startMonthDatePickerView.tag = 201;
    cell.startMonthDatePickerView.delegate = self;
    
    cell.endTimeTF.inputView = cell.endMonthDatePickerView;
    cell.endMonthDatePickerView.tag = 202;
    cell.endMonthDatePickerView.delegate = self;
    
    cell.timeStateDesLabel.text = @"生日";
}

-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFStudentFilterTimeCell *cell = (YFStudentFilterTimeCell *)baseCell;
    cell.startTimeTF.text = self.startTime;
    cell.endTimeTF.text = self.endTime;
}

-(void)keyboardConfirm:(QCKeyboardView *)keyboadeView
{
    YFStudentFilterTimeCell *cell = (YFStudentFilterTimeCell *)self.weakCell;
    
    NSDateFormatter *df = [YFDateService dateformatter];
    [df setDateFormat:@"MM-dd"];
    if (keyboadeView.tag == 201){
        
        NSTimeInterval timeInterval = [[df dateFromString:[df stringFromDate:cell.startDP.date]] timeIntervalSinceDate:[df dateFromString:cell.endTimeTF.text]];
        
        if (timeInterval>0 && cell.endTimeTF.text.length > 0) {
            
            [[[UIAlertView alloc]initWithTitle:@"开始日期不能晚于结束日期" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else
        {
            
            cell.startTimeTF.text = [df stringFromDate:cell.startDP.date];
            self.startTime = cell.startTimeTF.text;
            [self.weakCell.currentVC.view endEditing:YES];
            
        }
        
    }else if(keyboadeView.tag == 202)
    {
        
        NSTimeInterval timeInterval = [[df dateFromString:[df stringFromDate:cell.endDP.date]] timeIntervalSinceDate:[df dateFromString:cell.startTimeTF.text]];
        
        if (timeInterval<0) {
            
            [[[UIAlertView alloc]initWithTitle:@"结束日期不能早于开始日期" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else
        {
            
            cell.endTimeTF.text = [df stringFromDate:cell.endDP.date];
            self.endTime = cell.endTimeTF.text;
            
            [self.weakCell.currentVC.view endEditing:YES];
            
        }
        
    }
}

- (void)datePickerView:(PTXDatePickerView *)datePickerView didSelectDate:(NSDate *)date
{
    YFStudentFilterTimeCell *cell = (YFStudentFilterTimeCell *)self.weakCell;

    NSDateFormatter *dateFormatter = [YFDateService dateformatter];
    [dateFormatter setDateFormat:@"MM-dd"];
    
    
    
     NSString *dateStr = [dateFormatter stringFromDate:date];
    
    if (datePickerView.tag == 201)
    {
        if (self.endTime) {
            NSString *startNumString = [dateStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
            NSString *endNumString = [self.endTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
            if (startNumString.integerValue > endNumString.integerValue) {
                
                [[[UIAlertView alloc]initWithTitle:@"开始日期不能晚于结束日期" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
            }
        }

        
        cell.startTimeTF.text = dateStr;
        self.startTime = cell.startTimeTF.text;
    }else
    {
        if (self.startTime) {
            NSString *startNumString = [self.startTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
            NSString *endNumString = [dateStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
            if (startNumString.integerValue > endNumString.integerValue) {
                
                [[[UIAlertView alloc]initWithTitle:@"结束日期不能早于开始日期" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                
                return;
            }
        }

        
        cell.endTimeTF.text = dateStr;
        self.endTime = cell.endTimeTF.text;
    }
    

}


@end
