//
//  CoursePlanInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanInfo.h"

#define PrivateAPI @"/api/staffs/%ld/coaches/%ld/batches/"

#define GroupAPI @"/api/staffs/%ld/courses/%ld/batches/"

@implementation CoursePlanInfo

-(void)requestPrivateData
{
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (self.gym.gymId && self.gym.type.length){
        
        [para setParameter:self.gym.type forKey:@"model"];
        
        [para setInteger:self.gym.gymId forKey:@"id"];
        
    }else if(self.gym.shopId && self.gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:self.gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:self.gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [para setParameter:@"1" forKey:@"is_private"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PrivateAPI,StaffId,(long)self.coach.coachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.coach.courseCount = [responseDic[@"data"][@"coach"][@"courses_count"] integerValue];
            
            self.coach.serviceCount = [responseDic[@"data"][@"coach"][@"users_count"] integerValue];
            
            NSMutableArray *batches = [NSMutableArray array];
            
            NSArray *array = responseDic[@"data"][@"batches"];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                CoursePlanBatch *batch = [[CoursePlanBatch alloc]init];
                
                batch.start = obj[@"from_date"];
                
                batch.end = obj[@"to_date"];
                
                batch.batchId = [obj[@"id"] integerValue];
                
                batch.course.name = obj[@"course"][@"name"];
                
                batch.course.imgUrl = [NSURL URLWithString:obj[@"course"][@"photo"]];
                
                batch.course.courseId = [obj[@"course"][@"id"] integerValue];
                
                [batches addObject:batch];
                
            }];
            
            self.batches = [batches copy];
            
            if (self.requestFinish) {
                self.requestFinish(YES);
            }
            
        }else
        {
            
            if (self.requestFinish) {
                self.requestFinish(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.requestFinish) {
            self.requestFinish(NO);
        }
        
    }];
    
}

-(void)requestGroupData
{
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (self.gym.gymId && self.gym.type.length){
        
        [para setParameter:self.gym.type forKey:@"model"];
        
        [para setInteger:self.gym.gymId forKey:@"id"];
        
    }else if(self.gym.shopId && self.gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:self.gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:self.gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:GroupAPI,StaffId,(long)self.course.courseId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.course.during = [responseDic[@"data"][@"course"][@"length"] integerValue]/60;
            
            NSMutableArray *batches = [NSMutableArray array];
            
            NSArray *array = responseDic[@"data"][@"batches"];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                CoursePlanBatch *batch = [[CoursePlanBatch alloc]init];
                
                batch.start = obj[@"from_date"];
                
                batch.end = obj[@"to_date"];
                
                batch.batchId = [obj[@"id"] integerValue];
                
                batch.coach.name = obj[@"teacher"][@"username"];
                
                batch.coach.iconUrl = [NSURL URLWithString:obj[@"teacher"][@"avatar"]];
                
                batch.coach.coachId = [obj[@"teacher"][@"id"] integerValue];
                
                [batches addObject:batch];
                
            }];
            
            self.batches = [batches copy];
            
            if (self.requestFinish) {
                self.requestFinish(YES);
            }
            
        }else
        {
            
            if (self.requestFinish) {
                self.requestFinish(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.requestFinish) {
            self.requestFinish(NO);
        }
        
    }];
    
}

@end
