//
//  YFStudentChooseTimeVC.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentChooseTimeVC.h"
#import "YFChooseTimeModel.h"
#import "YFStudentChooseTimeCell.h"
#import "YFDateService.h"
#import "YFAppService.h"

@interface YFStudentChooseTimeVC ()

@property(nonatomic,strong)UILabel *tableViewLabel;
@property(nonatomic,strong)UIView *tableViewFootView;





@end

@implementation YFStudentChooseTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navi removeFromSuperview];
    
    NSMutableArray *dataArray = [NSMutableArray array];

    [dataArray addObject:self.startTimeModel];
    [dataArray addObject:self.endTimeModel];
    
    [self requestSuccessArray:dataArray];
    self.baseTableView.scrollEnabled = NO;
    self.baseTableView.backgroundColor = RGB_YF(246, 246, 246);
    self.view.backgroundColor = self.baseTableView.backgroundColor;
    
    [self.baseTableView setTableHeaderView:self.tableViewLabel];
    [self.baseTableView setTableFooterView:self.tableViewFootView];
    
    
}


- (YFChooseTimeModel *)startTimeModel
{
    if (!_startTimeModel)
    {
        _startTimeModel = [YFChooseTimeModel defaultWithDic:nil];
    }
    return _startTimeModel;
}

- (YFChooseTimeModel *)endTimeModel
{
    if (!_endTimeModel)
    {
        _endTimeModel = [YFChooseTimeModel defaultWithDic:nil];
    }
    return _endTimeModel;
}


-(void)keyboardConfirm:(QCKeyboardView *)keyboadeView
{
    
    NSDateFormatter *df = [YFDateService dateformatter];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    YFStudentChooseTimeCell *startCell = (YFStudentChooseTimeCell *)self.startTimeModel.weakCell;

    YFStudentChooseTimeCell *endCell = (YFStudentChooseTimeCell *)self.endTimeModel.weakCell;
    
    if (keyboadeView.tag == 1){
        
        
        NSTimeInterval timeInterval = [[df dateFromString:[df stringFromDate:startCell.startDP.date]] timeIntervalSinceDate:[df dateFromString:endCell.startTimeTF.text]];
        
        if (timeInterval>0 && endCell.startTimeTF.text.length > 0) {
            
            [[[UIAlertView alloc]initWithTitle:@"开始日期不能晚于结束日期" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else
        {
            
            startCell.startTimeTF.text = [df stringFromDate:startCell.startDP.date];
            self.startTimeModel.timeStr = startCell.startTimeTF.text;
            [self.view endEditing:YES];
            
        }
        
    }else if(keyboadeView.tag == 2)
    {
        
        NSTimeInterval timeInterval = [[df dateFromString:[df stringFromDate:endCell.startDP.date]] timeIntervalSinceDate:[df dateFromString:startCell.startTimeTF.text]];
        
        if (timeInterval<0) {
            
            [[[UIAlertView alloc]initWithTitle:@"结束日期不能早于开始日期" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }else
        {
            
            endCell.startTimeTF.text = [df stringFromDate:endCell.startDP.date];
            self.endTimeModel.timeStr = endCell.startTimeTF.text;
            
            [self.view endEditing:YES];
            
        }
        
    }
    
}


- (void)sureAction:(UIButton *)button
{
    if (self.startTimeModel.timeStr.length || self.endTimeModel.timeStr.length)
    {
        if (!self.startTimeModel.timeStr.length)
        {
            [YFAppService showAlertMessage:@"开始日期不能为空"];
            return;
        }
        if (!self.endTimeModel.timeStr.length)
        {
            [YFAppService showAlertMessage:@"结束日期不能为空"];
            
            return;
        }
    }
    
    self.start = self.startTimeModel.timeStr;
    self.end = self.endTimeModel.timeStr;
    
    if (self.selectBlock) {
        self.selectBlock();
    }
    
}


- (UILabel  *)tableViewLabel
{
    if (_tableViewLabel == nil)
    {
        _tableViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MSW, 40.0)];
        
        _tableViewLabel.backgroundColor = self.baseTableView.backgroundColor;
        _tableViewLabel.textColor = RGB_YF(153, 153, 153);
        _tableViewLabel.font = FontSizeFY(13.5);
        _tableViewLabel.textAlignment = NSTextAlignmentCenter;
        _tableViewLabel.text = [NSString stringWithFormat:@"- 筛选某段时间内%@的会员 -",self.title];
    }
    return _tableViewLabel;
}

- (UIView  *)tableViewFootView
{
    if (_tableViewFootView == nil)
    {
        _tableViewFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, XFrom6YF(75.0))];
        
        _tableViewFootView.backgroundColor = self.baseTableView.backgroundColor;
        
        CGFloat beginGap = 19.0;
        CGFloat buttonGap = 17.5;
        CGFloat buttonWidth =  (_tableViewFootView.width - 2 * beginGap - buttonGap) / 2.0;
        
        for (NSInteger i = 0; i < 2; i ++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(beginGap + i * (buttonGap + buttonWidth), 14.0, buttonWidth, XFrom6YF(42.0));
            [button addTarget:self action:@selector(selectTimeAction:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = i + 1;
            if (i == 0)
            {
                button.backgroundColor = RGB_YF(250, 250, 250);
                [button setTitleColor:RGB_YF(73, 73, 73) forState:UIControlStateNormal];
                [button setTitle:@"重置" forState:UIControlStateNormal];
            }else
            {
                button.backgroundColor = RGB_YF(11, 177, 74);
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setTitle:@"确定" forState:UIControlStateNormal];
            }
            button.layer.cornerRadius = 3.0;
            button.layer.borderWidth =  0.5;
            button.layer.borderColor =  YFLineViewColor.CGColor;
            [_tableViewFootView addSubview:button];
            
            
        }
    }
    return _tableViewFootView;
}


- (void)selectTimeAction:(UIButton *)button
{
    if (button.tag == 1)
    {
        weakTypesYF
        [YFAppService showAlertMessage:@"确定重置时间筛选条件" sureBlock:^{
            [weakS clearAllCondition];
        }];
       
    }else
    {
        [self sureAction:button];
    }
}

- (void)clearAllCondition
{
    self.startTimeModel.timeStr = @"";
    self.endTimeModel.timeStr = @"";
    [self.baseTableView reloadData];
    [self sureAction:nil];
}


-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    _tableViewLabel.text = [NSString stringWithFormat:@"- 筛选某段时间内%@的会员 -",self.title];

    
}

@end
