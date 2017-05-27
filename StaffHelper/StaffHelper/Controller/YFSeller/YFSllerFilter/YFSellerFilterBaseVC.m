//
//  YFSellerFilterBaseVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/1/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSellerFilterBaseVC.h"

#import "YFSellerFiterViewModel.h"

@interface YFSellerFilterBaseVC ()

@property(nonatomic, strong)UILabel *tableFootLabel;
@property(nonatomic, strong)UIView *tableFootView;

@end

@implementation YFSellerFilterBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



-(YFSellerFiterViewModel *)fiterViewModel
{
    if (!_fiterViewModel) {
        _fiterViewModel = [[YFSellerFiterViewModel alloc] init];
        weakTypesYF
        [_fiterViewModel setButtonActionTime:^{
            [weakS timeSort];
        }];
        [_fiterViewModel setButtonActionLetter:^{
            [weakS letterSort];
        }];
    }
    _fiterViewModel.sliderVC = self.sliderVC;
    _fiterViewModel.rightVC = self.rightVC;
    return _fiterViewModel;
}

-(void (^)())sureBlock
{
    if (!_sureBlock) {
        weakTypesYF
        [self setSureBlock:^{
            [weakS sureToFilterOtherAction];
        }];
    }
    return _sureBlock;
}

-(void)sureToFilterOtherAction
{
    // 请求成功 后 = self.dataModel.fiterOtherModel
    _temFilterModel = [self.rightVC.filterModel modelCopy];
    _temFilterModel.allOrigDic = [NSMutableDictionary dictionaryWithDictionary:[self.rightVC.filterModel allOrigDic]];
    _temFilterModel.allRecoDic = [NSMutableDictionary dictionaryWithDictionary:[self.rightVC.filterModel allRecoDic]];
    
    self.fiterViewModel.buttonOfOtherFilter.selected = !self.rightVC.filterModel.isEmptyYF;
    self.fiterViewModel.fiterOtherModel = _temFilterModel;
    [self.sliderVC closeSideBar];
    [self reloadData];
}

- (YFFilterOtherModel *)temFilterModel
{
    if (!_temFilterModel)
    {
        if (self.fiterViewModel.fiterOtherModel) {
            _temFilterModel = self.fiterViewModel.fiterOtherModel;
        }else{
        _temFilterModel = [[YFFilterOtherModel alloc] init];
        }
    }
    return _temFilterModel;
}



-(UIView *)tableFootView
{
    if (!_tableFootView)
    {
        _tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, 44)];
        _tableFootView.backgroundColor = YFGrayViewColor;
        CGFloat labelWidth = 70;
        _tableFootLabel = [[UILabel alloc] initWithFrame:CGRectMake((_tableFootView.width - labelWidth) / 2.0, 0, labelWidth, 44)];
        _tableFootLabel.backgroundColor = YFGrayViewColor;
        _tableFootLabel.textColor = RGB_YF(153, 153, 153);
        _tableFootLabel.font = FontSizeFY(12.0);
        _tableFootLabel.textAlignment = NSTextAlignmentCenter;
        [_tableFootView addSubview:_tableFootLabel];
        
        CGFloat lineViewWidth = 0.25 * _tableFootView.width;;
        CGFloat lineViewxx1 = _tableFootLabel.left - lineViewWidth - 10;
        CGFloat lineViewxx2 = _tableFootLabel.right + 10;
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(lineViewxx1, _tableFootView.height / 2.0, lineViewWidth, 0.5)];
        lineView1.backgroundColor = YFLineViewColor;
        [_tableFootView addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(lineViewxx2, _tableFootView.center.y, lineViewWidth, 0.5)];
        lineView2.backgroundColor = YFLineViewColor;
        [_tableFootView addSubview:lineView2];
        
        self.baseTableView.backgroundColor = _tableFootView.backgroundColor;
    }
    
    return _tableFootView;
}

- (void)setTableFootviewLabelNum:(NSInteger )count
{
    
    //    搜索全部会员，无搜索结果
    if (count > 0) {
        self.tableFootView.hidden = NO;
        _tableFootLabel.text = [NSString stringWithFormat:@"%@名会员",@(count)];
        [self.baseTableView setTableFooterView:self.tableFootView];
        [self.emptyView removeFromSuperview];
        
    }else
    {
//        _emptyViewYF.emptyLabel.text = @"无搜索结果";
//        [self.baseTableView addSubview:self.emptyView];
        self.tableFootView.hidden = YES;
        [self.baseTableView setTableFooterView:[[UIView alloc] init]];
    }
}

- (void)timeSort
{
    
}
- (void)letterSort
{
    
}





@end
