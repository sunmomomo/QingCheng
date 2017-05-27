//
//  YFRequestHeader.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>


// 删除 品牌
extern NSString * const kDeleteBrandYF;
// 删除 场馆
extern NSString * const kDeleteGymYF;

// 销售
extern NSString * const kVTwoSellersUsersRequestYF;
extern NSString * const kVTwoSellersUsersAllRequestYF;
extern NSString * const kStaffsUsersRequestYF;
// 销售列表 (包括教练)
extern NSString * const kSellersListRequestYF;
// 销售列表 (不包括教练)
extern NSString * const kSellersWithoutCoachListRequestYF;



// 会员出勤
extern NSString * const kStaffsUsersAttendanceGlanceRequestYF;
extern NSString * const kStaffsUsersAbsenceRequestYF;
extern NSString * const kStaffsUsersAttendanceRequestYF;




@interface YFRequestHeader : NSObject

@end
