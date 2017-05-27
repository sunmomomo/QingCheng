//
//  CoursePicturesInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePicturesInfo.h"

#define API @"/api/v2/coaches/%ld/courses/schedules/photos/"

@interface CoursePicturesInfo ()

{
    
    NSInteger _currentPage;
    
    NSInteger _totalPages;
    
}

@end

@implementation CoursePicturesInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _currentPage = 0;
        
        _totalPages = 1;
        
        self.batches = [NSMutableArray array];
        
    }
    
    return self;
}

-(void)requestWithCourse:(Course *)course result:(void (^)(BOOL, NSString *))result
{
    
    if (_currentPage>=_totalPages) {
        
        if (self.callBack) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }
        
        return;
        
    }
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setInteger:_currentPage+1 forKey:@"page"];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }

    [para setInteger:course.courseId forKey:@"course_id"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            _totalPages = [responseDic[@"data"][@"pages"] integerValue];
            
            _currentPage = [responseDic[@"data"][@"current_page"] integerValue];
            
            [responseDic[@"data"][@"schedules"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                CoursePlanBatch *batch = [[CoursePlanBatch alloc]init];
        
                batch.course = course;
                
                batch.coach.name = obj[@"teacher"][@"username"];
                
                batch.coach.coachId = [obj[@"teacher"][@"id"] integerValue];
                
                if ([obj[@"start"] length]) {
                    
                    batch.start = [[[obj[@"start"] componentsSeparatedByString:@"T"] lastObject] substringToIndex:5];
                    
                    batch.date = [[obj[@"start"] componentsSeparatedByString:@"T"] firstObject];
                    
                }
                
                if ([obj[@"end"] length]) {
                    
                    batch.end = [[[obj[@"end"] componentsSeparatedByString:@"T"]lastObject] substringToIndex:5];
                    
                }
                
                batch.gym.name = obj[@"shop"][@"name"];
                
                batch.gym.shopId = [obj[@"shop"][@"id"] integerValue];
                
                batch.courseURL = [NSURL URLWithString:obj[@"url"]];
                
                NSMutableArray *pictures = [NSMutableArray array];
                
                [obj[@"photos"] enumerateObjectsUsingBlock:^(NSDictionary *photoObj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    CoursePicture *picture = [[CoursePicture alloc]init];
                    
                    picture.imageURL = [NSURL URLWithString:photoObj[@"photo"]];
                    
                    picture.uploadStaffName = photoObj[@"created_by"][@"username"];
                    
                    picture.isPrivate = ![photoObj[@"is_public"] boolValue];
                    
                    picture.canSeeUserName = photoObj[@"owner"][@"username"];
                    
                    if ([photoObj[@"created_at"] length]) {
                        
                        picture.uploadTime = [[photoObj[@"created_at"] stringByReplacingOccurrencesOfString:@"T" withString:@"  "] substringToIndex:17];
                        
                    }else{
                        
                        picture.uploadTime = @"";
                        
                    }
                    
                    [pictures addObject:picture];
                    
                }];
                
                batch.pictures = pictures;
                
                [self.batches addObject:batch];
                
            }];
            
            
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
