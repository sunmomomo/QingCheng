//
//  GymProInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/2/8.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "GymProInfo.h"

#define API @"/api/v2/staffs/%ld/gyms/pay/"

#define ProAPI @"/api/gyms/orders/"

#define TryAPI @"/api/v2/staffs/%ld/gyms/trial/"

@implementation GymProInfo

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
            
            NSDictionary *dict = responseDic[@"data"];
            
            AppGym.havePrivilege = [dict[@"is_regular"]boolValue];
            
            self.pays = [NSMutableArray array];
            
            [dict[@"normal"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                GymPay *pay = [[GymPay alloc]init];
                
                pay.month = [obj[@"times"]integerValue];
                
                if (AppGym.havePrivilege) {
                    
                    pay.price = [obj[@"favorable_price"] integerValue];
                    
                    pay.discardedPrice = [obj[@"price"] integerValue];
                    
                    pay.canUsed = YES;
                    
                    pay.privilege = YES;
                    
                }else{
                    
                    pay.price = [obj[@"price"] integerValue];
                    
                    pay.discardedPrice = [obj[@"favorable_price"] integerValue];
                    
                    pay.canUsed = YES;
                    
                    pay.privilege = NO;
                    
                }
                
                if (pay.month == 12) {
                    
                    pay.choosed = YES;
                    
                }
                
                [self.pays addObject:pay];
                
            }];
            
            [dict[@"normal"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                GymPay *pay = [[GymPay alloc]init];
                
                pay.month = [obj[@"times"]integerValue];
                
                if (AppGym.havePrivilege) {
                    
                    pay.price = [obj[@"price"] integerValue];
                    
                    pay.discardedPrice = [obj[@"favorable_price"] integerValue];
                    
                    pay.canUsed = YES;
                    
                    pay.privilege = NO;
                    
                }else{
                    
                    pay.price = [obj[@"favorable_price"] integerValue];
                    
                    pay.discardedPrice = [obj[@"price"] integerValue];
                    
                    pay.canUsed = NO;
                    
                    pay.privilege = NO;
                    
                }
                
                [self.pays addObject:pay];
                
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

-(void)proGymWithGymPay:(GymPay *)pay result:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:@"12" forKey:@"channel"];
    
    [para setParameter:WXKEY forKey:@"app_id"];
    
    [para setParameter:[NSNumber numberWithInteger:pay.month] forKey:@"times"];
    
    [para setParameter:[NSNumber numberWithBool:pay.privilege] forKey:@"favorable"];

    [MOAFHelp AFPostHost:ROOT bindPath:ProAPI postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            self.payURL = [NSURL URLWithString:responseDic[@"data"][@"url"]];
            
            self.systemEnd = responseDic[@"data"][@"system_end"];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,nil);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,nil);
            
        }
        
    }];
    
}

-(void)tryGymResult:(void (^)(BOOL, NSString *))result
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

    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:TryAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
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
