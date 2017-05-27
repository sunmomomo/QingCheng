//
//  YFSmsListViewModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/16.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudentBaseViewModel.h"

@interface YFSmsListViewModel : YFStudentBaseViewModel

@property(nonatomic, copy)NSString *status;

@property(nonatomic, assign)NSUInteger page;

@property(nonatomic, copy)NSString *searhStr;

@property(nonatomic, strong)YFRespoDataArrayModel *arrayModel;

@end
