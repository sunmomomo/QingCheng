//
//  YFBaseConditionViewController.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

#import "GTWSelectOperationView.h"

#import "YFConditionPopView.h"



@interface YFBaseConditionViewController : YFBaseRefreshTBExtensionVC<GTWSelectOperationViewDelegate>

@property(nonatomic ,strong)NSArray *classsArray;


@property(nonatomic, strong)YFConditionPopView *showPopView;

@property(nonatomic, strong)NSMutableArray *popViewsArray;


@property (nonatomic,strong) GTWSelectOperationView *operationView;

@property (nonatomic, strong)NSArray *buttonTitleArray;

@property(nonatomic, strong)NSMutableDictionary *allParam;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic, assign)CGRect popViewFrame;

@end
