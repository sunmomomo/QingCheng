//
//  YFFolloSubUpCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFFolloSubUpCModel.h"

#import "YFFolloSubUpCell.h"

#import "YFDateService.h"

#import "YFConditionPopView.h"

#import "YFStudentStateDetailVC.h"

#import "YFConditionSellerPopView.h"

#import "YFConditionTimeNoTodayPopView.h"

static NSString *yFFolloSubUpCell = @"YFFolloSubUpCell";

@interface YFFolloSubUpCModel()<GTWSelectOperationViewDelegate>

@property(nonatomic, strong)YFConditionPopView *showPopView;

@property(nonatomic, strong)NSMutableArray *popViewsArray;

@property (nonatomic,strong) GTWSelectOperationView *operationView;


/**
 * 正常图片
 */
@property(nonatomic, strong)NSMutableArray *nomalDownImageArray;

@property(nonatomic, strong)NSMutableArray *nomalUpImageArray;



/**
 * 选中图片
 */
@property(nonatomic, strong)NSMutableArray *selectDownImageArray;

/**
 * 选中图片
 */
@property(nonatomic, strong)NSMutableArray *selectUpImageArray;

@property(nonatomic ,strong)NSArray *buttonTitlesArray;

@end

@implementation YFFolloSubUpCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFFolloSubUpCell;
        self.cellClass = [YFFolloSubUpCell class];
        self.cellHeight = XFrom5To6YF(40) + Width320(164);
        
        self.staticsModel = [YFStaticsModel defaultWithDic:jsonDic];
        
    }
    return self;
}

- (void)setCell:(YFFolloSubUpCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [baseCell.buttonOfSeller addTarget:self action:@selector(sellerAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [baseCell.buttonOfTime addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [baseCell.contentView addSubview:self.operationView];

    
    YFStudentStateDetailVC *detailVC = (YFStudentStateDetailVC *)self.weakCell;
    
    for (Class popClass in self.classsArray)
    {
        YFConditionPopView *popView = [[popClass alloc] initWithFrame:detailVC.baseTableView.frame superView:detailVC.view];
        popView.title = detailVC.title;
        weakTypesYF
        
        [popView setSelectBlock:^(NSString *value, NSDictionary *param) {
            
            [weakS selectParam:value param:param];
        }];
        __weak typeof(popView)weakPop = popView;
        
        [popView setCancelBlock:^(id model) {
            NSInteger index = [weakS.popViewsArray indexOfObject:weakPop];
            
            UIButton *button = [weakS.operationView buttonWithIndex:index];
            button.selected = NO;
        }];
        
        
        popView.gym = detailVC.gym;
        [self.popViewsArray addObject:popView];
    }

    
}

- (void)bindCell:(YFFolloSubUpCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    if ([baseCell.chartView.staticModel isEqual:self.staticsModel])
    {
        return;
    }

    baseCell.nameLabel.text = @"趋势图";
    
    [baseCell creatCharViewWithDateCount:self.staticsModel.arrayModels.count defaultColor:self.defaultColor];
    baseCell.chartView.staticModel = self.staticsModel;

    
    [baseCell setContentOffsetWithXX:baseCell.chartView.beginSelelctOffsetIndex];
    [baseCell setDefaultView];
    
    self.cellHeight = baseCell.scrollView.bottom + Width320(29);
}


- (void)sellerAction:(id)sender
{
    
}

- (void)timeAction:(id)sender
{
    
}



- (void)selectParam:(NSString *)value param:(NSDictionary *)param
{
    [self.showPopView hide];
    
    NSMutableDictionary *allParam = [NSMutableDictionary dictionary];
    
    for (NSUInteger i = 0; i < self.popViewsArray.count; i ++)
    {
        YFConditionPopView *popView = self.popViewsArray[i];
        if (popView.param.count) {
            if (popView.isValidParam)
            {
                [allParam setValuesForKeysWithDictionary:popView.param];
            }
            [self.operationView setSelectButtonWithIndex:i];
        }else
        {
            [self.operationView setUnSelectButtonWithIndex:i];
        }
        if ([popView isEqual:self.showPopView])
        {
            [self.operationView setSelectButtonTitleWithIndex:i suitFrametitle:self.showPopView.value maxWidth:(MSW / self.buttonTitlesArray.count - 10)];
        }
    }
    
    for (YFConditionPopView *popView in self.popViewsArray) {
        [popView afterSetAllConditionsParam:allParam];
    }
    
    [self.operationView setUnselectButtonFY];
    self.allConditionParam = allParam;
    
    if (self.refreshStaticBlock)
    {
        self.refreshStaticBlock();
    }
    
}

- (NSArray *)buttonTitlesArray
{
    if (!_buttonTitlesArray)
    {
        NSArray *buttonTitleArray = @[@"销售",@"最近7天"];

        _buttonTitlesArray = buttonTitleArray;
    }
    return _buttonTitlesArray;
}

- (NSMutableArray *)popViewsArray
{
    if (!_popViewsArray)
    {
        _popViewsArray = [[NSMutableArray alloc] init];
    }
    return _popViewsArray;
}

- (void)setShowPopView:(YFConditionPopView *)showPopView
{
    if (_showPopView && [showPopView isEqual:_showPopView] == NO) {
        [_showPopView hideAnimate:NO];
    }
    _showPopView = showPopView;
}



- (GTWSelectOperationView *)operationView
{
    if (!_operationView)
    {
        CGFloat xx = Width320(158);
        
        CGFloat widthYF = (long)(MSW - xx);
        
        
        _operationView = [[GTWSelectOperationView alloc]initWithDataSourceFY:self.buttonTitlesArray sepImageArray:self.nomalUpImageArray downImageArray:self.nomalDownImageArray delegate:self font:[UIFont systemFontOfSize:IPhone4_5_6_6PYF(13, 13, 14, 14) ] allWidth:widthYF];
        
        _operationView.upSeleImageArray = self.selectUpImageArray;
        //        _operationView.downSeleImageArray = self.selectDownImageArray;
        _operationView.backgroundColor = [UIColor whiteColor];
        
        _operationView.frame = CGRectMake(xx, 0, widthYF, GTWSelectOperationViewHeight);
    }
    return _operationView;
}

#pragma mark -- Getter

- (NSMutableArray *)nomalDownImageArray
{
    if (!_nomalDownImageArray)
    {
        _nomalDownImageArray = [NSMutableArray arrayWithObjects:@"buttonUnSelectedDown",@"buttonUnSelectedDown",@"buttonUnSelectedDown",@"buttonUnSelectedDown", nil];
    }
    return _nomalDownImageArray;
}

- (NSMutableArray *)nomalUpImageArray
{
    if (!_nomalUpImageArray)
    {
        _nomalUpImageArray = [NSMutableArray arrayWithObjects:@"buttonUnSelectedUp",@"buttonUnSelectedUp",@"buttonUnSelectedUp",@"buttonUnSelectedUp", nil];
    }
    return _nomalUpImageArray;
}

- (NSMutableArray *)selectDownImageArray
{
    if (!_selectDownImageArray)
    {
        _selectDownImageArray = [NSMutableArray arrayWithObjects:@"buttonSelectedDown",@"buttonSelectedDown",@"buttonSelectedDown",@"buttonSelectedDown", nil];
    }
    return _selectDownImageArray;
}

- (NSMutableArray *)selectUpImageArray
{
    if (!_selectUpImageArray)
    {
        _selectUpImageArray = [NSMutableArray arrayWithObjects:@"buttonSelectedUp",@"buttonSelectedUp",@"buttonSelectedUp",@"buttonSelectedUp", nil];
    }
    return _selectUpImageArray;
}

- (NSArray *)classsArray
{
    if (!_classsArray) {
        NSArray * classArray = @[[YFConditionSellerPopView class],[YFConditionTimeNoTodayPopView class]];
        _classsArray = classArray;
    }
    return _classsArray;
}


#pragma mark Delegate
- (void)operationViewDidSelectedIndex:(NSInteger)index selectedState:(BOOL)selectedState button:(UIButton *)button
{
    if (self.popViewsArray.count > index) {
        self.showPopView = self.popViewsArray[index];
    }else
    {
        self.showPopView = nil;
    }
    if (self.showPopView.isCanShow == NO)
    {
        [self.operationView setUnselectButtonFY];
    }
    
    CGFloat yyPop = yyPop =  self.operationView.height + 64;
    
    
    YFStudentStateDetailVC *detailVC = (YFStudentStateDetailVC *)self.weakCell.currentVC;

    [detailVC.baseTableView setContentOffset:CGPointZero];
    
    self.showPopView.originFrame = CGRectMake(0, yyPop, detailVC.view.width, MSH - yyPop);
    
    [self.showPopView showOrHide];
}




@end
