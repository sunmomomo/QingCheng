//
//  CourseListInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseListInfo.h"

#define API @"/api/v2/coaches/%ld/courses/"

#define ChangeAPI @"/api/v2/coaches/%ld/courses/%ld/"

#define GymAPI @"/api/v2/coaches/%ld/courses/%ld/shops/"

#define PermissionAPI @"/api/v2/coaches/%ld/method/courses/"

@implementation CourseListInfo

-(void)requestAllDataWithGym:(Gym *)gym
{
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"show_all"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSArray *array = responseDic[@"data"][@"courses"];
            
            NSMutableArray *courses = [NSMutableArray array];
            
            NSMutableArray *groups = [NSMutableArray array];
            
            NSMutableArray *privates = [NSMutableArray array];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Course *course = [[Course alloc]init];
                
                course.name = obj[@"name"];
                
                course.during = [obj[@"length"] integerValue]/60;
                
                if ([obj[@"photo"] rangeOfString:@"!/watermark/"].length) {
                    
                    course.imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@!120x120/watermark/%@",[[obj[@"photo"] componentsSeparatedByString:@"!/watermark/"]firstObject],[[obj[@"photo"] componentsSeparatedByString:@"!/watermark/"]lastObject]]];
                    
                }else if ([obj[@"photo"] rangeOfString:@"/watermark/"].length){
                    
                    course.imgUrl = [NSURL URLWithString:obj[@"photo"]];
                    
                }else{
                    
                    course.imgUrl = [NSURL URLWithString:[obj[@"photo"] stringByAppendingString:@"!120x120"]];
                    
                }
                
                course.courseId = [obj[@"id"] integerValue];
                
                course.type = [obj[@"is_private"] boolValue]?CourseTypePrivate:CourseTypeGroup;
                
                NSMutableArray *gyms = [NSMutableArray array];
                
                [obj[@"shops"] enumerateObjectsUsingBlock:^(id  _Nonnull gymObj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    Gym *gym = [[Gym alloc]init];
                    
                    gym.shopId = [gymObj[@"id"] integerValue];
                    
                    gym.name = gymObj[@"name"];
                    
                    [gyms addObject:gym];
                    
                }];
                
                course.gyms = gyms;
                
                if(course.type == CourseTypeGroup){
                    
                    [groups addObject:course];
                    
                }else{
                    
                    [privates addObject:course];
                    
                }
                
                [courses addObject:course];
                
            }];
            
            self.courses = [courses copy];
            
            self.groups = [groups copy];
            
            self.privates = [privates copy];
            
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

-(void)requestGroupDataWithGym:(Gym *)gym
{
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [para setParameter:[NSNumber numberWithBool:NO] forKey:@"is_private"];
    
    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"show_all"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSArray *array = responseDic[@"data"][@"courses"];
            
            NSMutableArray *courses = [NSMutableArray array];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Course *course = [[Course alloc]init];
                
                course.name = obj[@"name"];
                
                course.during = [obj[@"length"] integerValue]/60;
                
                course.type = CourseTypeGroup;
                
                course.imgUrl = [NSURL URLWithString:obj[@"photo"]];
                
                course.courseId = [obj[@"id"] integerValue];
                
                [courses addObject:course];
                
            }];
            
            self.courses = [courses copy];
            
            if (self.requestFinish) {
                self.requestFinish(YES);
            }
            
        }else
        {
            
            if (self.requestFinish) {
                self.requestFinish(YES);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.requestFinish) {
            self.requestFinish(NO);
        }
        
    }];
    
}


-(void)requestPrivateDataWithGym:(Gym *)gym
{
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }

    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_private"];
    
    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"show_all"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSArray *array = responseDic[@"data"][@"courses"];
            
            NSMutableArray *courses = [NSMutableArray array];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Course *course = [[Course alloc]init];
                
                course.name = obj[@"name"];
                
                course.during = [obj[@"length"] integerValue]/60;
                
                course.type = CourseTypePrivate;
                
                course.imgUrl = [NSURL URLWithString:obj[@"photo"]];
                
                course.courseId = [obj[@"id"] integerValue];
                
                [courses addObject:course];
                
            }];
            
            self.courses = [courses copy];
            
            if (self.requestFinish) {
                self.requestFinish(YES);
            }
            
        }else
        {
            
            if (self.requestFinish) {
                self.requestFinish(YES);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.requestFinish) {
            self.requestFinish(NO);
        }
        
    }];
    
}

-(void)createCourse:(Course *)course result:(void (^)(BOOL, NSString *))result
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
    
    [para setParameter:course.imgUrl.absoluteString forKey:@"photo"];
    
    [para setParameter:course.name forKey:@"name"];
    
    [para setParameter:[NSNumber numberWithBool:course.type == CourseTypePrivate] forKey:@"is_private"];
    
    [para setParameter:[NSNumber numberWithInteger:course.during*60] forKey:@"length"];
    
    [para setParameter:[NSNumber numberWithInteger:course.capacity] forKey:@"capacity"];
    
    if (course.type == CourseTypeGroup) {
        
        [para setParameter:[NSNumber numberWithInteger:course.minNumber] forKey:@"min_users"];
        
        if (course.meassure.meassureId) {
            
            [para setParameter:[NSNumber numberWithInteger:course.meassure.meassureId] forKey:@"plan_id"];
            
        }
        
    }
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)deleteCourse:(Course *)course result:(void (^)(BOOL, NSString *))result
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
    
    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:ChangeAPI,CoachId,(long)course.courseId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)editCourse:(Course *)course result:(void (^)(BOOL, NSString *))result
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

    [para setParameter:course.imgUrl.absoluteString forKey:@"photo"];
    
    [para setParameter:course.name forKey:@"name"];
    
    [para setParameter:[NSNumber numberWithInteger:course.capacity] forKey:@"capacity"];
    
    [para setParameter:[NSNumber numberWithInteger:course.during*60] forKey:@"length"];
    
    if (course.type == CourseTypeGroup) {
        
        [para setParameter:[NSNumber numberWithInteger:course.minNumber] forKey:@"min_users"];
        
        if (course.meassure.meassureId) {
            
            [para setParameter:[NSNumber numberWithInteger:course.meassure.meassureId] forKey:@"plan_id"];
            
        }
        
    }
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ChangeAPI,CoachId,(long)course.courseId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)changeGymWithCourse:(Course *)course result:(void (^)(BOOL, NSString *))result
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

    if (!AppGym && course.gyms.count) {
        
        NSString *shopIdStr = @"";
        
        for (NSInteger i = 0 ; i < course.gyms.count; i++) {
            
            Gym *tempGym = course.gyms[i];
            
            shopIdStr = [shopIdStr stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)tempGym.shopId]];
            
            if (i < course.gyms.count-1) {
                
                shopIdStr = [shopIdStr stringByAppendingString:@","];
                
            }
            
        }
        
        [para setParameter:shopIdStr forKey:@"shop_ids"];
        
    }
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:GymAPI,CoachId,(long)course.courseId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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

-(void)requestWithCourseType:(CourseType)type andIsAdd:(BOOL)isAdd andGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
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

    [para setParameter:isAdd?@"post":@"put" forKey:@"method"];
    
    if (type == CourseTypeGroup) {
        
        [para setParameter:@"teamarrange_calendar" forKey:@"key"];
        
    }else{
        
        [para setParameter:@"priarrange_calendar" forKey:@"key"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PermissionAPI,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSArray *array = responseDic[@"data"][@"courses"];
            
            NSMutableArray *courses = [NSMutableArray array];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Course *course = [[Course alloc]init];
                
                course.name = obj[@"name"];
                
                course.during = [obj[@"length"] integerValue]/60;
                
                course.type = [obj[@"is_private"]boolValue]?CourseTypePrivate:CourseTypeGroup;
                
                course.imgUrl = [NSURL URLWithString:obj[@"photo"]];
                
                course.courseId = [obj[@"id"] integerValue];
                
                if (course.type == type) {
                    
                    [courses addObject:course];
                    
                }
                
            }];
            
            self.courses = [courses copy];
            
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

-(void)requestReportDataWithGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
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

    [para setParameter:@"get" forKey:@"method"];
    
    [para setParameter:@"cost_report" forKey:@"key"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PermissionAPI,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSArray *array = responseDic[@"data"][@"courses"];
            
            NSMutableArray *courses = [NSMutableArray array];
            
            NSMutableArray *privates = [NSMutableArray array];
            
            NSMutableArray *groups = [NSMutableArray array];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Course *course = [[Course alloc]init];
                
                course.name = obj[@"name"];
                
                course.during = [obj[@"length"] integerValue]/60;
                
                course.type = [obj[@"is_private"]boolValue]?CourseTypePrivate:CourseTypeGroup;
                
                course.imgUrl = [NSURL URLWithString:obj[@"photo"]];
                
                course.courseId = [obj[@"id"] integerValue];
                
                if (course.type == CourseTypeGroup) {
                    
                    [groups addObject:course];
                    
                }else{
                    
                    [privates addObject:course];
                    
                }
                
                [courses addObject:course];
                
            }];
            
            self.courses = [courses copy];
            
            self.groups = [groups copy];
            
            self.privates = [privates copy];
            
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
