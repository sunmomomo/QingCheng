//
//  YFChooseRecoVC.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

#import "YFStudentFilterRePeoModel.h"

@interface YFChooseRecoVC : YFBaseRefreshTBExtensionVC

@property(nonatomic,strong)YFStudentFilterRePeoModel *selectModel;

// 传进来 选择的id
@property(nonatomic, copy)NSString *recoId;

@property(nonatomic, copy)void(^selectBlock)();

@property(nonatomic,strong)Gym *gym;

@end
