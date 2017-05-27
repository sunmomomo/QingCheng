//
//  MyPlanInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MyPlanInfo.h"

#define API @"/api/v2/coaches/%ld/plantpls/all/"

@implementation MyPlanInfo

-(instancetype)init
{
    
    if (self = [super init]) {
        
        self.gymPlans = [NSMutableArray array];
        
        self.studyPlans = [NSMutableArray array];
        
        self.customPlans = [NSMutableArray array];
        
        self.allPlans = [NSMutableArray array];
        
    }
    
    return self;
    
}

-(void)requestDataResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    if (!CoachId) {
        
        if (self.callBack) {
            
            self.callBack(NO,@"用户信息获取失败");
            
            self.callBack = nil;
            
        }
        
    }else
    {
        
        NSString *api = [NSString stringWithFormat:API,CoachId];
        
        Parameters *para = [[Parameters alloc]init];
        
        if (AppGym.type.length &&AppGym.gymId) {
            
            [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
            
            [para setParameter:AppGym.type forKey:@"model"];
            
        }else if(AppGym.shopId && AppGym.brand.brandId){
            
            [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
            
            [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,@"场馆信息获取失败");
                
                self.callBack = nil;
                
            }
            
            return;
            
        }
        
        [MOAFHelp AFGetHost:ROOT bindPath:api param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue] == 200) {
                
                [self createDataWithArray:responseDic[@"data"][@"plans"]];
                
                if (self.callBack) {
                    
                    self.callBack(YES,nil);
                    
                    self.callBack = nil;
                                        
                }
                
            }else
            {
                
                if (self.callBack) {
                    
                    self.callBack(NO,responseDic[@"msg"]);
                    
                    self.callBack = nil;
                    
                }
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            if (self.callBack) {
                
                self.callBack(NO,error);
                
                self.callBack = nil;
                
            }
            
        }];

        
    }
    
}

-(void)createDataWithArray:(NSArray *)array
{
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Plan *plan = [[Plan alloc]init];
        
        plan.tags = obj[@"tags"];
        
        plan.planId = [obj[@"id"] integerValue];
        
        plan.planName = obj[@"name"];
        
        plan.url = [NSURL URLWithString:obj[@"url"]];
        
        plan.type = [obj[@"type"] integerValue];
        
        if (obj[@"brand"]) {
            
            plan.brandName = obj[@"brand"][@"name"];
            
        }
        
        if (plan.type == PlanTypePersonal) {
            
            [self.customPlans addObject:plan];
            
        }else if(plan.type == PlanTypeGroup || plan.type == PlanTypeOrganization){
            
            [self.gymPlans addObject:plan];
            
        }
        
        [self.allPlans addObject:plan];
        
    }];
    
}

@end
