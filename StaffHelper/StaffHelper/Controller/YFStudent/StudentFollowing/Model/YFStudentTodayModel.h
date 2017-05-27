//
//  YFStudentTodayModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFStudentTodayModel : YFBaseCModel

@property(nonatomic, copy)NSString *valueNewRegNum;
@property(nonatomic, copy)NSString *valueFlowwNum;
@property(nonatomic, copy)NSString *valueNewMeNum;


@property(nonatomic, copy)void(^buttonActionBlock)(NSUInteger);



@end
