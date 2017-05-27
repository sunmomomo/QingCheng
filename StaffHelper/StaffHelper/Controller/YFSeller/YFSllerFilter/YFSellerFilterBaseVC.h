//
//  YFSellerFilterBaseVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/1/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "YFSliderViewController.h"

#import "YFStudentListRightVC.h"

#import "YFSellerFiterViewModel.h"

@interface YFSellerFilterBaseVC : MOViewController

@property(nonatomic, strong)YFSellerFiterViewModel *fiterViewModel;

@property(nonatomic,weak)YFSliderViewController *sliderVC;
@property(nonatomic,weak)YFStudentListRightVC *rightVC;
@property(nonatomic,copy)void(^sureBlock)();
@property(nonatomic,strong)YFFilterOtherModel *temFilterModel;

@property(nonatomic, strong)UITableView *baseTableView;
@property(nonatomic, strong)UIView *emptyView;

@property(nonatomic, copy)NSString *seller_id;

@property(nonatomic,copy)NSString *coach_id;

- (void)setTableFootviewLabelNum:(NSInteger )count;

- (void)timeSort;

- (void)letterSort;
@end
