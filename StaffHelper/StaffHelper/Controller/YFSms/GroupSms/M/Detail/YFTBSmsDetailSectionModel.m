//
//  YFTBSmsDetailSectionModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/17.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFTBSmsDetailSectionModel.h"

@implementation YFTBSmsDetailSectionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isShowDetail = NO;
    }
    return self;
}

- (NSUInteger)sectionCount
{
    if (self.isShowDetail == NO && self.dataArray.count)
    {
        return 1;
    }else
    {
        return self.dataArray.count;
    }
}

@end

