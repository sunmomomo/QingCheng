//
//  YFSearchStuListDataModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFDataBaseModel.h"

@interface YFSearchStuListDataModel : YFDataBaseModel

@property(nonatomic, copy)NSString *searchStr;

@property(nonatomic, copy)NSString *allMemNum;

@property(nonatomic, strong)NSMutableArray *allSearchDataArray;

-(void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym  successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;


@end
