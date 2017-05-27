//
//  YFSmsDetaiDataModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/16.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudentBaseViewModel.h"

#import "YFSmsListCModel.h"

@interface YFSmsDetaiDataModel : YFStudentBaseViewModel

@property(nonatomic, strong)YFSmsListCModel *detailModel;

@property(nonatomic, assign)YFSmsType smsType;


- (void)deleteDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

@end
