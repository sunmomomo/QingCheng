//
//  BrandDetailInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Brand.h"

@interface BrandDetailInfo : NSObject

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error,Brand *brand);

-(void)requestWithBrand:(Brand*)brand result:(void(^)(BOOL success,NSString *error,Brand *brand))result;

@end
