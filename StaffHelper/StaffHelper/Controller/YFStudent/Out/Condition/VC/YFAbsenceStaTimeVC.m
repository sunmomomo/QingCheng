//
//  YFAbsenceStaTimeVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFAbsenceStaTimeVC.h"

#import "YFStuAbsenceFilterTimeModel.h"

#import "YFTBSectionLineEdgeDelegate.h"

#import "YFTimeTwoButtonView.h"

#import "YFAppService.h"

@interface YFAbsenceStaTimeVC ()

@property(nonatomic, strong)YFTimeTwoButtonView *twoButtonView;

@end

@implementation YFAbsenceStaTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.baseTableView.bounces = NO;
    [self.navi removeFromSuperview];
    [self requestData];
    self.leftView = self.baseTableView;
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.twoButtonView];
    self.rightView = self.twoButtonView;
    self.baseTableView.backgroundColor = [UIColor whiteColor];
    
}

- (void)requestData
{
    NSArray *buttonTitleArray = @[@"缺勤>60天",@"缺勤30-60天",@"缺勤7-30天",@"自定义"];
    NSArray *paramArray = @[@{@"absence__gt":@"60"},@{@"absence__lte":@"60",@"absence__gte":@"30"},@{@"absence__lte":@"30",@"absence__gte":@"7"},@{}];
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i < buttonTitleArray.count; i++) {
        NSString *title = buttonTitleArray[i];
        NSDictionary *param = paramArray[i];
     YFStuAbsenceFilterTimeModel *model = [YFStuAbsenceFilterTimeModel defaultWithYYModelDic:nil selectBlock:^(YFStuAbsenceFilterTimeModel *filterModel) {
            NSLog(@"%@",filterModel.name);
        }];
        model.param = param;
        model.name = title;
        if ([title isEqualToString:@"缺勤7-30天"]) {
            model.isSelected = YES;
            _filterTimeModel = model;
        }
        [dataArray addObject:model];
    }
    self.baseDataArray = dataArray;
    [self.baseTableView reloadData];
}

- (void)setFilterTimeModel:(YFStuAbsenceFilterTimeModel *)filterTimeModel
{
    if (_filterTimeModel && [_filterTimeModel isEqual:filterTimeModel] == NO) {
        _filterTimeModel.isSelected = NO;
    }
    _filterTimeModel = filterTimeModel;
    [self.baseTableView reloadData];
    self.param = _filterTimeModel.param;
    self.selectTitle = _filterTimeModel.name;
    if (self.selectBlock) {
        self.selectBlock(nil);
    }
}

-(YFTBBaseDelegate *)delegateTBYF
{
    weakTypesYF
    return [YFTBSectionLineEdgeDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
        
    } currentVC:self];
}

- (YFTimeTwoButtonView *)twoButtonView
{
    if (_twoButtonView == nil)
    {
        _twoButtonView = [[YFTimeTwoButtonView alloc] initWithFrame:CGRectMake(self.view.width, 0, self.view.width, XFrom5To6YF(120))];
        
        [_twoButtonView creatView];
        
        [_twoButtonView.leftButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_twoButtonView.rightButton addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _twoButtonView;
}

- (void)backAction:(UIButton *)button
{
    [self showLeftView];
}

- (void)sureAction:(UIButton *)button
{
    
    if (self.twoButtonView.leftTextField.text.length == 0 )
    {
        [YFAppService showAlertMessage:@"请输入最小天数" oneTitle:@"确定"];
        return;
    }
    
    if (self.twoButtonView.rightTextField.text.length == 0 )
    {
        [YFAppService showAlertMessage:@"请输入最大天数" oneTitle:@"确定"];
        return;
    }
    
    if (self.twoButtonView.leftTextField.text.integerValue  >  self.twoButtonView.rightTextField.text.integerValue )
    {
        [YFAppService showAlertMessage:@"最小天数不能大于最大天数" oneTitle:@"确定"];
        return;
    }
    
    self.param = @{@"absence__gte":self.twoButtonView.leftTextField.text,@"absence__lte":self.twoButtonView.rightTextField.text};
self.selectTitle = [NSString stringWithFormat:@"缺勤%@-%@天",self.twoButtonView.leftTextField.text,self.twoButtonView.rightTextField.text];
    if (self.selectBlock) {
        
        
        YFStuAbsenceFilterTimeModel *model = self.baseDataArray.lastObject;
        model.isSelected = YES;
        _filterTimeModel.isSelected = NO;
        _filterTimeModel = model;
        [self.baseTableView reloadData];
        self.selectBlock(nil);
    }
}



@end
