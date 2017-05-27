//
//  YFRequestHeader.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFRequestHeader.h"

NSString * const kDeleteBrandYF = @"/api/brands/%ld";

NSString * const kDeleteGymYF = @"/api/gym/%ld";


NSString * const kVTwoSellersUsersRequestYF = @"/api/v2/staffs/%ld/sellers/users/";

NSString * const kVTwoSellersUsersAllRequestYF = @"/api/v2/staffs/%ld/sellers/users/all/";

NSString * const kStaffsUsersRequestYF = @"/api/staffs/%ld/users/";



NSString * const kStaffsUsersAttendanceGlanceRequestYF = @"/api/staffs/%ld/users/attendance/glance/";

NSString * const kStaffsUsersAbsenceRequestYF = @"/api/staffs/%ld/users/absence/";

NSString * const kStaffsUsersAttendanceRequestYF = @"/api/staffs/%ld/users/attendance/";

NSString * const kSellersListRequestYF = @"/api/staffs/%ld/sellers/";

NSString * const kSellersWithoutCoachListRequestYF = @"/api/staffs/%ld/sellers-without-coach/";




extern NSString * const kStaffsUsersAttendanceGlanceRequestYF;
extern NSString * const kStaffsUsersAbsenceRequestYF;
extern NSString * const kStaffsUsersAttendanceRequestYF;


@implementation YFRequestHeader

@end



