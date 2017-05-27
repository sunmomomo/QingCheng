//
//  GymDetailInfo.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/30.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "GymDetailInfo.h"

#import "UIColor+Hex.h"

#define API @"/api/v1/coaches/%ld/gyms/welcome/"

#define ChangeAPI @"/api/v2/coaches/%ld/gyms/update/"

#define QuitAPI @"/api/v2/coaches/%ld/dimission/"

@implementation GymDetailInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.groupCourses = [NSMutableArray array];
        
        self.privateCourses = [NSMutableArray array];
        
    }
    return self;
}

-(void)requestWithGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setInteger:AppGym.gymId forKey:@"id"];
    
    [para setParameter:AppGym.type forKey:@"model"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            [self createDataWithDict:responseDic[@"data"][@"gym"]];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
            }
            
        }else
        {
            
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

-(void)createDataWithDict:(NSDictionary *)dict
{
    
    NSString *colorStr = dict[@"color"];
    
    if (colorStr.length) {
        
        AppGym.color = [UIColor colorWithHexString:colorStr];
        
    }
    
    AppGym.name = dict[@"name"];
    
    AppGym.type = dict[@"model"];
    
    AppGym.gymId = [dict[@"id"] integerValue];
    
    AppGym.imgUrl = [NSURL URLWithString:dict[@"photo"]];
    
    AppGym.type = dict[@"model"];
    
    AppGym.address = dict[@"address"];
    
    AppGym.systemEnd = dict[@"system_end"];
    
    AppGym.userCount = [dict[@"users_count"] integerValue];
    
    AppGym.courseCount = [dict[@"courses_count"] integerValue];
    
    AppGym.brand.name = dict[@"brand_name"];
    
}

-(void)editGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:gym.type forKey:@"model"];
    
    [para setInteger:gym.gymId forKey:@"id"];
    
    [para setParameter:gym.imgUrl.absoluteString forKey:@"photo"];
    
    [para setParameter:gym.districtCode forKey:@"gd_district_id"];
    
    [para setParameter:gym.name forKey:@"name"];
    
    [para setParameter:gym.address forKey:@"address"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ChangeAPI,CoachId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)quitGymResult:(void (^)(BOOL, NSString *))result
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
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:QuitAPI,CoachId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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
