//
//  YardListInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YardListInfo.h"

#define API @"/api/staffs/%ld/spaces/"

#define ChangeAPI @"/api/staffs/%ld/spaces/%ld/"

#define PermissionAPI @"/api/staffs/%ld/method/spaces/"

@implementation YardListInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.allYards = [NSArray array];
        
        self.privateYards = [NSArray array];
        
        self.groupYards = [NSArray array];
        
    }
    return self;
}

-(void)requestWithGym:(Gym *)gym
{
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (gym.gymId && gym.type.length){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSArray *array = responseDic[@"data"][@"spaces"];
            
            NSMutableArray *yards = [NSMutableArray array];
            
            NSMutableArray *groups = [NSMutableArray array];
            
            NSMutableArray *privates = [NSMutableArray array];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Yard *yard = [[Yard alloc]init];
                
                yard.name = obj[@"name"];
                
                yard.yardId = [obj[@"id"] integerValue];
                
                yard.capacity = [obj[@"capacity"] integerValue];
                
                BOOL supportPrivate = [obj[@"is_support_private"] boolValue];
                
                BOOL supportGroup = [obj[@"is_support_team"]boolValue];

                yard.type = supportPrivate && supportGroup?YardTypeUnlimited: supportPrivate && !supportGroup?YardTypePrivate:YardTypeGroup;
                
                if (supportGroup) {
                    
                    [groups addObject:yard];
                    
                }
                
                if (supportPrivate) {
                    
                    [privates addObject:yard];
                    
                }
                
                [yards addObject:yard];
                
            }];
            
            self.allYards = [yards copy];
            
            self.groupYards = [groups copy];
            
            self.privateYards = [privates copy];
            
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

-(void)addYard:(Yard *)yard result:(void (^)(BOOL,NSString*))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:yard.name forKey:@"name"];
    
    [para setParameter:[NSNumber numberWithInteger:yard.capacity] forKey:@"capacity"];
    
    if (yard.type == YardTypeGroup) {
        
        [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_support_team"];
        
        [para setParameter:[NSNumber numberWithBool:NO] forKey:@"is_support_private"];
        
    }else if (yard.type == YardTypePrivate){
        
        [para setParameter:[NSNumber numberWithBool:NO] forKey:@"is_support_team"];
        
        [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_support_private"];
        
    }else
    {
        
        [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_support_team"];
        
        [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_support_private"];
        
    }
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (yard.gym.gymId && yard.gym.type.length){
        
        [para setParameter:yard.gym.type forKey:@"model"];
        
        [para setInteger:yard.gym.gymId forKey:@"id"];
        
    }else if(yard.gym.shopId && yard.gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:yard.gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:yard.gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

-(void)deleteYard:(Yard *)yard result:(void (^)(BOOL,NSString*))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (yard.gym.gymId && yard.gym.type.length){
        
        [para setParameter:yard.gym.type forKey:@"model"];
        
        [para setInteger:yard.gym.gymId forKey:@"id"];
        
    }else if(yard.gym.shopId && yard.gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:yard.gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:yard.gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:ChangeAPI,StaffId,(long)yard.yardId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

-(void)changeYard:(Yard *)yard result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:yard.name forKey:@"name"];
    
    [para setParameter:[NSNumber numberWithInteger:yard.capacity] forKey:@"capacity"];
    
    if (yard.type == YardTypeGroup) {
        
        [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_support_team"];
        
        [para setParameter:[NSNumber numberWithBool:NO] forKey:@"is_support_private"];
        
    }else if (yard.type == YardTypePrivate){
        
        [para setParameter:[NSNumber numberWithBool:NO] forKey:@"is_support_team"];
        
        [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_support_private"];
        
    }else
    {
        
        [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_support_team"];
        
        [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_support_private"];
        
    }
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (yard.gym.gymId && yard.gym.type.length){
        
        [para setParameter:yard.gym.type forKey:@"model"];
        
        [para setInteger:yard.gym.gymId forKey:@"id"];
        
    }else if(yard.gym.shopId && yard.gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:yard.gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:yard.gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ChangeAPI,StaffId,(long)yard.yardId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

-(void)requestDataWithCourseType:(CourseType)type andIsAdd:(BOOL)isAdd andGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (gym.gymId && gym.type.length){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [para setParameter:isAdd?@"post":@"put" forKey:@"method"];
    
    if (type == CourseTypeGroup) {
        
        [para setParameter:@"teamarrange_calendar" forKey:@"key"];
        
    }else{
        
        [para setParameter:@"priarrange_calendar" forKey:@"key"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PermissionAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSArray *array = responseDic[@"data"][@"spaces"];
            
            NSMutableArray *yards = [NSMutableArray array];
            
            NSMutableArray *groups = [NSMutableArray array];
            
            NSMutableArray *privates = [NSMutableArray array];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Yard *yard = [[Yard alloc]init];
                
                yard.name = obj[@"name"];
                
                yard.yardId = [obj[@"id"] integerValue];
                
                yard.capacity = [obj[@"capacity"] integerValue];
                
                BOOL supportPrivate = [obj[@"is_support_private"] boolValue];
                
                BOOL supportGroup = [obj[@"is_support_team"]boolValue];
                
                yard.type = supportPrivate && supportGroup?YardTypeUnlimited: supportPrivate && !supportGroup?YardTypePrivate:YardTypeGroup;
                
                if (supportGroup) {
                    
                    [groups addObject:yard];
                    
                }
                
                if (supportPrivate) {
                    
                    [privates addObject:yard];
                    
                }
                
                [yards addObject:yard];
                
            }];
            
            self.allYards = [yards copy];
            
            self.groupYards = [groups copy];
            
            self.privateYards = [privates copy];
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

@end
