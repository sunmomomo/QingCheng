//
//  YFSearchResultSellerListBatchVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/1/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSearchResultSellerListBaseVC.h"

#import "CoachUserBatchEditController.h"

@class SellerUserBatchEditController;
@interface YFSearchResultSellerListBatchVC : YFSearchResultSellerListBaseVC

@property(nonatomic, strong)NSMutableArray *(^chooseArray)();

@property(nonatomic, strong)SellerUserBatchEditController *sellerBatchEditVC;

@property(nonatomic,strong)CoachUserBatchEditController *coachBatchEditVC;

// 选择会员，暂时在群发短信 时用，搜索全部会员
@property(nonatomic, assign)BOOL isChooseStudent;

@end
