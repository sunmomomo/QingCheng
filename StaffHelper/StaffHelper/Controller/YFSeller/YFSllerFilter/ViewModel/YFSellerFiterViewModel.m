//
//  YFSellerFiterViewModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/1/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSellerFiterViewModel.h"
#import "YFAppConfig.h"
#import "UIView+masonryExtesionYF.h"
#import "YFStudentListRightVC.h"
#import "YFSliderViewController.h"
#import "YFSellerFilterBaseVC.h"

#import "NSObject+firterModel.h"


@interface YFSellerFiterViewModel ()




@end

@implementation YFSellerFiterViewModel

- (UIView *)conditionButtonViews
{
    if (_conditionButtonViews == nil)
    {
        _conditionButtonViews = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, XFrom5YF(41))];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _conditionButtonViews.frame.size.width, 0.5)];
        lineView.backgroundColor = YFLineViewColor;
        [_conditionButtonViews addSubview:lineView];
        
        lineView = [[UIView alloc] init];
        lineView.backgroundColor = YFLineViewColor;
        [_conditionButtonViews addSubview:lineView];
        [lineView setBottomLine];
        _conditionButtonViews.backgroundColor = YFMainBackColor;
        
        CGFloat buttonWidth = MSW / 3.0;
        
        CGFloat labelWidth = XFrom5YF(53.0);
        CGFloat labelHeight = _conditionButtonViews.height;
        
        CGFloat imageWidth = XFrom5YF(10.0);
        CGFloat imageHeight = XFrom5YF(9.0);
        
        CGFloat labelx = (buttonWidth - labelWidth - imageWidth)/ 2.0;
        CGFloat labely = 0;
        
        CGFloat imagex = (buttonWidth - labelWidth - imageWidth)/ 2.0 + labelWidth;
        CGFloat imagey = (_conditionButtonViews.height - imageHeight)/ 2.0;
        
        NSArray *titleArray = @[@"字母排序",@"最新注册",@"筛选"];
        
        for (NSInteger i = 0; i < 3; i ++)
        {
            
            if (i == 2)
            {
                labelWidth = XFrom5YF(32.0);
                labelHeight = _conditionButtonViews.height;
                
                imageWidth = XFrom5YF(11.0);
                imageHeight = XFrom5YF(10.0);
                
                labelx = (buttonWidth - labelWidth - imageWidth)/ 2.0;
                labely = 0;
                
                imagex = (buttonWidth - labelWidth - imageWidth)/ 2.0 + labelWidth;
                imagey = (_conditionButtonViews.height - imageHeight)/ 2.0;
            }
            
            YFButton *button = [[YFButton alloc] initWithFrame:CGRectMake(buttonWidth * i, 0, buttonWidth, _conditionButtonViews.height) imageFrame:CGRectMake(imagex, imagey, imageWidth, imageHeight) titleFrame:CGRectMake(labelx, labely, labelWidth, labelHeight)];
            
            [button setTitle:titleArray[i] forState:UIControlStateNormal];
            
            [button setTitleColor:RGB_YF(51, 51, 51) forState:UIControlStateNormal];
            [button setTitleColor:RGB_YF(24, 181, 83) forState:UIControlStateSelected];
            
            [button.titleLabel setFont:[UIFont systemFontOfSize:XFrom5YF(12.0)]];
            
            if (i < 2)
            {
                [button setImage:[UIImage imageNamed:@"Shape"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"ShapeGreen"] forState:UIControlStateSelected];
            }
            else
            {
                [button setImage:[UIImage imageNamed:@"TriangleFilter"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"TriangleFilterGreen"] forState:UIControlStateSelected];
            }
            
            if (i == 0)
            {
                self.buttonOfLetterFilter = button;
                [button addTarget:self action:@selector(letterFilterAction:) forControlEvents:UIControlEventTouchUpInside];
            }else if (i == 1)
            {
                self.buttonOfNewRegisterFilter = button;
                [button addTarget:self action:@selector(NewRegisterAction:) forControlEvents:UIControlEventTouchUpInside];
                self.buttonOfNewRegisterFilter.selected = YES;
            }else if (i == 2)
            {
                self.buttonOfOtherFilter = button;
                [button addTarget:self action:@selector(OtherFilterAction:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            
            [_conditionButtonViews addSubview:button];
        }
        
        CGFloat lineWidht = 0.5;
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(buttonWidth - lineWidht, XFrom5YF(12), 0.5, XFrom5YF(16.0))];
        lineView1.backgroundColor = YFLineViewColor;
        [_conditionButtonViews addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(buttonWidth * 2 - lineWidht, XFrom5YF(12), 0.5, XFrom5YF(16.0))];
        lineView2.backgroundColor = YFLineViewColor;
        [_conditionButtonViews addSubview:lineView2];
        
        CGRect firstFrame = self.buttonOfLetterFilter.frame;
        self.buttonOfLetterFilter.frame = self.buttonOfNewRegisterFilter.frame;
        self.buttonOfNewRegisterFilter.frame = firstFrame;
        
    }
    return _conditionButtonViews;
}



// fileter 本地排序
- (void)letterFilterAction:(UIButton *)button
{
    self.buttonOfLetterFilter.selected = YES;
    self.buttonOfNewRegisterFilter.selected = NO;
    
    self.baseTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    //    self.baseDataArray = self.dataModel.showLetterFilterdataArray;
    //    [self.baseTableView reloadData];
    
    if (self.buttonActionLetter) {
        self.buttonActionLetter();
    }
    
    
}
- (void)NewRegisterAction:(UIButton *)button
{
    //    [self.dataModel setTimeArraySorted];
    //    self.baseDataArray = self.dataModel.showSortTimeArray;
    
    self.buttonOfLetterFilter.selected = NO;
    self.buttonOfNewRegisterFilter.selected = YES;
    
    
    //    [self.baseTableView reloadData];
    if (self.buttonActionTime) {
        self.buttonActionTime();
    }
    
    
}

- (void)OtherFilterAction:(UIButton *)button
{
    
    self.rightVC.filterModel = [self.fiterOtherModel modelCopy];
    
    
    DebugLogYF(@"%@",self.fiterOtherModel.status);
    self.rightVC.allRecoDic = self.fiterOtherModel.allRecoDic;
    self.rightVC.allOrigDic = self.fiterOtherModel.allOrigDic;
    
    [self.sliderVC showRightViewController];
}

- (YFFilterOtherModel *)fiterOtherModel
{
    if (!_fiterOtherModel)
    {
        _fiterOtherModel = [[YFFilterOtherModel alloc] init];
    }
    return _fiterOtherModel;
}

+ (UIViewController *)setFilterRightVcToVC:(YFSellerFilterBaseVC *)filterVC gym:(Gym *)gym fiterViewModel:(YFSellerFiterViewModel *)fiterViewModel
{
    YFSliderViewController *sliderVC = [[YFSliderViewController alloc] init];
    
    
    sliderVC.isBulr = NO;
    sliderVC.canSpanShowingRight = NO;
    YFStudentListRightVC *rightVC = [[YFStudentListRightVC alloc] init];
    rightVC.seller_id = filterVC.seller_id;
    rightVC.isFilter = YES;
    rightVC.gym = gym;
    
    __weak typeof(rightVC)rightWeak = rightVC;
    [sliderVC setShowMiddleVc:^{
        [rightWeak.view endEditing:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
    
    [sliderVC setFinishShowRight:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }];
    
    
    if (fiterViewModel)
    {
        filterVC.fiterViewModel.fiterOtherModel = [fiterViewModel.fiterOtherModel modelCopy];
        filterVC.fiterViewModel.fiterOtherModel.allOrigDic = fiterViewModel.fiterOtherModel.allOrigDic.mutableCopy;
        filterVC.fiterViewModel.fiterOtherModel.allRecoDic = fiterViewModel.fiterOtherModel.allRecoDic.mutableCopy;
        if (fiterViewModel.buttonOfOtherFilter)
        {
            [filterVC.fiterViewModel conditionButtonViews];
            filterVC.fiterViewModel.buttonOfOtherFilter.selected = fiterViewModel.buttonOfOtherFilter.selected;
            filterVC.fiterViewModel.buttonOfLetterFilter.selected = fiterViewModel.buttonOfLetterFilter.selected;
            filterVC.fiterViewModel.buttonOfNewRegisterFilter.selected = fiterViewModel.buttonOfNewRegisterFilter.selected;
        }
        rightVC.isCanFilterBirthday = fiterViewModel.fiterOtherModelCaYF.isCanFilterBirthday;
        rightVC.isCanFilterSeller = fiterViewModel.fiterOtherModelCaYF.isCanFilterSeller;
    }
    
    filterVC.rightVC  = rightVC;
    filterVC.sliderVC = sliderVC;
    sliderVC.mainVC = filterVC;
    sliderVC.rightVC = rightVC;
    
    
    rightVC.sureBlock = filterVC.sureBlock;
    sliderVC.rightViewShowScale = StudentRightShowScale;
    
    return sliderVC;
}

+ (UIViewController *)addFilterVCToVC:(UIViewController *)mainVC gym:(Gym *)gym sureBlock:(void(^)(id))sureBlock
{
    YFStudentListRightVC *rightVC = [[YFStudentListRightVC alloc] init];
    rightVC.isFilter = YES;
    rightVC.gym = gym;
    rightVC.isCanFilterSeller = mainVC.fiterOtherModelCaYF.isCanFilterSeller;
    rightVC.isShouldChooseTodayWhenClear = mainVC.fiterOtherModelCaYF.isShouldChooseTodayWhenClear;
    
    YFSliderViewController *sliderVC = [self sliderVCWithMainVC:mainVC rightVC:rightVC];

//    [mainVC fiterOtherModelCaYF];
    
    __weak typeof(rightVC)weakRightVC = rightVC;
    
    __weak typeof(mainVC)weakMainVCVC = mainVC;

    __weak typeof(sliderVC)weakSliderVCVC = sliderVC;

    // 显示 右面的筛选View
    [mainVC setShowRightBlockCaYF:^(id model) {
      
        BOOL isCopyParam = weakMainVCVC.fiterOtherModelCaYF.isCopyParam;
        
        weakRightVC.filterModel = [weakMainVCVC.fiterOtherModelCaYF modelCopy];
        weakRightVC.allRecoDic = weakMainVCVC.fiterOtherModelCaYF.allRecoDic;
        if (isCopyParam == NO)
        {
        weakRightVC.allOrigDic = weakMainVCVC.fiterOtherModelCaYF.allOrigDic;
        }
        
        [weakSliderVCVC showRightViewController];
    }];
    


    
    [rightVC setSureBlock:^{
        
        weakMainVCVC.fiterOtherModelCaYF = [weakRightVC.filterModel modelCopy];
        
        weakMainVCVC.fiterOtherModelCaYF.allOrigDic = [NSMutableDictionary dictionaryWithDictionary:[weakRightVC.filterModel allOrigDic]];
        weakMainVCVC.fiterOtherModelCaYF.allRecoDic = [NSMutableDictionary dictionaryWithDictionary:[weakRightVC.filterModel allRecoDic]];
        
        [weakSliderVCVC closeSideBar];
        if (sureBlock)
        {
            sureBlock(nil);
        }
    }];
    return sliderVC;
}

+ (YFSliderViewController *)sliderVCWithMainVC:(UIViewController *)mainVC rightVC:(UIViewController *)rightVC
{
    
    YFSliderViewController *sliderVC = [[YFSliderViewController alloc] init];
    sliderVC.isBulr = NO;
    sliderVC.canSpanShowingRight = NO;
    
    __weak typeof(rightVC)rightWeak = rightVC;
    [sliderVC setShowMiddleVc:^{
        [rightWeak.view endEditing:YES];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
    
    [sliderVC setFinishShowRight:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }];
    
    sliderVC.mainVC = mainVC;
    sliderVC.rightVC = rightVC;

    sliderVC.rightViewShowScale = StudentRightShowScale;

    
    return sliderVC;
}





@end
