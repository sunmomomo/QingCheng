//
//  GymPayHistoryInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/17.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "GymPayHistoryInfo.h"

#define API @"/api/v2/staffs/%ld/gyms/renews/"

@implementation GymPayHistoryInfo

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
    
    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"show_all"];

    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.histories = [NSMutableArray array];
            
            [responseDic[@"data"][@"renews"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                GymPayHistory *history = [[GymPayHistory alloc]init];
                
                NSString *time = [obj[@"created_at"] stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
                
                history.time = time.length>17?[time substringToIndex:17]:time;
                
                history.staff = [[Staff alloc]init];
                
                history.staff.name = obj[@"created_by"][@"username"];
                
                history.staff.staffId = [obj[@"created_by"][@"id"] integerValue];
                
                history.fromDate = obj[@"start"];
                
                history.toDate = obj[@"end"];
                
                history.month = [obj[@"times"] integerValue];
                
                history.price = [obj[@"order"][@"price"] integerValue];
                
                history.success = YES;
                
                history.onlinePay = [obj[@"order"][@"channel"] integerValue]>10;
                
                history.isTried = [obj[@"is_trial"] boolValue];
                
                if ([obj[@"remark"] length]) {
                    
                    history.remarks = obj[@"remark"];
                    
                }else{
                    
                    history.remarks = history.isTried?@"试用15天":[NSString stringWithFormat:@"%@%ld个月",history.onlinePay?@"在线支付":@"线下支付",(long)history.month];
                    
                }
                
                [self.histories addObject:history];
                
            }];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
            }
            
        } else {
            
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
