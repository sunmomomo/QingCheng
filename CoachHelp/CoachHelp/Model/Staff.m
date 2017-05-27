//
//  Staff.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "Staff.h"

#import "DistrictInfo.h"

@implementation Staff

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.city = [DistrictInfo sharedDistrictInfo].defaultDistrictName;
        
        self.districtCode = [DistrictInfo sharedDistrictInfo].defaultDistrictCode;
        
        self.position = [[Position alloc]init];
        
    }
    return self;
}

@end
