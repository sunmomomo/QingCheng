//
//  YFCardSuffientModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//


#import "YFCardSuffientModel.h"

#import "YYModel.h"

@interface YFCardSuffientModel ()<YYModel>

@end

@implementation YFCardSuffientModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"cardSet_Id":@"id"};
}

@end
