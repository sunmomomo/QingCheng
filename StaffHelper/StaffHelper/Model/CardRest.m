//
//  CardRest.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardRest.h"

#define API @"/api/staffs/%ld/leaves/%ld/"

#import "YFAppConfig.h"

@implementation CardRest

-(void)deleteRestResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    Gym *appGym = ((AppDelegate *)[UIApplication sharedApplication].delegate).gym;
    
    if (appGym &&appGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:appGym.gymId] forKey:@"id"];
        
        [para setParameter:appGym.type forKey:@"model"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId,(long)self.restId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
    }];
    
}

- (CGFloat)remarkHeight
{
    if (_remarkHeight == 0)
    {
        
        NSString *str = [NSString stringWithFormat:@"备注：%@",_remark.length?_remark:@""];

        CGSize size = YF_MULTILINE_TEXTSIZE(str, AllFont(13), CGSizeMake(MSW-Width320(24), 10000000), 0);
        
        _remarkHeight = size.height;
    }
    return _remarkHeight;
}

@end
