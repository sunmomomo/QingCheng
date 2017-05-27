//
//  GymURLInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/2/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "GymURLInfo.h"

#define API @"/api/v2/staffs/%ld/gym-extra/"

@implementation GymURLInfo

-(void)requestResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }

    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            [responseDic[@"data"][@"urls"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj[@"name"] isEqualToString:@"checkin"]) {
                    
                    AppGym.checkinScreenURL = [NSURL URLWithString:obj[@"url"]];
                    
                }
                
            }];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
        }
        
    }];
    
}

@end
