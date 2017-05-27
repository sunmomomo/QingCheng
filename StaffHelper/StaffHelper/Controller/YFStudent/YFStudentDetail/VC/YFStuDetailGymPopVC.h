//
//  YFStuDetailGymPopVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/26.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

#import "YFStuDetailPopViewCModel.h"

@interface YFStuDetailGymPopVC : YFBaseRefreshTBExtensionVC

@property(nonatomic,strong)Gym *gym;

@property(nonatomic, strong)YFStuDetailPopViewCModel *selelcModel;

@property(nonatomic, copy)void(^selectBlock)();

- (void)resultGyms:(NSArray *)gymArray;

@end
