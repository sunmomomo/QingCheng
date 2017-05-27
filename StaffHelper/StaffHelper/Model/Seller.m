//
//  Seller.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "Seller.h"

@implementation Seller

- (NSString *)sellerStrId
{
    if (!_sellerStrId)
    {
        _sellerStrId = [NSString stringWithFormat:@"%@",@(_sellerId)];
    }
    return _sellerStrId;
}

@end
