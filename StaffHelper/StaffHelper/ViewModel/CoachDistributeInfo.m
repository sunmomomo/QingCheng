//
//  CoachDistributeInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/25.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "CoachDistributeInfo.h"

#import "NSObject+YFExtension.h"

#define ListAPI @"/api/v2/staffs/%ld/coaches/preview/"

#define DeleteAPI @"/api/v2/staffs/%ld/coaches/users/"

#define BatchDeleteAPI @"/api/v2/staffs/%ld/coaches/users/remove/"

#define AddAPI @"/api/v2/staffs/%ld/coaches/users/"

#define ChangeAPI @"/api/v2/staffs/%ld/coaches/users/"

@implementation CoachDistributeInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.coaches = [NSMutableArray array];
        
    }
    return self;
}

-(void)requestWithGym:(Gym *)gym result:(RequestCallBack)result
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
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:ListAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        __block Coach *noneCoach ;
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            [responseDic[@"data"][@"coaches"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Coach *coach = [[Coach alloc]init];
                
                coach.userCount = [obj[@"count"] integerValue];
                
                coach.coachId = [obj[@"coach"][@"id"] integerValue];
                
                coach.name = obj[@"coach"][@"username"];
                
                coach.avatar = [obj[@"coach"][@"avatar"] guardStringYF];
                
                coach.sex = [obj[@"coach"][@"gender"] integerValue];
                
                if (!coach.coachId) {
                    
                    coach.type = CoachDistributeTypeNone;
                    noneCoach = coach;
                }else{
                    
                    coach.type = CoachDistributeTypeNormal;
                    [self.coaches addObject:coach];
                    
                }
                
                NSMutableArray *users = [NSMutableArray array];
                
                for (NSString *name in obj[@"users"]) {
                    
                    Student *user = [[Student alloc]init];
                    
                    user.name = name;
                    
                    [users addObject:user];
                    
                }
                
                coach.users = users;
                
                
            }];
            
            if (noneCoach) {
                [self.coaches insertObject:noneCoach atIndex:0];
            }
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
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

-(void)deleteUser:(Student *)user withCoach:(Coach *)coach withGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
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
    
    [para setInteger:user.stuId forKey:@"user_id"];
    
    [para setInteger:coach.coachId forKey:@"coach_id"];
    
    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:DeleteAPI,StaffId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
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

-(void)deleteUsers:(NSArray *)users withCoach:(Coach *)coach withGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
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
    
    [para setInteger:coach.coachId forKey:@"coach_id"];
    
    NSString *userIdStr = @"";
    
    for(NSInteger i = 0;i<users.count;i++){
        
        Student *user = users[i];
        
        userIdStr = [userIdStr stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)user.stuId]];
        
        if (i<users.count-1) {
            
            userIdStr = [userIdStr stringByAppendingString:@","];
            
        }
        
    }
    
    [para setParameter:userIdStr forKey:@"user_ids"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:BatchDeleteAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic)  {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
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

-(void)changeUsers:(NSArray *)users withOriginalCoach:(Coach *)originalCoach withCoaches:(NSArray *)coaches withGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
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
    
    NSString *userIdStr = @"";
    
    for(NSInteger i = 0;i<users.count;i++){
        
        Student *user = users[i];
        
        userIdStr = [userIdStr stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)user.stuId]];
        
        if (i<users.count-1) {
            
            userIdStr = [userIdStr stringByAppendingString:@","];
            
        }
        
    }
    
    [para setParameter:userIdStr forKey:@"user_ids"];
    
    NSString *coachIdStr = @"";
    
    for(NSInteger i = 0;i<coaches.count;i++){
        
        Coach *coach = coaches[i];
        
        coachIdStr = [coachIdStr stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)coach.coachId]];
        
        if (i<coaches.count-1) {
            
            coachIdStr = [coachIdStr stringByAppendingString:@","];
            
        }
        
    }
    
    [para setParameter:coachIdStr forKey:@"coach_ids"];
    
    if (originalCoach.coachId) {
        
        [para setInteger:originalCoach.coachId forKey:@"coach_id"];
        
    }
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ChangeAPI,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic)  {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
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

-(void)addUsers:(NSArray *)users withCoach:(Coach *)coach withGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
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
    
    NSString *userIdStr = @"";
    
    for(NSInteger i = 0;i<users.count;i++){
        
        Student *user = users[i];
        
        userIdStr = [userIdStr stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)user.stuId]];
        
        if (i<users.count-1) {
            
            userIdStr = [userIdStr stringByAppendingString:@","];
            
        }
        
    }
    
    [para setParameter:userIdStr forKey:@"user_ids"];
    
    [para setInteger:coach.coachId forKey:@"coach_id"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:AddAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic)  {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
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

@end
