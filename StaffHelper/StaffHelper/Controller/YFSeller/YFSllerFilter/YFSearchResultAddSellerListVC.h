//
//  YFSearchResultAddSellerListVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/1/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSearchResultSellerListBaseVC.h"

#import "CoachUserAddController.h"

@class SellerUserAddController;

@interface YFSearchResultAddSellerListVC : YFSearchResultSellerListBaseVC

@property(nonatomic, strong)NSMutableArray *(^chooseArray)();

@property(nonatomic, strong)SellerUserAddController *sellerAddVC;

@property(nonatomic,strong)CoachUserAddController *coachAddVC;

@property(nonatomic, assign)BOOL showAllSwitch;

@end
