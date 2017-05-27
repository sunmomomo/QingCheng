//
//  YFSellerFiterViewModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/1/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//
#import "YFDataBaseModel.h"
#import "YFButton.h"

@class YFSellerFilterBaseVC;
@class YFStudentListRightVC;
@class YFSliderViewController;
@class YFFilterOtherModel;
@interface YFSellerFiterViewModel : YFDataBaseModel




@property(nonatomic, strong)YFButton *buttonOfLetterFilter;
@property(nonatomic, strong)YFButton *buttonOfNewRegisterFilter;
@property(nonatomic, strong)YFButton *buttonOfOtherFilter;

@property(nonatomic, copy)void(^buttonActionTime)();
@property(nonatomic, copy)void(^buttonActionLetter)();

@property(nonatomic, strong)UIView *conditionButtonViews;

@property(nonatomic, weak)UITableView *baseTableView;

@property(nonatomic, copy)NSMutableArray *(^baseDataArray)();

@property(nonatomic,weak)YFStudentListRightVC *rightVC;
@property(nonatomic,weak)YFSliderViewController *sliderVC;

@property(nonatomic, strong)YFFilterOtherModel *fiterOtherModel;


+ (UIViewController *)setFilterRightVcToVC:(YFSellerFilterBaseVC *)filterVC gym:(Gym *)gym fiterViewModel:(YFSellerFiterViewModel *)fiterViewModel;

+ (UIViewController *)addFilterVCToVC:(UIViewController *)mainVC gym:(Gym *)gym sureBlock:(void(^)(id))sureBlock;

@end
