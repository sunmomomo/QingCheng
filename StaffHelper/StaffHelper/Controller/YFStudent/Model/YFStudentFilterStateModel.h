//
//  YFStudentFilterStateModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

#import "YFStudentFilterStateCell.h"

@interface YFStudentFilterStateModel : YFBaseCModel

@property(nonatomic, assign)BOOL isNewReg;
@property(nonatomic, assign)BOOL isFollowing;
@property(nonatomic, assign)BOOL isMember;

- (NSString *)statusString;

@end
